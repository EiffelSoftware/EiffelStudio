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
			l_pos: INTEGER
		do
			create file.make_open_read (filename)			
			file.go (file.count)
			l_pos := file.position
			file.recede (10)
			l_pos := file.position
			io.put_character (file.item)
			io.put_new_line
			file.close			
		end	

feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
