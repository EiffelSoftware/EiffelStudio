note
	description: "[
		Maps a Eiffel frozen class/feature to a generated C routine.
		
		There is no caching of the generated C file when retrieving feature names. Every request made
		will traverse the generated code from the beginning.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TO_C_FUNCTION_MAPPER

inherit
	ANY

	SHARED_CODE_FILES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like class_c; a_type: like class_type)
			-- Initialize a function name mapper with a compiled class.
			--
			-- `a_class':
			-- `a_finalized': True to
		require
			a_class_attached: a_class /= Void
			a_type_attached: a_type /= Void
		do
			class_c := a_class
			class_type := a_type
		ensure
			class_c_set: class_c = a_class
			class_type_set: class_type = a_type
		end

feature -- Access

	class_c: CLASS_C
			-- Compiler class used to reference the C generated source.

	class_type: CLASS_TYPE
			-- The class type variant (used for generic selection).

feature -- Status report

	is_for_finalized: BOOLEAN assign set_is_for_finalized
			-- Indicates if the retrieval for finalized code.

feature -- Status setting

	set_is_for_finalized (a_finalized: BOOLEAN)
			-- Sets workbench/finalized
		do
			is_for_finalized := a_finalized
		ensure
			is_for_finalized_set: is_for_finalized = a_finalized
		end

feature -- Query

	c_class_file_name: detachable FILE_NAME_32
			-- Retrieves the name of the Eiffel generated C file name.
			-- Note: The result may not exist.
		local
			l_file_name: STRING_32
			u: FILE_UTILITIES
		do
			if project_location.is_compiled then
				create l_file_name.make (class_type.base_file_name.count + dot_c.count)
				l_file_name.append (class_type.base_file_name)
				l_file_name.append (dot_c)

				if is_for_finalized then
					create Result.make_from_string (project_location.final_path)
				else
					create Result.make_from_string (project_location.workbench_path)
				end
				Result.extend (packet_name (c_prefix, class_type.packet_number))
				Result.set_file_name (l_file_name)

				if not u.file_exists (Result) then
					Result := Void
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: Result /= Void implies (create {FILE_UTILITIES}).file_exists (Result)
		end

	c_class_path: detachable DIRECTORY_NAME_32
			-- Retrieves the name of the Eiffel generated C file name's containing folder.
			-- Note: The result may not exist.
		local
			u: GOBO_FILE_UTILITIES
		do
			if attached c_class_file_name as l_file_name then
				create Result.make_from_string (u.file_directory_path (l_file_name).as_string_32)
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: Result /= Void implies (create {FILE_UTILITIES}).directory_exists (Result)
		end

	c_feature_line (a_feature: E_FEATURE): NATURAL
			-- Retrieves a the line of a given feature of the class.
			--
			-- `a_feature': The feature to retrieve a line number for.
			-- `Result': A corresponding line number of 0 if the
		require
			a_feature_attached: a_feature /= Void
			a_feature_written_in_class_c: a_feature.written_class = class_c
		local
			l_search_string: STRING
			l_file: PLAIN_TEXT_FILE
			l_line: STRING
			i: NATURAL
			u: FILE_UTILITIES
		do
			if attached c_class_file_name as l_file_name then
				l_file := u.make_text_file (l_file_name)
				if l_file.exists and then l_file.is_readable then
						-- Build the search string, identifying the written class and feature name.
					create l_search_string.make (30)
					l_search_string.append ("/* {")
					l_search_string.append (a_feature.written_class.name_in_upper)
					l_search_string.append ("}.")
						-- |FIXME: Unicode search.
					l_search_string.append (a_feature.name_32.as_string_8)
					l_search_string.append (" */")

					from
						l_file.open_read
						l_file.read_line
					until
						l_file.end_of_file or
						Result > 0
					loop
						i := i + 1
						l_line := l_file.last_string
						if not l_line.is_empty then
							l_line.left_adjust
							l_line.right_adjust
							if l_line ~ l_search_string then
									-- We want the next line, the one with the routine signature on it, not the comment.
								Result := i + 1
							end
						end
						if Result = 0 then
							l_file.read_line
						end
					end
				end
			end
		end

invariant
	class_c_attached: class_c /= Void
	class_type_attached: class_type /= Void

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
