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
				file.read_character
			until
				file.off
			loop
				io.put_character (file.last_character)
				file.read_character
			end
			file.close
		end
	
feature -- Common

	file: RAW_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
