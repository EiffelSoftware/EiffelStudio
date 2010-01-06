
deferred class TEST1 [G -> INTEGER]
inherit
	TEST2
		redefine
			value
		end
feature

	value: G
		external "C inline"
		alias "17"
		end
	
end
