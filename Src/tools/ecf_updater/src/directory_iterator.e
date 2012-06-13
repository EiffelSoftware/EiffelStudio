note
	description: "Summary description for {DIRECTORY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DIRECTORY_ITERATOR

inherit
	DIRECTORY_VISITOR

	SHARED_FILE_SYSTEM

feature -- Visitor

	process_directory (dn: READABLE_STRING_GENERAL)
		local
			d: DIRECTORY
			l_sep: READABLE_STRING_8
		do
			create d.make (dn.as_string_8)
			if d.exists and then d.is_readable then
				l_sep := operating_environment.directory_separator.out
				if attached file_system.names (d) as t_files_dirs then
					across
						t_files_dirs.files as c_f
					loop
						if not file_excluded (c_f.item) then
							process_file (d.name + l_sep + c_f.item)
						end
					end

					across
						t_files_dirs.dirs as c_d
					loop
						if not directory_excluded (c_d.item) then
							process_directory (d.name + l_sep + c_d.item)
						end
					end
				end
			end
		end

	process_file (f: READABLE_STRING_GENERAL)
		do
		end

feature -- Status

	directory_excluded (dn: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := False
		end

	file_excluded (fn: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := False
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
