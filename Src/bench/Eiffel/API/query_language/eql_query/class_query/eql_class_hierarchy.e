indexing
	description: "Object that returns ancestor/descendant classes of some class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_CLASS_HIERARCHY

feature -- Access

	classes (a_class: CLASS_C) : LIST [CLASS_C] is
			-- Class hierarchy of `a_class'
			-- Can be either ancestors or descendants.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

	recursive_classes (a_class: CLASS_C): LIST [CLASS_C] is
			-- Recursive class hierarchy of `a_class'
			-- Can be either ancestors or descendants.
		require
			a_class_not_void: a_class /= Void
		deferred
		end

end
