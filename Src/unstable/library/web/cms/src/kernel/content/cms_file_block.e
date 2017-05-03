note
	description: "[
			CMS block with file content.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_FILE_BLOCK

inherit
	CMS_BLOCK
		redefine
			out
		end

create
	make,
	make_raw

feature {NONE} -- Initialization

	make (a_name: like name; a_title: like title; a_files_root_path: detachable PATH; a_file_location: PATH)
			-- Create Current with `a_name', `a_title', `a_file_location'
			-- inside root directory `a_files_root_path' for the files.
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			is_enabled := True
			name := a_name
			title := a_title
			location := a_file_location
			root_path := a_files_root_path
		end

	make_raw (a_name: like name; a_title: like title; a_files_root_path: PATH; a_file_location: PATH)
			-- Create Current with `a_name', `a_title', `a_file_location'
			-- inside root directory `a_files_root_path' for the files.
		require
			a_name_not_blank: not a_name.is_whitespace
		do
			make (a_name, a_title, a_files_root_path, a_file_location)
			set_is_raw (True)
		end

feature -- Access

	name: READABLE_STRING_8
			-- <Precursor>

	location: PATH
			-- Location of file.

	root_path: detachable PATH
			-- Root location for files universe.

	resolved_location: PATH
			-- Path of related file, taking into account `root_path' and `location'.
		do
				-- Process html generation
			if attached root_path as l_root_path then
				Result := l_root_path.extended_path (location)
			else
				Result := location
			end
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is current block empty?
		do
			Result := not exists
			debug ("cms")
				Result := True
			end
		end

	is_raw: BOOLEAN
			-- Is raw?
			-- If True, do not get wrapped it with block specific div	

	exists: BOOLEAN
		local
			ut: FILE_UTILITIES
		do
			Result := ut.file_path_exists (resolved_location)
		end

feature -- Element change

	set_is_raw (b: BOOLEAN)
		do
			is_raw := b
		end

	set_name (n: like name)
			-- Set `name' to `n'.
		require
			not n.is_whitespace
		do
			name := n
		end

feature -- Conversion

	to_html (a_theme: CMS_THEME): STRING_8
			-- <Precursor>
		local
			p: detachable PATH
			f: RAW_FILE
			ut: FILE_UTILITIES
		do
				-- Process html generation
			p := resolved_location
			if ut.file_path_exists (p) then
				create f.make_with_path (p)
				if f.exists and then f.is_access_readable then
					create Result.make (f.count)
					f.open_read
					from
					until
						f.end_of_file or f.exhausted
					loop
						f.read_stream_thread_aware (1_024)
						Result.append (f.last_string)
					end
					f.close
				else
					Result := ""
					debug ("cms")
						Result := "File block #" + name
					end
				end
			else
				Result := ""
				debug ("cms")
					Result := "File block #" + name
				end
			end
		end

feature -- Debug

	out: STRING
		local
			utf: UTF_CONVERTER
		do
			create Result.make_from_string (generator)
			Result.append ("%Nname:")
			Result.append (name)
			if attached title as l_title then
				Result.append ("%N%Ttitle:")
				Result.append (utf.string_32_to_utf_8_string_8 (l_title))
			end
			Result.append ("%Nlocation:")
			Result.append (location.out)
			if attached root_path as l_root_path then
				Result.append ("%Nroot_path:")
				Result.append (l_root_path.out)
			end
			Result.append ("%N")
		end
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
