-- Syntax error

class SYNTAX_ERROR

inherit

	ERROR
		redefine
			trace, stone
		end

creation

	init

feature -- Attributes

	file_name: STRING;
			-- Path to the file where the syntax error happened

	start_position: INTEGER;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER;
			-- Ending position of the of the token involved in the syntax
			-- error

feature -- Creation

	init is
			-- Initialize `start_position' and `end_position'.
		do
			start_position := get_start_position;
			end_position := get_end_position;
			file_name := get_yacc_file_name;
		end;

feature -- Conveniences

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

	set_start_position (i: INTEGER) is
			-- Assign `i' to `start_position'.
		do
			start_position := i;
		end;

	set_end_position (i: INTEGER) is
			-- Assign `i' to `end_position'.
		do
			end_position := i;
		end;

feature -- Error code

	code: STRING is "Syntax error";
			-- Error code

feature

	trace is
			-- Debug purpose
		local
			dummy_reference: CLASS_C
		do
			error_window.put_string ("Syntax error at position ");
			error_window.put_string (start_position.out);
			if Lace.parsed then
				-- Error happened in a class
				error_window.put_string (" in class ");
				error_window.put_clickable_string (
						stone (dummy_reference),
						System.current_class.signature)
			else
				error_window.put_clickable_string (stone (dummy_reference), " in ace file")
			end;
			error_window.put_string ("%N");
			build_explain (error_window)
		end

feature {NONE} -- Externals

	get_start_position: INTEGER is
			-- Get start position processed by yacc
		external
			"C"
		end;

	get_end_position: INTEGER is
			-- Get end position processed by yacc.
		external	
			"C"
		end;

	get_yacc_file_name: STRING is
			-- Get file name processed by yacc.
		external
			"C"
		end;

feature -- stoning

	stone (reference_class: CLASS_C): SYNTAX_STONE is
			-- Reference class is useless here
		do
			!!Result.make (Current)
		end

end
