class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			object: ANY
			weak_reference: WEAK_REFERENCE [ANY]
			m: MEMORY
			i: INTEGER
		do
			create object
			create m
			create weak_reference.put (object)

			from until i = 100 loop
				m.$COLLECTION_TYPE
				if not attached weak_reference.item then
					print ("Bug at iteration #"+i.out+"%N")
				end
				i := i + 1
			end
		end

end
