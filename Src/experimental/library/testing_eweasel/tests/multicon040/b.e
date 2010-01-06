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
			x.f := x
			io.put_string (x.out)
			io.put_new_line
			x.h (x) := x
			io.put_string (x.out)
			io.put_new_line
			x [x] := x
			io.put_string (x.out)
			io.put_new_line
		end

end