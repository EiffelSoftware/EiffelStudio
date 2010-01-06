class A [
	G ->
		C
			rename
				f as f alias "-",
				g as g alias "+",
				h as h alias "[]"
			end
	]

create
	make

feature {NONE} -- Creation

	make (x: G) is
			-- Run test.
		require
			x_attached: x /= Void	
		do
			io.put_string ((-x).out)
			io.put_new_line
			io.put_string ((x + x).out)
			io.put_new_line
			io.put_string (x [x].out)
			io.put_new_line
		end

end