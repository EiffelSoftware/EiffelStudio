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

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
        do
			error_window.put_string ("(Uncompleted string, missing final quote)")
        end

end
