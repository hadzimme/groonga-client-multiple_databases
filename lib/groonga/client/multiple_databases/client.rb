module Groonga
  class Client
    private
    def initialize(options = {})
      options = options.dup
      if @prefix = options.delete(:prefix) || protocol == :http
        @connection = Groonga::Client::Protocol::HTTP.new(options)
      else
        @connection = Groonga::Client::Protocol::GQTP.new(options)
      end
    end

    def execute_command(command_name, parameters={}, &block)
      parameters = normalize_parameters(parameters)
      command_class = Groonga::Command.find(command_name)
      command = command_class.new(@prefix, command_name, parameters)
      execute(command, &block)
    end
  end
end
