
class TEST4
inherit
	TEST3
		redefine
			weasel
		end
feature
	weasel: INTEGER
		external "C inline"
		alias "29"
		end

end
