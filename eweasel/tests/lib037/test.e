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
			l_string: STRING
			l_old_hash_code: INTEGER
			l_count: INTEGER
		do
			l_string := "toto"
			l_old_hash_code := l_string.hash_code

			create pf.make_open_read (filename)
			l_count := pf.read_to_string (l_string, 1, l_string.count)
			check
				valid_read: l_count = l_string.count
			end
			pf.close

			if l_old_hash_code = l_string.hash_code then
				io.put_string ("Not OK!%N")
			end

			create rf.make_open_read (filename)
			l_count := rf.read_to_string (l_string, 1, l_string.count)
			check
				valid_read: l_count = l_string.count
			end
			rf.close

			if l_old_hash_code = l_string.hash_code then
				io.put_string ("Not OK!%N")
			end

		end
	
feature -- Common

	pf: PLAIN_TEXT_FILE_BIS
			-- Plain Text File

	rf: RAW_FILE_BIS
			-- Raw File

	filename: STRING is "file.txt"
		

end -- class TEST
