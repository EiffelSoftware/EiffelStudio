indexing
	description: "General notion of a command on a function."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class FUNC_COMMAND 

inherit
	EB_UNDOABLE_COMMAND
		redefine
			execute
		end

feature -- Access

	execute (arg: EV_ARGUMENT1 [BUILD_FUNCTION]; ev_data: EV_EVENT_DATA) is
			-- Do not update the history.
		do
			edited_function := arg.first
			work
		end

	comment: STRING is
		do
			!!Result.make (0)
			if edited_function /= Void then
				Result.append (edited_function.label)
			end
			if worked_on /= Void then
				Result.append ("-")
				Result.append (worked_on)
			end
		end

	undo is 
		do
			undo_work
			update_interface
--			update_page_number
		end

	redo is
		do
			redo_work
			update_interface
--			update_page_number
		end

--	update_history is
--		do
--			history.record (Current)
--			update_page_number
--		end

feature {NONE}

--	update_page_number is
--		do
--			if edited_function.func_editor /= Void then
--				edited_function.func_editor.display_page_number
--			end
--		end

	update_interface is
		do
			App_editor.update_transitions_list (Void)
		end

	undo_work is
			-- Undo the command.
		deferred
		end

	redo_work is
			-- Redo the command.
		deferred
		end

	work is
			-- Do not update history.
		deferred
		end

	worked_on: STRING is
			-- What the command changed
		deferred
		end 

	failed: BOOLEAN

	edited_function: BUILD_FUNCTION
			-- function being edited 

end -- class APP_COMMAND

