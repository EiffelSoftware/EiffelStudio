--|---------------------------------------------------------------
--|   Copyright (C) 1993 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Handling of input documents through a lexical analyzer

indexing

	date: "$Date$";
	revision: "$Revision$"

class INPUT 

inherit

	LINKED_LIST [TOKEN]
		rename 
			item as token
		export
			{ANY} token
		end

creation

	make

feature {NONE}

	analyzer: LEXICAL;
			-- Lexical analyzer used

	file_name : STRING is
			-- Name of the file read by the lexical analyser
		do  
			Result := analyzer.file_name
		end -- file_name

feature 

	set_input_file (filename: STRING) is
			-- Set the name of the input file to be read
			-- by the lexical analyser.
		require
			not_lex_void: not (analyzer = Void);
			not_name_void: not (filename = Void);
		do
			check not (analyzer = Void) end;
			analyzer.set_file (filename)
		end; -- set_input_file

	set_input_string (stringname: STRING) is
			-- Set the name of the input string to be read
			-- by the lexical analyser.
		do
			analyzer.set_string (stringname)
		end; -- set_input_string

	end_of_document : BOOLEAN is
			-- Has end of document been reached?
		do
			Result := analyzer.end_of_text
		end; -- end_of_document

	keyword_code (s: STRING) : INTEGER is
			-- Keyword code corresponding to `s';
			-- -1 if no specimen of `s' is found.
		do  
			Result := analyzer.keyword_code (s)
		end; -- keyword_code

	keyword_string (code: INTEGER): STRING is
			-- Keyword string corresponding to code
		do
			Result := analyzer.keyword_string (code)
		end; -- keyword_string

	set_lexical (lexical: LEXICAL) is
			-- Assign `lexical' to `analyzer'.
		do
			analyzer := lexical
		end -- set_lexical

feature {NONE}

	line_number : INTEGER is
			-- Line number of token
		do
			Result := analyzer.token_line_number
		end -- line_number

feature 

	get_token is
			-- Make next token accessible with ``token''
		local
			new_token: TOKEN
		do
			if empty or else islast then
				analyzer.get_token;
				if analyzer.last_token.type = 0 then
					io.putstring("unrecognised_tokens%N");
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
				add_right (new_token)
			end;
			forth
		end; -- get_token
	
	retrieve_lex (filename: STRING) is
			-- Retrieve `analyzer' from filename if exists.
		require
			not_lex_void: not (analyzer = Void);
			not_name_void: not (filename = Void);
		local
			retrieved_file: UNIX_FILE
		do
			if analyzer = Void then
				!!analyzer.make
			end;
			!!retrieved_file.make_open_read (filename);
			analyzer ?= analyzer.retrieved (retrieved_file);
			retrieved_file.close
		end; -- retrieve_lex

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
		end -- out_list

feature {NONE}

	error_message : STRING is
			-- Last error message output
		once
			!!Result.make(120)
		end

feature 

	raise_error (s: STRING) is
			-- Print error message s.
		local
			b: BASIC_ROUTINES
		do  
			!!b;
			error_message.wipe_out;
			error_message.append (file_name); 
			error_message.append (" (line "); 
			error_message.append (token.line_number.out);
			error_message.append ("): "); 
			error_message.append (s); 
			io.error.putstring (error_message);
			io.error.new_line
		end  -- raise_syntax_error

end -- class INPUT
