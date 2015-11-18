require 'sinatra'
require 'csv'
require "pry"
require_relative "app/models/television_show"

set :views, File.join(File.dirname(__FILE__), "app/views")


get "/" do

  @ryan = SourceFromCsv.new
  erb :index
end

get "/new" do
  @ruby = TelevisionShow.new
  erb :new
end


post "/new" do
  title = params['show_title']
  network = params['show_network']
  start = params['show_start']
  synopsis = params['show_synopsis']
  genre = params['show_genre']



  if title == "" || network == "" || start == "" || synopsis == "" || genre == ""
    erb :error_blank
  else
    total_of_arrays = []
    arr_of_arrs = CSV.read("television-shows.csv")

    arr_of_arrs.each do |array|
      array.each do |piece|
        final = piece.downcase
        total_of_arrays << final
      end
    end

    if total_of_arrays.include?(title.downcase)
      erb :error_duplicate
    else
      CSV.open("television-shows.csv", "a") do |csv|
        csv << [title, network, start, synopsis, genre]
      end
      redirect "/"
    end

  end
end


get "/:show" do
  @title = params[:show]
  @tom = SourceFromCsv.new
  erb :show
end

class SourceFromCsv

  attr_reader :favorite_shows

  def initialize
    @favorite_shows = []
    @shows_from_csv = []

    @shows_from_csv = CSV.foreach('television-shows.csv', headers: true, header_converters: :symbol) do |row|
      @favorite_shows << row.to_hash
    end
  end

end
