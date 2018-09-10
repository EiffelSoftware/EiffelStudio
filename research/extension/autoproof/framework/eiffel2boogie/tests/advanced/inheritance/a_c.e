deferred class
	A_C

feature
	right: A_A
		deferred
		end

	something
		require
			right /= Void
		do
		end

end
