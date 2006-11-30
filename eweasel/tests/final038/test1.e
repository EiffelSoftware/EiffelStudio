
expanded class TEST1 [G]
create
	default_create
feature

	make (n: G) is
		do
			x := n
			print ((agent x).item ([])); io.new_line
		end

	x: G

end
