indexing

	description:
		"Widget: File Selection Dialog. %
		%Able to select file names."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class FILE_BOX

inherit

	FILE_SEL_D
		rename
			make as file_sel_d_make,
			popup as old_popup
		end
		
	COMMAND

	BUILD_COMMAND_ARGS

creation

	make

feature

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create file selection box.
		do
			file_sel_d_make (a_name, a_parent)
			hide_help_button
			add_ok_action (Current, First)
			add_cancel_action (Current, Second)
			set_exclusive_grab
		end

	popup (com: BUILD_CMD) is
			-- Set caller to `com' and popup Current
			-- file box.
		do
			caller := com
			old_popup
		end

	caller: BUILD_CMD
			-- Command calling Curren file_box

	canceled: BOOLEAN
			-- Action canceled

	execute (argument: ANY) is
		do
			if (argument = First) then
				popdown
				canceled := False
				caller.work
			elseif (argument = Second) then
				popdown
				canceled := True
				caller.work
			end
		end
		
end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
