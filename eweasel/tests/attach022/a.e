class A [G]

feature

	f (a: detachable ANY): G
		external "C inline"
			alias "return eif_access($a);"
		end

	g (a: detachable ANY): like f
		external "C inline"
			alias "return eif_access($a);"
		end

	h (a: detachable ANY): detachable TEST
		external "C inline"
			alias "return eif_access($a);"
		end

	i (a: detachable ANY): like h
		external "C inline"
			alias "return eif_access($a);"
		end

end