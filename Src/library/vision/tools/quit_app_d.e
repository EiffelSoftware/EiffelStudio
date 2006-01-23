indexing

	description: "Message dialog to ensure that the user really wants to quit the application"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	QUIT_APP_D 

inherit

	STD_COMMANDS
		export
			{NONE} all
		end;

	QUESTION_D
		rename
			make as question_d_make
		end

create

	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a predefined question dialog with `a_name' as identifier,
			-- `a_parent' as parent. When `execute' is called, popup the
			-- question dialog and ask the user if he's sure to quit the
			-- application. Exit if OK is pressed.
		require
			name_not_void: a_name /= Void
			parent_not_void: a_parent /= Void
		do
-- FIXME
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class QUIT_APP_D 

