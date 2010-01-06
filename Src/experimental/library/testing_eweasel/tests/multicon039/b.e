class B [G -> {
	C
		rename
			f as f alias "-"
		end,
	C
		rename
			g as g alias "+"
		end,
	C
		rename
			h as h alias "[]"
		end
	}]

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