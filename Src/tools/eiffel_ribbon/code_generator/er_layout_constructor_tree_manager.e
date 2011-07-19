note
	description: "Summary description for {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER

feature --

	save_tree
			-- Save to Microsoft Ribbon makrup XML directly
		deferred
		end

	load_tree (a_ribbon_window_count: INTEGER)
			--
		deferred
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--		

end
