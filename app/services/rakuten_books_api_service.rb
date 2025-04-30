require 'net/http'
require 'json'

class RakutenBooksApiService

  def self.search(title)
    return nil if title.blank?
    begin
      uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404")
      params = {
        applicationId: ENV['RAKUTEN_API_ID'],
        title: title,
        format: 'json'
      }
      uri.query = URI.encode_www_form(params)

      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        if data['Items'].present?
          books = data['Items'].map do |item|
            {
              title: item['Item']['title'],
              isbn: item['Item']['isbn'],
              url: item['Item']['itemUrl'],
              image_url: item['Item']['largeImageUrl']
            }
          end
          { books: books, hits: data['count'].to_i }
        else
          return { items: nil, hits: 0 }
        end
      end
    rescue StandardError => e
      Rails.logger.error("Error fetching data from Rakuten API: #{e.message}")
      return nil
    end
  end
end