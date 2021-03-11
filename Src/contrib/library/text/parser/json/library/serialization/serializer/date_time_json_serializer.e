note
	description: "[
			JSON Serializer for DATE_TIME, DATE and TIME object following ISO 8601 specification.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DATE_TIME_JSON_SERIALIZER

inherit
	JSON_SERIALIZER

feature -- Conversion

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
			-- JSON value representing the JSON serialization of Eiffel value `obj', in the eventual context `ctx'.	
		local
			s: STRING_8
		do
			if attached {DATE_TIME} obj as dt then
				create s.make (20)
				append_date_to (dt.date, s) 				-- yyyy-mm-dd
				s.append_character ('T')					-- 'T'
				append_2_digits_fine_time_to (dt.time, s)	-- hh:mi:ss
				s.append_character ('Z')					-- 'Z'
				create {JSON_STRING} Result.make_from_string (s)
			elseif attached {DATE} obj as d then
				create s.make (10)
				append_date_to (d, s) 						-- yyyy-mm-dd
				create {JSON_STRING} Result.make_from_string (s)
			elseif attached {TIME} obj as t then
				create s.make (10)
				append_2_digits_fine_time_to (t, s)			-- hh:mi:ss... 
				create {JSON_STRING} Result.make_from_string (s)
			else
				create {JSON_NULL} Result
			end
		end

feature {NONE} -- Implementation

	append_date_to (d: DATE; s: STRING_8)
		do
			s.append (d.year.out) 					-- yyyy
			s.append_character ('-')				-- '-'
			append_2_digits_integer_to (d.month, s)	-- mm
			s.append_character ('-')				-- '-'
			append_2_digits_integer_to (d.day, s)	-- dd
		end

	append_2_digits_fine_time_to (t: TIME; s: STRING_8)
		local
			fd: FORMAT_DOUBLE
			r64: REAL_64
			f: STRING
		do
			append_2_digits_integer_to (t.hour, s)		-- hh
			s.append_character (':')					-- :
			append_2_digits_integer_to (t.minute, s)	-- mi
			s.append_character (':')					-- :
			create fd.make (2, 2)
			fd.show_trailing_zeros
			fd.show_zero
			r64 := t.second + t.fractional_second * 0.01
			f := fd.formatted (r64)
			if f.ends_with_general (".00") then
				append_2_digits_integer_to (t.second, s)-- ss				
			else
				if r64 < 10 then
					s.append_character ('0') -- '0'
				end
				s.append (f)							-- ss.nn
			end
		end

	append_2_digits_integer_to (i: INTEGER; s: STRING_8)
		require
			is_not_negative: i >= 0
		do
			if i <= 9 then
				s.append_character ('0')
			end
			s.append (i.out)
		end

note
	copyright: "2010-2021, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
