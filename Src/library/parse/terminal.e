indexing

	description:
		"Constructs to be parsed by lexical analysis classes";

	copyright: "See notice at end of class";
	date: "$Date$";
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

	token: TOKEN; 
			-- Token associated with terminal

feature -- Status report

	token_type: INTEGER is
			-- Token code associated with terminal
		deferred 
		end 

feature {NONE} -- Implementation

	production: LINKED_LIST [CONSTRUCT] is
			-- Void
			-- (Meaningless for terminal constructs)
		once 
		end; 

	no_left_recursion: BOOLEAN is true;

	check_recursion is
			-- Do nothing.
			-- (Meaningless for terminal constructs)
		do
		end; 

	expand is
			-- Do nothing.
		do
		end; 

	parse_body is
			-- Parse a terminal construct.
		do
			-- From Kim Walden if token_correct or is_optional then
			if token_correct then
				token := document.token;
				document.get_token;
				complete := true
			else
				complete := false
			end
		end; 

	token_correct: BOOLEAN is
			-- Is token recognized?
		do  
			Result := document.token.type = token_type
		end; 

   action is
			-- To be redefined in descendants.
		do
		end; 

	in_action is
			-- Do nothing.
		do
		end 

end -- class TERMINAL
 

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
