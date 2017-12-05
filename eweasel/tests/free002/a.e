class A

feature {NONE} -- Tests

	f
		require
			not attached a
		do
		ensure
			not attached a
			class
		end

	a: detachable TEST

end