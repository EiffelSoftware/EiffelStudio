class A [G]

feature

	f (a: ?ANY): G
		external "C inline"
			alias "return eif_access($a);"
		end

	g (a: ?ANY): like f
		external "C inline"
			alias "return eif_access($a);"
		end

	h (a: ?ANY): ?TEST
		external "C inline"
			alias "return eif_access($a);"
		end

	i (a: ?ANY): like h
		external "C inline"
			alias "return eif_access($a);"
		end

end