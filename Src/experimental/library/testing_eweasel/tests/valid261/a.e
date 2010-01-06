class A [G]
feature
	f (v: G)
		do
			(agent (x: G) do end (v)).do_nothing
		end
end