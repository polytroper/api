class CopyService
  def initialize(conversation_name, hash)
    @conversation_name = conversation_name
    @context = hash_to_binding hash
  end

  def get_copy(key)
    erb = ERB.new get_erb(key)

    erb.result @context
  end

  def get_erb(key)
    sections = key.split '.'
    copy = get_conversation_yaml(@conversation_name)

    sections.each { |s| copy = copy[s] }

    # If there are multiple options, choose one at random.
    copy.respond_to?('each') ? copy.sample : copy
  end

  private

  def get_conversation_yaml(name)
    path = File.join(copy_route, "#{name}.yml")

    YAML.load File.read(path)
  end

  def copy_route
    Rails.root.join 'lib/data/copy/'
  end

  def hash_to_binding(hash)
    b = binding
    b.local_variable_set('info', hash)
    b
  end
end
