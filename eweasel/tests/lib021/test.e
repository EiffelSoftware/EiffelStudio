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
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write ("temp" + filename)
			create file.make_open_read (filename)
			file.read_stream (file.count)
			l_file.put_string (file.last_string)
			file.close
			io.put_string (l_file.count.out)
			io.put_new_line
			l_file.extend ('$')
			io.put_string (l_file.count.out)
			io.put_new_line
			l_file.close			
		end
	
feature -- Common

	file: PLAIN_TEXT_FILE
			-- File

	filename: STRING is "file.txt"
		

end -- class TEST
