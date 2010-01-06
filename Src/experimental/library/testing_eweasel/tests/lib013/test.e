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
			file.read_stream (file.count)
			io.put_string (file.last_string)
			file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
