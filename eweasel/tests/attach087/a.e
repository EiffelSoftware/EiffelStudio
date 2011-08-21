class A

create

	make

feature

	make
		do
		end

	d: like Current
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
		
	p (x: like Current)
		do
		end

end
