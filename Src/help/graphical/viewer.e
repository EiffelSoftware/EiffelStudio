indexing
	description:"Viewer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:"pascalf"

class VIEWER

inherit
	EV_APPLICATION
		redefine
			initialize
		end

	ARGUMENTS

	FACILITIES

creation
	make

feature -- Initialization

	initialize is
			-- Process command line & Update viewer-window.
		local
			file: RAW_FILE
		do
			process_command_line
			create file.make(help_file)
			if not file.exists then
				warning ("File not found", "Using default. (help.xml)", first_window)
				help_file := default_file
			end
			first_window.update
			--install_timer
		end

	install_timer is
			-- Creation of the Timer.
		local
			com: E_TIMER_COMMAND
		do
			create com.make(first_window, "topic.dat")
			create timer.make(2000, com, Void)
		end

	process_command_line is
			-- Read the command line for help file and topic.
		local
			n: INTEGER
			err: BOOLEAN
		do
			if not err then
				from
					n := 0
				until
					n >= argument_count
				loop
					if is_xml_file(arg_option(n+1)) then
						create help_file.make_from_string(arg_option(n+1))
					else
						topic_id := arg_option(n+1).out
					end
					n := n + 1
				end
				if help_file = Void then
					-- Assign a default value.
					help_file := default_file
				end
			else
				warning("Error while reading command-line", "Please check the arguments and retry.", first_window)
			end
		ensure
			help_file_set: help_file /= Void
		rescue
			err := TRUE
			retry
		end

feature -- State Setting

	set_help_file(s:STRING) is
		require
			not_void: s /= Void
			string_is_xml_file: is_xml_file(s)
		do
			create help_file.make_from_string(s)
			first_window.update
		end

feature -- Implementation

	default_file: FILE_NAME is
			-- The default root-file.
		do
			create Result.make_from_string("help.xml")
		end

feature -- Access

	timer: EV_TIMEOUT
			-- The timer to read the file 'topic.dat' every 2 secs.

	help_file: FILE_NAME
			-- The XML-help-file to be loaded.

	topic_id: STRING
			-- The topic to be diplayed. Root topic if Void.

	first_window: VIEWER_WINDOW is
			-- The main window.
		once
			!! Result.make_viewer(Current)
			set_main_window(Result)
		end

invariant
	VIEWER_consistent: topic_id /= Void implies not topic_id.empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end --VIEWER
