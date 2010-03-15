note

	status: "See notice at end of class.";
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

	ecp_message: STRING
			-- Error message if `sql_parsed' is false
		once
			create Result.make (0)
		end

	ecp_token_array: detachable ARRAY [TOKEN]
			-- Array of tokens

	ecp_reference: detachable ANY
			-- One object reference

	is_descriptor_set: BOOLEAN
			-- If descriptor has been set?
		do
			Result := descriptor /= Void
		end

feature  -- Status setting

	set_descriptor (e: EC_DESCRIPTOR)
			-- Set `ecl_descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		end;

	ecp_parse (at: ARRAY[TOKEN])
			-- Perform syntactical analysis on a lexical item list.
		require
			token_array_exists: at /= Void
			set: is_descriptor_set
		local
			l_reference: detachable ANY
			l_descriptor: like descriptor
			l_array: like ecp_token_array
		do
			l_array := at
			ecp_token_array := l_array;
			ecp_parsed := True;
			ecp_message.wipe_out;
			if at.is_empty then
				set_ecp_parse_error("Empty Line")
			end;
			from
				ecp_current_field := 1;
				ecp_current_token := 1;
				ecp_token := l_array.item(1);
				l_descriptor := descriptor
				check l_descriptor /= Void end -- implied by precondition `is_descriptor_set'
				l_reference := l_descriptor.ecd_reference
				check l_reference /= Void end -- FIXME: implied by .... bug?
				set_ecp_reference(l_reference)
			until
				not ecp_parsed or
					ecp_current_field >= l_descriptor.ecd_max_index
			loop
				ecp_field := l_descriptor.ecd_fields.item(ecp_current_field);
				ecp_parse_field;
				ecp_parse_separator;
				ecp_current_field := ecp_current_field +1
			end;
			ecp_field := l_descriptor.ecd_fields.item(ecp_current_field);
			ecp_parse_last_field;
			check_end_of_line
		end;

feature {NONE} -- Status report

	descriptor: detachable EC_DESCRIPTOR
		-- A descriptor

	ecp_field: detachable EC_FIELD
		-- A field instance

	ecp_token: detachable TOKEN
		-- One lexical token

	ecp_current_token: INTEGER
		-- Token lexical number

	ecp_current_field: INTEGER
		-- Field number

	tmps: STRING
			-- Temporary buffer
		once
			create Result.make (0)
		end;

feature {NONE} -- Status setting

	set_ecp_reference (object: ANY)
			-- Set `ecp_reference' with `object'.
		require
			object_exists: object /= Void
		do
			ecp_reference := object
		end;

	set_ecp_parse_error (message: STRING)
			-- Set error flag, and initialize error message.
		do
			ecp_parsed := False;
			ecp_message.wipe_out;
			ecp_message.append(message)
		end;

