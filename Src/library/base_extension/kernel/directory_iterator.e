note
	description: "[
			Iterator on DIRECTORY
			
			This can be used to scan a directory recursively.
			For a directory, files are processed first, then folders.
			
			It is possible to exclude a path, a directory name, or a file name thanks to
				path_excluded, 
				directory_excluded, 
				and file_excluded
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIRECTORY_ITERATOR

inherit
	DIRECTORY_VISITOR

feature -- Visitor

	process_directory (dn: PATH)
			-- Iterate on directory `dn'
			-- process files first and then directories recursively.
		local
			fp, p: PATH
			d: DIRECTORY
			u: FILE_UTILITIES
			l_dirs: ARRAYED_LIST [PATH]
		do
			create d.make_with_path (dn)
			if
				d.is_readable and then
				attached d.entries as l_entries
			then
				create l_dirs.make (l_entries.count)
				across
					l_entries as c
				loop
					p := c
					if not path_excluded (p) then
						if not directory_excluded (p) then
							fp := d.path.extended_path (p)
							if u.directory_path_exists (fp) then
								l_dirs.force (p)
							end
						end
						if not file_excluded (p) then
							fp := d.path.extended_path (p)
							if u.file_path_exists (fp) then
								process_file (fp)
							end
						end
					end
				end

				across
					l_dirs as c
				loop
					check not_excluded: not directory_excluded (c) end
					process_directory (d.path.extended_path (c))
				end
			end
		end

	process_file (fn: PATH)
			-- Visit file `fn'.
		do
		end

feature -- Status

	path_excluded (a_path: PATH): BOOLEAN
			-- Is Path `a_path' excluded?
			--| this can be a directory or a file
		require
			a_path_is_simple: a_path.is_simple
		do
			Result := a_path.is_current_symbol or a_path.is_parent_symbol
		end

	directory_excluded (dn: PATH): BOOLEAN
			-- Is Directory `dn' excluded?
		require
			dn_is_simple: dn.is_simple
			path_not_excluded: not path_excluded (dn)
		do
			Result := False
		end

	file_excluded (fn: PATH): BOOLEAN
			-- Is file `fn' excluded?
		require
			fn_is_simple: fn.is_simple
			path_not_excluded: not path_excluded (fn)
		do
			Result := False
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
