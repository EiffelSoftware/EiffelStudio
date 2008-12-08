class
	TEST

inherit
	ARGUMENTS

create
	make

feature -- Initialization

	make is
			-- Run application.
		do
			create list.make (10)
			list.extend (create {A [ANY]}.make (create {ANY}))
			list.extend (create {A [!ANY]}.make (create {ANY}))
			list.extend (create {A [?ANY]}.make (create {ANY}))

-- Commented out since it is only needed when created the test originally.
--			save (list)
			retrieve (list)
		end

	save (a_list: like list) is
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write (file_name)
			l_file.independent_store (a_list)
			l_file.close
		end

	retrieve (orig: like list) is
		local
			a: ANY
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: A [!ANY]
		do
			if not retried then
				create l_file.make_open_read (file_name)
				a := l_file.retrieved
				if not a.is_deep_equal (orig) then
					io.put_string ("ERROR%N")
				end
				l_file.close
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	file_name: STRING is "data"
	list: ARRAYED_LIST [ANY]

end
