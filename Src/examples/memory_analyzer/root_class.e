indexing
	description	: "[
					System's root class. Demonstrate how to use Memory Analyzer library.
					Before use, you should include Gobo, Graph, Vision2, Wel or Gtk, Time, Structure library.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	note		: "Initial version automatically generated"

class
	ROOT_CLASS

inherit
	EV_APPLICATION
	
create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_env: EXECUTION_ENVIRONMENT
			l_path: STRING
			l_dir: DIRECTORY_NAME
		do
			create l_env
			l_path := l_env.get ("EIFFEL_SRC")
			if l_path = Void then
				io.put_string ("ISE_EIFFEL not defined.%N")
				io.put_string ("Press enter to exit.%N")
				io.read_line
			else
				create l_dir.make_from_string (l_path)
				l_dir.extend_from_array (<<"library", "memory_analyzer" >>)
				default_create
				create ma_window.make (l_dir)
				ma_window.close_request_actions.extend (agent handle_close_window)
				ma_window.show
				launch
			end
		end

feature {NONE} -- Implementation

	handle_close_window is
			-- Handle close window.
		do
			ma_window.destroy
			destroy
		end
		
	ma_window: MA_WINDOW; 
			-- Window of Memory Analyzer.
			
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


end -- class ROOT_CLASS
