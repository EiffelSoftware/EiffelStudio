indexing

	description:
		"Access to information provided by a user through an HTML form. This %
		%class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CGI_INTERFACE

inherit
	CGI_ENVIRONMENT;
	SHARED_STDOUT;
	SHARED_STDIN;
	BASIC_ROUTINES
		export
			{NONE} all
		end;
	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Initialization

	make is
			-- Initiate input data parsing and process information.
		local
			retried: BOOLEAN
		do
			if not retried then
				parse_input;
				if not error_happened then
					execute
				else
					raise_error
				end;
			else
				handle_exception
			end
		rescue
			retried := True;
			retry
		end

	make_debug (args: ARRAY[STRING]) is
			-- Set environment variables and proceed to regular execution.
		local
			retried: BOOLEAN
		do
			if not retried then
				set_environment;
				parse_arguments (args);
				make
			else
				handle_exception
			end
		rescue
			retried := True;
			retry
		end

feature -- Access

	fields: ARRAY[STRING] is
			-- Names of fields in the form.
		once
			Result := form_data.current_keys;
			Result.compare_objects
		end

	value (field_name: STRING): STRING is
			-- First (unique?) value for a field.
		require
			field_not_Void: field_name /= Void;
			field_exists: field_defined (field_name)
		do
			Result := form_data.item (field_name).first
		ensure
			value_exists: Result /= Void
		end

	value_count (field_name: STRING): INTEGER is
			-- Number of values for a field.
		require
			field_not_Void: field_name /= Void;
			field_exists: field_defined (field_name)
		do
			Result := form_data.item (field_name).count
		ensure
			valid_count: Result >= 0
		end

	value_list (field_name: STRING): LINKED_LIST[STRING] is
			-- List of values for a field.
		require
			field_not_Void: field_name /= Void;
			field_exists: field_defined (field_name)
		do
			Result := form_data.item (field_name)
		ensure
			valid_count: Result.count = value_count (field_name)
		end

feature -- Report

	field_defined (field_name: STRING): BOOLEAN is
			-- Is field `field_name' defined?
		require
			filed_name_not_void: field_name /= Void
		do
			result := fields.has (field_name)
		end

feature -- HTTP facilities

	generate_html_header is
			-- Generate CGI header reply.
		once
			stdout.putstring ("Content-type: text/html%N%N")
		end

feature -- Miscellanous

	execute is
			-- Process user provided information.
		deferred
		end

	set_environment is
			-- Set environment variable to user value.
		do
		end

feature -- Status setting

	set_message is
			-- Display error message.
		do
			debug_level := Dl_message
		end

	set_no_debug is
			-- Do nothing.
		do
			debug_level := Dl_no
		end

feature {NONE} -- Implementation; error handling

	debug_level: INTEGER
			-- Debug level.

	Dl_message: INTEGER is 1;
			-- Display error message.

	Dl_no: INTEGER is 0;
			-- Do nothing.

	error_happened: BOOLEAN
			-- Did an error occur?

	error_message: STRING
			-- Message describing the error.

	handle_exception is
			-- General exception hanlding.
		do
			generate_html_header
			inspect
				debug_level
			when Dl_no then
					-- Do nothing
			when Dl_message then
					-- Display an error message
				set_error ("Internal error");
				raise_error
			else
					-- Do nothing
			end
		end

	raise_error is
			-- Display error message `msg' and exit.
		do
			generate_html_header;
			stdout.putstring (error_message);
			stdout.new_line;
			new_die(0)
		end

	set_error (msg: STRING) is
			-- Set error message.
		do
			if not error_happened then
				error_message := msg;
				error_happened := True
			end
		end
	
