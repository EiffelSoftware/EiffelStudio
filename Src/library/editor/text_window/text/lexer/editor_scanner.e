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
		require
			string_not_empty: not a_string.is_empty
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

	tab_size: INTEGER
			-- Cell that contains the size of tabulations
			-- blank spaces.
			
feature -- Query
	
	in_verbatim_string: BOOLEAN
			-- Are we inside a verbatim string?
		
feature -- Status Setting

	set_in_verbatim_string (a_flag: BOOLEAN) is
			-- Set `in_verbatim_string' to `a_flag'
		do
			in_verbatim_string := a_flag
		ensure
			value_set: in_verbatim_string = a_flag
		end		
		
feature -- Element Change

	set_tab_size (size: INTEGER) is
			-- Set `tab_size' to `size'.
		do
			tab_size := size
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

feature {NONE} -- Implementation

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*\][^%\n"]*\"  .)
			from j := 1 until found loop
				if text_item (j) = ']' then
					found := True
				end
				j := j + 1
			end
			nb := text.count
			if nb = (text_count - j) then
				Result := True
				from i := 1 until i > nb loop
					if text.item (i) = text_item (j) then
						i := i + 1
						j := j + 1
					else
						Result := False
						i := nb + 1  -- Jump out of the loop.
					end
				end
			end
		end

invariant
	eif_buffer_not_void: eif_buffer /= Void

end -- class EDITOR_SCANNER
