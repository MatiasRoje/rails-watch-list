require 'open-uri'
require 'json'

def parsed_movies
  url = "https://tmdb.lewagon.com/movie/top_rated"
  movies_json = URI.open(url).read
  movies = JSON.parse(movies_json)
  return movies
end

puts "Destroying our previus movies from the DB"
Movies.destroy_all
puts "Adding 20 movies to the DB"

movies = parsed_movies
movies["results"].each do |movie|
  Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}", rating: movie["vote_average"])
end

puts "#{Movie.count} movies were added to the DB"
