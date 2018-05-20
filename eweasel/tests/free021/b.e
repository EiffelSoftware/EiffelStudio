class B

feature {TEST} -- Tests

	a: BOOLEAN
		do
			Result := out /= "0"
		end

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