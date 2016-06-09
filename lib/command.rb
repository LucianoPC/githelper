# Abstract class with definitions of commands
class Command
  def self.usage
    raise 'return usage message'
  end

  def self.options_messages
    raise 'return a list with how to use this command'
  end

  def self.command_name
    raise 'return the command name'
  end

  def self.run(argv)
    raise 'implements the command feature'
  end

  def self.parent
    raise 'return the parent command'
  end

  def self.childrens
    raise 'return the childrens commands'
  end

  def self.run_childrens(argv)
    self_argv_index = argv.index(self.command_name)
    return self.show_usage unless self_argv_index

    children_command = argv[self_argv_index + 1]
    children = self.childrens.detect{|c| c.command_name == children_command}
    return self.show_usage unless children

    children.run(argv)
  end

  def self.show_usage
    usage_message = self.usage
    usage_message += "\n\n[options]"

    childrens.each do |command|
      messages = command.options_messages
      messages = [messages] unless messages.is_a?(Array)

      messages.each do |message|
        usage_message += "\n#{message}" if message
      end
    end

    puts usage_message
  end
end
