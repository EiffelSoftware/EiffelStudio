class CHILD [G -> TEST1]
inherit
	PARENT
		redefine
			attr
		end

feature

	attr: G

end
