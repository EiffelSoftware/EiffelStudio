note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_PARSE

inherit
	EC_TYPES;

	EXT_INTERNAL

create
	make

feature {NONE} -- Initialization

	make
		do
			create descriptor.make
			create ecp_reference
		end

feature -- Status report

	ecp_parsed: BOOLEAN
			-- Did last operation succeeded?

	ecp_message: STRING
			-- Error message if `sql_parsed' is false
		once
			create Result.make (0)
		end

	ecp_token_array: detachable ARRAYED_LIST [TOKEN]
			-- Array of tokens

	ecp_reference: ANY
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

	ecp_parse (at: ARRAYED_LIST [TOKEN])
			-- Perform syntactical analysis on a lexical item list.
		require
			token_array_exists: at /= Void
			set: is_descriptor_set
		local
			l_descriptor: like descriptor
			l_array: like ecp_token_array
			l_context: like context_type
			l_token: TOKEN
		do
			l_array := at
			ecp_token_array := l_array;
			ecp_parsed := True;
			ecp_message.wipe_out;
			if at.is_empty then
				set_ecp_parse_error("Empty Line")
			else
				from
					ecp_current_field := 1;
					ecp_current_token := 1;
					l_token := l_array.i_th (1);
					l_descriptor := descriptor
					if attached l_descriptor.ecd_reference as l_ref then
						set_ecp_reference (l_ref)
					end
					l_context := [l_token, l_descriptor.ecd_fields.i_th (ecp_current_field), 0, 0]
				until
					not ecp_parsed or
						ecp_current_field >= l_descriptor.ecd_max_index
				loop
					l_context.ecp_field := l_descriptor.ecd_fields.i_th (ecp_current_field);
					ecp_parse_field (l_context)
					ecp_parse_separator (l_context)
					ecp_current_field := ecp_current_field +1
				end;
				l_context.ecp_field := l_descriptor.ecd_fields.i_th (ecp_current_field);
				ecp_parse_last_field (l_context)
				check_end_of_line
			end
		end;

feature {NONE} -- Status report

	context_type: TUPLE [ecp_token: TOKEN; ecp_field: EC_FIELD; ecp_current_token, ecp_current_field: INTEGER]
			-- Type of context used during parsing. It is only used for typing.
		do
			check False then
			end
		end

	descriptor: EC_DESCRIPTOR
		-- A descriptor

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
			ecp_token_array := Void
			ecp_message.wipe_out;
			ecp_message.append(message)
		end;

feature {NONE} -- Implementation

	ecp_parse_separator (a_context: like context_type)
			-- Parse current token which must be the field separator.
		require
			set: is_descriptor_set
		local
			l_descriptor: like descriptor
		do
			if ecp_parsed then
				l_descriptor := descriptor
				if a_context.ecp_token.type = Field_sep_ttype
					and then a_context.ecp_token.string_value ~
					l_descriptor.field_separator.out then
					ecp_remove_word (a_context)
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad field separator `");
					tmps.append(a_context.ecp_token.string_value);
					tmps.append("' instead of `");
					tmps.append(l_descriptor.field_separator.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_field (a_context: like context_type)
			-- Parse an object field.
		local
		do
			if ecp_parsed then
				if a_context.ecp_field.use_label then
					ecp_parse_label_name (a_context)
					ecp_parse_label_sep (a_context)
				end;
				if a_context.ecp_field.use_value_delimiters then
					ecp_parse_left_delimiter (a_context)
				end;
				ecp_parse_value(a_context, 1);
				if a_context.ecp_field.use_value_delimiters then
					ecp_parse_right_delimiter(a_context, 1)
				end
			end
		end;

	ecp_parse_last_field (a_context: like context_type)
			-- Parse the last field of an object.
		do
			if ecp_parsed then
				if a_context.ecp_field.use_label then
					ecp_parse_label_name (a_context)
					ecp_parse_label_sep (a_context)
				end;
				if a_context.ecp_field.use_value_delimiters then
					ecp_parse_left_delimiter (a_context)
				end;
				if a_context.ecp_field.use_value_delimiters then
					ecp_parse_value(a_context, 1);
					ecp_parse_right_delimiter(a_context, 0)
				else
					ecp_parse_value(a_context, 0)
				end
			end
		end;

	ecp_parse_label_name (a_context: like context_type)
			-- Parse current token which must be an identifier
			-- matching the current field name.
		require
			set: is_descriptor_set
		local
			i: INTEGER;
			done: BOOLEAN
			l_field: EC_FIELD
			l_descriptor: like descriptor
		do
			if ecp_parsed then
				if a_context.ecp_token.type = Identifier_ttype and then a_context.ecp_token.string_value ~ a_context.ecp_field.field_name then
					ecp_remove_word (a_context)
				else
					from
						l_descriptor := descriptor
						i := 1
					until
						i > l_descriptor.ecd_max_index or done
					loop
						l_field := l_descriptor.ecd_fields.i_th (i)
						if (a_context.ecp_token.string_value ~ l_field.field_name) then
							--l_field.set_rank (ecp_current_field);
							a_context.ecp_field := l_field
							ecp_remove_word (a_context)
							done := True
						end;
						i := i + 1
					end;
					if not done then
						tmps.wipe_out;
						tmps.append("Syntax error, Field name `");
						tmps.append(a_context.ecp_token.string_value);
						tmps.append("' instead of `");
						tmps.append(a_context.ecp_field.field_name);
						tmps.append("'.%N");
						set_ecp_parse_error(tmps)
					end
				end
			end
		end;

	ecp_parse_label_sep (a_context: like context_type)
			-- Parse current token which must be an label separator
			-- matching the current field label separator.
		do
			if ecp_parsed then
				if a_context.ecp_token.type = Label_sep_ttype and then
					a_context.ecp_token.string_value ~ a_context.ecp_field.label_separator.out then
					ecp_remove_word (a_context)
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad label separator `");
					tmps.append(a_context.ecp_token.string_value);
					tmps.append("' instead of `");
					tmps.append(a_context.ecp_field.label_separator.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_left_delimiter (a_context: like context_type)
			-- Parse current token which must be a left delimiter
			-- matching the current field value left delim. .
		do
			if ecp_parsed then
				if a_context.ecp_token.type = Left_del_ttype and then
					a_context.ecp_token.string_value ~ a_context.ecp_field.left_delimiter.out then
					ecp_remove_word (a_context)
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad left delimiter `");
					tmps.append(a_context.ecp_token.string_value);
					tmps.append("' instead of `");
					tmps.append(a_context.ecp_field.left_delimiter.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_right_delimiter (a_context: like context_type; i: INTEGER)
			-- Parse current token which must be a right delimiter
			-- matching the current field value right delim.
			-- `i' is 0 if this is the last token to be read, else >0
		do
			if ecp_parsed then
				if a_context.ecp_token.type = Right_del_ttype and then
					a_context.ecp_token.string_value ~ a_context.ecp_field.right_delimiter.out then
					if i>0 then
						ecp_remove_word (a_context)
					else
						ecp_current_token := ecp_current_token+1
					end
				else
					tmps.wipe_out;
					tmps.append("Syntax error, Bad right delimiter `");
					tmps.append(a_context.ecp_token.string_value);
					tmps.append("' instead of `");
					tmps.append(a_context.ecp_field.right_delimiter.out);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				end
			end
		end;

	ecp_parse_value (a_context: like context_type; i:INTEGER)
			-- Parse and skip next token which
			-- will be converted in an object.
			-- `i' is 0 if this is the last token to be read, else >0
		local
			token_string, tmp_s: STRING;
			token_type, tmp_i: INTEGER;
			tmp_r: REAL;
			tmp_b ,tst: BOOLEAN
			l_field: EC_FIELD
			l_reference: like ecp_reference
		do
			if ecp_parsed then
				l_field := a_context.ecp_field
				l_reference := ecp_reference
				token_string := a_context.ecp_token.string_value.twin
				token_type := a_context.ecp_token.type;
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
						tmps.append(l_field.field_name);
						tmps.append("' invalid with `");
						tmps.append(token_string);
						tmps.append("'.%N");
						set_ecp_parse_error (tmps)
					end;
					if ecp_parsed then
						if i>0 then
							ecp_remove_word (a_context)
						else
							ecp_current_token := ecp_current_token + 1
						end
					end
				else
					tmps.wipe_out;
					tmps.append("Type of attribute `");
					tmps.append(l_field.field_name);
					tmps.append("' invalid with `");
					tmps.append(token_string);
					tmps.append("'.%N");
					set_ecp_parse_error (tmps)
				end
			end
		end;

	ecp_remove_word (a_context: like context_type)
			-- Remove current token and checks for the
			-- next token to exist.
		do
			if attached ecp_token_array as l_array then
				ecp_current_token := ecp_current_token + 1;
				if ecp_current_token > l_array.count then
					tmps.wipe_out;
					tmps.append("Unexpected end of line after `");
					tmps.append(a_context.ecp_token.string_value);
					tmps.append("'.%N");
					set_ecp_parse_error(tmps)
				else
					a_context.ecp_token := l_array.i_th (ecp_current_token)
				end
			end
		end;

	check_end_of_line
			-- Check if the last token read was the last of the array
		do
			-- Not implemented yet
		end

invariant
	ecp_token_array_not_void: ecp_parsed = (ecp_token_array /= Void)

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EC_PARSE



