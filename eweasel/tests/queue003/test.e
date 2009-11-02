class TEST

create
	make

feature

	make
		do
			test_queue (create {BOUNDED_QUEUE [INTEGER]}.make (3), create {BOUNDED_QUEUE [INTEGER]}.make (3))
			test_queue (create {ARRAYED_QUEUE [INTEGER]}.make (3), create {ARRAYED_QUEUE [INTEGER]}.make (3))
			test_queue (create {LINKED_QUEUE [INTEGER]}.make, create {LINKED_QUEUE [INTEGER]}.make)
		end

	test_queue (a_queue1, a_queue2: QUEUE [INTEGER])
		require
			a_queue1.is_empty
			a_queue2.is_empty
			a_queue1.same_type (a_queue2)
		do
			io.put_string (a_queue1.generating_type)
			io.put_new_line

			print_list ("1", a_queue1.linear_representation)

			a_queue1.extend (1)
			a_queue1.extend (2)
			a_queue1.extend (3)

			print_list ("2", a_queue1.linear_representation)

			a_queue1.remove
			a_queue1.remove

			print_list ("3", a_queue1.linear_representation)

			a_queue1.extend (4)
			a_queue1.extend (5)

			print_list ("4", a_queue1.linear_representation)

			a_queue2.extend (3)
			a_queue2.extend (4)
			a_queue2.extend (5)

			print_list ("5", a_queue2.linear_representation)
		end

	print_list (tag: STRING; l: LINEAR [INTEGER])
		do
			io.put_string ("Test #" + tag + ":%N")
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
					io.put_string (l.item.out)
					io.put_character (' ')
					l.forth
				end
				io.put_new_line
			end
			io.put_new_line
		end

end

