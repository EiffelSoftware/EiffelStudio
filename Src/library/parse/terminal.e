--|---------------------------------------------------------------
--|   Copyright (C) 1993 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Constructs to be parsed by lexical analysis classes

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class TERMINAL  

inherit

	CONSTRUCT
		rename 
			post_action as action, 
			pre_action as unused_pre_action
		redefine 
			action
		end

feature 

	token: TOKEN; 
			-- Token associated with terminal

	token_type: INTEGER is
			-- Token code associated with terminal
		deferred 
		end -- token_type

feature {NONE}

	production: LINKED_LIST [CONSTRUCT] is
			-- Void
			-- (Meaningless for terminal constructs)
		once 
		end; -- production

	no_left_recursion: BOOLEAN is true;

	check_recursion is
			-- Do nothing.
			-- (Meaningless for terminal constructs)
		do
		end; -- check_recursion

	expand is
			-- Do nothing.
		do
		end; -- expand

	parse_body is
			-- Parse a terminal construct.
		do
			if token_correct or is_optional then
				token := document.token;
				document.get_token;
				complete := true
			else
				complete := false
			end
		end; -- parse_body

	token_correct: BOOLEAN is
			-- Is token recognized?
		do  
			Result := document.token.type = token_type
		end; -- token_correct

   action is
			-- To be redefined in descendants.
		do
		end; -- action

	in_action is
			-- Do nothing.
		do
		end -- in_action

end -- class TERMINAL
