deferred class
	A

feature

	test
		require
			attached {STRING} Current as t and then not t.is_empty
		deferred
		ensure
			attached {STRING} Current as s implies not s.is_empty
		end

end
