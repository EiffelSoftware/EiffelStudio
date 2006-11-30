deferred class
	TEST1 [G]

feature

	f is
		deferred
		ensure
			test: agent {LIST [G]}.generating_type /= Void
		end


end
