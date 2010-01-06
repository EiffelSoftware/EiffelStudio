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
				file.position = file.count
			loop
				io.put_character (file.item)
				file.forth
			end
			file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
