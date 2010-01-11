
class TEST
inherit
	PLAIN_TEXT_FILE
		rename
			make as file_make
		end

create
	make

feature {NONE} -- Initialization
	
	make
		local
			tried, started, done: BOOLEAN
		do
			if not tried then
				file_make ("test.txt")
				open_write
				close
				mode := Write_file
					-- `file_pointer' now invalid
				started := True
				print (position); io.new_line
				done := True
				mode := Closed_file
			else
				print ("Bad file pointer detected"); io.new_line
			end
		rescue
			if started and not done then
				mode := Closed_file
				tried := True
				retry
			end
		end

end
