indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSIC_OBJECT_TREE_ITEM

inherit
	EB_OBJECT_TREE_ITEM

create
	make_with_value

feature {NONE} -- Initialization

	fill_onces_with_list (a_parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `a_parent' with the once functions `a_once_list'.
		local
			once_r: ONCE_REQUEST
			l_item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]
		do
			once_r := Application.debug_info.Once_request
			flist := a_once_list
			from
				flist.start
			until
				flist.after
			loop
				if once_r.already_called (flist.item) then
					l_item := debug_value_to_tree_item (once_r.once_result (flist.item))
				else
					create l_item
					l_item.set_pixmap (Pixmaps.Icon_void_object)
					l_item.set_text (flist.item.name + Interface_names.l_Not_yet_called)
				end
				a_parent.extend (l_item)
				flist.forth
			end
				-- We remove the dummy item.
			a_parent.start
			a_parent.remove
		end

	debug_value_to_tree_item (dv: ABSTRACT_DEBUG_VALUE): like Current is
			-- Convert `dv' into a tree item.
		do
			create Result.make_with_value (dv, tool)
		end
	
end
