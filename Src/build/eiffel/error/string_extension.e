-- Syntax error when a string extension is bad

class STRING_EXTENSION

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
			put_string ("(invalid character code after percent)%N")
        end

end
