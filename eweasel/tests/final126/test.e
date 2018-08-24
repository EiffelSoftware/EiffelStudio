class TEST

inherit
	MEMORY

create
	make

feature {NONE} -- Creation

	make
		local
			b: BOOLEAN
		do
			value := "abc"
			if f = f then
				print ("Test #1: OK%N")
			else
				print ("Test #1: Failed%N")
			end
			if f /= f then
				print ("Test #2: Failed%N")
			else
				print ("Test #2: OK%N")
			end
			if f ~ f then
				print ("Test #3: OK%N")
			else
				print ("Test #3: Failed%N")
			end
			if f /~ f then
				print ("Test #4: Failed%N")
			else
				print ("Test #4: OK%N")
			end
			print
				(if f = f then
					"Test #5: OK%N"
				else
					"Test #5: Failed%N"
				end)
			print
				(if f /= f then
					"Test #6: Failed%N"
				else
					"Test #6: OK%N"
				end)
			print
				(if f ~ f then
					"Test #7: OK%N"
				else
					"Test #7: Failed%N"
				end)
			print
				(if f /~ f then
					"Test #8: Failed%N"
				else
					"Test #8: OK%N"
				end)
			b := f = f
			if b then
				print ("Test #9: OK%N")
			else
				print ("Test #9: Failed%N")
			end
			b := f /= f
			if b then
				print ("Test #10: Failed%N")
			else
				print ("Test #10: OK%N")
			end
			b := f ~ f
			if b then
				print ("Test #11: OK%N")
			else
				print ("Test #11: Failed%N")
			end
			b := f /~ f
			if b then
				print ("Test #12: Failed%N")
			else
				print ("Test #12: OK%N")
			end
		end

feature -- Testing

	f: STRING
		do
			create Result.make (100000)
			Result := value
			full_collect
		end

	value: STRING

end
