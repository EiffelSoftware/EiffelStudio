indexing
	description: "Command to apply a format"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMAT_COMMAND

inherit
	EV_COMMAND

	EB_TWO_STATES_COMMAND_FEEDBACK

	EB_CONFIRM_SAVE_CALLBACK

create
	make

feature {NONE} -- Initialization

	make (xxx: EB_FORMATTER) is
		do
			f := xxx
		end

feature -- Access

	f: EB_FORMATTER

	s: STONE

feature {EB_CONFIRM_SAVE_DIALOG} -- Callbacks

	process is
		do
--			execute_licensed (s)
			f.format (s)
			set_selected (True)
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute current command but don't change the cursor into watch shape.
		local
--			mp: MOUSE_PTR
			ed: EB_EDIT_TOOL
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if argument = Void then
				s ?= f.tool.stone
			else
				s ?= argument.first
			end
			ed ?= f.tool
			if ed /= Void then
				if ed.text_area.changed then
					create csd.make_and_launch (ed, Current)
				else
					process
				end
			else
				process
			end
		end
		
end -- class EB_FORMAT_COMMAND
