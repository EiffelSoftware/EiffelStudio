indexing
	description: "Class describing the notion of a command, that is %
				% a procedure with only one argument."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_COMMAND

inherit

	APPLICATION_METHOD
		rename
			method_name as command_name
		end

creation
	make

feature -- Creation

	make (cmd_name, arg_name, arg_type: STRING) is
			-- Create a command with name `command_name', whose
			-- argument name is `arg_name' and argument type is
			-- `arg_type'.
		require
			valid_command_name: cmd_name /= Void and then not cmd_name.empty
			valid_arg_name: arg_name /= Void and then not arg_name.empty
			valid_arg_type: arg_type /= Void and then not arg_type.empty
		do
			create precondition_list.make
			command_name := cmd_name
			argument_name := arg_name
			argument_type := arg_type
		end

feature -- Attributes

	argument_name: STRING
			-- Name of the argument

	argument_type: STRING
			-- Type of the argument

end -- class APPLICATION_COMMAND
