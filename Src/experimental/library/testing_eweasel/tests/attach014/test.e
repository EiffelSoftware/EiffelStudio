class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			test (Current)
		end

feature {NONE} -- Test

	test (v: ?ANY)
		require
			v /= Void and then v.out /= Void
		do
			check
				v /= Void and then v.out /= Void
			end
		ensure
			v /= Void and then v.out /= Void
		end
	
end