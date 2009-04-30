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
	ES_C_FUNCTION_MAPPER

inherit
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

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

	c_class_file_name: detachable FILE_NAME
			-- Retrieves the name of the Eiffel generated C file name.
			-- Note: The result may not exist.
		local
			l_name: STRING
			l_file_name: STRING
		do
			if project_location.is_compiled then
				l_name := packet_name (c_prefix, class_type.packet_number)
				l_file_name := full_file_name (is_for_finalized, l_name, class_type.base_file_name, dot_c)
				if file_system.file_exists (l_file_name) then
					create Result.make_from_string (l_file_name)
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: Result /= Void implies file_system.file_exists (Result)
		end

	c_class_path: detachable DIRECTORY_NAME
			-- Retrieves the name of the Eiffel generated C file name's containing folder.
			-- Note: The result may not exist.
		do
			if attached c_class_file_name as l_file_name then
				create Result.make_from_string (file_system.dirname (l_file_name))
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: Result /= Void implies file_system.directory_exists (Result)
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
		do
			if attached c_class_file_name as l_file_name then
				create l_file.make (l_file_name)
				if l_file.exists and then l_file.is_readable then
						-- Build the search string, identifying the written class and feature name.
					create l_search_string.make (30)
					l_search_string.append ("/* {")
					l_search_string.append (a_feature.written_class.name_in_upper)
					l_search_string.append ("}.")
					l_search_string.append (a_feature.name)
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
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
