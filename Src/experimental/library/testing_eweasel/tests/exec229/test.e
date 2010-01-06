class TEST
create
	make

feature
	make is
		local
			d1, d2, d3: DOUBLE
		do
			print ("pre D1=")
			print (d1)
			print ("%N")

			print ("pre D2=")
			print (d2)
			print ("%N")

			print ("pre D3=")
			print (d3)
			print ("%N")

			d1 := -0.75
			d2 := my_clone (d1)
			d3 ?= my_clone (d1)

			print ("post D1=")
			print (d1)
			print ("%N")

			print ("post D2=")
			print (d2)
			print ("%N")

			print ("post D3=")
			print (d3)
			print ("%N")
		end

	frozen my_clone (other: ANY): like other is
		do
			if other /= Void then
				Result := other.twin
			end
		end

end
