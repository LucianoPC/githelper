# Abstract class with definitions of commands
class Command
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

  def self.childrens?
    !self.childrens.empty?
  end

  def self.run_childrens(argv)
    self_argv_index = argv.index(self.command_name)
    return self.show_usage unless self_argv_index

    children_command = argv[self_argv_index + 1]
    children = self.childrens.detect{|c| c.command_name == children_command}
    return self.show_usage unless children

    children.run(argv)
  end

  def self.usage
    usage_message = self.get_usage_header
    usage_message += "\n\n[options]\n"

    childrens.each do |command|
      messages = command.options_messages
      messages = [messages] unless messages.is_a?(Array)

      messages.each do |message|
        usage_message += "\n#{message}" if message
      end
    end

    puts usage_message
  end

  def self.get_usage_header
    header = ''
    header += '[option]' if self.childrens?
    header = "#{self.command_name} " + header

    parent = self.parent
    while !parent.nil? do
      header = "#{parent.command_name} " + header
      parent = parent.parent
    end

    header = '$ ' + header
    header
  end
end
