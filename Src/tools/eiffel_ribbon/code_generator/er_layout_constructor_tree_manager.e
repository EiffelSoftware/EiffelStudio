note
	description: "[
					Layout Constructor's tree manager common ancestor
																						]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER

feature -- Command

	save_tree
			-- Save to Microsoft Ribbon makrup XML directly
		deferred
		end

	load_tree (a_ribbon_window_count: INTEGER)
			-- Load tree data from Microsoft Ribbon markup XML file
		deferred
		end

feature {NONE} -- Implementation

	shared_singleton: ER_SHARED_SINGLETON
			--	Shared singleton

end
