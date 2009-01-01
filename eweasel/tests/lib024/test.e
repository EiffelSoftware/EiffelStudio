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
			l_file, l_orig: RAW_FILE
		do
				-- First step, check that `filename_orig' and `filename' are indeed identical.
			create l_file.make_open_read (filename)			
			l_file.read_stream (l_file.count)
			l_file.close
			
			create l_orig.make_open_read (filename_orig)
			l_orig.read_stream (l_orig.count)
			l_orig.close

			if not l_file.last_string.is_equal (l_orig.last_string) then
				io.put_string ("Error")
			end

				-- Check that renaming `filename' into itself does not change anything to its content.
			create l_file.make (filename)			
			l_file.change_name (filename)
			
			l_file.open_read
			l_file.read_stream (l_file.count)
			l_file.close
			
			create l_orig.make_open_read (filename_orig)
			l_orig.read_stream (l_orig.count)
			l_orig.close

			if not l_file.last_string.is_equal (l_orig.last_string) then
				io.put_string ("Error")
			end

				-- Check that renaming `filename' into `file2.txt' does not change anything to its content.
			create l_file.make (filename)			
			l_file.change_name ("file2.txt")
			
			l_file.open_read
			l_file.read_stream (l_file.count)
			l_file.close
			
			create l_orig.make_open_read (filename_orig)
			l_orig.read_stream (l_orig.count)
			l_orig.close

			if not l_file.last_string.is_equal (l_orig.last_string) then
				io.put_string ("Error")
			end
		end
	
feature -- Common

	filename: STRING is "file.txt"
	filename_orig: STRING is "file_orig.txt"
		
end -- class TEST
