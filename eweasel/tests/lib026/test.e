class TEST

inherit
	ARGUMENTS

create
	make

feature

	make is
			--
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_open_read (test_file_name)
			f.forth
			f.forth
			f.forth
			if not f.after then
				print ("File should be exhausted.")
				io.put_new_line
			end
			f.close
		end

feature {NONE} -- Implementation

	test_file_name: STRING = "file.txt"

end
