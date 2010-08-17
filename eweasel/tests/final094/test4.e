
class TEST4
inherit
	TEST3
		redefine
			min_value
		end
feature
	min_value: INTEGER = 47
end
