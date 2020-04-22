class TEST

inherit
	ANY
		rename
			twin as twin alias "+" alias "-"
		end

create
	make

feature {NONE} -- Creation

	make
		do
			io.put_boolean (Current ~ + Current)
			io.put_new_line
			io.put_boolean (Current ~ - Current)
			io.put_new_line
		end

end
