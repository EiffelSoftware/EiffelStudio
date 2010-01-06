class TEST
	
create
	make

feature {NONE}

	make
		do
			f
		end

	f is
		do
			copy_of_current.do_nothing
			memory.collect
			print (generating_type)
			print ("%N")
			if Current /= copy_of_current then
				print ("Failure%N")
			end
		end

	copy_of_current: TEST is
		once
			Result := Current
		end

	memory: MEMORY is
		once
			create Result
		end

end
