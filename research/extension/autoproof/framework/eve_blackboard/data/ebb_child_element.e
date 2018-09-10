note
	description: "Data element which has a parent."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EBB_CHILD_ELEMENT [PARENT -> EBB_PARENT_ELEMENT [PARENT, CHILD], CHILD -> EBB_CHILD_ELEMENT [PARENT, CHILD]]

inherit

	EBB_DATA_ELEMENT

feature -- Access

	parent: detachable PARENT
			-- Parent of this element.

feature -- Element change

	set_parent (a_parent: like parent)
			-- Set `parent' to `a_parent'.
		do
			if attached {CHILD} Current as l_current then
				if attached parent then
					check parent.children.has (l_current) end
					parent.children.prune_all (l_current)
					check not parent.children.has (l_current) end
				end
				parent := a_parent
				if attached parent then
					check not parent.children.has (l_current) end
					parent.children.extend (l_current)
					check parent.children.has (l_current) end
				end
			else
				check False end
			end
		ensure
			parent_set: parent = a_parent
		end

end
