require 'uri'

module Panchira
  class TwitterResolver < Resolver
    URL_REGEXP = %r{twitter.com/(\w+)/status/(\d+)}.freeze

    def initialize(url, options = nil)
      super(url, options)
      @screen_name = @url.slice(URL_REGEXP, 1)
      @id = @url.slice(URL_REGEXP, 2)

      @bearer_token = options&.dig(:twitter, :bearer_token)
    end

    def fetch
      return super unless @bearer_token

      @response = fetch_api if @bearer_token

      result = PanchiraResult.new

      result.canonical_url = parse_canonical_url
      result.title = parse_title
      result.description = parse_description
      result.image = parse_image
      result.tags = parse_tags
      result.author = parse_author
      result.resolver = parse_resolver

      result
    end

    private

      def fetch_api
        uri = URI.parse("https://api.twitter.com/2/tweets/#{@id}")
        uri.query = URI.encode_www_form({
          'expansions': 'attachments.media_keys,author_id',
          'media.fields': 'preview_image_url,type,url',
          'user.fields': 'name,username',
          'tweet.fields': 'entities'
        })

        raw_json = uri.read('Authorization' => "Bearer #{@bearer_token}")
        JSON.parse(raw_json)
      end

      def parse_canonical_url
        # Twitter returns false canonical url when the account is set as sensitive.
        "https://twitter.com/#{@screen_name}/status/#{@id}"
      end

      def parse_title
        @title = if @response
                   @author = @response['includes']['users'][0]['name']
                   "#{@author} on Twitter"
                 else
                   super
                 end
      end

      def parse_author
        @author || @title.match(/\A(.+) on Twitter\z/)[1]
      rescue StandardError
        nil
      end

      def parse_description
        if @response
          @response['data']['text']
        else
          @description = super.gsub(/\A“|”\z/, '')
        end
      end

      def parse_tags
        if @response
          @response.dig('data', 'entities', 'hashtags')&.map { |obj| obj['tag'] }
        else
          @description.scan(/[#＃]([^#＃\s]+)/).map(&:first)
        end
      end

      def parse_image_url
        return super unless @response

        first_media = @response.dig('includes', 'media')&.first

        return unless first_media

        case first_media['type']
        when 'photo'
          first_media['url']
        when 'video'
          first_media['preview_image_url']
        end
      end
  end

  ::Panchira::Extensions.register(Panchira::TwitterResolver)
end
