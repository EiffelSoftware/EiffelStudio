deferred class MATCHER

feature -- Status setting

	set_input_string (input: STRING) is
			-- Sets `input' as string which should match.
		require
			valid_input: input /= Void
		do
			input_string := input
		end

feature -- Access

	match is
			-- Tries to match the string given by `set_input_string'
			-- and the automaton.
			-- `matched' has the answer
		deferred
		end

feature -- Status report

	matched: BOOLEAN is
			-- Did the automaton recognize `input' during last call
			-- to `match'
		do
			Result := matching_strings
		end

feature {MATCHER} -- Attributes

	matching_strings: BOOLEAN
			-- Are the strings matching?

	input_string: STRING
			-- String to recognize

	automaton_string: STRING
			-- String where automaton is build of.
			-- (Argument of make)

end -- class MATCHER
