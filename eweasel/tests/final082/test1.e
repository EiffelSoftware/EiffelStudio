
expanded class TEST1

create
	default_create, make

feature
	make
		do
			print (value (29)); io.new_line
			print ((agent value (29)).item ([])); io.new_line
		end

	value (n: INTEGER): INTEGER
		do
			Result := n
		end

end
