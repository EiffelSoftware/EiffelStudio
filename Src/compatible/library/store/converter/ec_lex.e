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
			-- create `input_array', `final_array' and `keywords_list'
			create input_array.make (0, 0)
			create final_array.make (0, 0)
			create keywords_list.make

			create ecl_message.make(5)
			array_make (1, 0)
		end;

feature  -- Status report

	descriptor: detachable EC_DESCRIPTOR

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
			descriptor_is_ok: attached descriptor as lr_descriptor and then not lr_descriptor.ecd_error;
			analyzer_is_built: analyzer /= Void
		local
			t:TOKEN
			l_analyzer: like analyzer
		do
			ecl_error := False;
			ecl_message.wipe_out;
			if input_string.count=0 then
				ecl_error := True;
				ecl_message.append("Empty line%N")
			end;
			from
				l_analyzer := analyzer
				check l_analyzer /= Void end -- implied by precondition `analyzer_is_built'
				l_analyzer.set_string(input_string);
				ecl_token_array.clear_all;
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
						ecl_token_array.force(t,ecl_nb_token+1);
						ecl_nb_token := ecl_nb_token + 1
					end
				end
			end;
			if not ecl_error then
				ecl_token_array.conservative_resize(1,ecl_nb_token)
			end
		end;

	ecl_token_array: ARRAY[TOKEN]
			-- Array of tokens
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: attached descriptor as lr_descriptor and then not lr_descriptor.ecd_error
		local
			l_descriptor: like descriptor
		once
			l_descriptor := descriptor
			check l_descriptor /= Void end -- implied by precondition `descriptor_exists'
			create Result.make(1,l_descriptor.ecd_index)
		end;

	ecl_build (s: STRING)
			-- Retrieve analyzer associated with current object description
			-- if it exists, else build a new one according to current description
			-- and store it.
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: (attached descriptor as lr_descriptor) and then not lr_descriptor.ecd_error;
			argument_exists: s /= Void
		local
			tmp_file: RAW_FILE
			tmpsl,tmpsr,tmpss,file_name: STRING;
			i:INTEGER;
			already_done: BOOLEAN;
			l_descriptor: like descriptor
		do
			if analyzer = Void then
	 			metalex_make
			end;
			create tmpsl.make(0);
			create tmpsr.make(0);
			create tmpss.make(0);
			create file_name.make(0);
		--	file_name.append("/tmp/ec_");
			file_name.append(s);
			file_name.append(".lex");
			file_name.to_lower;
			create tmp_file.make(file_name);
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
				l_descriptor := descriptor
				check l_descriptor /= Void end -- implied by precondition `descriptor_exists'
				tmpsl.append (char2string(l_descriptor.field_separator));
				put_expression(tmpsl.twin, Field_sep_ttype, "FieldSepT");
				tmpsl.wipe_out;
				from
					i := 1
				until
					i > l_descriptor.ecd_index
				loop
					if i > 1 then
						tmpss.append(" | ")
					end;
					tmpss.append
						(char2string(l_descriptor.ecd_fields.item(i).label_separator));
					if l_descriptor.ecd_fields.item(i).use_value_delimiters then
						if not already_done then
							already_done := True
						else
							tmpsl.append(" | ");
							tmpsr.append(" | ")
						end;
						tmpsl.append
							(char2string(l_descriptor.ecd_fields.item(i).left_delimiter));
						tmpsr.append
							(char2string(l_descriptor.ecd_fields.item(i).right_delimiter))
					end;
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EC_LEX



