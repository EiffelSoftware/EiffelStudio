class TEST
create
	make
feature
	
	make is
		local
			a: ANY
		do
			a := $x
			print (a.generating_type); io.new_line
		end

	x: TEST1
end
