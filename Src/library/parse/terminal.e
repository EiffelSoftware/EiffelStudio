note

	description:
		"Constructs to be parsed by lexical analysis classes"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class TERMINAL  inherit

	CONSTRUCT
		rename
			post_action as action,
			pre_action as unused_pre_action
		redefine
			action
		end

feature -- Access

	token: detachable TOKEN
			-- Token associated with terminal

feature -- Status report

	token_type: INTEGER
			-- Token code associated with terminal
		deferred
		end

feature {NONE} -- Implementation

	production: LINKED_LIST [CONSTRUCT]
			-- Empty
			-- (Meaningless for terminal constructs)
		once
			create Result.make
		end

	left_recursion: BOOLEAN = False;

	check_recursion
			-- Do nothing.
			-- (Meaningless for terminal constructs)
		do
		end

	expand
			-- Do nothing.
		do
		end

	parse_body
			-- Parse a terminal construct.
		do
			-- From Kim Walden if token_correct or is_optional then
			if token_correct then
				token := document.token;
				document.get_token;
				complete := True
			else
				complete := False
			end
		end

	token_correct: BOOLEAN
			-- Is token recognized?
		do
			Result := document.token.type = token_type
		end

   action
			-- To be redefined in descendants.
		do
		end

	in_action
			-- Do nothing.
		do
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class TERMINAL

