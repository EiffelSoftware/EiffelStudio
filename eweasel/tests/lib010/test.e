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
		local
			l_file: like file
		do
			create file.make (filename)
			create l_file.make_create_read_write ("dummy.txt")
			l_file.put_string ("abcdefgh123456789")	
			l_file.flush
			l_file.close						
			if file.is_closed and l_file.is_closed then
				file.append (l_file)
				file.open_read
				file.read_stream (file.count)
				io.put_string (file.last_string)
				file.close	
				l_file.delete
			end
			io.put_new_line
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
