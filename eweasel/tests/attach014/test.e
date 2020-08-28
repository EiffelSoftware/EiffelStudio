class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			test (Current)
		end

feature {NONE} -- Test

	test (v: detachable ANY)
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