class TEST
inherit
	EXECUTION_ENVIRONMENT
	PLATFORM

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
			if not is_windows then
				system ("ls > /dev/null") 
			else
				system ("dir > tmp")
			end

			io.put_string (return_code.out)
			io.new_line
		end

end
