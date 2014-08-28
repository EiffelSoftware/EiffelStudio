note
	description: "Summary description for {CMS_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CONFIGURATION

inherit
	ANY

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make,
	make_from_file

feature {NONE} -- Initialization

	make
		do
			create options.make_equal (10)
			analyze
		end

	make_from_file (a_filename: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		local
			p: PATH
		do
			make
			create p.make_from_string (a_filename)
			configuration_location := p
			import_from_path (p)
			analyze
		end

	analyze
		do
			get_root_location
			get_var_location
			get_themes_location
			get_files_location
		end

feature -- Access

	configuration_location: detachable PATH

	option (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := options.item (a_name)
		end

	options: STRING_TABLE [STRING_32]

feature -- Conversion

	append_to_string (s: STRING)
		local
			utf: UTF_CONVERTER
		do
			s.append ("Options:%N")
			across
				options as c
			loop
				s.append (c.key.to_string_8)
				s.append_character ('=')
				utf.string_32_into_utf_8_string_8 (c.item, s)
				s.append_character ('%N')
			end

			s.append ("Specific:%N")
			s.append ("root_location=" + root_location.utf_8_name + "%N")
			s.append ("var_location=" + var_location.utf_8_name + "%N")
			s.append ("files_location=" + files_location.utf_8_name + "%N")
			s.append ("themes_location=" + themes_location.utf_8_name + "%N")
		end

feature -- Element change

	set_option (a_name: READABLE_STRING_GENERAL; a_value: STRING_32)
		do
			options.force (a_value, a_name.as_string_8)
		end

feature -- Access

	var_location: PATH

	root_location: PATH

	files_location: PATH

	themes_location: PATH

	theme_name (dft: detachable like theme_name): READABLE_STRING_8
		do
			if attached options.item ("theme") as s then
				Result := s
			elseif dft /= Void then
				Result := dft
			else
				Result := "default"
			end
		end

	site_id: READABLE_STRING_8
		do
			if attached options.item ("site.id") as s then
				Result := s
			else
				Result := "_EWF_CMS_NO_ID_"
			end
		end

	site_name (dft: like site_name): READABLE_STRING_8
		do
			if attached options.item ("site.name") as s then
				Result := s
			else
				Result := dft
			end
		end

	site_url (dft: like site_url): READABLE_STRING_8
		do
			if attached options.item ("site.url") as s then
				Result := s
			else
				Result := dft
			end
			if Result /= Void then
				if Result.is_empty then
					-- ok
				elseif not Result.ends_with ("/") then
					Result := Result + "/"
				end
			end
		end

	site_script_url (dft: like site_script_url): detachable READABLE_STRING_8
		do
			if attached options.item ("site.script_url") as s then
				Result := s
			else
				Result := dft
			end
			if Result /= Void then
				if Result.is_empty then
				elseif not Result.ends_with ("/") then
					Result := Result + "/"
				end
			end
		end

	site_email (dft: like site_email): READABLE_STRING_8
		do
			if attached options.item ("site.email") as s then
				Result := s
			else
				Result := dft
			end
		end

feature -- Change

	get_var_location
		local
			utf: UTF_CONVERTER
		do
			if attached options.item ("var-dir") as s then
				create var_location.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
			else
				var_location := execution_environment.current_working_path
			end
		end

	get_root_location
		local
			utf: UTF_CONVERTER
		do
			if attached options.item ("root-dir") as s then
				create root_location.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
			else
				root_location := execution_environment.current_working_path
			end
		end

	get_files_location
		local
			utf: UTF_CONVERTER
		do
			if attached options.item ("files-dir") as s then
				create files_location.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
			else
				create files_location.make_from_string ("files")
			end
		end

	get_themes_location
		local
			utf: UTF_CONVERTER
		do
			if attached options.item ("themes-dir") as s then
				create themes_location.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (s))
			else
				themes_location := root_location.extended ("themes")
			end
		end

feature {NONE} -- Implementation

	import_from_file (fn: READABLE_STRING_GENERAL)
		do
			import_from_path (create {PATH}.make_from_string (fn))
		end

	import_from_path (a_filename: PATH)
			-- Import ini file content
		local
			f: PLAIN_TEXT_FILE
			l,v: STRING_8
			p: INTEGER
		do
			create f.make_with_path (a_filename)
			if f.exists and f.is_readable then
				f.open_read
				from
					f.read_line
				until
					f.exhausted
				loop
					l := f.last_string
					l.left_adjust
					if not l.is_empty then
						if l[1] = '#' then
							-- commented line
						else
							p := l.index_of ('=', 1)
							if p > 1 then
								v := l.substring (p + 1, l.count)
								l.keep_head (p - 1)
								v.left_adjust
								v.right_adjust
								l.right_adjust

								if l.is_case_insensitive_equal ("@include") then
									import_from_file (resolved_string (v))
								else
									set_option (l.as_lower, resolved_string (v))
								end
							end
						end
					end
					f.read_line
				end
				f.close
			end
		end

feature {NONE} -- Environment

	resolved_string	(s: READABLE_STRING_8): STRING_32
			-- Resolved `s' using `options' or else environment variables.
		local
			i,n,b,e: INTEGER
			k: detachable READABLE_STRING_8
		do
			from
				i := 1
				n := s.count
				create Result.make (s.count)
			until
				i > n
			loop
				if i + 1 < n and then s[i] = '$' and then s[i+1] = '{' then
					b := i + 2
					e := s.index_of ('}', b) - 1
					if e > 0 then
						k := s.substring (b, e)
						if attached option (k) as v then
							if attached {READABLE_STRING_32} v as s32 then
								Result.append (s32)
							else
								Result.append (v.out)
							end
							i := e + 1
						elseif attached execution_environment.item (k) as v then
							Result.append (v)
							i := e + 1
						else
							Result.extend (s[i])
						end
					else
						Result.extend (s[i])
					end
				else
					Result.extend (s[i])
				end
				i := i + 1
			end
		end



end
