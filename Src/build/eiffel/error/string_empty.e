-- Syntax error for empty lace string

class STRING_EMPTY

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
			put_string ("(empty string not permitted here)%N")
        end;

end
