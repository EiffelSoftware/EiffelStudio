indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_PARSE 

inherit 

	EC_TYPES;

	EXT_INTERNAL

feature -- Status report

	ecp_parsed: BOOLEAN
			-- Did last operation succeeded?

	ecp_message: STRING is
			-- Error message if `sql_parsed' is false
		once
			!! Result.make (0)
		end

	ecp_token_array: ARRAY [TOKEN]
			-- Array of tokens

	ecp_reference: ANY
			-- One object reference

feature  -- Status setting

	set_descriptor (e: EC_DESCRIPTOR) is
			-- Set `ecl_descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		end;

	ecp_parse (at: ARRAY[TOKEN]) is
			-- Perform syntactical analysis on a lexical item list.
		require
			token_array_exists: at /= Void
		local 	
			o: ANY
		do
			ecp_token_array := at;
			ecp_parsed := True;
			ecp_message.wipe_out;
			if at.empty then 
				set_ecp_parse_error("Empty Line")
			end;
			from
				ecp_current_field := 1;
				ecp_current_token := 1;
				ecp_token := ecp_token_array.item(1);
				set_ecp_reference(descriptor.ecd_reference)
			until
				not ecp_parsed or
					ecp_current_field >= descriptor.ecd_max_index
			loop
				ecp_field := descriptor.ecd_fields.item(ecp_current_field);
				ecp_parse_field;
				ecp_parse_separator;
				ecp_current_field := ecp_current_field +1
			end;
			ecp_field := descriptor.ecd_fields.item(ecp_current_field);
			ecp_parse_last_field;
			check_end_of_line
		end;


feature {NONE} -- Status report

	descriptor: EC_DESCRIPTOR
		-- A descriptor

	ecp_field: EC_FIELD
		-- A field instance

	ecp_token: TOKEN
		-- One lexical token

	ecp_current_token: INTEGER
		-- Token lexical number

	ecp_current_field: INTEGER
		-- Field number
	
	tmps: STRING is
			-- Temporary buffer
		once
			!! Result.make (0)
		end;

feature {NONE} -- Status setting

	set_ecp_reference (object: ANY) is
			-- Set `ecp_reference' with `object'.
		require
			object_exists: object /= Void
		do
			ecp_reference := object
		end;

	set_ecp_parse_error (message: STRING) is
			-- Set error flag, and initialize error message.
		do
			ecp_parsed := False;
			ecp_message.wipe_out;
			ecp_message.append(message)
		end;

