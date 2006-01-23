indexing 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	POPUP_SHELL_IMP
 
inherit 
	SHELL_IMP

feature -- Status report

	foreground: COLOR

feature -- Status setting

	set_foreground (a_color: COLOR) is
		do
		end

	update_foreground is
		do
		end

feature -- Output

	popup is
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




end -- class POPUP_SHELL_IMP

