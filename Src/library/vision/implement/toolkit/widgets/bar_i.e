indexing

	description: "General menu bar implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	BAR_I 

inherit

	MENU_I


	
feature -- Access

	help_button: MENU_B is
			-- Menu Button which appears at the lower right corner of the
			-- menu bar
		deferred
		end;

feature -- Status setting


	allow_recompute_size is
		deferred
		end;

	forbid_recompute_size is
		deferred
		end

feature -- Element change

	set_help_button (button: MENU_B) is
			-- Set the Menu Button which appears at the lower right corner
			-- of the menu bar.
		deferred
		ensure
			same_button: help_button.same (button)
		end;

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




end -- class BAR_I

