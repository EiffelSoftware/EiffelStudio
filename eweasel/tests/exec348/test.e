class
	TEST

create
	make

feature
	make
		local
			exec: EXECUTION_ENVIRONMENT
		do
			create exec
			if attached exec.item ("EWEASEL_VAL_ENV") as l_val then
				io.put_string (l_val.as_string_8)
				io.put_new_line
			end
		end

end
