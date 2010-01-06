class
	TEST1

feature

	infix "+" (other: TEST1): TEST1 is
			--
		do

		end

	f is
		do
		ensure
			Current + Current = Current
		end


end
