note
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
			percentage_prefix,
			put_melting_changes_message,
			put_freezing_message,
			put_start_dead_code_removal_message,
			put_string,
			put_dead_code_removal_message,
			degree_message,
			put_system_compiled,
			put_header,
			put_degree_output,
			put_degree
		end

create
	make

feature {NONE} -- Initialization

	make (a_file_name: like output_file_name)
			--
		do
			output_file_name := a_file_name
		ensure
			output_file_name_set: output_file_name ~ a_file_name
		end

feature {NONE} -- Access

	output_file: detachable PLAIN_TEXT_FILE
			-- Output file.

	output_file_name: STRING
			-- Output file name

feature {NONE} -- Query

	degree_message (a_degree: INTEGER): STRING_32
			-- <Precursor>
		do
			create Result.make (2)
			Result.append_integer (a_degree)
		end

	percentage_prefix (a_to_go: INTEGER): STRING_32
			-- <Precursor>
		do
			create Result.make (4)
			Result.append_integer (calculate_percentage (a_to_go))
			Result.append_string ("%%")
		end

feature -- Basic operations



feature -- Basic operations: Eiffel compiler

	put_header
			-- <Precursor>
		do
		end

	put_melting_changes_message
			-- <Precursor>
		do
		end

	put_freezing_message
			-- <Precursor>
		do
		end

	put_start_dead_code_removal_message
			-- <Precursor>
		do
		end

	put_dead_code_removal_message (a_total: INTEGER; a_to_go: INTEGER)
			-- <Precursor>
		do
		end

	put_system_compiled
			-- <Precursor>
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

feature {NONE} -- Basic operations

	put_degree (a_degree: STRING_32; a_to_go: INTEGER; a_name: STRING)
			-- <Precursor>
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (encoding_converter.utf32_to_file_encoding (a_degree))
				output_file.put_string ("%T")
				output_file.put_string (encoding_converter.utf32_to_file_encoding (percentage_prefix (a_to_go)))
				output_file.put_new_line
				close_file
			end
		end

	put_degree_output (a_degree: STRING; a_to_go: INTEGER; a_total: INTEGER)
			-- <Precursor>
		do
			total_number := a_total
			open_file
			if not output_file.is_closed then
				output_file.put_string (encoding_converter.utf32_to_file_encoding (a_degree))
				output_file.put_string ("%T")
				output_file.put_string (encoding_converter.utf32_to_file_encoding (percentage_prefix (a_to_go)))
				output_file.put_new_line
				close_file
			end
		end

	put_string (a_message: STRING_32)
			-- <Precursor>
		do
			open_file
			if not output_file.is_closed then
				output_file.put_string (encoding_converter.utf32_to_file_encoding (a_message))
				output_file.put_new_line
				close_file
			end
		end

feature {NONE} -- Implementation

	open_file
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

	close_file
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

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class FILE_DEGREE_OUTPUT
