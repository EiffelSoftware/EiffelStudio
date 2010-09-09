
class TEST2 [G $(CONSTRAINT)]
inherit
	TEST3 [G]
feature
	a: TEST3 [G]
		once ("OBJECT")
			create Result
		end
end

