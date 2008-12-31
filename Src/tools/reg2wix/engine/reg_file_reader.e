note
	description: "[
		Utility used to open registry files and construct {REG_FILE} instances.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	REG_FILE_READER

inherit
	ERROR_HANDLER_PROVIDER

create
	make

feature {NONE} -- Access

	ini_reader: INI_DOCUMENT_READER
			-- Reader used to parse INI documents
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Conversion

	load_reg_file (a_file_name: STRING): REG_FILE
			-- Load a registry from from a file `a_file_name'
			-- Note: Unsuccessful loads will return Void.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_file: PLAIN_TEXT_FILE
			l_document: INI_DOCUMENT
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read (a_file_name)
				ini_reader.read_from_file (l_file, False)
				if ini_reader.successful then
					l_document := ini_reader.read_document
					create Result.make (l_document, error_handler)
					if Result.is_empty then
							-- Not a valid file
						Result := Void
					else
						Result.set_source_file_name (a_file_name)
					end

				else

				end
			else
				Result := Void
			end

			if Result = Void then
				error_handler.add_warning (create {RWWI}.make (a_file_name))
			end

			if l_file /= Void then
					-- Enusre file is always closed
				l_file.close
			end
		rescue
			retried := True
			retry
		end

	load_reg_files (a_files: LINEAR [STRING]): HASH_TABLE [REG_FILE, STRING]
			-- Load a collection of files from the file names in `a_files'. The
			-- returned table contains all loaded reg files indexesd by their file name.
			-- Note: For all reg files that cannot be parsed, the result's item, at the
			--       respective file name index, will be Void.
		require
			a_files_attached: a_files /= Void
			not_a_files_is_empty: not a_files.is_empty
			a_files_items_attached: not a_files.has (Void)
			not_a_files_items_is_empty: a_files.for_all (agent (a_item: STRING): BOOLEAN do Result := not a_item.is_empty end)
			a_files_items_exists: a_files.for_all (agent (a_item: STRING): BOOLEAN do Result := (create {RAW_FILE}.make (a_item)).exists end)
		local
			l_files: like a_files
		do
			create Result.make (5)

			l_files := a_files.twin
			from l_files.start until l_files.after loop
				Result.force (load_reg_file (l_files.item), l_files.item)
				l_files.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_compares_objects: Result.object_comparison
		end

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
