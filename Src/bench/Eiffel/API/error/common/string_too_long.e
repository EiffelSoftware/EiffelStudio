-- Syntax error for manifest string too long

class STRING_TOO_LONG

inherit

	SYNTAX_ERROR
		redefine
			build_explain
		end

creation

	init

feature

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
        do
			error_window.put_string ("(String too long)")
        end;

end
