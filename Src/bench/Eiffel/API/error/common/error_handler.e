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

feature -- Status

	has_error: BOOLEAN is
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end


feature {E_PROJECT, COMPILER_EXPORTER, SHARED_ERROR_HANDLER} -- Element change

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
			raise_error
		end

feature {COMPILER_EXPORTER, E_PROJECT} -- Output

	trace is
			-- Trace the output of the errors if there are any.
		require	
			non_void_error_displayer: error_displayer /= Void
		do
			if has_warning then
				error_displayer.trace_warnings (Current)
				warning_list.wipe_out
			end

			if has_error then
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
			if has_warning then
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

	has_warning: BOOLEAN is
			-- Has error handler detected a warning so far?
		do
			Result := not warning_list.is_empty
		end

	raise_error is
			-- Raise an exception retrieved by routine `recompile'
			-- of class SYSTEM_I
		require
			non_void_error_displayer: error_displayer /= Void
			has_error: has_error
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
			if has_error then
				raise_error
			end
		end

	force_display is
			-- Make sure the user can see the messages we send.
		do
			error_displayer.force_display
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

invariant

	error_list_exists: error_list /= Void
	warning_list_exists: warning_list /= Void

end -- class ERROR_HANDLER
