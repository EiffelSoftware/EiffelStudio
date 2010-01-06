class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			p: PROCEDURE [TEST, TUPLE [TEST, INTEGER]]
		do
			p := agent ?.f
			p := agent {TEST}.f
		end

feature -- Settings

	f (i: INTEGER) is
		do
		end

end
