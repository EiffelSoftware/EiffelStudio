deferred class A [G]

feature

	j: G is
			-- 
		deferred
		end
		
	f is
			-- 
		local
			i: G
		do
			i := j
		end
		
end -- class A
