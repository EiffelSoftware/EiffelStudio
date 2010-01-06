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
			create file.make_open_read (filename)	
			file.next_line
			file.next_line
			file.next_line
			io.put_character (file.item)
			io.put_new_line			
			file.close			
		end
		
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
