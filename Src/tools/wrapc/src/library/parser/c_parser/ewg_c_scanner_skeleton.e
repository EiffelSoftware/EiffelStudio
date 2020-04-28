note

	description:

		"Skeleton class for class EWG_C_SCANNER"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class EWG_C_SCANNER_SKELETON

inherit

	EWG_C_TOKENS
		export {NONE} all end

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			print_last_token,
			read_token
		end

	UT_CHARACTER_CODES
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

feature

	make (a_header_file_name: STRING)
			-- Create a new scanner.
			-- `a_header_file_name' will only be used until
			-- the first header file name directive has been found.
			-- This is usually the first line.
			-- This parameter is thus only useful for very simple
			-- header files, that do not need preprocessing.
			-- Because in this case, no header file name directives
			-- can be found.
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			make_compressed_scanner_skeleton
			last_header_file_name := a_header_file_name
			create type_name_scope_stack.make
		end

feature {ANY} -- Status report

	is_msc_extensions_enabled: BOOLEAN
			-- Should the scanner recognize and report Visual C specific keywords?

	last_header_line_numer: INTEGER
			-- Header file line number of last found token.

	last_header_file_name: STRING
			-- Name of header file from which last token came from.
			-- Note that via the c preprocessor remarks in the
			-- preprocessed header file, we can determine the header
			-- file name that the token really came from (in constrast
			-- to just always have `last_header_file_name' contain the
			-- name of the header we are parsing.


feature {ANY} -- Status setting

	enable_msc_extensions
			-- Scanner will recognize and report Visual C specific keywords.
			-- Note that turning on these extensions should only be used
			-- for header really meant to be parsed by Visual C.
			-- This is because this extension mode will make the scanner
			-- and parser choke on certain otherwise perfectly valid ANSI
			-- C headers.
		require
			msc_extensions_disabled: is_msc_extensions_enabled = False
		do
			is_msc_extensions_enabled := True
		ensure
			msc_extensions_enabled: is_msc_extensions_enabled
		end

feature {ANY}

	read_token
		do
			if position - error_handler.current_task_ticks > 20 then
				error_handler.set_ticks (position)
			end
			Precursor
		end

