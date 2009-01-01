indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- 
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write ("test.txt")
			io.put_string (l_file.exists.out)			
			io.put_new_line
			l_file.close
			l_file.delete			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
