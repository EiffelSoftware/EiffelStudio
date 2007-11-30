indexing
	description	: "System's root class"
	note		: "Initial version automatically generated"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Test `back'
		do
			create file.make_open_read (filename)			
			from
				file.finish
			until
				file.position = 0
			loop				
				file.back
				io.put_character (file.item)				
			end
			io.put_new_line
			file.close			
		end
	
feature -- Common

	file: RAW_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
