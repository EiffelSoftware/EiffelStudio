indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_DISPLAY_PARAMETERS_DOTNET

inherit

	EB_OBJECT_DISPLAY_PARAMETERS

create {SHARED_DEBUG}
	make, make_from_debug_value, make_from_stack_element

feature {NONE} -- Debug Value

	associated_debug_value: ABSTRACT_DEBUG_VALUE is
		require
			Application.is_dotnet
		do
			Result := internal_associated_debug_value
			if Result = Void then
				if application.imp_dotnet.know_about_kept_object (address) then
					Result := Application.imp_dotnet.kept_object_item (address)					
				end				
				internal_associated_debug_value := Result
			end
		end

	internal_associated_debug_value: like associated_debug_value

feature -- Transformation

	object_type_and_value: STRING is
			-- Full ouput representation for related object
		local
			abstract_value: ABSTRACT_DEBUG_VALUE
		do
			abstract_value := associated_debug_value
			if abstract_value /= Void then
				Result := abstract_value.dump_value.type_and_value
			else
				Result := ""
			end
		end

feature {EB_SET_SLICE_SIZE_CMD} -- Refreshing

	refresh is
			-- Reload attributes (useful if `Current' represents a special object)
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			conv_nat_value: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.refresh%N")
			end
			attr_item.wipe_out
			attr_item.expand_actions.wipe_out
			attr_item.collapse_actions.wipe_out
			attributes_loaded := True

			dv ?= associated_debug_value
			if dv /= Void then
				conv_nat_value ?= dv
				if conv_nat_value /= Void then -- NativeArray (.NET)
					conv_nat_value.items.wipe_out
					conv_nat_value.fill_items (spec_lower, spec_higher)
				end
				list := dv.sorted_children
				if list /= Void and then not list.is_empty then
					from
						list_cursor := list.new_cursor
						list_cursor.start
					until
						list_cursor.after
					loop
						attr_item.extend (debug_value_to_item (list_cursor.item))
						list_cursor.forth
					end
					conv_abs_spec ?= dv
					if conv_abs_spec /= Void then
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
		end

feature {NONE} -- Specific Implementation

	load_attributes_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the associated attributes object.
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			dv: ABSTRACT_DEBUG_VALUE
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.load_attributes_under%N")
			end
			dv ?= associated_debug_value
			if dv /= Void then
				list := dv.sorted_children
				if list /= Void then
					from
						list_cursor := list.new_cursor
						list_cursor.start
					until
						list_cursor.after
					loop
						parent.extend (debug_value_to_item (list_cursor.item))
						list_cursor.forth
					end					
				end
				parent.start
				parent.remove
			end
			attributes_loaded := True
		end

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		local
			item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]

			item_dv: ABSTRACT_DEBUG_VALUE
			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			l_feat: E_FEATURE
		do
			flist := a_once_list
			if dv /= Void then
				l_dotnet_ref_value ?= dv
			else
				l_dotnet_ref_value ?= associated_debug_value
			end

			check
				dotnet_ref_value_not_void: l_dotnet_ref_value /= Void
			end
			
			--| Eiffel dotnet |--
			if not flist.is_empty then
				l_dotnet_ref_value.get_object_value
				from
					flist.start
				until
					flist.after
				loop
					l_feat := flist.item				
					item_dv := l_dotnet_ref_value.once_function_value (l_feat)
					if item_dv /= Void then
						item := debug_value_to_item (item_dv)						
					else
						create item
						item.set_pixmap (Pixmaps.Icon_void_object)
						item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
					end						
					parent.extend (item)
	
					flist.forth
				end
				l_dotnet_ref_value.release_object_value
			end
				-- We remove the dummy item.
			parent.start
			parent.remove
		end

end -- class EB_OBJECT_DISPLAY_PARAMETERS_DOTNET