feature {NONE} -- Implementation

	form_data: HASH_TABLE[LINKED_LIST[STRING],STRING]
			-- User provided data.

	hexa_to_ascii (s: STRING) is
			-- Replace %xy by the corresponding ASCII character.
		local
			char: CHARACTER;
			new: STRING;
			i: INTEGER
		do
			!!new.make (s.count);
			from
				i := 1
			until
				i > s.count
			loop
				if s.item (i) = '%%' then
					if s.valid_index (i + 1) and s.valid_index (i + 2) then
						char := charconv (16 * hexa_value (s.item (i + 1)) +
											hexa_value (s.item (i + 2)));
						new.append_character (char);
						i := i + 2
					else
						new.append_character (s.item (i))
					end
				else
					new.append_character (s.item (i))
				end;
				i := i + 1;
			end;
			s.make_from_string (new)
		end

	hexa_value (c: CHARACTER): INTEGER is
			-- Hexadecimal value of a character from the hexa alphabet.
		require
			valid_hexa_character: (c>='0' and c<='9') or (c>='A' and c<='F')
		do
			inspect
				c
			when '0'..'9' then
				Result := c.code - ('0').code
			when 'A'..'F' then
				Result := c.code - ('A').code + 10
			end
		end

	Input_data: STRING is
			-- Data sent by the server.
		once
				-- Default method is "GET".
			if Request_method.is_equal ("POST") then
				if Content_length.is_integer then
					stdin.read_stream (Content_length.to_integer);
					Result := stdin.last_string
				else
					set_error ("Incorrect value for CONTENT_LENGTH")
				end
			else
				Result := Query_string
			end;
			if Result = Void then
				Result := ""
			end
		ensure
			input_data_exists: Result /= Void
		end

	insert_pair (name, val: STRING) is
			-- Insert pair (name,value) into form_data; take care of collisions.
		local
			vl: LINKED_LIST[STRING]
		do
				-- Convert strings to plain ASCII
			hexa_to_ascii (name);
			hexa_to_ascii (val);
				-- Is there already a value for `name'?
			if form_data.has (name) then
				form_data.item (name).extend (val);
				form_data.item (name).start
			else
				!!vl.make;
				vl.extend (val);
				vl.start;
				form_data.put (vl, name)
			end
		end

	parse_arguments (args: ARRAY[STRING]) is
			-- Parse arguments array and set environment variables.
		local
			i, sep_index: INTEGER;
			lh, rh, item: STRING
		do
			from
				i := args.lower
			until
				i > args.upper
			loop
				item := args.item (i);
				sep_index := item.index_of ('=', 1);
				if sep_index > 1 then
					lh := item.substring (1, sep_index - 1);
					if sep_index < item.count then
						rh := item.substring (sep_index + 1, item.count);
					else
						rh := "";
					end;
					set_environment_variable (lh, rh);
				end;
				i := i + 1
			end
		end

	parse_input is
			-- Split input string and build (name,value) pairs.
		local
			data, pair, key, val: STRING;
			nb_pairs, c, sep_index, field_sep_index: INTEGER;
			done: BOOLEAN
		do
			data := clone (Input_data);
			if not data.empty then
					-- Convert +'s to spaces
				data.replace_substring_all ("+"," ");
	
					-- Build the (name,value) pairs
				nb_pairs := data.occurrences (Pair_separator) + 1;
				!!form_data.make (nb_pairs);
				from
					c := 1
				until
					done or else c > data.count
				loop
					sep_index := data.index_of (Pair_separator, c);
					if sep_index = 1 then
						c := 2
					else
						if sep_index = 0 then
								-- Last pair reached
							pair := data.substring (c, data.count);
							done := True;
						else
							pair := data.substring (c, sep_index - 1);
						end
						field_sep_index := pair.index_of (Value_separator, 1);
						key := pair.substring (1, field_sep_index - 1);
						if pair.count >= field_sep_index + 1 then
							val := pair.substring (field_sep_index + 1, pair.count);
						else
							val := "";
						end
						insert_pair (key, val);
						c := sep_index + 1
					end
				end
			else
				!!form_data.make (0)
			end
		end

feature {NONE} -- Implementation constants

	Pair_separator: CHARACTER is '&'
			-- Name / value pairs separator.

	Value_separator: CHARACTER is '='
			-- Name / value separator.

end -- class CGI_INTERFACE

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

