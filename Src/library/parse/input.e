indexing

	description:
		"Handling of input documents through a lexical analyzer";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INPUT inherit

	LINKED_LIST [TOKEN]
		rename 
			item as token
		export
			{ANY} token
		end

creation

	make

feature  -- Access

	analyzer: LEXICAL;
			-- Lexical analyzer used

	keyword_code (s: STRING) : INTEGER is
			-- Keyword code corresponding to `s';
			-- -1 if no specimen of `s' is found.
		require
			lex_not_void: analyzer /= Void
		do  
			Result := analyzer.keyword_code (s)
		end;

	keyword_string (code: INTEGER): STRING is
			-- Keyword string corresponding to `code'
		require
			lex_not_void: analyzer /= Void
		do
			Result := analyzer.keyword_string (code)
		end;

	set_lexical (lexical: LEXICAL) is
			-- Designate `lexical' as the `analyzer' to be used.
		require
			lex_not_void: lexical /= Void
		do
			analyzer := lexical
		end;

feature  -- Status report

	end_of_document : BOOLEAN is
			-- Has end of document been reached?
		do
			Result := analyzer.end_of_text
		end;

feature  -- Status setting

	set_input_file (filename: STRING) is
			-- Set the name of the input file to be read
			-- by the lexical analyzer.
		require
			lex_not_void: analyzer /= Void;
			name_not_void: filename /= Void;
		do
			check not (analyzer = Void) end;
			analyzer.set_file (filename)
		end;

	set_input_string (stringname: STRING) is
			-- Set the name of the input string to be read
			-- by the lexical analyzer.
		do
			analyzer.set_string (stringname)
		end;

feature  -- Input

	get_token is
			-- Make next token accessible with ``token''
		local
			new_token: TOKEN
		do
			if empty or else islast then
				analyzer.get_token;
				if analyzer.last_token.type = 0 then
					io.putstring("unrecognized_tokens%N");
					raise_error
						("Unrecognized token(s) found (and ignored)");
					from
					until
						end_of_document or analyzer.last_token.type /= 0
					loop
						analyzer.get_token
					end
				end;
				new_token := clone (analyzer.last_token);
				put_right (new_token)
			end;
			forth
		end;
	
	retrieve_lex (filename: STRING) is
			-- Retrieve `analyzer' from filename if exists.
		require
			name_not_void: filename /= Void
		local
			retrieved_file: UNIX_FILE
		do
			if analyzer = Void then
				!! analyzer.make
			end;
			!! retrieved_file.make_open_binary_read (filename);
			analyzer ?= analyzer.retrieved (retrieved_file);
			retrieved_file.close
		end;

feature  -- Output

	out_list is
			-- Output tokens recognized so far.
		do
			if not empty then
				from
					start;
					io.putstring ("Printing all tokens ");
					io.new_line
				until 
					after
				loop
					io.putstring (token.string_value);
					io.new_line;
					forth
				end
			end
		end;


	raise_error (s: STRING) is
			-- Print error message `s'.
		do  
			error_message.wipe_out;
			error_message.append (file_name); 
			error_message.append (" (line "); 
			error_message.append (token.line_number.out);
			error_message.append ("): "); 
			error_message.append (s); 
			io.error.putstring (error_message);
			io.error.new_line
		end;

feature {NONE}


	error_message : STRING is
			-- Last error message output
		once
			!! Result.make (120)
		end

	file_name : STRING is
			-- Name of the file read by the lexical analyzer
		do  
			Result := analyzer.file_name
		end;

	line_number : INTEGER is
			-- Line number of token
		do
			Result := analyzer.token_line_number
		end;


end -- class INPUT
 

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
