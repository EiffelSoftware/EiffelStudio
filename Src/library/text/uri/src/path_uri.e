note
	description: "[
			Object representing File uri for local PATH representation	
			i.e provide conversion from a 'file://' URI to native PATH object
			
			Creation from string, file URI, and PATH
			This allows to easily convert PATH to URI, and reverse
			
			for instance on Windows
				uri: PATH_URI
				create uri.make_from_path (create {PATH}.make_from_string ("c:\dev\abc\foo"))
				print (uri.string)
				> file:///c:/dev/abc/foo
				
				create v.make_from_file_uri (create {URI}.make_from_string ("file:///c:/dev/abc/foo/bar"))
				print (uri.file_path.name)
				> c:\dev\abc\foo\bar

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PATH_URI

inherit
	URI
		redefine
			make_from_string,
			hier
		end

create
	make_from_string,
	make_from_file_uri,
	make_from_path

feature {NONE} -- Initialization

	make_from_string (a_string: READABLE_STRING_8)
		do
			if a_string.starts_with_general ("file:") then
				Precursor (a_string)
				get_file_path
			else
				make_from_path (create {PATH}.make_from_string (a_string))
			end
		end

	make_from_file_uri (a_uri: URI)
		require
			is_file_uri: a_uri.scheme.same_string_general ("file")
		do
			make_from_uri (a_uri)
			get_file_path
		end

	make_from_path (a_path: PATH)
		local
			p: PATH
			s: STRING_32
			l_item_name: READABLE_STRING_32
			l_components: LIST [PATH]
			is_abs: BOOLEAN
			i: INTEGER
		do
			p := a_path
			if a_path.is_absolute then
				is_abs := True
			end
			file_path := p
			set_scheme ("file")
			set_path ("")

			is_absolute := is_abs

			if {PLATFORM}.is_windows then
				l_components := p.components

				from
					l_components.start
				until
					l_components.after
				loop
					l_item_name := l_components.item.name
					if p.has_root and then l_components.isfirst then
							-- Is root
						check item_is_root: attached p.root as p_root and then l_item_name.same_string (p_root.name) end
						if l_item_name.starts_with_general ("\\") then
							i := l_item_name.index_of ('\', 3)
							if i > 0 then
								set_hostname (l_item_name.substring (3, i - 1))
								l_item_name := l_item_name.substring (i + 1, l_item_name.count)
							else
								check invalid_root_value: False end
							end
						end
						create s.make_from_string (l_item_name)
						if s[s.count] = '\' then
							if l_components.islast then
								s[s.count] := '/'
							else
								s.remove_tail (1)
							end
						end

						if is_abs and (s.is_empty or else s[1] /= '/') then
							s.prepend_character ('/')
						end
						if not l_components.islast then
							l_components.forth
							if is_abs and s[s.count] /= '/' then
								s.append_character ('/')
							end
							append_percent_encoded_string_to (l_components.item.name, s)
						end
						set_path (s)
					elseif l_components.isfirst then
						check not is_abs end
						set_unencoded_path (l_item_name)
					else
						add_unencoded_path_segment (l_item_name)
					end
					l_components.forth
				end
			else
				set_unencoded_path (p.name)
			end
		end

	get_file_path
		local
			p: PATH
			l_segments: LIST [READABLE_STRING_32]
			s: STRING_32
			i: INTEGER
		do
			l_segments := decoded_path_segments
			if l_segments.is_empty then
				create p.make_empty
			else
				from
					l_segments.start
					if {PLATFORM}.is_windows then
						if l_segments.item.is_empty then
							l_segments.forth
						end
						if l_segments.after then
							create p.make_empty
						else
							create s.make_from_string (l_segments.item)
							i := s.index_of ('|', 1)
							if i > 0 then
								s[i] := ':'
							else
								i := s.index_of (':', 1)
							end
							if i > 0 then
								is_absolute := True
									-- Absolute
								if i = s.count and not l_segments.islast then
									s.append_character ('\')
								end
								create p.make_from_string (s)
							else
								create p.make_empty
								p := p.extended (s)
							end
							l_segments.forth
						end
					else -- Not Windows
						if l_segments.item.is_empty then
							create p.make_from_string ("/")
						else
							create p.make_from_string (l_segments.item)
						end
						l_segments.forth
					end
				until
					l_segments.after
				loop
					if not l_segments.item.is_empty then
						p := p.extended (l_segments.item)
					end
					l_segments.forth
				end
			end
			file_path := p
		end

feature -- Access

	file_path: PATH
			-- Associated local PATH.

	is_absolute: BOOLEAN
			-- Is current URI represents an absolute path?

	hier: READABLE_STRING_8
			-- Hier part.
			-- hier-part   = "//" authority path-abempty
            --      / path-absolute
            --      / path-rootless
            --      / path-empty
		local
			s: STRING_8
		do
			create s.make (10)
			if attached authority as l_authority then
				s.append_character ('/')
				s.append_character ('/')
				s.append (l_authority)
			elseif is_absolute then
				s.append_character ('/')
				s.append_character ('/')
			end
			s.append (path)
			Result := s
		end

invariant

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
