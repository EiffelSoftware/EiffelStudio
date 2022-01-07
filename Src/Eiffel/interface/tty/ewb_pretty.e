note
	description: "Displays pretty formatted class in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_PRETTY

inherit
	EWB_CMD
		rename
			name as pretty_cmd_name,
			help_message as pretty_help,
			abbreviation as pretty_abb
		redefine
			executable
		end

	SHARED_ERROR_HANDLER

create
	make

feature {NONE} -- Initialization

	make (a_in_filename, a_out_filename: like in_filename)
			-- Initialization
		require
			a_in_filename_not_void: a_in_filename /= Void
			a_out_filename_not_void: a_out_filename /= Void
		do
			in_filename := a_in_filename
			out_filename := a_out_filename
		ensure
			in_filename_set: in_filename = a_in_filename
			out_filename_set: out_filename = a_out_filename
		end

feature -- Properties

	in_filename: STRING_32
			-- Input filename

	out_filename: STRING_32
			-- Output filename

feature -- Status report

	executable: BOOLEAN
			-- <Precursor>
		do
				-- A project is not needed.
			Result := True
		end

feature {NONE} -- Execution

	execute
			-- Execute Current batch command.
		local
			show_pretty: E_SHOW_PRETTY
			e: ERROR
		do
			create show_pretty.make_file (in_filename, out_filename)
			if show_pretty.error then
				io.error.put_string ("Prettifyer: Unable to prettify.%N")
				from
					error_handler.error_list.start
				until
					error_handler.error_list.after
				loop
					e := error_handler.error_list.item
					io.error.put_string ("- Syntax error at line " + e.line.out + "%N")
					error_handler.error_list.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
