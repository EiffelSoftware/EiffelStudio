deferred class A

feature {NONE} -- Tests

	a: BOOLEAN
		deferred
		end

	f1
		do
		ensure
			a
		end

	f2
		do
		ensure
			a
		end

	f3
		deferred
		ensure
			a
		end

end