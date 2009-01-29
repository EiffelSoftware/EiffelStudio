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
			$SAVE
			retrieve
		end

	save (ignore_marks: BOOLEAN) is
		local
			l_file: RAW_FILE
		do
			set_ignore_marks (ignore_marks)
			create l_file.make_open_write (file_name)
			l_file.independent_store (create {A [!ANY, ?ANY]}.make (create {ANY}))
			l_file.close
		end

	retrieve is
		local
			a: ANY
			l_file: RAW_FILE
			retried: BOOLEAN
			l_spec: A [!ANY, ?ANY]
		do
			if not retried then
				create l_file.make_open_read (file_name)
				a := l_file.retrieved
				print (a.generating_type)
				print ("%N")
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	file_name: STRING is "data"

	set_ignore_marks (a: BOOLEAN) is
		external
			"C inline use %"eif_store.h%""
		alias
			"eif_set_is_discarding_attachment_marks ($a);"
		end

end
