-- Syntax error for more than 4 generic parameters

class TOO_MANY_GENERICS

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
			put_string ("(the number of generic parameters is limited to four)%N")
        end;

end
