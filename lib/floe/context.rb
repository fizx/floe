require "grit"
require "yaml"
module Floe
  class Context
    attr_reader :repo
    def initialize(opts = {})
      @dir = opts[:dir]
      @remote = opts[:remote]
      @repo = Grit::Repo.new(@dir)
      @status = {}
      @status["milestone"] ||= nil
      @status["issue"] ||= nil
      load_status if initialized?
    end
    
    def url
      @repo.config["remote.#{@remote}.url"]
    end
    
    def path
      URI.parse(url).path
    rescue URI::InvalidURIError
      url.split(":")[1]
    end
    
    def init!
      raise "Already initialized" if initialized?
      save!
    end
    
    def set(k, v)
      require_initialization
      @status[k.to_s] = v
      save!
    end
    
    def require_initialization
      raise "Not initialized" unless initialized?
    end
    
    def repo_name
      path.gsub(/\.git$/,"").split("/")[1]
    end
  
    def user
      path.split("/")[0]
    end
    
    def dotfile
      @repo.path.gsub(/\.git$/, ".floe")
    end
    
    def initialized?
      File.exists? dotfile
    end
    
    def load_status
      @status.update YAML.load(File.read(dotfile))
    end
    
    def status
      @status.dup
    end
    
    def save!
      File.open(dotfile, "w") do |f|
        f.puts(status.to_yaml)
      end
    end
  end
end