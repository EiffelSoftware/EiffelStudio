
class TEST1 [G -> {ANY, NUMERIC}]
create
	make

feature {NONE}

	make (a: G) is
		do
			print (a // 2); io.new_line
		end

end
