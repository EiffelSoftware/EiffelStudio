indexing
	description	: "Output compilation degree messages into a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	FILE_DEGREE_OUTPUT

inherit
	DEGREE_OUTPUT
		redefine
			display_degree_output,
			display_degree,
			put_melting_changes_message,
			put_freezing_message,
			put_start_dead_code_removal_message,
			put_string,
			put_dead_code_removal_message,
			percentage_output,
			degree_message,
			put_system_compiled,
			put_header
		end

create
	make

feature -- Initialization

	make (a_file_name: STRING) is
			-- Initialize
		do
			output_file_name := a_file_name
		end

feature -- Basic operations

	put_melting_changes_message is
			-- Put message indicating that melting changes is ocurring.
		do
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
		end

	put_start_dead_code_removal_message is
			-- Put message indicating the start of dead code removal.
		do
		end

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
		end

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (a_message)
				output_file.put_new_line
				close_file
			end
		end

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
				-- Wait for the file to be writable.
			from
			until
				not output_file.is_closed
			loop
				open_file
			end

			output_file.put_string ("finished")
			output_file.put_new_line
			close_file
		end

	put_header (displayed_version_number: STRING) is
		do
		end

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (deg_nbr)
				output_file.put_string ("%T")
				output_file.put_string (percentage_output (to_go))
				output_file.put_new_line
				close_file
			end
		end

feature {NONE} -- Implementation

	output_file: PLAIN_TEXT_FILE
			-- Output file.

	output_file_name: STRING
			-- Output file name

	degree_message (a_degree: INTEGER): STRING is
			-- Display the message corresponding to degree `a_degree'.
		do
			create Result.make (2)
			Result.append_integer (a_degree)
		end

	open_file is
			-- Open the output file
		local
			retried: BOOLEAN
		do
			if not retried then
				create output_file.make_open_write (output_file_name)
			end
		rescue
			retried := True
			retry
		end

	close_file is
			-- Close the output file
		local
			retried: BOOLEAN
		do
			if not retried then
				output_file.close
			end
		rescue
			retried := True
			retry
		end

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total
			open_file
			if not output_file.is_closed then
				output_file.put_integer (-2)
				output_file.put_string ("%T")
				output_file.put_string (percentage_output (to_go))
				output_file.put_new_line
				close_file
			end
		end

	percentage_output (nbr_to_go: INTEGER): STRING is
			-- Return percentage based on `nbr_to_go' and
			-- `total_number'
		do
			create Result.make (4)
			Result.append_integer (percentage_calculation (nbr_to_go))
			Result.append_string ("%%")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FILE_DEGREE_OUTPUT
