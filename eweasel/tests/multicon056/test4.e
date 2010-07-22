
class TEST4
inherit
	TEST3
		redefine
			weasel
		end
feature
	weasel: INTEGER = 47
		-- external "C inline"
		-- alias "47"
		-- end
end

