class
	CAT_UNREACHABLE_CODE

feature {NONE} -- Test

	unreachable
		-- Should violate the Unreachable code rule twice.
		local
			l_exception: EXCEPTION
		do
			if False then
				io.putstring("Test")
			else
				io.putstring("Test")
			end

			io.putstring("Test")

			l_exception.raise

			io.putstring("Test")
			io.putstring("Test")
			io.putstring("Test")
		end

	unreachable_2
		-- Should violate the Unreachable code rule once.
		do
			check
				False
			end

			io.putstring("Test")
			io.putstring("Test")
		end

	unreachable_3
		-- Should not violate the Unreachable code rule.
		do
			if False then

			elseif True then

			else
				io.putstring("Test")
			end

			check
				False
			end
		end

end
