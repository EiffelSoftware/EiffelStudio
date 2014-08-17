note
	description : "apple_bug application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_file: RAW_FILE
		do
			create t1.make
			create l_file.make_open_write ("test.bin")
			l_file.independent_store (t1)
			l_file.close

			create l_file.make_open_read ("test.bin")
			if not attached l_file.retrieved as l_obj then
				io.put_string ("Failure%N")
			end
		end

	t1: TEST1

end
