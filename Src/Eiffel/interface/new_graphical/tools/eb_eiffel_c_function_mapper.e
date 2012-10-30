note
	description: "Object that retrieves corresponding C files/functions for an Eiffel class/feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EIFFEL_C_FUNCTION_MAPPER

inherit
	SHARED_CODE_FILES

	SHARED_BYTE_CONTEXT

	SHARED_WORKBENCH

	INTERNAL_COMPILER_STRING_EXPORTER

create
	create_with_class,
	create_with_feature

feature{NONE} -- Initialization

	create_with_class (a_class: like class_c; a_workbench: BOOLEAN)
			-- Initialize Current with `a_class'.
			-- `a_workbench' is True indicates that workbench C files should be retrieved,
			-- otherwise finalized C files.
		require
			a_class_attached: a_class /= Void
		do
			class_c := a_class
			is_for_workbench := a_workbench
		end

	create_with_feature (a_feature: like e_feature; a_workbench: BOOLEAN)
			-- Initialize Current with `a_feature'.
			-- `a_workbench' is True indicates that workbench C files should be retrieved,
			-- otherwise finalized C files.		
		require
			a_feature_attached: a_feature /= Void
		do
			e_feature := a_feature
			create_with_class (e_feature.written_class, a_workbench)
		end

feature -- Access

	class_c: CLASS_C
			-- Class whose corresponding C files are to be retrieved

	e_feature: E_FEATURE
			-- Feature whose corresponding C functions are to be retrieved

	valid_c_file_table: HASH_TABLE [CLASS_TYPE, STRING_32]
			-- Table of C files for `class_c'.
			-- [Generic deriviation type, C file name]
		local
			l_types: TYPE_LIST
			l_cursor: CURSOR
			l_type: CLASS_TYPE
			l_file_name: STRING_32
			l_file: RAW_FILE
		do
			create Result.make (10)
			l_types := class_c.types
			if l_types /= Void and then not l_types.is_empty then
				l_cursor := l_types.cursor
				from
					l_types.start
				until
					l_types.after
				loop
					l_type := l_types.item
					l_file_name := c_file (l_type)
					if not l_file_name.is_empty then
						create l_file.make_with_name (l_file_name)
						if l_file.exists and then l_file.is_readable then
							Result.put (l_type, l_file_name)
						end
					end
					l_types.forth
				end
				l_types.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

	line_number (a_file_name: STRING_32): INTEGER
			-- If `e_feature' is set, return the line number for its corresponding C function in `a_file_name'.
			-- IF `e_feature' is not set or some error occurred when trying to retrieve line number, return 1.
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_comment: STRING
			l_done: BOOLEAN
			l_line: STRING
			l_cnt: INTEGER
		do
			if not l_retried then
				if is_for_feature then
					create l_file.make_open_read (a_file_name)
					create l_comment.make (20)
					l_comment.append ("/* ")
					l_comment.append ("{")
					if attached {CLASS_C} (e_feature.written_class) as cl then
						l_comment.append (cl.name_in_upper)
					end
					l_comment.append ("}.")
					l_comment.append (e_feature.name)
					l_comment.append (" */")
					l_cnt := l_comment.count
						-- Find the comment line for the feature.
					from
						Result := 1
						l_file.read_line
					until
						l_file.after or l_done
					loop
						l_line := l_file.last_string
						if l_line.count = l_cnt and then l_line.is_equal (l_comment) then
							l_done := True
						else
							Result := Result + 1
							l_file.read_line
						end
					end
					l_file.close
				else
					Result := 1
				end
			end
		rescue
			l_retried := True
			Result := 1
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
		end

feature -- Status report

	is_for_feature: BOOLEAN
			-- Is a feature wrapped in Current?
		do
			Result := e_feature /= Void
		ensure
			good_result: Result implies e_feature /= Void
		end

	is_for_workbench: BOOLEAN
			-- Is for workbench?

feature{NONE} -- Implementation

	c_file (a_class_type: CLASS_TYPE): STRING_32
			-- C file name for `a_class_type'
			-- If that C file is not generated, return an empty string.
		require
			a_class_type_attached: a_class_type /= Void
			system_defined: workbench.system_defined
		local
			l_mode: BOOLEAN
			l_package_name: STRING
			l_dir_name: DIRECTORY_NAME_32
			l_location: STRING_32
			l_dir: DIRECTORY
		do
			l_mode := context.workbench_mode
			set_context_mode (is_for_workbench)

				-- Check if C folder is created.
			if is_for_workbench then
				l_location := project_location.workbench_path
			else
				l_location := project_location.final_path
			end
			create l_dir_name.make_from_string (l_location)
			l_package_name := packet_name (c_prefix, a_class_type.packet_number)
			l_dir_name.extend (l_package_name)
			create l_dir.make (l_dir_name)
			if l_dir.exists then
				Result := full_file_name (not is_for_workbench, l_package_name, a_class_type.base_file_name, Void)
				Result.append (dot_c)
			else
				Result := ""
			end
			set_context_mode (l_mode)
		ensure
			result_attached: Result /= Void
		end

	set_context_mode (a_workbench_mode: BOOLEAN)
			-- If `a_workbench_mode' is True, enable workbench mode in `context',
			-- otherwise enable final mode.
		do
			if a_workbench_mode then
				context.set_workbench_mode
			else
				context.set_final_mode
			end
		end

invariant
	status_valid: e_feature /= Void implies class_c /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
