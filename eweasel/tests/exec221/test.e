indexing
	description	: "System's root class"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			t: TEST1
			i: INTEGER
		do
			from
				i := 1
			until
				i = 100
			loop
				create t
				i := i + 1
			end

			from
				i := 1
			until
				i = 10000000
			loop
				i.io.do_nothing
				i := i + 1
			end
		end

end -- class TEST
