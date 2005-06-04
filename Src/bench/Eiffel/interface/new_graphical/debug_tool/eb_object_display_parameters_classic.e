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

feature {NONE} -- Refreshing Implementation

	refreshed_sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		local
			obj: DEBUGGED_OBJECT
		do
			obj := debugged_object_manager.debugged_object (address, spec_lower, spec_higher)
			is_sorted_children_about_special := obj.is_special
			Result := obj.sorted_attributes
		end

feature {NONE} -- Specific Implementation

	sorted_attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		local
			obj: DEBUGGED_OBJECT
		do
			obj := debugged_object_manager.debugged_object (address, spec_lower, spec_higher)
			Result := obj.sorted_attributes
		end

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		local
			once_r: ONCE_REQUEST
			l_item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]
			odv: ABSTRACT_DEBUG_VALUE
		do
			once_r := Application.debug_info.Once_request
			flist := a_once_list
			from
				flist.start
			until
				flist.after
			loop
				if once_r.already_called (flist.item) then
					fixme ("JFIAT: update the runtime to avoid evaluate the once")
--					odv := once_r.once_result (flist.item)
--					item := debug_value_to_item (odv)

					if flist.item.argument_count > 0 then
						create l_item.default_create
						l_item.set_pixmap (pixmaps.icon_dbg_error)
						l_item.set_text (flist.item.name + " could not evaluate once with arguments...")
					else
						if dv /= Void then
							odv := once_r.once_eval_result (dv.address, flist.item, dv.dynamic_class)
						else
							odv := once_r.once_eval_result (address, flist.item, dtype)
						end
						if odv /= Void then
							l_item := debug_value_to_item (odv)
						else
							create l_item.default_create
							l_item.set_pixmap (pixmaps.icon_dbg_error)
							l_item.set_text (flist.item.name + " : unable to get value !")
						end
					end	
				else
					create l_item
					l_item.set_pixmap (Pixmaps.Icon_void_object)
					l_item.set_text (flist.item.name + ": " + Interface_names.l_Not_yet_called)
				end
				parent.extend (l_item)
				flist.forth
			end
				-- We remove the dummy item.
			parent.start
			parent.remove
		end


end -- class EB_OBJECT_DISPLAY_PARAMETERS_CLASSIC
