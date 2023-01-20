note
	description: "[
			Useful routines to import to JSON.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_IMPORT_JSON_UTILITIES

feature -- Access

	json_value_from_string (a_json_string: READABLE_STRING_GENERAL): detachable JSON_VALUE
		local
			s: STRING_8
			jp: JSON_PARSER
		do
			if a_json_string.is_valid_as_string_8 then
				s := a_json_string.to_string_8
			else
				s := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_json_string)
			end
			create jp.make
			jp.parse_string (s)
			if
				jp.is_parsed and then
				jp.is_valid
			then
				Result := jp.parsed_json_value
			end
		end

	json_value_from_location (a_location: PATH): detachable JSON_VALUE
		local
			f: RAW_FILE
			s: STRING
		do
			create f.make_with_path (a_location)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
					create s.make (0)
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					s.append (f.last_string)
				end
				f.close
				Result := json_value_from_string (s)
			end
		end

	json_object_from_location (a_location: PATH): detachable JSON_OBJECT
		do
			if attached {JSON_OBJECT} json_value_from_location (a_location) as jo then
				Result := jo
			end
		end

	json_string_item (j: JSON_OBJECT; a_name: READABLE_STRING_GENERAL): detachable STRING_32
		do
			if attached {JSON_STRING} j.item (a_name) as s then
				Result := s.unescaped_string_32
			end
		end

	json_string_8_item (j: JSON_OBJECT; a_name: READABLE_STRING_GENERAL): detachable STRING_8
		do
			if attached {JSON_STRING} j.item (a_name) as s then
				Result := s.unescaped_string_8
			end
		end

	json_integer_item (j: JSON_OBJECT; a_name: READABLE_STRING_GENERAL): INTEGER_64
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {JSON_NUMBER} j.item (a_name) as i then
				Result := i.integer_64_item
			elseif attached {JSON_STRING} j.item (a_name) as js then
				s := js.unescaped_string_32
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

	json_date_item (j: JSON_OBJECT; a_name: READABLE_STRING_GENERAL): detachable DATE_TIME
		local
			hd: HTTP_DATE
			i,y,m,d,h,min,sec: INTEGER
			s: STRING_8
		do
			if attached {JSON_NUMBER} j.item (a_name) as num then
				create hd.make_from_timestamp (num.integer_64_item)
				Result := hd.date_time
			elseif attached {JSON_STRING} j.item (a_name) as js then
				s := js.unescaped_string_8

					-- Parse yyyy-mm-dd hh:mm:ss
					--	     1234567890123456789
				i := s.index_of ('-', 1)
				if i = 5 then
					y := s.substring (1, i - 1).to_integer
					i := s.index_of ('-', i + 1)
					if i = 8 then
						m := s.substring (6, i - 1).to_integer
						i := s.index_of (' ', i + 1)
						if i = 11 then
							d := s.substring (9, i - 1).to_integer
							i := s.index_of (':', i + 1)
							if i = 14 then
								h := s.substring (12, i - 1).to_integer
								i := s.index_of (':', i + 1)
								if i = 17 then
									min := s.substring (15, i - 1).to_integer
									sec := s.substring (i + 1, s.count).to_integer
									create Result.make (y,m,d,h,min,sec)
								end
							end
						end
					end
				end
				if Result = Void then
					create hd.make_from_string (s)
					if not hd.has_error then
						Result := hd.date_time
					end
				end
			end
		end

note
	copyright: "2011-2023, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
