indexing
	description: "General notion of a command on a EiffelBuild command (CMD)."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

deferred class CMD_COMMAND 

inherit

	EB_UNDOABLE_COMMAND
		redefine
			execute
		end

feature -- Access

	redo is
		do
			command_work
		end

	execute (arg: EV_ARGUMENT1 [CMD]; ev_data: EV_EVENT_DATA) is
		do
			edited_command ?= arg.first
			if edited_command /= Void then
				command_work
			else
					-- do not update the history
				failed := True
			end
		end

	comment: STRING is
		do
			create Result.make (0)
			if edited_command /= Void then
				Result.append (edited_command.label)
			end
			if
				worked_on /= Void
			then
				Result.append ("-")
				Result.append (worked_on)
			end
		end
	
	edited_command: USER_CMD

feature {NONE} -- Implementation

	command_work is
		deferred
		end
	
	worked_on: STRING is
			-- What the command changed
		deferred
		end 

	failed: BOOLEAN
	
end -- class CMD_COMMAND

