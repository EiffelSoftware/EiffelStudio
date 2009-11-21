class
	A [G]

feature -- Access

	a1, a2: detachable G

	many_types (n: INTEGER): A [A [G]]
		do
			create Result
			if n > 0 then
				Result.many_types (n - 1).do_nothing
			end
		end

end
