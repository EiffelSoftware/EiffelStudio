-- Error handler

class ERROR_HANDLER

inherit

	EXCEPTIONS

creation

	make

feature -- Attributes

	new_error: BOOLEAN;
			-- Boolean for testing if new error since last `mark'

	error_list: LINKED_LIST [ERROR];
			-- Error list

	warning_list: LINKED_LIST [WARNING];
			-- Warning list

feature -- Creation feature

	make is
			-- Initialization
		do
			!!error_list.make;
			!!warning_list.make;
		end;

feature	-- Error handling primitives

	insert_error (e: ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
debug
io.error.putstring ("Inserting error object:%N");
e.trace;
end;
			new_error := True;
			error_list.start;	
			error_list.put_right (e);
		end;

	insert_warning (w: WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
debug
io.error.putstring ("Inserting warning object:%N");
w.trace;
end;
			warning_list.start;	
			warning_list.put_right (w);
		end;

	mark is
			-- Mark for testing `new_error'.
		do
			new_error := False;
		end;

	has_error: BOOLEAN is
			-- Has the error handler detected an error so far ?
		do
			Result := not error_list.empty;
		end;

	raise_error is
			-- Raise an exception retrieved by routine `recompile'
			-- of class SYSTEM_I
		require
			has_error: not error_list.empty;
		do
			raise ("Compiler error");
		end;

	checksum is
			-- Check if there are errors in `error_list' and raise
			-- an error if needed.
		do
			if not warning_list.empty then
				trace_warnings;
			end;
			if not error_list.empty then
				raise_error;
			end;
		end;

feature -- Syntax errors

	make_syntax_error is
			-- Build a syntax error message
			-- [Called by the parsers]
		local
			syntax_error: SYNTAX_ERROR;
		do
			!!syntax_error.init;
			insert_error (syntax_error);
			raise_error;
		end;

	make_string_too_long is
			-- Build an error message for a too long manifest string.
		local
			string_too_long: STRING_TOO_LONG;
		do
			!!string_too_long.init;
			string_too_long.init;
			insert_error (string_too_long);
			raise_error;
		end;

	make_string_extension is
			-- Build an error message for a bad string extension.
		local
			string_extension: STRING_EXTENSION;
		do
			!!string_extension.init;
			insert_error (string_extension);
			raise_error;
		end;

	make_string_uncompleted is
			-- Build an error message for an umcompleted string
		local
			string_uncompleted: STRING_UNCOMPLETED;
		do
			!!string_uncompleted.init;
			insert_error (string_uncompleted);
			raise_error;
		end;

	make_bad_character is
			-- Build an error message for a bad character
		local
			bad_char: BAD_CHARACTER;
		do
			!!bad_char.init;
			insert_error (bad_char);
			raise_error;
		end;

	make_string_empty is
			-- Build an error message for an empty string
		local
			string_empty: STRING_EMPTY;
		do
			!!string_empty.init;
			insert_error (string_empty);
			raise_error;
		end;

	send_yacc_information is
			-- Send to C code of Yacc information for making
			-- error messages.
		once
			error_init ($Current, 	$make_syntax_error,
									$make_string_too_long,
									$make_string_extension,
									$make_string_uncompleted,
									$make_bad_character,
									$make_string_empty);
		end;

	wipe_out is
			-- Empty `error_list'.
		do
			error_list.wipe_out;
			warning_list.wipe_out;
		end;

feature -- Debug purpose

	trace is
		do
			from
				error_list.start
			until
				error_list.offright
			loop
				error_list.item.trace;
				io.error.putstring ("------------------------------%N");
				error_list.forth;
			end;
		end;

	trace_warnings is
		do
			from
				warning_list.start
			until
				warning_list.offright
			loop
				io.error.putstring ("%T");
				warning_list.item.trace;
				io.error.putstring ("------------------------------%N");
				warning_list.forth;
			end;
			warning_list.wipe_out;
		end;

feature {NONE} -- Externals

	error_init (obj: ANY; ptr1, ptr2, ptr3, ptr4, ptr5, ptr6: POINTER) is
			-- Initialize syntac error handling C primitives.
		external
			"C"
		end;

invariant

	error_list_exists: error_list /= Void;

end
