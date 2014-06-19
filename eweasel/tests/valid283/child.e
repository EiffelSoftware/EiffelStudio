class CHILD
inherit
	PARENT
		redefine
			parent
		end

feature

	parent: detachable STRING

end
