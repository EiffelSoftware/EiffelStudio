note
	description: "Summary description for {ER_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ER_HELPER

feature -- Command

	expand_all (a_tree: EV_TREE)
			--
		local
			l_item: EV_TREE_NODE
		do
			from
				a_tree.start
			until
				a_tree.after
			loop
				l_item := a_tree.item_for_iteration
				l_item.expand
				expand_all_imp (l_item)

				a_tree.forth
			end
		end

feature {NONE} -- Implementation

	expand_all_imp (a_tree_node: EV_TREE_NODE)
			--
		local
			l_item: EV_TREE_NODE
		do
			from
				a_tree_node.start
			until
				a_tree_node.after
			loop
				l_item := a_tree_node.item_for_iteration
				if l_item.is_expandable then
					l_item.expand
					expand_all_imp (l_item)
				end

				a_tree_node.forth
			end
		end
end
