indexing

	Status: "See notice at end of class";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class CONVERTER inherit

	EC_TYPES

creation -- Creation procedure

	make

feature -- Initialization

	make is
		do
			!! lex.make;
			!! parse;
			!! container.make (1, 5);
			!! tmps.make (0)
		end;

feature -- Status report

	conv_error: BOOLEAN
			-- Error flag.

	conv_message: STRING
			-- Error message.

	descriptor: EC_DESCRIPTOR
			-- The object descriptor

	container: ARRAY [ANY];
			-- Objects are stored in this container which can be
			-- saved using ENVIRONMENT facilities.

	container_size: INTEGER
			-- Number of objects stored in the container.

feature -- Status setting

	set_descriptor (e: EC_DESCRIPTOR) is
			-- Set `descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		ensure
			descriptor = e
		end;

	set_file (f: PLAIN_TEXT_FILE) is
			-- Set file to be parsed with `f'.
		require
			file_exists: f /= Void
		do
			current_file := f;
			if not f.readable then
				tmps.wipe_out;
				tmps.append ("Cannot open source file `");
				tmps.append (f.name);
				tmps.append ("' for reading.%N");
				set_error (clone (tmps))
			end
		ensure
			current_file = f
		end;

	set_file_name (fn: STRING) is
			-- Open specified file and set `current_file' with it.
		require
			file_name_exists: fn /= Void
		local
			f: PLAIN_TEXT_FILE
		do
			!! f.make (fn);
			set_file (f)
		end;

feature -- Basic operations

	parse_file is
			-- Analyze the content of the file.
		require
			descriptor_is_set: descriptor /= Void
		do
			from
				conv_error := False;
				container_size := 0;
				container.clear_all;
				current_line_number := 1;
				lex.set_descriptor (descriptor);
				parse.set_descriptor (descriptor);
				lex.ecl_build (current_file.name);
				current_file.open_read
			until
				current_file.end_of_file or conv_error
			loop
				current_file.readline;
				if current_file.laststring.count /= 0 then
					current_line:= current_file.laststring;
					parse_line;
					current_line_number := current_line_number + 1
				end
			end;
			current_file.close
		end;

feature {NONE} -- Status setting

	set_error (s: STRING) is
			-- Set the error flag to `True' and the
			-- error message to `s'.
		require
			error_message_exists: s /= Void
		do
			conv_error := True;
			conv_message := s
		end;

feature {NONE} -- Status report

	lex: EC_LEX;
			-- The lexical analyzer, that will be build especially

	parse: EC_PARSE;
			-- The parser, using the previously created lex-analyzer

	current_line: STRING;
			-- Current line being parsed

	current_line_number: INTEGER;
			-- Number of the line being parsed

	current_file: PLAIN_TEXT_FILE;
			-- File being parsed

	tmps: STRING ;
			-- Local and temporary string

feature {NONE} -- Basic operations

	parse_line is
			-- Parse current file line and put object in the array.
		require
			current_line_exists: current_line /= Void;
			lexical_analyzer_exists: lex /= Void;
			parser_exists: parse /= Void
		do
			lex.ecl_analyze (current_line);
			if lex.ecl_error then
				raise_error (clone (lex.ecl_message))
			else
				parse.ecp_parse (lex.ecl_token_array);
				if parse.ecp_parsed then
					store_object
				else
					raise_error (clone (parse.ecp_message))
				end
			end
		end;

	store_object is
			-- Store parsed object in the container.
		do
			container.force (clone(parse.ecp_reference),container_size+1);
			container_size := container_size + 1
		end;

	raise_error (s: STRING)  is
			-- Display the appropriate error message, prepended
			-- with the file line.
		require
			error_message_exists: s /= Void
		do
			s.prepend (", ");
			s.prepend (current_line_number.out);
			s.prepend ("Line ");
			set_error (s)
		end

end -- class CONVERTER



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

