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

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			error_window.put_string ("(Bad character)")
		end

end
