indexing
	description: 
		"%"Hello world%" application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	HELLO_WORLD

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Set up `first_window'.
		local
			b: EV_BUTTON
		do
			create b.make_with_text ("Hello world")
			b.select_actions.extend (agent on_button_select)
			first_window.extend (b)
		end

feature -- Actions

	on_button_select is
			-- Output text that a button has been pressed.
		do
			io.put_string ("Button pressed%N")
		end

feature -- Access

	first_window: MAIN_WINDOW is
			-- Main window of the example
		once
			create Result
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
