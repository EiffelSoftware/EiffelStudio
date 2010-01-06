
class TEST
create
	make

feature {NONE}

	make is
		do
			print ((agent x).item ([])); io.new_line
		end

	x: INTEGER is 13

end
