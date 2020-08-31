class
	TEST

create
	make

feature -- Initialization

	make
			-- Run application.
		do
			$SAVE
			retrieve
		end

	save (ignore_marks: BOOLEAN)
		local
			l_file: RAW_FILE
		do
			set_ignore_marks (ignore_marks)
			create l_file.make_open_write (file_name)
			l_file.independent_store (create {A [attached ANY, detachable ANY]}.make (create {ANY}))
			l_file.close
		end

	retrieve
		local
			a: detachable ANY
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read (file_name)
				a := l_file.retrieved
				if a /= Void then
					print (a.generating_type)
					print ("%N")
				end
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	file_name: STRING = "data"

	set_ignore_marks (a: BOOLEAN)
		external
			"C inline use %"eif_store.h%""
		alias
			"eif_set_is_discarding_attachment_marks ($a);"
		end

end
