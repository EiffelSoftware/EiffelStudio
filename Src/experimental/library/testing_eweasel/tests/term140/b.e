expanded class B

inherit

	A [TEST]
		rename
			g as h
		redefine
			f
		end

feature

	f is
		require else
			False
		do
			io.put_string ("{B}.f")
			io.put_new_line
		end

end