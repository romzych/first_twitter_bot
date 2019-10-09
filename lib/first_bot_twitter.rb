# ligne très importante qui appelle la gem.
require 'twitter'
require 'dotenv'
Dotenv.load('.env')

# n'oublie pas les lignes pour Dotenv ici…

# quelques lignes qui appellent les clés d'API de ton fichier .env
def client
    
    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    return client
end

def client_stream

    client = Twitter::Streaming::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
    return client
end

# ligne qui permet de tweeter sur ton compte
# client.update('Ptit dernier try')


def like_stream

    client_stream.filter(track: "#boxing") do |object|
        client.favorite(object) if object.is_a?(Twitter::Tweet)
        client.follow(object.user) if object.is_a?(Twitter::Tweet)
    end
end

like_stream



def follow_account

    client.search("#boxing", result_type:"recent").take(3).each do |tweet|
        client.follow(tweet.user)
    end

end

# follow_account


def search_tweet

    client.search("#bonjour_monde", result_type:"recent").take(10).each do |tweet|
        client.favorite(tweet)
    end

end

# search_tweet

def post_tweet(handle)

    client.update("#{handle} ZAD PARTOUT JUSTICE NULLE PART !")

end


def tweet_to_random
    
    list_handle = ['@EmmanuelMacron', '@EPhilippePM', '@agnesbuzyn', '@Prefet76', '@ars_normandie', '@SibethNdiaye', '@LubrizolCorp', '@LZAdditives', '@Elisabeth_Borne', '@enmarchefr', '@CCastaner', '@gouvernementFR']
    handle_randomizer = 0
    5.times do
        post_tweet(list_handle[rand(0..(list_handle.size))])
    end

end

# tweet_to_random