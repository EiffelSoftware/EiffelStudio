class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
		end

	all_compact (input_list: READABLE_SIMPLE_LIST[READABLE_DESCRIPTION, DESCRIPTION]): BOOLEAN
		do
			result :=
				across
					input_list as input
				all
					attached input
				end
		end

end
