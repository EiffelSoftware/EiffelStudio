class TEST

inherit
	MEMORY

create
	make

feature
	
	make (args: ARRAY [STRING]) is
			-- Run test.
		local
			list: ARRAYED_LIST [TEST2]
			is_error: BOOLEAN
		do
			if not is_error then
				create list.make (args.item (1).to_integer)
			end
		rescue
			if not is_error then
				is_error := True
				io.put_string ((create {EXCEPTION_MANAGER}).last_exception.meaning)
				io.put_new_line
				retry
			end
		end

end
