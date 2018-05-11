deferred class B

feature {NONE} -- Tests

	e1
		require
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		ensure
			different: "" /= ""
		end

	e2
		require
			is_empty: ("").is_empty
		external "C inline"
			alias "return"
		ensure
			different: "" /= ""
		end

	o1
		require
			is_empty: ("").is_empty
		once ("OBJECT")
		ensure
			different: "" /= ""
		end

	o2
		require
			is_empty: ("").is_empty
		once ("OBJECT")
		ensure
			different: "" /= ""
		end

	p1
		require
			is_empty: ("").is_empty
		do
		ensure
			different: "" /= ""
		end

	p2
		require
			is_empty: ("").is_empty
		do
		ensure
			different: "" /= ""
		end

	p3
		require
			is_empty: ("").is_empty
		deferred
		ensure
			different: "" /= ""
		end

end