indexing
	description: "Class describing the notion of routine; %
				% a command (corresponding to APPLICATION_COMMAND) %
				% is also a routine."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_ROUTINE

inherit

	APPLICATION_METHOD
		rename
			method_name as routine_name
		end

creation
	make, make_from_command

feature -- Creation

	make (rout_name: STRING; arg_list: LINKED_LIST [APPLICATION_ARGUMENT]) is
			-- Create a routine object with name `rout_name'
			-- whose arguments are `arg_list'.
		require
			valid_routine_name: rout_name /= Void and not rout_name.empty
			valid_arguments: arg_list /= Void 
		do
			create precondition_list.make
			routine_name := rout_name
			argument_list := arg_list
		end

	make_from_command (a_command: APPLICATION_COMMAND) is
			-- Create a routine object using `a_command'.
		require
			valid_command: a_command /= Void
		local
			arg: APPLICATION_ARGUMENT
		do
			routine_name := a_command.command_name
			create precondition_list.make
			create argument_list.make
			create arg.make (a_command.argument_name, a_command.argument_type)
			argument_list.extend (arg)
			precondition_list := a_command.precondition_list
		end

feature -- Scrollable element

	value: STRING is
			-- Value displayed in a scrollable list.
		do
			create Result.make (0)
			Result.append (routine_name)
			if not argument_list.empty then
				Result.append (" (")
				argument_list.start
				Result.append (argument_list.item.eiffel_text)
				from
					argument_list.forth
				until
					argument_list.after
				loop
					Result.append ("; ")
					Result.append (argument_list.item.eiffel_text)
					argument_list.forth
				end
				Result.append (")")
			end
		end

feature -- Attributes

	argument_list: LINKED_LIST [APPLICATION_ARGUMENT]
			-- List of arguments

end -- class APPLICATION_ROUTINE
