note
	description: "[
		Represents a Windows registry file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	REG_FILE

inherit
	ERROR_HANDLER_PROVIDER
		rename
			make as make_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_doc: INI_DOCUMENT; a_handler: like error_handler)
			-- Initialize registry file using document `a_doc'.
		require
			a_doc_attached: a_doc /= Void
			a_handler_attached: a_handler /= Void
		do
			make_error (a_handler)
			create internal_keys.make (a_doc.sections.count)
			process_ini_content (a_doc)
		ensure
			error_handler_set: error_handler = a_handler
		end

feature -- Access

	source_file_name: STRING assign set_source_file_name
			-- Location of file, if any

	keys: LINEAR [REG_FILE_KEY]
			-- Registry file keys
		do
			Result := internal_keys
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

	set_source_file_name (a_file_name: like source_file_name)
			-- Set `source_file_name' with `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			not_has_source_file_name: not has_source_file_name
		do
			source_file_name := a_file_name
		ensure
			source_file_name_set: source_file_name = a_file_name
			has_source_file_name: has_source_file_name
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Indicates if the file has not content
		do
			Result := keys.is_empty
		end

	has_source_file_name: BOOLEAN
			-- Indicate if a source file name is available
		do
			Result := source_file_name /= Void
		end

feature {NONE} -- Process

	process_ini_content (a_doc: INI_DOCUMENT)
			-- Processes the content of an INI document `a_doc'
		require
			a_doc_attached: a_doc /= Void
			internal_keys_attached: internal_keys /= Void
		do
			a_doc.sections.do_all (agent (a_item: INI_SECTION)
				do
					internal_keys.extend (create {REG_FILE_KEY}.make (a_item, error_handler))
				end)
		end

feature {NONE} -- Internal implementation cache

	internal_keys: ARRAYED_LIST [REG_FILE_KEY]
			-- Mutable version of `keys'

invariant
	source_file_name_attached: has_source_file_name implies source_file_name /= Void
	not_source_file_name_is_empty: has_source_file_name implies not source_file_name.is_empty

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
