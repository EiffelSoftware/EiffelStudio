class TEST

create
	make

feature 

	make
		local
			a1: A [TUPLE [v: STRING; i: INTEGER]]
			a2: A [B [STRING]]
			a3: A [B [INTEGER]]
			a4: A [C]
		do
			create a1
			create a2
			create a3
			create a4

			print (a1.item.generating_type) print ("%N")
			print (a1.item_att.generating_type) print ("%N")
			print (a1.item_det.generating_type) print ("%N")

			print (a2.item.generating_type) print ("%N")
			print (a2.item_att.generating_type) print ("%N")
			print (a2.item_det.generating_type) print ("%N")

			print (a3.item.generating_type) print ("%N")
			print (a3.item_att.generating_type) print ("%N")
			print (a3.item_det.generating_type) print ("%N")

			print (a4.item.generating_type) print ("%N")
			print (a4.item_att.generating_type) print ("%N")
			print (a4.item_det.generating_type) print ("%N")
		end

end
