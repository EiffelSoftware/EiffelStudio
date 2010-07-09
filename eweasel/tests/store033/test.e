class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
-- Uncomment to store old version of stacks and queues.
--			store
			retrieve
		end

	store
		do
			store_dispenser (create {BOUNDED_QUEUE [INTEGER]}.make (10))
			store_dispenser (create {ARRAYED_QUEUE [INTEGER]}.make (10))
			store_dispenser (create {BOUNDED_STACK [INTEGER]}.make (10))
			store_dispenser (create {ARRAYED_STACK [INTEGER]}.make (10))
		end

	store_dispenser (a_dispenser: DISPENSER [INTEGER])
		local
			l_file: RAW_FILE
		do
			a_dispenser.extend (1)
			a_dispenser.extend (2)
			a_dispenser.extend (3)

			create l_file.make_open_write (a_dispenser.generator.as_lower + "_1")
			l_file.independent_store (a_dispenser)
			l_file.close

			a_dispenser.remove
			a_dispenser.remove
			create l_file.make_open_write (a_dispenser.generator.as_lower + "_2")
			l_file.independent_store (a_dispenser)
			l_file.close

			a_dispenser.extend (4)
			a_dispenser.extend (5)
			a_dispenser.extend (6)
			a_dispenser.extend (7)
			a_dispenser.extend (8)
			create l_file.make_open_write (a_dispenser.generator.as_lower + "_3")
			l_file.independent_store (a_dispenser)
			l_file.close

			a_dispenser.extend (9)
			create l_file.make_open_write (a_dispenser.generator.as_lower + "_4")
			l_file.independent_store (a_dispenser)
			l_file.close

			a_dispenser.extend (10)
			create l_file.make_open_write (a_dispenser.generator.as_lower + "_5")
			l_file.independent_store (a_dispenser)
			l_file.close
		end

	retrieve
		do
			retrieve_dispenser ("bounded_queue_1")
			retrieve_dispenser ("bounded_queue_2")
			retrieve_dispenser ("bounded_queue_3")
			retrieve_dispenser ("bounded_queue_4")
			retrieve_dispenser ("bounded_queue_5")
			retrieve_dispenser ("arrayed_queue_1")
			retrieve_dispenser ("arrayed_queue_2")
			retrieve_dispenser ("arrayed_queue_3")
			retrieve_dispenser ("arrayed_queue_4")
			retrieve_dispenser ("arrayed_queue_5")
			retrieve_dispenser ("bounded_stack_1")
			retrieve_dispenser ("bounded_stack_2")
			retrieve_dispenser ("bounded_stack_3")
			retrieve_dispenser ("bounded_stack_4")
			retrieve_dispenser ("bounded_stack_5")
			retrieve_dispenser ("arrayed_stack_1")
			retrieve_dispenser ("arrayed_stack_2")
			retrieve_dispenser ("arrayed_stack_3")
			retrieve_dispenser ("arrayed_stack_4")
			retrieve_dispenser ("arrayed_stack_5")
		end

	retrieve_dispenser (a_file_name: STRING)
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_read (a_file_name)
			if attached {DISPENSER [INTEGER]} l_file.retrieved as l_data then
				io.put_string (l_data.generating_type)
				io.put_character (':')
				print_list (l_data.linear_representation)
			end
			l_file.close
		end

	print_list (list: LINEAR [INTEGER])
			-- Print `list'.
		require
			list_not_void: list /= Void
		do
			from
				list.start
			until
				list.after
			loop
				io.put_integer (list.item)
				list.forth
			end
			io.put_new_line
		end

end
