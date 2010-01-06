class
	TEST

inherit {NONE}

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make is
		do
			if argument_count = 0 then
				print ("ok%N")
			end
		end

end
