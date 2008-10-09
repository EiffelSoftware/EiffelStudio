class TEST
 
create
	make
 
feature
 
	make is
		local
			a: TEST1
			b: TEST2
		do
			create a
			a.f
			create b
			b.f
		end
 
end
