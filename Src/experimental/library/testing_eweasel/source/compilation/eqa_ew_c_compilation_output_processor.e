note
	description: "[
					C compilation output processor
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_C_COMPILATION_OUTPUT_PROCESSOR

inherit
	EQA_SYSTEM_OUTPUT_PROCESSOR
		redefine
			on_new_character,
			on_new_line
		end

create
	make

feature {NONE} -- Initializatin

	make (a_test_set: EQA_EW_SYSTEM_TEST_SET)
			-- Creation method
		require
			not_void: attached a_test_set
		do
			initialize_buffer
			test_set := a_test_set
			create cached_whole_file.make_empty
		ensure
			set: test_set = a_test_set
		end

feature -- Command

	write_output_to_file
			-- Write `cached_whole_file' to output file
		local
			l_file: PLAIN_TEXT_FILE
			l_path: EQA_EW_STRING_UTILITIES
			l_output_path: detachable STRING
		do
			create l_path
			l_output_path := test_set.environment.value ({EQA_EW_PREDEFINED_VARIABLES}.Output_dir_name)
			check attached l_output_path end -- Implied by environment virable should be set before testing
			create l_file.make (l_path.file_path(<<l_output_path, test_set.c_compile_output_name>>))
			l_file.open_read_append

			l_file.put_string (cached_whole_file)

			l_file.close
		end

feature -- Query

	compilation_result: detachable EQA_EW_C_COMPILATION_RESULT
			-- Compilation result

feature {NONE} -- Implementation

	on_new_character (a_character: CHARACTER_8)
			-- <Precursor>
		do
		end

	on_new_line
			-- <Precursor>
		local
			l_result: like compilation_result
		do
			if not attached compilation_result then
				create compilation_result
			end
			l_result := compilation_result
			check attached l_result end -- Implied by previous if clause
			l_result.update (buffer.twin)
			-- Write to output file

			cached_whole_file.append (buffer.twin + "%N")
		end

	test_set: EQA_EW_SYSTEM_TEST_SET
			-- System level test set current managed

	cached_whole_file: STRING
			-- Cached whole output file

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
