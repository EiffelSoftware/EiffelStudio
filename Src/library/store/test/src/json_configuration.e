class JSON_CONFIGURATION

create
	make,
	make_from_string

feature {NONE} -- Initialization

	make (fn: STRING_32)
		require
			fn_not_empty: fn /= Void and then not fn.is_empty
		do
			filename := fn
		end

	make_from_string (s: READABLE_STRING_32)
		do
			text := s
		end

	filename: detachable READABLE_STRING_32

	text: detachable READABLE_STRING_32

feature -- Report

	has_location: BOOLEAN
		do
			Result := location /= Void
		end

	location: detachable READABLE_STRING_32
		do
			Result := filename
		end

	to_json_representation: READABLE_STRING_8
		do
			if attached data as d then
				Result := d.representation
			else
				Result := "{ }"
			end
		end

feature -- Element change

	set_location (a_loc: like location)
		do
			filename := a_loc
			data := Void
		end

	set_text (t: like text)
		require
			not_has_location: has_location
		do
			text := t
		end

feature -- Status report

	has_error: BOOLEAN

feature -- Basic operation

	reset_error
		do
			has_error := False
		end

	load
		local
			p: JSON_PARSER
			f: PLAIN_TEXT_FILE
			s, t: detachable STRING_8
			i: INTEGER
			u: UTF_CONVERTER
		do
			reset_error
			if attached filename as fn then
				create f.make_with_name (fn)
				if f.exists and then f.is_readable then
					create s.make (f.count)
					from
						f.open_read
						if f.readable or f.file_readable then
							f.read_stream (1024)
							t := f.last_string
							s.append_string (t)
						end
					until
						t = Void or else t.is_empty or else not (f.file_readable or f.readable)
					loop
						f.read_stream (1024)
						t := f.last_string
						s.append_string (t)
					end
				end
			end
			if
				s = Void and then
				attached text as l_text
			then
				create s.make_from_string (u.string_32_to_utf_8_string_8 (l_text))
			end
			if s /= Void then
				from
					i := 1
				until
					s [i] = '{'
				loop
					i := i + 1
				end
				if i > 1 then
					s.remove_head (i - 1)
				end

				create p.make_with_string (s)
				p.parse_content
				if
					p.is_parsed and then
					attached p.parsed_json_object as j
				then
					data := j
				end
				has_error := p.errors.count > 0
				debug
					if has_error then
						⟳ e: p.errors ¦ print (e + "%N") ⟲
					end
				end
			end
			text := Void
		end

	save
		require
			has_location: location /= Void
		local
			f: RAW_FILE
		do
			if attached location as l_location then
				create f.make_with_name (l_location)
				if not f.exists or else f.is_writable then
					f.open_write
					if attached text as l_text then
						f.put_string ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_text))
					elseif attached data as l_data then
						f.put_string (l_data.representation)
					end
					f.close
					load
				end
			else
				check has_location: False end
			end
		ensure
			same_data: (attached (old data) as l_old_data) implies (attached data as l_data and then l_data.representation.same_string (l_old_data.representation))
		end

feature -- Access

	item (k: READABLE_STRING_8): detachable STRING
		do
			if attached json_value (data, k) as v then
				if attached {JSON_STRING} v as j_string then
					Result := j_string.unescaped_string_8
				else
					Result := v.representation
				end
			end
		end

	items (k: STRING): detachable HASH_TABLE [STRING, STRING]
		do
			if attached map_representation (k) as l_map then
				create Result.make (l_map.count)
				across
					l_map as c
				loop
					if attached {JSON_STRING} c as v then
						Result.force (v.unescaped_string_8, @ c.key.unescaped_string_8)
					end
				end
			end
		end

	map_representation (k: STRING): detachable HASH_TABLE [JSON_VALUE, JSON_STRING]
		do
			if attached {JSON_OBJECT} json_value (data, k) as o then
				Result := o.map_representation
			end
		end

feature -- Query

	json_value (a_json_data: detachable JSON_VALUE; a_id: READABLE_STRING_GENERAL): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [READABLE_STRING_GENERAL]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						create l_id.make_from_string_general (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end

feature {NONE} -- Implementation

	data: detachable JSON_OBJECT

end
