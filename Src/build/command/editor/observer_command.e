indexing
	description: "Command to manipulate observers.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	OBSERVER_COMMAND

inherit
	EB_UNDOABLE
		redefine
			execute, is_template
		end

feature

	make (a_command: CMD_INSTANCE) is
			-- Set `observed_command' to `a_command'.
		do
			observed_command := a_command
		end
feature

	is_template: BOOLEAN is True

	redo is
		do
			command_work
		end

	execute (argument: ANY) is
		do
			observer ?=  argument
			if observer /= Void then
				command_work
				update_history
			end
		end

	work (argument: ANY) is
		do
		end

	failed: BOOLEAN

	name: STRING is
			-- Name of the command appearing in 
			-- the history window.
		do
			!! Result.make (0)
			Result.append (c_name)
			Result.append (" (")
			Result.append (observer.label)
			Result.append ("-")
			Result.append (action_symbol)
			Result.append ("->")
			Result.append (observed_command.label)
			Result.append (")")
			
		end

feature {NONE}

	observed_command: CMD_INSTANCE

	observer: CMD_INSTANCE

	command_work is
		deferred
		end

	c_name: STRING is
			-- Type name of the command.
		deferred
		end

	action_symbol: STRING is
			-- Symbol used in the history window. It can be
			-- either "-" or "/", to have the symbol "<--"
			-- when adding an observer, and "<-/-" when 
			-- removing
		deferred
		end
			
end -- class OBSERVER_COMMAND
