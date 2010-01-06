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
			save
			retrieve
		end

	save is
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write (file_name)
			l_file.independent_store (create {A [!ANY]}.make (create {ANY}))
			l_file.close
		end

	retrieve is
		local
			a: ANY
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: A [!ANY]
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

	file_name: STRING is "data"

end