feature {NONE} -- Debug

	print_last_token
			-- Print to standard error debug information
			-- about the last token read. Can be redefined
			-- in descendant classes to print more information.
			-- (Called at the end of `read_token' when compiled
			-- with 'debug ("GELEX")' enabled).
		do
			std.error.put_string ("Last token code: ")
			std.error.put_integer (last_token)
			std.error.put_string (" / ")
			std.error.put_string (token_name (last_token))
			std.error.put_string (" / ")

			inspect last_token
			when yyEOF_token then
				std.error.put_string ("EOF token")
			when yyError_token then
				std.error.put_string ("Error token")
			when yyUnknown_token then
					-- Should never happen.
				std.error.put_string ("Unknown token")
			else
				std.error.put_character ('%"')
				std.error.put_string (text)
				std.error.put_string ("%"")
			end
			if yyLine_used then
					-- Line and column numbers are used.
				std.error.put_string (" [")
				std.error.put_integer (line)
				std.error.put_string (",")
				std.error.put_integer (column)
				std.error.put_string ("]")
			end
			std.error.put_string ("%N")
		end

feature {NONE}

	is_type_name_reporting_enabled: BOOLEAN
			-- Is TOK_TYPE_NAME reporting turned on?
			-- NOTE: `is_type_name_reporting = True' does not mean
			-- that any identifier will be reported as TOK_TYPE_NAME.
			-- `is_type_name_reporting = False' means that no identifier
			-- will be reported as TOK_TYPE_NAME.
			-- The concept of differentiating between type names and
			-- identifiers, although they are lexicaly identical, is
			-- a lexical tie in. This is one way around the problem that
			-- there cannot be a simple and effective pure LR(1) grammar
			-- for C. For references on why this is the case, search the net
			-- for "ANSI C parser type name identifier".
		do
			if type_name_scope_stack.is_empty or else
				type_name_scope_stack.item = True then
				Result := True
			end
		end

	type_name_scope_stack: DS_LINKED_STACK [BOOLEAN]
			-- Stack of type name scopes.
			-- Is the topmost element of the stack `True' then
			-- or is the stack empty, then reporting of TOK_TYPE_NAME
			-- is enabled. Otherwise TOK_TYPE_NAME reporting is disabled.
			-- Since there can be more than one type name scope in C
			-- we need to remember for which scope type name reporting is
			-- enabled and for which it isn't.

	is_type_name (a_token: STRING): BOOLEAN
			-- Has `a_token' been declared to be a type name?
			-- If `True' the lexer will report tokens that would
			-- otherwise be reported as TOK_IDENTIFIER, as TOK_TYPE_NAME
			-- instead. This is because of the infamouns typename/identifier
			-- problem in C. (C99 should fix this, but hey that does not buy
			-- us much considering the amount of legacy C code out there)
			-- To be implemented by the parser.
		require
			a_token_not_void: a_token /= Void
		deferred
		end

	implementation_bracket_counter: INTEGER
			-- To make things easier the lexer simply skips function
			-- implementations. Meaning the parser will never know about
			-- function bodies. It does this by using very simple
			-- lexical rules. But it needs to know the number of open brackets
			-- to know when the last closing bracket has been found and
			-- it should return to its mode where it reports every token it
			-- finds to the parser.

	gcc_attribute_bracket_counter: INTEGER
			-- Bracket counter for gcc attribute constructs.

	msc_declspec_bracket_counter: INTEGER
			-- Bracket counter for msc __declspec (...) constructs.

	INITIAL: INTEGER
			-- Code for the scanners start condition.
			-- Will be effected by C_SCANNER.
		deferred
		end

	SC_IMPL: INTEGER
			-- Code for the scanners impementation condition.
			-- Will be effected by C_SCANNER.
		deferred
		end

feature {NONE}

	error_handler: EWG_ERROR_HANDLER
		deferred
		end

	set_header_line_number (a_line_number: INTEGER)
			-- Make `a_line_number' the new `last_header_line_number' of
			-- `Current'.
		require
			a_line_number_greater_zero: a_line_number >= 0
		do
			last_header_line_numer := a_line_number
		end

	set_header_file_name (a_file_name: STRING)
			-- Make `a_file_name' the new `last_header_file_name' of
			-- `Current'.
		require
			a_file_name_not_void: a_file_name /= Void
		do
			last_header_file_name := file_system.pathname_from_file_system (a_file_name, unix_file_system)
		end

	report_type_or_identifier (a_text: STRING)
			-- Decide if `a_text' is either a TOK_IDENTIFIER or
			-- a TOK_TYPE_NAME, and report the right token type to the parser
			-- (together with `a_text' as it's value)
		require
			a_text_not_void: a_text /= Void
		do
			if is_type_name_reporting_enabled and is_type_name (a_text) then
				last_token := TOK_TYPE_NAME
				debug ("EWG_TYPE_IDENTIFIER")
					print ("reporting [" + a_text + "] as TOK_TYPE_NAME")
				end
			else
				last_token := TOK_IDENTIFIER
				debug ("EWG_TYPE_IDENTIFIER")
					print ("reporting [" + a_text + "] as TOK_IDENTIFIER")
					if is_type_name (a_text) then
						print (" even though it is a type name")
					end
				end
			end

			debug ("EWG_TYPE_IDENTIFIER")
				print (" line: " + line.out + "%N")
			end

			last_string_value := a_text
		end

	push_reporting_type_name_scope
			-- Add another type name scope on top of the type name scope stack.
			-- Make the newly added scope report type names.
		do
			type_name_scope_stack.put (True)
			debug ("EWG_TYPE_IDENTIFIER")
				print ("pushing stack: reporting " + type_name_scope_stack.count.out + "%N")
			end
		ensure
			-- `type_name_scope_stack.count' increased by one
		end

	push_non_reporting_type_name_scope
			-- Add another type name scope on top of the type name scope stack.
			-- Make the newly added scope not report type names.
		do
			type_name_scope_stack.put (False)
			debug ("EWG_TYPE_IDENTIFIER")
				print ("pushing stack: non-reporting " + type_name_scope_stack.count.out + "%N")
			end
		ensure
			-- `type_name_scope_stack.count' increased by one
		end

	pop_type_name_scope
			-- Remove the top type name scope of the type name scope stack.
		require
			type_name_scope_stack_not_empty: type_name_scope_stack.count > 0
		do
			type_name_scope_stack.remove
			debug ("EWG_TYPE_IDENTIFIER")
				print ("poping stack: now ")
				if is_type_name_reporting_enabled then
					print ("reporting " + type_name_scope_stack.count.out + "%N")
				else
					print ("non-reporting " + type_name_scope_stack.count.out + "%N")
				end
			end
		ensure
			-- `type_name_scope_stack.count' decreased by one
		end

	disable_type_name_reporting_for_this_scope
			-- Disable reporting of TOK_TYPE_NAME for the lifetime of the
			-- stacks top type name scope.
		require
			type_name_scope_stack_not_empty: type_name_scope_stack.count > 0
		do
			debug ("EWG_TYPE_IDENTIFIER")
				print ("disabling reporting for this scope%N")
			end
			type_name_scope_stack.replace (False)
		end

	enable_type_name_reporting_for_this_scope
			-- Enable reporting of TOK_TYPE_NAME for the lifetime of the
			-- stacks top type name scope.
		require
			type_name_scope_stack_not_empty: type_name_scope_stack.count > 0
		do
			debug ("EWG_TYPE_IDENTIFIER")
				print ("enable reporting for this scope%N")
			end
			type_name_scope_stack.replace (True)
		end

	enable_implementation_mode
			-- Mark function body beginning.
			-- Scanner will cease to report tokens except brackets.
		require
			start_condition_is_intial: start_condition = INITIAL
			implementation_bracket_counter_is_zero: implementation_bracket_counter = 0
		do
			set_start_condition (SC_IMPL)
			implementation_bracket_counter := 1
		ensure
			start_condition_is_sc_impl: start_condition = SC_IMPL
			implementation_bracket_counter_is_one: implementation_bracket_counter = 1
		end

	disable_implementation_mode
			-- Mark function body end.
			-- Scanner will report all tokens again.
		require
			start_condition_is_sc_impl: start_condition = SC_IMPL
			implementation_bracket_counter_is_zero: implementation_bracket_counter = 0
		do
			set_start_condition (INITIAL)
		ensure
			start_condition_is_initial: start_condition = INITIAL
			implementation_bracket_counter_is_zero: implementation_bracket_counter = 0
		end

invariant

	last_header_file_name_not_void: last_header_file_name /= Void
	type_name_scope_stack_not_void: type_name_scope_stack /= Void

end
