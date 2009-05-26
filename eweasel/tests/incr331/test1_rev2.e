
deferred class TEST1 [G -> DOUBLE]
inherit
	TEST2
		redefine
			value
		end
feature

	value: G
		external "C inline"
		alias "17.03"
		end
	
end
