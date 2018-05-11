deferred class A

feature {NONE} -- Tests

	c1: INTEGER_8
		do
			Result := 1
		ensure
			positive: Result > 0
		end

	c2: INTEGER_8
		deferred
		ensure
			positive: Result > 0
		end

	e1
		do
		ensure
			different: "" /= ""
		end

	e2
		deferred
		ensure
			different: "" /= ""
		end

	f1
		do
		ensure
			different: "" /= ""
		end

	f2
		deferred
		ensure
			different: "" /= ""
		end

end