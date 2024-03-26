require 'httparty'
require 'json'

def fetch_github_repositories(username)
  response = HTTParty.get("https://api.github.com/users/#{username}/repos")
  JSON.parse(response.body)
end

def analyze_repositories(repos)
  max_stars_repo = repos.max_by { |repo| repo['stargazers_count'] }
  {
    name: max_stars_repo['name'],
    description: max_stars_repo['description'],
    stars: max_stars_repo['stargazers_count'],
    url: max_stars_repo['html_url']
  }
end

def display_most_starred_repository(repo)
  puts "Most Starred Repository:"
  puts "Name: #{repo[:name]}"
  puts "Description: #{repo[:description]}"
  puts "Stars: #{repo[:stars]}"
  puts "URL: #{repo[:url]}"
end

username = ARGV[0]
repos = fetch_github_repositories(username)
most_starred_repo = analyze_repositories(repos)
display_most_starred_repository(most_starred_repo)
