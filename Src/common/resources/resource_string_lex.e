indexing

	description:
		"Lexical analyzing of resource string values.";
	date: "$Date$";
	revision: "$Revision$"

class RESOURCE_STRING_LEX

feature -- Validation

	is_value_valid (str: STRING): BOOLEAN is
			-- Is `str' a valid value?
		do
				-- Assume `str' is valid.
			Result := True;

debug("RESOURCE_VALIDATE")
	io.error.put_string ("About to validate a resource value.");
	io.error.put_new_line;
	io.error.put_string ("The value is `");
	io.error.put_string (str);
	io.error.put_string ("'.");
	io.error.put_new_line;
	io.error.put_string ("The length is ");
	io.error.put_integer (str.count);
	io.error.put_new_line
end;
			from
				index := 2;
			until
				index > str.count or else
				not Result or else
				str @ index = '%"'
			loop
debug("RESOURCE_VALIDATE")
	io.error.put_string ("LOOP_START: ");
	io.error.put_new_line;
	io.error.put_string ("Index is: ");
	io.error.put_integer(index);
	io.error.put_new_line
end;
				if str @ index = '%%' then
					index := index + 1;
					if str @ index = '%N' then
						index := index + 1
						if
							str @ index /= '%N' and then
							str @ index = '%%'
						then
							index := index + 1
						else
							Result := False
						end
					else
						inspect str @ index
						when 'A' then
						when 'B' then
						when 'C' then
						when 'D' then
						when 'F' then
						when 'H' then
						when 'L' then
						when 'N' then
						when 'Q' then
						when 'R' then
						when 'S' then
						when 'T' then
						when 'U' then
						when 'V' then
						when '%%' then
						when '%'' then
						when '%"' then
						when '(' then
						when ')' then
						when '<' then
						when '>' then
						when '/' then
							Result := parse_char_code (str)
						else
							Result := False
						end;
						index := index + 1
					end	
				else
					index := index + 1
				end
debug("RESOURCE_VALIDATE")
	io.error.put_string ("LOOP_END: ");
	io.error.put_new_line;
	io.error.put_string ("Index is: ");
	io.error.put_integer(index);
	io.error.put_new_line
end;
debug("RESOURCE_VALIDATE")
	io.error.put_string ("Boolean `until' clause-values:");
	io.error.put_new_line;
	io.error.put_string ("index > str.count: ");
	io.error.putbool (index > str.count);
	io.error.put_new_line;
	io.error.put_string ("not Result: ");
	io.error.putbool (not Result);
	io.error.put_new_line;
	if index <= str.count then
		io.error.put_string ("str @ index = '%"': ");
		io.error.putbool (str @ index = '%"');
		io.error.put_new_line
	else
		io.error.put_string("Index > str.count! (while evaluating str @ index = '%"')");
		io.error.put_new_line;
	end;
	io.error.put_string ("Total value: ");
	io.error.putbool (index > str.count or else not Result or else str @ index = '%"');
	io.error.put_new_line;
end;
			end;

			if Result and then index <= str.count and then str @ index /= '%N' then
					-- Read the last ".
				index := index + 1
			else
				Result := False
			end;
debug("RESOURCE_VALIDATE")
	io.error.put_string ("Result of validation is ");
	io.error.putbool (Result);
	io.error.put_new_line
end
		end;

feature {NONE} -- Implementation

	parse_char_code(str: STRING): BOOLEAN is
			-- Parse a special character of the form %/../ and insert
			-- it at the end of `last_token'. `last_token' becomes
			-- void if an error occurred.
		require
			str @ index /= '%N' and then str @ index = '/'
		do
				-- Assume valid.
			Result := True;

			index := index + 1;
			if str @ index /= '%N' then
				inspect str @ index
				when '0'..'9' then
					index := index + 1;
					if str @ index /= '%N' then
						inspect str @ index
						when '0'..'9' then
							index := index + 1;
							if str @ index /= '%N' then
								inspect str @ index
								when '0'..'9' then
									index := index + 1;
									if 
										str @ index /= '%N' and then
										str @ index = '/'
									then
									else
										Result := False
									end
								when '/' then
								else
									Result := False
								end
							else
								Result := False
							end
						when '/' then
						else
							Result := False
						end
					else
						Result := False
					end
				else
					Result := False
				end
			else
				Result := False
			end
		end;

feature {NONE} -- Implementation

	index: INTEGER

end -- class RESOURCE_STRING_LEX
