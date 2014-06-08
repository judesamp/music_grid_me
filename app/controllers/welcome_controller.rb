class WelcomeController < ApplicationController
  def index
  end

  def rdio_test
    processed_name = params[:artist_name].gsub(" ", "%20")
    response = HTTParty.get("http://developer.echonest.com/api/v4/artist/profile?api_key=COBRP02WAFAHDHN89&name=#{processed_name}&format=json&bucket=id:rdio-US")
    rdio_key_string = response['response']['artist']['foreign_ids'][0]['foreign_id']
    parse_to_key = rdio_key_string.scan(/[r]\d\d\d\d\d\d/)
    song = Echowrap.song_search(:artist => params[:artist_name], :results => 1, :bucket => "id:rdio-US")
    puts song.inspect
  end
end
