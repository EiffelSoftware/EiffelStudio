indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMAT_COMMAND

inherit
	EV_COMMAND

	EB_COMMAND_FEEDBACK
		redefine
			set_menu_item
		end

create
	make

feature {NONE} -- Initialization

	make (xxx: EB_FORMATTER) is
		do
			f := xxx
		end

feature -- Access

	f: EB_FORMATTER

feature

	set_menu_item (m: like menu_item) is
		do
			precursor (m)
			m.add_select_command (Current, Void)
		end

feature -- Execution

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute current command but don't change the cursor into watch shape.
		local
--			mp: MOUSE_PTR
			s: STONE
		do
			if argument = Void then
				s ?= f.tool.stone
			else
				s ?= argument.first
			end
			if not f.tool.text_window.changed then
--				execute_licensed (s)
				f.format (s)
			else
--				warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
--					Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
			end
		end
		
end -- class EB_FORMAT_COMMAND
