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

	build_explain is
            -- Build specific explanation image for current error
            -- in `error_window'.
        do
			put_string ("(string too long)%N")
        end;

end
