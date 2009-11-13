note
	description: "[
		Source writer that creates a class referencing a list of classes.
		
		Note: this is used by testing framework to reference all existing test classes in system.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_EVALUATOR_ROOT_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			ancestor_names
		end

feature -- Access

	class_name: STRING
			-- Name of class
		do
			Result := {ETEST_CONSTANTS}.eqa_evaluator_root
		end

	root_feature_name: STRING
			-- <Precursor>
		do
			Result := {ETEST_CONSTANTS}.eqa_evaluator_creator
		end

	ancestor_names: ARRAY [STRING]
			-- <Precursor>
		do
			if attached ancestor_names_cache as l_cache then
				Result := l_cache
			else
				Result := << >>
			end
		end

feature {NONE} -- Access

	ancestor_names_cache: detachable ARRAY [STRING]
			-- <Precursor>

feature -- Basic operations

	write_source (a_file: KI_TEXT_OUTPUT_STREAM; a_list: LIST [EIFFEL_CLASS_I])
			-- Write anchor root class to file
		require
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			if not a_list.is_empty then
				ancestor_names_cache := << {ETEST_CONSTANTS}.eqa_evaluator >>
			end
			put_indexing
			put_class_header
			if a_list.is_empty then
				put_launch_routine
			else
				put_execute_test_routine
			end
			put_anchor_routine (a_list)
			put_class_footer
			stream := Void
		end

feature {NONE} -- Implementation

	put_execute_test_routine
			-- Print default implementation of `execute_test'
		require
			stream_valid: is_writing
		do
			stream.indent
			stream.put_line ("execute_test: EQA_TEST_EVALUATOR [EQA_TEST_SET]")
			stream.indent
			stream.indent
			stream.put_line ("-- The body of this routine is replaced at runtime with a melted representation that")
			stream.put_line ("-- calls the actual test routine.")
			stream.dedent
			stream.put_line ("local")
			stream.indent
			stream.put_line ("l_result: detachable like execute_test")
			stream.dedent
			stream.put_line ("do")
			stream.indent
			stream.put_line ("check not_replaced: l_result /= Void end")
			stream.put_line ("Result := l_result")
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_new_line
		end

	put_launch_routine
			-- Print `launch' routine if not inherited from EQA_EVALUATOR.
		require
			stream_valid: is_writing
		do
			stream.indent
			stream.put_line ("launch")
			stream.indent
			stream.indent
			stream.put_line ("-- Initialize `Current'")
			stream.dedent
			stream.put_line ("do")
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_new_line
		end

	put_anchor_routine (a_list: LIST [EIFFEL_CLASS_I])
			-- Print references to test classes and important library classes to force their compilation.
		require
			stream_valid: is_writing
		do
			stream.indent
			stream.put_line ("make")
			stream.indent
			stream.put_line ("local")
			stream.indent
			stream.put_line ("l_type: detachable TYPE [ANY]")
			stream.dedent
			stream.put_line ("do")
			stream.indent
			stream.indent
			stream.put_line ("-- Make sure commonly used classes in testing library which take long to compile are always referenced and compiled ")
			stream.dedent
			stream.put_line ("l_type := {ANY}")

			if not a_list.is_empty then
				stream.put_line ("l_type := {EQA_EVALUATOR}")
				stream.put_line ("l_type := {ITP_INTERPRETER}")
				stream.put_line ("l_type := {EQA_EXTRACTED_TEST_SET}")
				stream.put_line ("l_type := {EQA_COMMONLY_USED_ASSERTIONS}")
				stream.put_line ("")
				a_list.do_all (agent (a_class: EIFFEL_CLASS_I)
					do
						stream.put_string ("l_type := {EQA_TEST_EVALUATOR [")
						stream.put_string (a_class.name)
						stream.put_line ("]}")
					end)
			end
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_line ("")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
