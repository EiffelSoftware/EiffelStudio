-- Syntax error for uncompleted string (final quote is missing)

class STRING_UNCOMPLETED

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
			put_string ("(incomplete string: missing final quote)%N")
        end

end
