indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	EB_OBJECT_TREE_ITEM
	
inherit
	EV_TREE_ITEM
		export
			{NONE} make_with_text
		end
	
	VALUE_TYPES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end


--create 
--	make_with_value
	
feature {NONE} -- Initialization

	make_with_value (dv: ABSTRACT_DEBUG_VALUE; ot: EB_OBJECT_TOOL) is
			-- 
		do
			default_create
			tool := ot
			set_debug_value (dv)
		end
		
	tool: EB_OBJECT_TOOL

feature -- Properties

	debug_value: ABSTRACT_DEBUG_VALUE is
		do
			Result ?= data
		end	

feature -- Change

	set_debug_value (dv: ABSTRACT_DEBUG_VALUE) is
		local
			ost: OBJECT_STONE
		do
			last_dump_value := dv.dump_value
			set_text (dv.name + ": " + last_dump_value.type_and_value)
			set_pixmap (icons @ (dv.kind))
			set_data (dv)
			if dv.expandable then
				extend (create {EV_TREE_ITEM}.make_with_text ("Bug"))
				expand_actions.extend (agent fill_item (Current))
			end
			if dv.address /= Void then
					--| For now we don't support this for external type
				create ost.make (dv.address, dv.name, dv.dynamic_class)
				ost.set_associated_tree_item (Current)
				ost.set_associated_debug_value (dv)
				set_pebble (ost)
				set_accept_cursor (ost.stone_cursor)
				set_deny_cursor (ost.X_stone_cursor)
			end
			update
		end

feature -- Updating

	last_dump_value: DUMP_VALUE

	update is
		local
			l_dmp: DUMP_VALUE
			l_text: STRING
			l_pos: INTEGER
			l_integer_value: INTEGER
			l_integer64_value: INTEGER_64
		do
			l_dmp := last_dump_value
			inspect l_dmp.type 
				when feature {DUMP_VALUE_CONSTANTS}.Type_integer then
					l_text := text
					l_pos := l_text.index_of ('=', 1)
					l_integer_value := l_dmp.value_integer
					l_text :=  l_text.substring (1, l_pos)
					if hexa_mode_enabled then
						l_text.append_string ("0x" + l_integer_value.to_hex_string)
					else
						l_text.append_string (l_integer_value.out)
					end
					set_text (l_text)
				when feature {DUMP_VALUE_CONSTANTS}.Type_integer_64 then
					l_text := text
					l_pos := l_text.index_of ('=', 1)
					l_integer64_value := l_dmp.value_integer_64
					l_text :=  l_text.substring (1, l_pos)
					if hexa_mode_enabled then
						l_text.append_string ("0x" + l_integer64_value.to_hex_string)
					else
						l_text.append_string (l_integer64_value.out)
					end
					set_text (l_text)
				else
					-- Skip
			end
		end

feature {NONE} -- Implementation

	icons: ARRAY [EV_PIXMAP] is
			-- List of available icons for objects.
		once
			create Result.make (Immediate_value, External_reference_value)
			Result.put (Pixmaps.Icon_void_object, Void_value)
			Result.put (Pixmaps.Icon_object_symbol, Reference_value)
			Result.put (Pixmaps.Icon_immediate_value, Immediate_value)
			Result.put (Pixmaps.Icon_object_symbol, Special_value)
			Result.put (Pixmaps.Icon_expanded_object, Expanded_value)
			Result.put (Pixmaps.Icon_external_symbol, External_reference_value)
		end

	hexa_mode_enabled: BOOLEAN is
		do
			Result := tool.hexa_mode_enabled
		end

