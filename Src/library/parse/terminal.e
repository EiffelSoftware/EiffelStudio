indexing

	description:
		"Constructs to be parsed by lexical analysis classes"

	status: "See notice at end of class"
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

	token: TOKEN
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
		end

	left_recursion: BOOLEAN is False;

	check_recursion is
			-- Do nothing.
			-- (Meaningless for terminal constructs)
		do
		end

	expand is
			-- Do nothing.
		do
		end

	parse_body is
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

	token_correct: BOOLEAN is
			-- Is token recognized?
		do  
			Result := document.token.type = token_type
		end 

   action is
			-- To be redefined in descendants.
		do
		end 

	in_action is
			-- Do nothing.
		do
		end 

end -- class TERMINAL

--|----------------------------------------------------------------
--| EiffelParse: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

