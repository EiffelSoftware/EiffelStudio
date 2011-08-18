class A

create

	make

feature

	make
		do
		end

	d: like Current
			-- attached A
		attribute
			create Result.make
		end

	f
		do
			d.g
		end
	
	g
		do
			print ("g")
		end
		
end
