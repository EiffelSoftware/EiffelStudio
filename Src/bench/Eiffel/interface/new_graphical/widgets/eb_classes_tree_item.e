indexing
	description: "Tree items in a cluster tree"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASSES_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			parent_tree
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create, is_equal, copy
		end

feature -- Access

	parent_tree: EB_CLASSES_TREE is
			-- Tree of clusters containing `Current'.
		do
			Result ?= Precursor
		end

end -- class EB_CLASSES_TREE_ITEM
