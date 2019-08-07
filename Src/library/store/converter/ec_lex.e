note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_LEX inherit

	EC_TYPES
		undefine
			is_equal, copy
		end;

	METALEX
		rename
			make as metalex_make
		end

create -- Creation procedure

	make

feature -- Initialization

	make
			-- Make object.
		do
			metalex_make
			create ecl_message.make(5)
			create descriptor.make
		end;

feature  -- Status report

	descriptor: EC_DESCRIPTOR

	ecl_error: BOOLEAN
			-- Did lexical analysis succeeded?

	ecl_message: STRING

	ecl_nb_token: INTEGER

feature -- Status setting

	set_descriptor (e: EC_DESCRIPTOR)
			-- Set `ecl_descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		end;

	ecl_analyze (input_string: STRING)
			-- Perform lexical analysis on `input_string'.
			-- Fill the token list.
		require
			input_string_exists: input_string /= Void;
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: not descriptor.ecd_error;
			analyzer_is_built: analyzer /= Void
		local
			t:TOKEN
		do
			if attached analyzer as l_analyzer then
				ecl_error := False;
				ecl_message.wipe_out;
				if input_string.count=0 then
					ecl_error := True;
					ecl_message.append("Empty line%N")
				end;
				from
					l_analyzer.set_string(input_string);
					ecl_token_array.wipe_out
					ecl_nb_token:=0
				until
					l_analyzer.end_of_text or ecl_error
				loop
					l_analyzer.get_any_token;
					if not l_analyzer.end_of_text and then not ecl_error then
						create t;
						t.copy(l_analyzer.last_token);
						if not t.string_value.is_equal(l_analyzer.last_string_read) then
							ecl_error := True;
							ecl_message.append("Lexical item `");
							ecl_message.append(l_analyzer.last_string_read);
							ecl_message.append("' is unknown.%N")
						end;
						if t.type /= Space_ttype then
							if t.type =  Boolean_ttype then
								t.string_value.to_upper
							end;
							ecl_token_array.extend (t);
							ecl_nb_token := ecl_nb_token + 1
						end
					end
				end;
			end
		end;

	ecl_token_array: ARRAYED_LIST [TOKEN]
			-- Array of tokens
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: not descriptor.ecd_error
		once
			create Result.make (descriptor.ecd_fields.count)
		end;

	ecl_build (s: READABLE_STRING_GENERAL)
			-- Retrieve analyzer associated with current object description
			-- if it exists, else build a new one according to current description
			-- and store it.
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: not descriptor.ecd_error
			argument_exists: s /= Void
		local
			tmp_file: RAW_FILE
			tmpsl,tmpsr,tmpss: STRING
			file_name: STRING_32;
			i:INTEGER;
			already_done: BOOLEAN;
			l_field: detachable EC_FIELD
		do
			if analyzer = Void then
	 			metalex_make
			end;
			create tmpsl.make(0);
			create tmpsr.make(0);
			create tmpss.make(0);
			create file_name.make(0);
		--	file_name.append("/tmp/ec_");
			file_name.append_string_general (s);
			file_name.append(".lex");
			file_name.to_lower;
			create tmp_file.make_with_name (file_name);
			if tmp_file.exists then
				retrieve_analyzer (file_name)
			else
				error_list.do_not_display_message;
				ignore_case;
				keywords_ignore_case;
				put_nameless_expression("+(' ' | '%T')",Space_ttype);
				put_nameless_expression("$R",Real_ttype);
				put_nameless_expression("$Z",Integer_ttype);
				put_nameless_expression
					("~('a'..'z')*(~('a'..'z') | '_' | ('0'..'9'))",Identifier_ttype);
				put_nameless_expression("%"\%"%"->%"\%"%"",String_ttype);
				put_nameless_expression
					("('t''r''u''e') | ('f''a''l''s''e')",Boolean_ttype);
				tmpsl.wipe_out;
				tmpsl.append (char2string(descriptor.field_separator));
				put_expression(tmpsl.twin, Field_sep_ttype, "FieldSepT");
				tmpsl.wipe_out;
				from
					i := 1
				until
					i > descriptor.ecd_fields.count
				loop
					l_field := descriptor.ecd_fields.i_th (i)
					if i > 1 then
						tmpss.append(" | ")
					end;
					tmpss.append (char2string(l_field.label_separator));
					if l_field.use_value_delimiters then
						if not already_done then
							already_done := True
						else
							tmpsl.append(" | ");
							tmpsr.append(" | ")
						end;
						tmpsl.append (char2string(l_field.left_delimiter));
						tmpsr.append (char2string(l_field.right_delimiter))
					end
					i := i + 1
				end;
				if not tmpsl.is_empty then
					put_nameless_expression(tmpsl.twin, Left_del_ttype);
					put_nameless_expression(tmpsr.twin, Right_del_ttype)
				end;
				put_nameless_expression(tmpss.twin, Label_sep_ttype);
				make_analyzer;
				store_analyzer(file_name);
				error_list.display_message
			end
		ensure
			analyzer_built: analyzer /= Void
		end

feature {NONE} -- Conversion

	char2string (c: CHARACTER): STRING
			-- Returns the string "'c'"
		do
			create Result.make(3);
			Result.append ("'");
			Result.append (c.out);
			Result.append ("'")
		end

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




end -- class EC_LEX



