indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- 
		do
			create file.make_open_read (filename)
			io.put_integer (file.count)
			io.put_new_line
			file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
