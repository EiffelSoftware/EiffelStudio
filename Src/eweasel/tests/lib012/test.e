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
			from
			until
				file.off
			loop		
				file.read_character
				io.put_character (file.last_character)				
			end
			file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
