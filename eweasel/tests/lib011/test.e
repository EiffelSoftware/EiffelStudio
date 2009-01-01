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
			from
				file.start
			until
				file.end_of_file
			loop
				file.read_character
				io.put_string (file.position.out)
				io.put_new_line
			end
			file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
