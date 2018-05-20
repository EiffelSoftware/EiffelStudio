deferred class B

feature {TEST} -- Tests

	a: BOOLEAN = True

	f1
		deferred
		ensure
			instance_free: class
		end

	f2
		deferred
		ensure
			instance_free: class
		end

end