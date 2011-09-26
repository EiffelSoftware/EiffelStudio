class TEST

create
        make

feature {NONE} -- Creation
        
        make
        		-- Run tests.
		local
			has_exception: BOOLEAN
                do
			if not has_exception then
				io.put_string ("0")
				f
					-- Should not get here.
				io.put_string ("9")
			else
					-- `f' raised an exception.
				io.put_string ("5")
			end
			io.put_new_line
                rescue
			has_exception := True
			retry
                end

feature {NONE} -- Test

	f
		local
			i: INTEGER
		do
			if i = 0 then
					-- First call to this feature.
				io.put_string ("1")
					-- Let's try to exit it.
			elseif i = 1 then
					-- Second try. This is expected.
				io.put_string ("3")
			else
					-- Something went wrong.
				io.put_string ("7")
			end
		ensure
			False
		rescue
			i := i + 1
			if i = 1 then
					-- Good.
				io.put_string ("2")
					-- Let's continue.
				retry
			elseif i = 2 then
					-- Second try. Now without retry.
				io.put_string ("4")
			else
					-- Something went wrong.
				io.put_string ("8")
			end
		end

end

