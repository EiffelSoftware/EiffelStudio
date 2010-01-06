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
			file.close
			io.put_string (file.is_closed.out)
			io.put_new_line
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
