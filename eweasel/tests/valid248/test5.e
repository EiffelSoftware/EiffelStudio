class
	TEST5

inherit
	TEST3
		rename
			is_less as is_less alias "<"
		end

	TEST4
		undefine
			is_less
		end
		
end
