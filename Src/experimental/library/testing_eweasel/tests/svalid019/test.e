class TEST

inherit
	B
		redefine
			anchor
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			g (create {A [STRING]}, "")
		end

feature {NONE} -- Test

	anchor: A [STRING]

end
