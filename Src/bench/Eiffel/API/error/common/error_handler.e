-- Error handler

class ERROR_HANDLER

inherit

	EXCEPTIONS;
	WINDOWS;
	SHARED_RESCUE_STATUS

creation

	make

feature -- Attributes

	new_error: BOOLEAN;
			-- Boolean for testing if new error since last `mark'

	error_list: SORTED_TWO_WAY_LIST [ERROR];
			-- Error list

	warning_list: SORTED_TWO_WAY_LIST [WARNING];
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
error_window.put_string ("Inserting error object:%N"); e.trace;
end;
			new_error := True;
			error_list.extend (e);
		end;

	insert_warning (w: WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
debug
error_window.put_string ("Inserting warning object:%N");
w.trace;
end;
			warning_list.extend (w);
		end;

	mark is
			-- Mark for testing `new_error'.
		do
			new_error := False;
		end;

	nb_errors: INTEGER is
		do
			Result := error_list.count;
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
debug
error_window.put_string ("Raising error%N");
end;
			Rescue_status.set_is_error_exception (True);
			raise ("Compiler error");
		end;

	checksum is
			-- Check if there are errors in `error_list' and raise
			-- an error if needed.
		do
debug
error_window.put_string ("Checking sum%N");
end;
			if not warning_list.empty then
debug
error_window.put_string ("Tracing warnings%N");
end;
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
			insert_error (string_too_long);
			raise_error;
		end;

	make_id_too_long is
			-- Build an error message for a too long identifier.
		local
			id_too_long: ID_TOO_LONG;
		do
			!!id_too_long.init;
			insert_error (id_too_long);
			raise_error;
		end;

	make_too_many_generics is
			-- Build an error message for too many generics.
		local
			too_many_generics: TOO_MANY_GENERICS;
		do
			!!too_many_generics.init;
			insert_error (too_many_generics);
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

	make_basic_generic_type is
		local
			basic_gen_type_error: BASIC_GEN_TYPE_ERR;
		do
			!!basic_gen_type_error.init;
			insert_error (basic_gen_type_error);
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
									$make_string_empty,
									$make_id_too_long,
									$make_basic_generic_type,
									$make_too_many_generics);
		end;

	wipe_out is
			-- Empty `error_list'.
		do
			error_list.wipe_out;
			warning_list.wipe_out;
		end;

feature -- Display

	retried: BOOLEAN;

	trace is
		do
			if not retried then
debug
error_window.put_string ("Error handler: trace%N")
end;
				from
					error_list.start
				until
					error_list.after
				loop
					display_separation_line;
					error_window.new_line;
					error_list.item.trace;
					error_window.new_line;
					error_list.forth;
				end;
				if not error_list.empty then
					display_separation_line
				end;
			else
				retried := False;
				display_error_error
			end;
		rescue
			if
				Rescue_status.is_unexpected_exception
			and then
				not Rescue_status.fail_on_rescue
			then
				retried := True;
				retry;
			end;
		end;

	trace_warnings is
		do
			if not retried then
				from
					warning_list.start
				until
					warning_list.after
				loop
					display_separation_line
					error_window.new_line;
					warning_list.item.trace;
					error_window.new_line;
					warning_list.forth;
				end;
				if not warning_list.empty and then error_list.empty then
						-- There is no error in the list
						-- put a separation before the next message
					display_separation_line
				end;
				warning_list.wipe_out;
			else
				retried := False;
				display_error_error
			end;
		rescue
			if Rescue_status.is_unexpected_exception then
				retried := True;
				retry;
			end;
		end;

	display_error_error is
		do
			error_window.put_string ("Exception occurred while displaying error message.%N%
										%Please contact ISE to report this bug.%N");
		end;

	display_separation_line is
		do
			error_window.put_string ("-------------------------------------------------------------------------------%N");
		end;

feature {NONE} -- Externals

	error_init (obj: ANY; ptr1, ptr2, ptr3, ptr4, ptr5, ptr6, ptr7, ptr8, ptr9: POINTER) is
			-- Initialize syntac error handling C primitives.
		external
			"C"
		end;

invariant

	error_list_exists: error_list /= Void;

end
