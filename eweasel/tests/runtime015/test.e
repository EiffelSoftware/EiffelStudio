class TEST

inherit
	MEMORY

create
	make

feature
	
	make (args: ARRAY [STRING])
			-- Run test.
		local
			$DECLARATION
			is_error: BOOLEAN
		do
			if not is_error then
				$CREATION
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
