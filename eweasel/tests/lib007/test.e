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
			cnt: INTEGER
		do
			create file.make_open_read (filename)
			from
				cnt := 0				
			until
				cnt >= file.count
			loop				
				file.go (cnt)
				io.put_character (file.item)
				cnt := cnt + 1
			end
			file.close
			
		end
	
feature -- Common

	file: RAW_FILE
			-- File

	filename: STRING is "file.txt"

end -- class TEST
