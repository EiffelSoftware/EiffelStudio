class
	A [G]

feature -- Access

	a1, a2: detachable G

	many_types (n: INTEGER): A [ANY]
		local
			l_result: A [A [A [A [A [A [G]]]]]]
		do
			create l_result
			if n > 0 then
				Result := l_result.many_types (n - 1)
			else
				Result := l_result
			end
		end

end
