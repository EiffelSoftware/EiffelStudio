class A

feature {NONE} -- Tests

	f
		require
			not attached a
		do
		ensure
			not attached a
		end

	a: detachable TEST

end