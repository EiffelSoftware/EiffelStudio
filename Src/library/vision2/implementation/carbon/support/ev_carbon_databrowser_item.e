note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CARBON_DATABROWSER_ITEM

inherit
	EV_ANY_I

feature -- Databrowser item features

	icon_ref: POINTER

	text: STRING_32
			--
		do

		end

	child_array: ARRAYED_LIST [EV_ANY]
			--
		do

		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			--
		deferred
		end

	item_id: INTEGER

	add_item_and_children_to_parent_tree (a_parent_tree: EV_CARBON_DATABROWSER; a_parent_node: EV_CARBON_DATABROWSER_ITEM; a_index: INTEGER)
			-- Used for setting items within parent tree
		local
			item: EV_CARBON_DATABROWSER_ITEM
			i: INTEGER
		do
			item_id := a_parent_tree.get_id (current)

			if child_array /= Void then
				from
					i := 1
				until
					i > child_array.count
				loop
					item ?= (child_array @ i).implementation
					item.add_item_and_children_to_parent_tree (a_parent_tree, Current, i)
					i := i + 1
				end
			end
		end

end
