class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make is
		local
			a: A
		do
			create a

			if attached storable_version_of_type (dynamic_type (a)) as l_version then
				io.put_string (l_version)
				io.put_new_line
			end
		end

end
