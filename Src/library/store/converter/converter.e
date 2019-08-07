note

	status: "See notice at end of class.";
	Date: "$Date$";
	Revision: "$Revision$";
	Product: "Environment Converter"

class CONVERTER inherit

	EC_TYPES

create -- Creation procedure

	make

feature -- Initialization

	make
		do
			create lex.make;
			create parse.make;
			create container.make_filled (Void, 1, 5);
			create tmps.make (0)
			create current_line.make_empty
			create descriptor.make
		end;

feature -- Status report

	conv_error: BOOLEAN
			-- Error flag.

	conv_message: detachable STRING
			-- Error message.
		obsolete
			"Use `conv_message_32' instead  [2017-11-30]."
		do
			if attached conv_message_32 as l_s then
				Result := l_s.as_string_8
			end
		end

	conv_message_32: detachable STRING_32
			-- Error message.

	descriptor: EC_DESCRIPTOR
			-- The object descriptor

	container: ARRAY [detachable ANY];
			-- Objects are stored in this container which can be
			-- saved using ENVIRONMENT facilities.

	container_size: INTEGER
			-- Number of objects stored in the container.

	is_current_file_set: BOOLEAN
			-- If `current_file' has been set?
		do
			Result := current_file /= Void
		end

feature -- Status setting

	set_descriptor (e: EC_DESCRIPTOR)
			-- Set `descriptor' with `e'.
		require
			descriptor_exits: e /= Void
		do
			descriptor := e
		ensure
			descriptor = e
		end;

	set_file (f: PLAIN_TEXT_FILE)
			-- Set file to be parsed with `f'.
		require
			file_exists: f /= Void
		do
			current_file := f;
			if not f.is_readable then
				tmps.wipe_out;
				tmps.append ("Cannot open source file `");
				tmps.append_string (f.path.name);
				tmps.append ("' for reading.%N");
				set_error (tmps.twin)
			end
		ensure
			current_file = f
		end;

	set_file_name (fn: STRING)
			-- Open specified file and set `current_file' with it.
		require
			file_name_exists: fn /= Void
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name (fn);
			set_file (f)
		end;

feature -- Basic operations

	parse_file
			-- Analyze the content of the file.
		require
			descriptor_is_set: descriptor /= Void
			current_file_is_set: is_current_file_set
		do
			check attached current_file as l_current_file then
				from
					conv_error := False;
					container_size := 0;
					container.clear_all;
					current_line_number := 1;
					lex.set_descriptor (descriptor);
					parse.set_descriptor (descriptor);
					lex.ecl_build (l_current_file.path.name);
					l_current_file.open_read
				until
					l_current_file.end_of_file or conv_error
				loop
					l_current_file.readline;
					if attached l_current_file.laststring as l_last_string then
						if l_last_string.count /= 0 then
							current_line:= l_current_file.laststring;
							parse_line;
							current_line_number := current_line_number + 1
						end
					else
						check False end -- implied by `readline'
					end
				end;
				l_current_file.close
			end
		end;

feature {NONE} -- Status setting

	set_error (s: like conv_message_32)
			-- Set the error flag to `True' and the
			-- error message to `s'.
		require
			error_message_exists: s /= Void
		do
			conv_error := True;
			conv_message_32 := s
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

	current_file: detachable PLAIN_TEXT_FILE;
			-- File being parsed

	tmps: STRING_32 ;
			-- Local and temporary string

feature {NONE} -- Basic operations

	parse_line
			-- Parse current file line and put object in the array.
		require
			lexical_analyzer_exists: lex /= Void;
			parser_exists: parse /= Void
		do
			lex.ecl_analyze (current_line);
			if lex.ecl_error then
				raise_error (lex.ecl_message.twin)
			else
				parse.ecp_parse (lex.ecl_token_array);
				if parse.ecp_parsed then
					store_object
				else
					raise_error (parse.ecp_message.twin)
				end
			end
		end;

	store_object
			-- Store parsed object in the container.
		require
			parsed: parse.ecp_parsed
		local
			l_reference: detachable ANY
		do
			l_reference := parse.ecp_reference
			check l_reference /= Void end -- implied by invariant `epc_reference_not_void' of `parse'
			container.force (l_reference.twin, container_size+1);
			container_size := container_size + 1
		end;

	raise_error (s: STRING)
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

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class CONVERTER



