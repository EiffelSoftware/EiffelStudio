note
	description: "Control behavior of CONF_PARSE_VISITOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PARSER_CONTROLLER

feature -- Status

	is_ignore_bad_libraries: BOOLEAN
			-- Should bad libraries be ignored for all instances of Current?
		do
			Result := is_ignore_bad_libraries_cell.item
		end

	is_safe_preferred: BOOLEAN
			-- Are safe versions of libraries taken instead of reguslar ones?
		do
			Result := is_safe_preferred_cell.item
		end

feature -- Access

	resolved_library_path (path: STRING_32): STRING_32
			-- Library path computed under current conditions.
		local
			extension: STRING_32
			file: RAW_FILE_32
		do
			Result := path
				-- Check if "-safe" may need to be added.
			if is_safe_preferred and then path.count > 4 then
				extension := path.substring (path.count - 3, path.count)
					-- Apply translation only for "*.ecf" files.
				if extension.is_case_insensitive_equal (".ecf") then
					create file.make (path)
						-- Check if the original file really exists.
					if file.exists and then file.is_readable then
						Result := path.substring (1, path.count - 4)
						Result.append_string ("-safe")
						Result.append_string (extension)
						file.reset (path)
							-- Check if the "safe" version of the file exists.
						if not file.exists or else not file.is_readable then
								-- Rollback to the original path.
							Result := path
						end
					end
				end
			end
		end

feature -- Update

	set_is_ignore_bad_libraries (v: like is_ignore_bad_libraries)
			-- Set `is_ignore_bad_libraries' with `v' for all instances of Current.
		do
			is_ignore_bad_libraries_cell.put (v)
		ensure
			is_ignore_bad_libraries_set: is_ignore_bad_libraries = v
		end

	prefer_safe (v: BOOLEAN)
			-- Prefer "-safe" versions of "*.ecf" files if available.
		do
			is_safe_preferred_cell.put (v)
		ensure
			is_safe_preferred_set: is_safe_preferred = v
		end

feature {NONE} -- Implementation

	is_ignore_bad_libraries_cell: CELL [BOOLEAN]
			-- Storage for `is_ignore_bad_libraries' for all instances of Current.
		once
			create Result.put (False)
		ensure
			is_ignore_bad_libraries_cell_not_void: Result /= Void
		end

	is_safe_preferred_cell: CELL [BOOLEAN]
			-- Storage to `is_safe_preferred'.
		once
			create Result.put (False)
		ensure
			is_safe_preferred_cell_attached: attached Result
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end
