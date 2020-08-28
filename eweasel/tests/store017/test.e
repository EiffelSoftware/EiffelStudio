class
	TEST

inherit
	ARGUMENTS

create
	make

feature -- Initialization

	make
			-- Run application.
		do
			save
			retrieve
		end

	save
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write (file_name)
			l_file.independent_store (create {A [attached ANY]}.make (create {ANY}))
			l_file.close
		end

	retrieve
		local
			a: ANY
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: A [attached ANY]
		do
			if not retried then
				create l_file.make_open_read (file_name)
				a := l_file.retrieved
				l_spec ?= a
				l_file.close
				if l_spec = Void then
					print ("ERROR%N")
				end
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	file_name: STRING = "data"

end
