
class TEST3
inherit
	TEST1
		redefine
			x
		end
feature
	x: STRING
		$(BODY)
end

