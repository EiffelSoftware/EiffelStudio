note

	description:

		"Expands special tokens in a template with given parameters"

	library: "Eiffel Wrapper Generator Support Library"
	copyright: "Copyright (c) 2001, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_TEMPLATE_EXPANDER

inherit

	KL_IMPORTED_STRING_ROUTINES

	KL_IMPORTED_ARRAY_ROUTINES

	KL_IMPORTED_ANY_ROUTINES

create

	make

feature {NONE} -- Initialisation

	make
		do
		end

feature -- Access

	expand_into_stream_from_array (a_stream: KI_TEXT_OUTPUT_STREAM; a_template: STRING; a_parameters: ARRAY [STRING])
			-- expands special tokens with parameters in template string
			--
			-- returns a new string based on `a_tmpl'
			-- where all occurences of "$N" or "${N}" (where N
			-- stands for [0-9]+) in `a_tmpl' are substituted by
			-- the entry `N' in `a_params' or left as "$N" or "${N}" if
			-- `N' is out of bounds. The character '$' is escaped
			-- using "$$".
		require
			a_stream_not_void: a_stream /= Void
			a_template_not_void: a_template /= Void
			a_parameters_not_void: a_parameters /= Void
		local
			str: STRING
			i, j, nb: INTEGER
			c: CHARACTER
			stop, lb, rb: BOOLEAN
		do
			str := STRING_.new_empty_string (a_template, 5)
			from
				i := 1
				nb := a_template.count
			until
				i > nb
			loop
				c := a_template.item (i)
				i := i + 1
				if c /= '$' then
					if c /= '%U' then
						a_stream.put_character (c)
					else
						a_stream.put_character (a_template.item (i - 1))
						-- TODO: remove
						-- Result := STRING_.appended_substring (Result, a_template, i - 1, i - 1)
					end
				elseif i > nb then
						-- Dollar at the end of `a_template'.
						-- Leave it as it is.
					a_stream.put_character ('$')
				else
					c := a_template.item (i)
					if c = '$' then
							-- Escaped dollar character.
						a_stream.put_character ('$')
						i := i + 1
					else
							-- Found beginning of a placeholder.
							-- It is either ${N} or $N.
						-- str := STRING_.new_empty_string (a_template, 5)
						str.wipe_out
						if c = '{' then
								-- Looking for a right brace.
							lb := True
							rb := False
							from
								i := i + 1
							until
								i > nb or rb
							loop
								c := a_template.item (i)
								if c = '}' then
									rb := True
								elseif c /= '%U' then
									str.append_character (c)
								else
									check
										same_type: ANY_.same_types (str, a_template)
									end
									STRING_.append_substring_to_string (str, a_template, i, i)
								end
								i := i + 1
							end
						else
								-- Looking for a non-numeric character
								-- (i.e. [^0-9]).
							lb := False
							rb := False
							from
								stop := False
							until
								i > nb or stop
							loop
								c := a_template.item (i)
								inspect c
								when '0'..'9' then
									str.append_character (c)
									i := i + 1
								else
									stop := True
								end
							end
						end
						if STRING_.is_decimal (str) then
							j := str.to_integer
							if a_parameters.valid_index (j) then
								a_stream.put_string (a_parameters.item (j))
							else
								a_stream.put_character ('$')
									-- Leave $N or ${N} unchanged.
								if lb then
									a_stream.put_character ('{')
								end
								a_stream.put_string (str)
								if rb then
									a_stream.put_character ('}')
								end
							end
						else
								-- Leave $N or ${N} unchanged.
							a_stream.put_character ('$')
							if lb then
								a_stream.put_character ('{')
							end
							a_stream.put_string (str)
							if rb then
								a_stream.put_character ('}')
							end
						end
					end
				end
			end
		end


	expand_from_array (a_template: STRING; a_parameters: ARRAY [STRING]): STRING 
			-- expands special tokens with parameters in template string
			--
			-- returns a new string based on `a_tmpl'
			-- where all occurences of "$N" or "${N}" (where N
			-- stands for [0-9]+) in `a_tmpl' are substituted by
			-- the entry `N' in `a_params' or left as "$N" or "${N}" if
			-- `N' is out of bounds. The character '$' is escaped
			-- using "$$".
		require
			a_template_not_void: a_template /= Void
			a_parameters_not_void: a_parameters /= Void
		local
			str: STRING
			i, j, nb: INTEGER
			c: CHARACTER
			stop, lb, rb: BOOLEAN
		do
			from
				i := 1
				nb := a_template.count
				Result := STRING_.new_empty_string (a_template, nb)
			until
				i > nb
			loop
				c := a_template.item (i)
				i := i + 1
				if c /= '$' then
					if c /= '%U' then
						Result.append_character (c)
					else
						Result := STRING_.appended_substring (Result, a_template, i - 1, i - 1)
					end
				elseif i > nb then
						-- Dollar at the end of `a_template'.
						-- Leave it as it is.
					Result.append_character ('$')
				else
					c := a_template.item (i)
					if c = '$' then
							-- Escaped dollar character.
						Result.append_character ('$')
						i := i + 1
					else
							-- Found beginning of a placeholder.
							-- It is either ${N} or $N.
						str := STRING_.new_empty_string (a_template, 5)
						if c = '{' then
								-- Looking for a right brace.
							lb := True
							rb := False
							from
								i := i + 1
							until
								i > nb or rb
							loop
								c := a_template.item (i)
								if c = '}' then
									rb := True
								elseif c /= '%U' then
									str.append_character (c)
								else
									check
										same_type: ANY_.same_types (str, a_template)
									end
									STRING_.append_substring_to_string (str, a_template, i, i)
								end
								i := i + 1
							end
						else
								-- Looking for a non-numeric character
								-- (i.e. [^0-9]).
							lb := False
							rb := False
							from
								stop := False
							until
								i > nb or stop
							loop
								c := a_template.item (i)
								inspect c
								when '0'..'9' then
									str.append_character (c)
									i := i + 1
								else
									stop := True
								end
							end
						end
						if STRING_.is_decimal (str) then
							j := str.to_integer
							if a_parameters.valid_index (j) then
								Result := STRING_.appended_string (Result, a_parameters.item (j))
							else
									-- Leave $N or ${N} unchanged.
								Result.append_character ('$')
								if lb then
									Result.append_character ('{')
								end
								Result := STRING_.appended_string (Result, str)
								if rb then
									Result.append_character ('}')
								end
							end
						else
								-- Leave $N or ${N} unchanged.
							Result.append_character ('$')
							if lb then
								Result.append_character ('{')
							end
							Result := STRING_.appended_string (Result, str)
							if rb then
								Result.append_character ('}')
							end
						end
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end


end
