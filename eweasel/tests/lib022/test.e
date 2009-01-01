indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- 
		do
			create file.make_open_read (filename)
			io.put_string (file.position.out)
			file.finish			
			io.put_new_line
			io.put_string (file.count.out)
			io.put_new_line
			io.put_string (file.position.out)
			io.put_new_line
			file.close				
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
