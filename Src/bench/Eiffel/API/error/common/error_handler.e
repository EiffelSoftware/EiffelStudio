indexing
	description: "Error handler that manages warning and error messages."
	date: "$Date$"
	revision: "$Revision $"

class ERROR_HANDLER

inherit
	EXCEPTIONS

	SHARED_RESCUE_STATUS

creation {SHARED_ERROR_HANDLER}

	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			!!error_list.make
			!!warning_list.make
		end

feature -- Properties

	error_displayer: ERROR_DISPLAYER
			-- Displays warning and error messages when they occur

	error_list: LINKED_LIST [ERROR]
			-- Error list

	warning_list: LINKED_LIST [WARNING]
			-- Warning list

	new_error: BOOLEAN
			-- Boolean for testing if new error since last `mark'

	error_position: INTEGER
			-- Position in file where error occurred (during degree 3)?

feature {E_PROJECT, COMPILER_EXPORTER, DEGREE_OUTPUT} -- Element change

	insert_interrupt_error (is_during_comp: BOOLEAN) is
			-- Insert an `interrup_error' so that the compilation
			-- can be stopped. `is_during_comp' indicates if it was
			-- done during a compilation.
		local
			interrupt_error: INTERRUPT_ERROR
		do
			!! interrupt_error
			if is_during_comp then
				interrupt_error.set_during_compilation
			end
			insert_error (interrupt_error)
		end

feature {COMPILER_EXPORTER, E_PROJECT} -- Output

	trace is
			-- Trace the output of the errors if there are any.
		require	
			non_void_error_displayer: error_displayer /= Void
		do
			if not warning_list.empty then
				error_displayer.trace_warnings (Current)
				warning_list.wipe_out
			end

			if not error_list.empty then
				error_displayer.trace_errors (Current)
				error_position := 0
				error_list.wipe_out
			end
		end

	trace_warnings is
			-- Trace the output of the warnings if there are any.
		require	
			non_void_error_displayer: error_displayer /= Void
		do
			if not warning_list.empty then
				error_displayer.trace_warnings (Current)
				warning_list.wipe_out
			end
		end

feature {COMPILER_EXPORTER} -- Error handling primitives

	set_error_position (i: like error_position) is
			-- Set `error_position' to `i'.
		require
			non_negative_value: i >= 0
		do
			error_position := i
		ensure
			set: error_position = i
		end

	insert_error (e: ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		local
			f_error: FEATURE_ERROR
		do
			new_error := True
			f_error ?= e
			if f_error /= Void then
				f_error.set_error_position (error_position)
			end
			error_list.extend (e)
			error_list.finish
		end

	insert_warning (w: WARNING) is
			-- Insert `w' in `warning_list'.
		require
			good_argument: w /= Void
		do
			warning_list.extend (w)
			warning_list.finish
		end

	mark is
			-- Mark for testing `new_error'.
		do
			new_error := False
		end

	nb_errors: INTEGER is
		do
			Result := error_list.count
		end

	has_error: BOOLEAN is
			-- Has the error handler detected an error so far ?
		do
			Result := not error_list.empty
		end

	raise_error is
			-- Raise an exception retrieved by routine `recompile'
			-- of class SYSTEM_I
		require
			non_void_error_displayer: error_displayer /= Void
			has_error: not error_list.empty
		do
			Rescue_status.set_is_error_exception (True)
			raise ("Compiler error")
		end

	checksum is
			-- Check if there are errors in `error_list' and raise
			-- an error if needed.
		require	
			non_void_error_displayer: error_displayer /= Void
		do
			if not error_list.empty then
				raise_error
			end
		end

	wipe_out is
			-- Empty `error_list'.
		do
			error_list.wipe_out
			warning_list.wipe_out
		end

feature {E_PROJECT, COMPILER_EXPORTER} -- Setting

	set_error_displayer (ed: like error_displayer) is
			-- Set `error_displayer' to `ed'.
		require
			non_void_ed: ed /= Void
		do
			error_displayer := ed
		ensure
			set: error_displayer = ed
		end

feature {COMPILER_EXPORTER} 

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
									$make_too_many_generics)
		end

feature {EXPR_ADDRESS_AS} -- Passed to C

	make_syntax_error is
			-- Build a syntax error message
			-- [Called by the parsers]
		local
			syntax_error: SYNTAX_ERROR
		do
			!!syntax_error.init
			insert_error (syntax_error)
			raise_error
		end

feature {COMPILER_EXPORTER}

	make_separate_syntax_error is
			-- Build an error message for using `separate' when
			-- Concurrent Eiffel is not enabled
		local
			separate_error: SEPARATE_SYNTAX_ERROR
		do
			!! separate_error.init
			insert_error (separate_error)
			raise_error
		end

feature {NONE} -- Passed to C

	make_string_too_long is
			-- Build an error message for a too long manifest string.
		local
			string_too_long: STRING_TOO_LONG
		do
			!!string_too_long.init
			insert_error (string_too_long)
			raise_error
		end

	make_id_too_long is
			-- Build an error message for a too long identifier.
		local
			id_too_long: ID_TOO_LONG
		do
			!!id_too_long.init
			insert_error (id_too_long)
			raise_error
		end

	make_too_many_generics is
			-- Build an error message for too many generics.
		local
			too_many_generics: TOO_MANY_GENERICS
		do
			!!too_many_generics.init
			insert_error (too_many_generics)
			raise_error
		end

	make_string_extension is
			-- Build an error message for a bad string extension.
		local
			string_extension: STRING_EXTENSION
		do
			!!string_extension.init
			insert_error (string_extension)
			raise_error
		end

	make_string_uncompleted is
			-- Build an error message for an umcompleted string
		local
			string_uncompleted: STRING_UNCOMPLETED
		do
			!!string_uncompleted.init
			insert_error (string_uncompleted)
			raise_error
		end

	make_bad_character is
			-- Build an error message for a bad character
		local
			bad_char: BAD_CHARACTER
		do
			!!bad_char.init
			insert_error (bad_char)
			raise_error
		end

	make_string_empty is
			-- Build an error message for an empty string
		local
			string_empty: STRING_EMPTY
		do
			!!string_empty.init
			insert_error (string_empty)
			raise_error
		end

	make_basic_generic_type is
		local
			basic_gen_type_error: BASIC_GEN_TYPE_ERR
		do
			!!basic_gen_type_error.init
			insert_error (basic_gen_type_error)
			raise_error
		end

feature {NONE} -- Externals

	error_init (obj: POINTER ptr1, ptr2, ptr3, ptr4, ptr5, ptr6, ptr7, ptr8, ptr9: POINTER) is
			-- Initialize syntac error handling C primitives.
		external
			"C"
		end

invariant

	error_list_exists: error_list /= Void
	warning_list_exists: warning_list /= Void

end -- class ERROR_HANDLER