feature {NONE} -- Filling Implementation

	fill_item (a_item: EV_TREE_ITEM) is
			-- If a tree item was expandable, fill it with its children. (Not the onces)
		local
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			dv: ABSTRACT_DEBUG_VALUE
			folder_item: EV_TREE_ITEM
			new_item: EV_TREE_ITEM
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			flist: LIST [E_FEATURE]
		do
			a_item.expand_actions.wipe_out
			dv ?= a_item.data
			if dv /= Void then
				list := dv.sorted_children
				if list /= Void and then not list.is_empty then
					create folder_item.make_with_text (Interface_names.l_Object_attributes)
					folder_item.set_pixmap (Pixmaps.Icon_attributes)
					a_item.extend (folder_item)

					from
						list_cursor := list.new_cursor
						list_cursor.start
					until
						list_cursor.after
					loop
						folder_item.extend (debug_value_to_tree_item (list_cursor.item))
						list_cursor.forth
					end
					conv_abs_spec ?= dv
					if conv_abs_spec /= Void then
						if conv_abs_spec.sp_lower > 0 then
							folder_item.put_front (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						if 0 <= conv_abs_spec.sp_upper and then conv_abs_spec.sp_upper < conv_abs_spec.capacity - 1 then
							folder_item.extend (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						folder_item.expand
					else
						folder_item.expand
					end
				end
				if dv.dynamic_class = Void then
					--| Q: Why do we have Void dynamic_class ?
					--| ANSWER : because of external class in dotnet system
					--| Should be fixed now by using SYSTEM_OBJECT for unknown type
				else
					flist := dv.dynamic_class.once_functions
					if not flist.is_empty then
						create folder_item.make_with_text (Interface_names.l_Once_functions)
						folder_item.set_pixmap (Pixmaps.Icon_once_objects)
						a_item.extend (folder_item)
						create new_item.make_with_text (Interface_names.l_Dummy)
							--| Add expand actions.
						folder_item.extend (new_item)
						folder_item.set_data (dv)
						folder_item.expand_actions.extend (agent fill_onces (folder_item))
					end
				end
			end
				-- We remove the dummy item.
			a_item.start
			a_item.remove
		end

	fill_onces (a_parent: EV_TREE_ITEM) is
			-- Fill `a_parent' with the once functions of the debug_value it is in.
		local
			flist: LIST [E_FEATURE]
			dv: ABSTRACT_DEBUG_VALUE
		do
			dv ?= a_parent.data
			a_parent.expand_actions.wipe_out
			if dv /= Void then
				flist := dv.dynamic_class.once_functions
				fill_onces_with_list (a_parent, flist, dv)
			end
		end

	fill_onces_with_list (a_parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `a_parent' with the once functions of the debug_value it is in.
--		local
--			once_r: ONCE_REQUEST
--			l_item: EV_TREE_ITEM
--			flist: LIST [E_FEATURE]
--			dv: ABSTRACT_DEBUG_VALUE
--
--			item_dv: ABSTRACT_DEBUG_VALUE
--			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
--			l_feat: E_FEATURE
		deferred
--			dv ?= a_parent.data
--			a_parent.expand_actions.wipe_out
--			if dv /= Void then
--				flist := dv.dynamic_class.once_functions
--				if Application.is_dotnet then
--					l_dotnet_ref_value ?= dv
--					check
--						dotnet_ref_value: l_dotnet_ref_value /= Void
--					end
--					
--					--| Eiffel dotnet |--
--					from
--						flist.start
--					until
--						flist.after
--					loop
--						l_feat := flist.item				
--						item_dv := l_dotnet_ref_value.once_function_value (l_feat)
--						if item_dv /= Void then
--							l_item := debug_value_to_tree_item (item_dv)						
--						else
--							create l_item
--							l_item.set_pixmap (Pixmaps.Icon_void_object)
--							l_item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
--						end						
--						a_parent.extend (l_item)
--
--						flist.forth
--					end
--				else 
--					--| Classic Eiffel |--
--					once_r := Application.debug_info.Once_request
--
--					from
--						flist.start
--					until
--						flist.after
--					loop
--						l_feat := flist.item
--						
--						if once_r.already_called (l_feat) then
--							l_item := debug_value_to_tree_item (once_r.once_result (l_feat))
--						else
--							create l_item
--							l_item.set_pixmap (Pixmaps.Icon_void_object)
--							l_item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
--						end
--						a_parent.extend (l_item)
--						flist.forth
--					end
--				end
--			end
--				-- We remove the dummy item.
--			a_parent.start
--			a_parent.remove
		end

	debug_value_to_tree_item (dv: ABSTRACT_DEBUG_VALUE): EB_OBJECT_TREE_ITEM is
			-- Convert `dv' into a tree item.
		deferred
--			create Result.make_with_value (dv, tool)
		end

end -- class EB_OBJECT_TREE_ITEM
