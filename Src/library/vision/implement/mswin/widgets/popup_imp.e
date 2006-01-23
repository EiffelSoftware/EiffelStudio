indexing 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	POPUP_IMP

inherit 
	ROOT_MENU_WINDOWS

	MENU_IMP
		redefine
			associated_shell
		end

	POPUP_I

create
	make

feature -- Initialization

	make (a_popup: POPUP; oui_parent: COMPOSITE) is
			-- Create the popup menu
		do
			parent ?= oui_parent.implementation
		end

feature -- Output

	popup is
			-- Display the popup menu
		local
			ww : WEL_COMPOSITE_WINDOW
		do
			if not exists then
				make_track
			end
			put_children_in_menu
			ww ?= parent
			parent.associate_menu (Current)
			show_track (x, y, ww)
			parent.remove_menu
		end

feature {NONE} -- Inapplicable

	associated_shell: WM_SHELL_IMP is
		do
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




end -- class POPUP_IMP

