indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC

inherit

	EB_OBJECT_DISPLAY_PARAMETERS

create {SHARED_DEBUG}
	make, make_from_debug_value, make_from_stack_element

feature -- Transformation

	object_type_and_value: STRING is
			-- Full ouput representation for related object
		do
			Result := (create {DUMP_VALUE}.make_object (address, dtype)).type_and_value
		end

feature {EB_SET_SLICE_SIZE_CMD} -- Refreshing

	refresh is
			-- Reload attributes (useful if `Current' represents a special object)
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			obj: DEBUGGED_OBJECT
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.refresh%N")
			end
			attr_item.wipe_out
			attr_item.expand_actions.wipe_out
			attr_item.collapse_actions.wipe_out
			attributes_loaded := True
			create {DEBUGGED_OBJECT_CLASSIC} obj.make (address, spec_lower, spec_higher)
			list := obj.sorted_attributes
			if not list.is_empty then
				from
					list_cursor := list.new_cursor
					list_cursor.start
				until
					list_cursor.after
				loop
					attr_item.extend (debug_value_to_item (list_cursor.item))
					list_cursor.forth
				end
				if obj.is_special then
					if spec_lower > 0 then
						attr_item.put_front (create {EV_TREE_ITEM}.make_with_text (
							Interface_names.l_More_items))
					end
					if spec_higher = spec_lower + list.count - 1 then
						attr_item.extend (create {EV_TREE_ITEM}.make_with_text (
							Interface_names.l_More_items))
					end
				end
				attr_item.expand
				attr_item.expand_actions.extend (agent on_expand (attributes_id))
				attr_item.collapse_actions.extend (agent on_unexpand (attributes_id))
			end
		end

feature {NONE} -- Specific Implementation

	load_attributes_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the once functions associated object.
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			obj: DEBUGGED_OBJECT
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.load_attributes_under%N")
			end
			create {DEBUGGED_OBJECT_CLASSIC} obj.make (address, spec_lower, spec_higher)
			list := obj.sorted_attributes
			from
				list_cursor := list.new_cursor
				list_cursor.start
			until
				list_cursor.after
			loop
				parent.extend (debug_value_to_item (list_cursor.item))
				list_cursor.forth
			end
			parent.start
			parent.remove
			attributes_loaded := True
		end

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		local
			once_r: ONCE_REQUEST
			item: EV_TREE_ITEM
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
					item := debug_value_to_item (once_r.once_result (flist.item))
				else
					create item
					item.set_pixmap (Pixmaps.Icon_void_object)
					item.set_text (flist.item.name + Interface_names.l_Not_yet_called)
				end
				parent.extend (item)
				flist.forth
			end
				-- We remove the dummy item.
			parent.start
			parent.remove
		end


end -- class EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC
