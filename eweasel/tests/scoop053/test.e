class TEST

inherit
	DISPOSABLE
		redefine
			dispose
		end

create
	make,
	make_with_exception

feature {NONE} -- Creation
	
	make
			-- Run the test.
		local
			t: separate TEST
		do
			across
				1 |..| 10 as c
			loop
					-- Start a new processor.
				create t.make_with_exception
					-- Trigger full GC.
				;(create {MEMORY}).full_collect
			end
		end

	make_with_exception
			-- Initialize an object so that it will raise an exception in `dispose'.
		do
			is_exception_requested := True
		end

feature {NONE} -- Status report

	is_exception_requested: BOOLEAN
			-- Should exception be raised during dispose?

feature {NONE} -- Removal

	dispose
			-- <Precusror>
		local
			i: INTEGER
		do
			if is_exception_requested then
					-- Raise an exception.
				i := i // i
			end
		end

end
