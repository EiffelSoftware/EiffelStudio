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
	io.error.putstring ("About to validate a resource value.");
	io.error.new_line;
	io.error.putstring ("The value is `");
	io.error.putstring (str);
	io.error.putstring ("'.");
	io.error.new_line;
	io.error.putstring ("The length is ");
	io.error.putint (str.count);
	io.error.new_line
end;
			from
				index := 2;
			until
				index > str.count or else
				not Result or else
				str @ index = '%"'
			loop
debug("RESOURCE_VALIDATE")
	io.error.putstring ("LOOP_START: ");
	io.error.new_line;
	io.error.putstring ("Index is: ");
	io.error.putint(index);
	io.error.new_line
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
	io.error.putstring ("LOOP_END: ");
	io.error.new_line;
	io.error.putstring ("Index is: ");
	io.error.putint(index);
	io.error.new_line
end;
debug("RESOURCE_VALIDATE")
	io.error.putstring ("Boolean `until' clause-values:");
	io.error.new_line;
	io.error.putstring ("index > str.count: ");
	io.error.putbool (index > str.count);
	io.error.new_line;
	io.error.putstring ("not Result: ");
	io.error.putbool (not Result);
	io.error.new_line;
	if index <= str.count then
		io.error.putstring ("str @ index = '%"': ");
		io.error.putbool (str @ index = '%"');
		io.error.new_line
	else
		io.error.putstring("Index > str.count! (while evaluating str @ index = '%"')");
		io.error.new_line;
	end;
	io.error.putstring ("Total value: ");
	io.error.putbool (index > str.count or else not Result or else str @ index = '%"');
	io.error.new_line;
end;
			end;

			if Result and then index <= str.count and then str @ index /= '%N' then
					-- Read the last ".
				index := index + 1
			else
				Result := False
			end;
debug("RESOURCE_VALIDATE")
	io.error.putstring ("Result of validation is ");
	io.error.putbool (Result);
	io.error.new_line
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
