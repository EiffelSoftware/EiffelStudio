-- Error for bad character recognition

class BAD_CHARACTER

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
			put_string ("(invalid character)%N")
		end

end
