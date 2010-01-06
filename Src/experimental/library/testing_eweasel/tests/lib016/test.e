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
				file.after
			loop
				file.read_line
				io.put_string (file.last_string)
				if not file.after then
					io.put_new_line	
				end
			end
			file.close		
		end
		
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
