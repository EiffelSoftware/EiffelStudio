class B

feature {TEST} -- Tests

	a: BOOLEAN = True

	f1
		do
		ensure
			instance_free: class
		end

	f2
		do
		ensure
			instance_free: class
		end

end