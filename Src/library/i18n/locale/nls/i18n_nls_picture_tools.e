note
	description: "Features to convert the date/time formatting strings from the NLS format to our format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_PICTURE_TOOLS

feature -- Interface

	translate_date_format(in: STRING_32): STRING_32
		--
		require
			in_not_null: in /= Void
		do
			Result := translate_picture_string(in, agent is_date_code_character, agent process_date_code)
		end

	translate_time_format(in: STRING_32): STRING_32
			--
		require
			in_not_null: in /= Void
		do
			Result := translate_picture_string(in, agent is_time_code_character, agent process_time_code)
		end


feature -- Do the work through the power of agents

	translate_picture_string(in:STRING_32;
							is_code_character: FUNCTION[ANY, TUPLE[CHARACTER_32], BOOLEAN];
							process_code: FUNCTION[ANY, TUPLE[STRING_32], STRING_32]
										): STRING_32
		-- Transforms an NLS "date format picture string" into somthing suitable for I18N_FORMAT_STRING
		-- An NLS format string is a sequence of format codes, spaces and user strings
		-- (between single quotes). Anything else we ignore.
		-- Oh yes: two single quotes -> one quote in result.
		require
				is_code_character_not_void: is_code_character /= Void
				process_code_not_void: process_code /= Void
				input_not_void: in /= Void
		local
			i: INTEGER
			j: INTEGER
		do
			create Result.make_empty
			from
				i := 1
				j := 1
			until
				i > in.count
			loop
				if
					in.item (i) = ' ' or in.item (i) = '/' or
					in.item (i) = ':' or in.item (i) = ',' or
					in.item (i) = '.'
				then
						-- append character to string, as we preserve them
						-- slash, dot, comma and colon should be thrown away according to MS
						-- documentation, but apparently it's wrong.
					Result.append_character(in.item(i))
				elseif in.item (i) = '%'' then -- hope that was a ' character
						-- start of 'user' string that we must preserve: read this to the end
					from
						j := i+1
					until
						j > in.count or in.item(j) = '%''
					loop
						j := j+1
					end
						-- special case: is the string ''?
					if j <= in.count and j-i = 1 then
						Result.append_character('%'')
					else
						Result.append(in.substring(i+1,j-1))
					end
					i := j
				elseif
					is_code_character.item([in.item(i)])
				then
						--start of formatting code: this _must_ be a sequence of in.item(i).code
					from
						j := i+1
					until
						j > in.count or in.item(j) /= in.item(i)
					loop
						j := j+1
					end
						-- what did we get?
					Result.append(process_code.item([in.substring(i, j-1)]))
					i := j-1  -- character at j was not part of the format string
				end
				i := i + 1
			end
		end

feature -- Helper functions

	is_date_code_character(c: CHARACTER_32): BOOLEAN
			--
		require
			c /= Void
		do
			Result := c = 'd' or  c = 'M' or c = 'y' or c = 'g'
		end

	is_time_code_character(c: CHARACTER_32): BOOLEAN
			--
		require
			c /= Void
		do
			Result := c = 'm' or  c = 's' or c = 't' or c = 'h' or c = 'H'
		end


	process_date_code(code:STRING_32): STRING_32
		-- Transforms a format code.
		require
			argument_not_void: code /= Void
		do
			create Result.make_empty
			if code.is_equal ("d") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.day_of_month)
			elseif code.is_equal ("dd") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.day_of_month_padded)
			elseif code.is_equal ("ddd") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.abbreviated_day_name)
			elseif code.is_equal ("dddd") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.day_name)
			elseif code.is_equal ("M") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.month)
			elseif code.is_equal ("MM") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.month_padded)
			elseif code.is_equal ("MMM") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.abbreviated_month_name1)
			elseif code.is_equal ("MMMM") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.month_name)
			elseif code.is_equal ("y") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.year_1)
			elseif code.is_equal ("yy") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.year_2)
			elseif code.is_equal ("yyy") or code.is_equal("yyyy") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.year_4)
			elseif code.is_equal ("gg") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.era)
			else
				-- It wasn't a valid format code, so we won't take it into account
			end
		ensure
			Result_not_void: Result /= Void
		end

	process_time_code(code:STRING_32): STRING_32
			-- Transforms a time format code.
		require
			argument_not_void: code /= Void
		do
			create Result.make_empty
			if code.is_equal ("h") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.hour_12)
			elseif code.is_equal ("hh") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.hour_12_padded)
			elseif code.is_equal ("H") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.hour_24)
			elseif code.is_equal ("HH") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.hour_24_padded)
			elseif code.is_equal ("m") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.minutes)
			elseif code.is_equal ("mm") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.minutes_padded)
			elseif code.is_equal ("s") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.seconds)
			elseif code.is_equal ("ss") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.seconds_padded)
			elseif code.is_equal ("t") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.am_pm_1)
			elseif code.is_equal ("tt") then
				Result.append_character({I18N_FORMATTING_CHARACTERS}.escape_character)
				Result.append_character({I18N_FORMATTING_CHARACTERS}.am_pm_lowercase)
			else
				-- It wasn't a valid format code, so we won't take it into account
			end
		ensure
			Result_not_void: Result /= Void
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
