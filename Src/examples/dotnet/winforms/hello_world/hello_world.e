indexing
	description: "Display a FORM with the title `Hello world'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
class
	HELLO_WORLD

inherit
	WINFORMS_FORM
		rename
			make as make_form
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			--| Set title with "hello_world".
			-- Entry point.
		do
			set_text ("Hello world")
			{WINFORMS_APPLICATION}.run_form (Current)
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


end -- class HELLO_WORLD
