indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMAT_COMMAND

inherit
	EV_COMMAND

	EB_COMMAND_FEEDBACK

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
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute current command but don't change the cursor into watch shape.
		local
--			mp: MOUSE_PTR
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			if argument = Void then
				s ?= f.tool.stone
			else
				s ?= argument.first
			end
			if f.tool.text_window.changed then
				create csd.make_and_launch (f.tool, Current)
			else
				process
			end
		end
		
end -- class EB_FORMAT_COMMAND
