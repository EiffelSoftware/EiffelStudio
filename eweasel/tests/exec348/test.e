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
			if attached exec.get ("EWEASEL_VAL_ENV") as l_val then
				io.put_string (l_val)
				io.put_new_line
			end
		end

end
