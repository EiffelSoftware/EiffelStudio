indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class EC_LEX inherit

	EC_TYPES
		undefine
			is_equal, copy, consistent, setup
		end;

	METALEX
		rename
			make as metalex_make
		end

creation -- Creation procedure

	make

feature -- Initialization

	make is
			-- Make object.
		do
			!! ecl_message.make(5)
		end;

feature  -- Status report

	descriptor: EC_DESCRIPTOR

	ecl_error: BOOLEAN
			-- Did lexical analysis succeeded?

	ecl_message: STRING

	ecl_nb_token: INTEGER

feature -- Status setting

	set_descriptor (e: EC_DESCRIPTOR) is
			-- Set `ecl_descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		end;

	ecl_analyze (input_string: STRING) is
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
			ecl_error := False;
			ecl_message.wipe_out;
			if input_string.count=0 then
				ecl_error := True;
				ecl_message.append("Empty line%N")
			end;
			from
				analyzer.set_string(input_string);
				ecl_token_array.clear_all;
				ecl_nb_token:=0
			until
				analyzer.end_of_text or ecl_error
			loop
				analyzer.get_any_token;
				if not analyzer.end_of_text and then not ecl_error then
					!!t;
					t.copy(analyzer.last_token);
					if not t.string_value.is_equal(analyzer.last_string_read) then
						ecl_error := True;
						ecl_message.append("Lexical item `");
						ecl_message.append(analyzer.last_string_read);
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
				ecl_token_array.resize(1,ecl_nb_token)
			end
		end;

	ecl_token_array: ARRAY[TOKEN] is
			-- Array of tokens
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: not descriptor.ecd_error
		once
			!! Result.make(1,descriptor.ecd_index)
		end;

	ecl_build (s: STRING) is
			-- Retrieve analyzer associated with current object description
			-- if it exists, else build a new one according to current description
			-- and store it. 
		require
			descriptor_exists: descriptor /= Void;
			descriptor_is_ok: not descriptor.ecd_error;
			argument_exists: s /= Void
		local
			tmp_file: RAW_FILE
			tmpsl,tmpsr,tmpss,file_name: STRING;
			i:INTEGER;
			already_done: BOOLEAN;
		do
			if analyzer = Void then 
	 			metalex_make
			end;
			!!tmpsl.make(0);
			!!tmpsr.make(0);
			!!tmpss.make(0);
			!!file_name.make(0);
		--	file_name.append("/tmp/ec_");
			file_name.append(s);
			file_name.append(".lex");
			file_name.to_lower;
			!!tmp_file.make(file_name);
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
				put_expression(clone (tmpsl), Field_sep_ttype, "FieldSepT");
				tmpsl.wipe_out;
				from 
					i := 1
				until
					i > descriptor.ecd_index
				loop
					if i > 1 then 
						tmpss.append(" | ")
					end;
					tmpss.append
						(char2string(descriptor.ecd_fields.item(i).label_separator));
					if descriptor.ecd_fields.item(i).use_value_delimiters then
						if not already_done then 
							already_done := True
						else
							tmpsl.append(" | ");
							tmpsr.append(" | ")
						end;
						tmpsl.append
							(char2string(descriptor.ecd_fields.item(i).left_delimiter));
						tmpsr.append
							(char2string(descriptor.ecd_fields.item(i).right_delimiter))
					end;
					i := i + 1
				end;
				if not tmpsl.is_empty then 
					put_nameless_expression(clone (tmpsl), Left_del_ttype);
					put_nameless_expression(clone (tmpsr), Right_del_ttype)
				end;
				put_nameless_expression(clone(tmpss), Label_sep_ttype);
				make_analyzer;
				store_analyzer(file_name);
				error_list.display_message
			end
		ensure
			analyzer_built: analyzer /= Void
		end

feature {NONE} -- Conversion

	char2string (c: CHARACTER): STRING is
			-- Returns the string "'c'"
		do
			!! Result.make(3);
			Result.append ("'");
			Result.append (c.out);
			Result.append ("'")
		end

end -- class EC_LEX



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