feature {NONE} -- Implementation

	ecp_parse_separator is
			-- Parse current token which must be the field separator.
		do
			if ecp_parsed and then ecp_token.type = Field_sep_ttype
					and then ecp_token.string_value.is_equal
					(descriptor.field_separator.out) then
				ecp_remove_word
			elseif ecp_parsed then
				tmps.wipe_out;
				tmps.append("Syntax error, Bad field separator `");
				tmps.append(ecp_token.string_value);
				tmps.append("' instead of `");
				tmps.append(descriptor.field_separator.out);
				tmps.append("'.%N");
				set_ecp_parse_error(tmps)
			end
		end;

	ecp_parse_field is
			-- Parse an object field.
		do
			if ecp_parsed then 
				if ecp_field.use_label then 
					ecp_parse_label_name;
					ecp_parse_label_sep
				end;
				if ecp_field.use_value_delimiters then
					ecp_parse_left_delimiter
				end;
				ecp_parse_value(1);
				if ecp_field.use_value_delimiters then
					ecp_parse_right_delimiter(1)
				end
			end
		end;

	ecp_parse_last_field is
			-- Parse the last field of an object.
		do
			if ecp_parsed then 
				if ecp_field.use_label then 
					ecp_parse_label_name;
					ecp_parse_label_sep
				end;
				if ecp_field.use_value_delimiters then
					ecp_parse_left_delimiter
				end;
				if ecp_field.use_value_delimiters then
					ecp_parse_value(1);
					ecp_parse_right_delimiter(0)
				else
					ecp_parse_value(0)
				end
			end
		end;	

	ecp_parse_label_name is
			-- Parse current token which must be an identifier
			-- matching the current field name.
		local
			i: INTEGER;
			done: BOOLEAN
		do
			if ecp_parsed 
					and then ecp_token.type = Identifier_ttype and then
					ecp_token.string_value.is_equal(ecp_field.field_name) then
				ecp_remove_word
			elseif ecp_parsed then
				from
					i := 1
				until
					i > descriptor.ecd_max_index or done
				loop
					if ecp_token.string_value.is_equal
							(descriptor.ecd_fields.item(i).field_name) then
						--descriptor.ecd_fields.item(i).set_rank (ecp_current_field);
						ecp_field := descriptor.ecd_fields.item(i);
						ecp_remove_word;
						done := True
					end;
					i := i + 1
				end;
				if not done then
					tmps.wipe_out;
					tmps.append("Syntax error, Field name `");
					tmps.append(ecp_token.string_value);
					tmps.append("' instead of `");
					tmps.append(ecp_field.field_name);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_label_sep is
			-- Parse current token which must be an label separator
			-- matching the current field label separator.
		do
			if ecp_parsed 
					and then ecp_token.type = Label_sep_ttype and then
					ecp_token.string_value.is_equal(ecp_field.label_separator.out) then
				ecp_remove_word
			elseif ecp_parsed then
				tmps.wipe_out;
				tmps.append("Syntax error, Bad label separator `");
				tmps.append(ecp_token.string_value);
				tmps.append("' instead of `");
				tmps.append(ecp_field.label_separator.out);
				tmps.append("'.%N");
				set_ecp_parse_error(tmps)
			end
		end;

	ecp_parse_left_delimiter is
			-- Parse current token which must be a left delimiter
			-- matching the current field value left delim. .
		do
			if ecp_parsed 
					and then ecp_token.type = Left_del_ttype and then
					ecp_token.string_value.is_equal(ecp_field.left_delimiter.out) then
				ecp_remove_word
			elseif ecp_parsed then
				tmps.wipe_out;
				tmps.append("Syntax error, Bad left delimiter `");
				tmps.append(ecp_token.string_value);
				tmps.append("' instead of `");
				tmps.append(ecp_field.left_delimiter.out);
				tmps.append("'.%N");
				set_ecp_parse_error(tmps)
			end
		end;

	ecp_parse_right_delimiter (i:INTEGER) is
			-- Parse current token which must be a right delimiter
			-- matching the current field value right delim.
			-- `i' is 0 if this is the last token to be read, else >0
		do
			if ecp_parsed and then ecp_token.type = Right_del_ttype and then
					ecp_token.string_value.is_equal(ecp_field.right_delimiter.out) then 
				if i>0 then
					ecp_remove_word
				else 
					ecp_current_token := ecp_current_token+1
				end
			elseif ecp_parsed then
				tmps.wipe_out;
				tmps.append("Syntax error, Bad right delimiter `");
				tmps.append(ecp_token.string_value);
				tmps.append("' instead of `");
				tmps.append(ecp_field.right_delimiter.out);
				tmps.append("'.%N");
				set_ecp_parse_error(tmps)
			end
		end;

	ecp_parse_value (i:INTEGER) is
			-- Parse and skip next token which
			-- will be converted in an object.
			-- `i' is 0 if this is the last token to be read, else >0
		local 
			token_string, tmp_s: STRING;
			token_type, tmp_i: INTEGER;
			tmp_r: REAL;
			tmp_b ,tst: BOOLEAN
		do
			if  ecp_parsed then
				token_string := clone (ecp_token.string_value);
				token_type := ecp_token.type;
				if token_type = ecp_field.field_type then 
					inspect 
						token_type
					when Integer_ttype then
						tmp_i := token_string.to_integer;
						tst := field_copy (ecp_field.field_rank, ecp_reference, tmp_i)
					when Real_ttype then 
						tmp_r := token_string.to_real;
						tst := field_copy (ecp_field.field_rank, ecp_reference, tmp_r)
					when Boolean_ttype then 
						if token_string.is_equal ("TRUE") then
							tmp_b:=True
						else
							tmp_b:=False
						end;
						tst := field_copy (ecp_field.field_rank, ecp_reference, tmp_b)
					when String_ttype then 
						!!tmp_s.make (0);
						tmp_s.append (token_string.substring
								(2, token_string.count-1));
						tst := field_copy (ecp_field.field_rank, ecp_reference, tmp_s)
					else
						tmps.wipe_out;
						tmps.append("Type of attribute `");
						tmps.append(ecp_field.field_name);
						tmps.append("' invalid with `");
						tmps.append(token_string);
						tmps.append("'.%N");	
						set_ecp_parse_error (tmps)
					end;
					if ecp_parsed then
						if i>0 then
							ecp_remove_word
						else 
							ecp_current_token := ecp_current_token + 1
						end
					end
				else
					tmps.wipe_out;
					tmps.append("Type of attribute `");
					tmps.append(ecp_field.field_name);
					tmps.append("' invalid with `");
					tmps.append(token_string);
					tmps.append("'.%N");	
					set_ecp_parse_error (tmps)
				end
			end	
		end;

	ecp_remove_word is 
			-- Remove current token and checks for the 
			-- next token to exist.
		do
			if ecp_parsed then 
				ecp_current_token := ecp_current_token+1;
				if ecp_current_token > ecp_token_array.upper or
						ecp_token_array.item (ecp_current_token) = Void then
					tmps.wipe_out;
					tmps.append("Unexpected end of line after `");
					tmps.append(ecp_token.string_value);
					tmps.append("'.%N");	
					set_ecp_parse_error(tmps)
				else
					ecp_token := ecp_token_array.item(ecp_current_token)
				end
			end
		end;

	check_end_of_line is
			-- Check if the last token read was the last of the array
		do
			-- Not implemented yet
		end

end -- class EC_PARSE



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

