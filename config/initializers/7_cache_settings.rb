redis_config_file = Rails.root.join('config', 'resque.yml')

resque_url = if File.exists?(redis_config_file)
               YAML.load_file(redis_config_file)[Rails.env]
             else
               "redis://localhost:6379"
             end

# Redis::Store does not handle Unix sockets well, so let's do it for them
redis_config_hash = Redis::Store::Factory.extract_host_options_from_uri(resque_url)
redis_uri = URI.parse(resque_url)
if redis_uri.scheme == 'unix'
  redis_config_hash[:path] = redis_uri.path
end

redis_config_hash[:namespace] = 'cache:gitlab'

Gitlab::Application.config.cache_store = :redis_store, redis_config_hash
