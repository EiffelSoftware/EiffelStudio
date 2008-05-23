class TEST

create
	make

feature

	make is
			--
		local
			t1: T_ACTIVE [STRING]
			t2: T_TRAVERSABLE [STRING]
			t3: T_SEQUENCE [STRING]
			t4: T_LINKED_LIST [STRING]
			t5: T_QUEUE [STRING]
			t6: T_LINKED_QUEUE [STRING]
		do
			create t6

			t1 := t6
			t2 := t6
			t3 := t6
			t4 := t6
			t5 := t6
			print ("From ACTIVE: ") print (t1.item)
			print ("From TRAVERSABLE: ") print (t2.item)
			print ("From SEQUENCE: ") print (t3.item)
			print ("From LINKED_LIST: ") print (t4.item)
			print ("From QUEUE: ") print (t5.item)
			print ("From LINKED_QUEUE: ") print (t6.item)
		end

end
