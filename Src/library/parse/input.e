indexing

	description:
		"Handling of input documents through a lexical analyzer";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class INPUT inherit

	ARRAYED_LIST [TOKEN]
		rename 
			item as token,
			make as arrayed_list_make
		end

create

	make

feature -- Initialisation

	make is
			-- Create an empty document
		do
			arrayed_list_make (0)
		end

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
			if is_empty or else islast then
				analyzer.get_token;
				if analyzer.last_token.type = 0 then
					io.put_string("unrecognized_tokens%N");
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
			retrieved_file: RAW_FILE
		do
			create retrieved_file.make_open_read (filename);
			analyzer ?= retrieved_file.retrieved;
			retrieved_file.close
		end;

feature  -- Output

	out_list is
			-- Output tokens recognized so far.
		do
			if not is_empty then
				from
					start;
					io.put_string ("Printing all tokens ");
					io.new_line
				until 
					after
				loop
					io.put_string (token.string_value);
					io.new_line;
					forth
				end
			end
		end;


	raise_error (s: STRING) is
			-- Print error message `s'.
		do  
			error_message.wipe_out;
			if file_name /= Void then
				error_message.append (file_name); 
			end
			error_message.append (" (line "); 
			error_message.append_integer (token.line_number);
			error_message.append ("): "); 
			error_message.append (s); 
			io.error.put_string (error_message);
			io.error.new_line
		end;

feature {NONE}


	error_message : STRING is
			-- Last error message output
		once
			create Result.make (120)
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
--| EiffelParse: library of reusable components for ISE Eiffel.
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