feature {NONE} -- Implementation

	ecp_parse_separator
			-- Parse current token which must be the field separator.
		require
			set: is_descriptor_set
		local
			l_token: like ecp_token
			l_field: like ecp_field
			l_descriptor: like descriptor
		do
			if ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				l_descriptor := descriptor
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_descriptor /= Void end -- implied by precondition `set'
				if l_token.type = Field_sep_ttype
					and then l_token.string_value ~
					l_descriptor.field_separator.out then
					ecp_remove_word
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad field separator `");
					tmps.append(l_token.string_value);
					tmps.append("' instead of `");
					tmps.append(l_descriptor.field_separator.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_field
			-- Parse an object field.
		local
			l_field: like ecp_field
		do
			if ecp_parsed then
				l_field := ecp_field
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'
				if l_field.use_label then
					ecp_parse_label_name;
					ecp_parse_label_sep
				end;
				if l_field.use_value_delimiters then
					ecp_parse_left_delimiter
				end;
				ecp_parse_value(1);
				if l_field.use_value_delimiters then
					ecp_parse_right_delimiter(1)
				end
			end
		end;

	ecp_parse_last_field
			-- Parse the last field of an object.
		local
			l_field: like ecp_field
		do
			if ecp_parsed then
				l_field := ecp_field
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'				
				if l_field.use_label then
					ecp_parse_label_name;
					ecp_parse_label_sep
				end;
				if l_field.use_value_delimiters then
					ecp_parse_left_delimiter
				end;
				if l_field.use_value_delimiters then
					ecp_parse_value(1);
					ecp_parse_right_delimiter(0)
				else
					ecp_parse_value(0)
				end
			end
		end;

	ecp_parse_label_name
			-- Parse current token which must be an identifier
			-- matching the current field name.
		require
			set: is_descriptor_set
		local
			i: INTEGER;
			done: BOOLEAN
			l_token: like ecp_token
			l_field: like ecp_field
			l_descriptor: like descriptor
			l_field_name: detachable STRING
		do
			if ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'			
				if l_token.type = Identifier_ttype and then
					l_token.string_value ~ l_field.field_name then
					ecp_remove_word
				else
					from
						l_descriptor := descriptor
						check l_descriptor /= Void end -- implied by precondition `set'
						i := 1
					until
						i > l_descriptor.ecd_max_index or done
					loop
						if l_token.string_value ~
								(l_descriptor.ecd_fields.item(i).field_name) then
							--descriptor.ecd_fields.item(i).set_rank (ecp_current_field);
							l_field := l_descriptor.ecd_fields.item(i);
							ecp_field := l_field
							ecp_remove_word;
							done := True
						end;
						i := i + 1
					end;
					if not done then
						tmps.wipe_out;
						tmps.append("Syntax error, Field name `");
						tmps.append(l_token.string_value);
						tmps.append("' instead of `");
						l_field_name :=l_field.field_name
						check l_field_name /= Void end -- FIXME: Can be void, bug?
						tmps.append(l_field_name);
						tmps.append("'.%N");
						set_ecp_parse_error(tmps)
					end
				end
			end
		end;

	ecp_parse_label_sep
			-- Parse current token which must be an label separator
			-- matching the current field label separator.
		local
			l_token: like ecp_token
			l_field: like ecp_field
		do
			if ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'
				if l_token.type = Label_sep_ttype and then
					l_token.string_value ~ l_field.label_separator.out then
					ecp_remove_word
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad label separator `");
					tmps.append(l_token.string_value);
					tmps.append("' instead of `");
					tmps.append(l_field.label_separator.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_left_delimiter
			-- Parse current token which must be a left delimiter
			-- matching the current field value left delim. .
		local
			l_token: like ecp_token
			l_field: like ecp_field
		do
			if ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'
				if l_token.type = Left_del_ttype and then
					l_token.string_value ~ l_field.left_delimiter.out then
					ecp_remove_word
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad left delimiter `");
					tmps.append(l_token.string_value);
					tmps.append("' instead of `");
					tmps.append(l_field.left_delimiter.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_right_delimiter (i:INTEGER)
			-- Parse current token which must be a right delimiter
			-- matching the current field value right delim.
			-- `i' is 0 if this is the last token to be read, else >0
		local
			l_token: like ecp_token
			l_field: like ecp_field
		do
			if ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'			
				if l_token.type = Right_del_ttype and then
					l_token.string_value ~ l_field.right_delimiter.out then
					if i>0 then
						ecp_remove_word
					else
						ecp_current_token := ecp_current_token+1
					end
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad right delimiter `");
					tmps.append(l_token.string_value);
					tmps.append("' instead of `");
					tmps.append(l_field.right_delimiter.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_value (i:INTEGER)
			-- Parse and skip next token which
			-- will be converted in an object.
			-- `i' is 0 if this is the last token to be read, else >0
		local
			token_string, tmp_s: STRING;
			token_type, tmp_i: INTEGER;
			tmp_r: REAL;
			tmp_b ,tst: BOOLEAN
			l_token: like ecp_token
			l_field: like ecp_field
			l_reference: like ecp_reference
			l_field_name: detachable STRING
		do
			if  ecp_parsed then
				l_token := ecp_token
				l_field := ecp_field
				l_reference := ecp_reference
				check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_field /= Void end -- implied by invariant `ecp_token_field_not_void'
				check l_reference /= Void end -- implied by invariant `ecp_reference_not_void'
				token_string := l_token.string_value.twin
				token_type := l_token.type;
				if token_type = l_field.field_type then
					inspect
						token_type
					when Integer_ttype then
						tmp_i := token_string.to_integer;
						tst := field_copy (l_field.field_rank, l_reference, tmp_i)
					when Real_ttype then
						tmp_r := token_string.to_real;
						tst := field_copy (l_field.field_rank, l_reference, tmp_r)
					when Boolean_ttype then
						if token_string.is_equal ("TRUE") then
							tmp_b:=True
						else
							tmp_b:=False
						end;
						tst := field_copy (l_field.field_rank, l_reference, tmp_b)
					when String_ttype then
						create tmp_s.make (0);
						tmp_s.append (token_string.substring
								(2, token_string.count-1));
						tst := field_copy (l_field.field_rank, l_reference, tmp_s)
					else
						tmps.wipe_out;
						tmps.append("Type of attribute `");
						l_field_name := l_field.field_name
						check l_field_name /= Void end -- FIXME: If token_type is 0, field_name can be void here... bug?
						tmps.append(l_field_name);
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
					l_field_name := l_field.field_name
					check l_field_name /= Void end -- FIXME: If token_type is 0, field_name can be void here... bug?
					tmps.append(l_field_name);
					tmps.append("' invalid with `");
					tmps.append(token_string);
					tmps.append("'.%N");
					set_ecp_parse_error (tmps)
				end
			end
		end;

	ecp_remove_word
			-- Remove current token and checks for the
			-- next token to exist.
		local
			l_token: like ecp_token
			l_array: like ecp_token_array
		do
			if ecp_parsed then
				l_array := ecp_token_array
				check l_array /= Void end -- implied by invariant `ecp_token_array_not_void'
				ecp_current_token := ecp_current_token+1;
				if ecp_current_token > l_array.upper or
						l_array.item (ecp_current_token) = Void then
					tmps.wipe_out;
					tmps.append("Unexpected end of line after `");
					l_token := ecp_token
					check l_token /= Void end -- implied by invariant `ecp_token_field_not_void'
					tmps.append(l_token.string_value);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				else
					ecp_token := l_array.item(ecp_current_token)
				end
			end
		end;

	check_end_of_line
			-- Check if the last token read was the last of the array
		do
			-- Not implemented yet
		end

invariant
	ecp_token_field_not_void: ecp_parsed implies ecp_token /= Void and ecp_field /= Void
	ecp_token_array_not_void: ecp_parsed implies ecp_token_array /= Void
	ecp_reference_not_void: ecp_parsed implies ecp_reference /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EC_PARSE



