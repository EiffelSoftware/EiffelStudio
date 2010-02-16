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
			b: B
			c: C
		do
			create a
			create b
			create c

			if attached storable_version_of_type (dynamic_type (a)) as l_version then
				io.put_string (l_version)
				io.put_new_line
			end

			if attached storable_version_of_type (dynamic_type (b)) as l_version then
				io.put_string (l_version)
				io.put_new_line
			end

			if attached storable_version_of_type (dynamic_type (c)) as l_version then
				io.put_string (l_version)
				io.put_new_line
			end

			if attached storable_version_of_type (dynamic_type (Current)) as l_version then
				io.put_string (l_version)
				io.put_new_line
			end

		end

end
