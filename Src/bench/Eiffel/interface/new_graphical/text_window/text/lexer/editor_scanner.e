indexing
	description:"Scanners for Eiffel parsers"
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

deferred class
	EDITOR_SCANNER

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		export
			{NONE} all
		end

	EIFFEL_TOKENS
		export
			{NONE} all
		end

	UT_CHARACTER_CODES
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS


feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			eif_buffer := STRING_.make (Init_buffer_size)
		end

feature -- Start Job / Reinitialization 

	execute(a_string: STRING) is
			-- Analyze a string.
		do
			reset
			set_input_buffer (new_string_buffer(a_string))
			scan
		end

	reset is
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_buffer.wipe_out
			end_token := Void
			first_token := Void
			in_comments := False
		end

feature -- Access

	curr_token: EDITOR_TOKEN
			-- Current token analysed

	end_token: EDITOR_TOKEN
			-- Last token analysed.

	first_token: EDITOR_TOKEN
			-- First token analysed.

	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	tab_size_cell: CELL [INTEGER] 
			-- Cell that contains the size of tabulations
			-- blank spaces.
feature -- Element Change

	set_tab_size_cell (size_cell: CELL [INTEGER]) is
			-- Set `tab_size_cell' to `size_cell'.
		do
			tab_size_cell := size_cell
		end
		
feature {NONE} -- Processing

	update_token_list is
			-- Link the current token to the last one.
		do
			if end_token = Void then
				first_token := curr_token
			else
				end_token.set_next_token(curr_token)
			end
			curr_token.set_previous_token(end_token)
			end_token := curr_token
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80 
				-- Initial size for `eif_buffer'

	in_comments: BOOLEAN
			-- Are we inside a comment?

invariant

	eif_buffer_not_void: eif_buffer /= Void

end -- class EDITOR_SCANNER
