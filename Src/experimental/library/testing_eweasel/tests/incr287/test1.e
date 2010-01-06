deferred class
	TEST1 [G]

feature

	f is
		do
		ensure
			test: agent {LIST [G]}.generating_type /= Void
			$CHANGE
		end


end
