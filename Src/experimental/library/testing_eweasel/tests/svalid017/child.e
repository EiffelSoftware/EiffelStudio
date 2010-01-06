
class CHILD
inherit	
	PARENT
		export
			{NONE} value
		redefine
			value
		end

feature {NONE}

	value: INTEGER = 47

end
