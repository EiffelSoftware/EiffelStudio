indexing
	description: "Flags describing what should be displayed for an object in the object tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_OBJECT_DISPLAY_PARAMETERS

inherit
	ANY

	REFACTORING_HELPER

	SHARED_DEBUG
		export
			{NONE} all
		end
	EB_CONSTANTS
		export
			{NONE} all
		end
	VALUE_TYPES
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make (ot: EB_OBJECT_TOOL; n_type: CLASS_C; n_addr: STRING) is
			-- Initialize `Current' and associate it with object
			-- of dynamic type `n_type', named `n_name' and located at address `n_addr'.
		require
			valid_address: n_addr /= Void
		do
			tool := ot
			display_attributes := True
			display_onces := False
			display_special := True
			display := True
			dtype := n_type
			address := n_addr
			spec_lower := min_slice_ref.item
			spec_higher := max_slice_ref.item
		end

	make_from_debug_value (ot: EB_OBJECT_TOOL; val: ABSTRACT_DEBUG_VALUE) is
			-- Initialize `Current' and associate it with object
			-- represented by `val'.
		local
			conv_abs_ref: ABSTRACT_REFERENCE_VALUE
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			addr: STRING
		do
			conv_abs_ref ?= val
			if conv_abs_ref /= Void then
				addr := conv_abs_ref.address
			else
				conv_abs_spec ?= val
				if conv_abs_spec /= Void then
					addr := conv_abs_spec.address
					is_special := True
					capacity := conv_abs_spec.capacity
				else
					addr := "Unknown address"
				end
			end
			make (ot, val.dynamic_class, addr)
		end

	make_from_stack_element (ot: EB_OBJECT_TOOL; elem: EIFFEL_CALL_STACK_ELEMENT) is
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		require
			elem_not_void: elem /= Void
		do
			make (ot, elem.dynamic_class, elem.object_address)
		end

feature {NONE} -- Properties

	tool: EB_OBJECT_TOOL	

feature -- Measurement

feature {EB_OBJECT_TOOL,EB_SET_SLICE_SIZE_CMD} -- Status report

	display_attributes: BOOLEAN
			-- Should attributes be displayed or not?

	display_onces: BOOLEAN
			-- Should once functions be displayed or not?

	display_special: BOOLEAN
			-- If `Current' represents a special object, should we display it?

	display: BOOLEAN
			-- Should we expand the associated object at all?

	spec_lower, spec_higher: INTEGER
			-- Limits to display special object.

	address: STRING
			-- Hector address of the described object.

	dtype: CLASS_C
			-- Dynamic type of the object located at `address'.

	is_special: BOOLEAN
			-- Do we have information concerning the capacity of Current, if it is a special object?

	capacity: INTEGER
			-- If `is_special', what is the expected capacity of this object? (this information is only
			-- available when `Current' is created from a special value)

feature -- Transformation

	object_type_and_value: STRING is
			-- Full ouput representation for related object
		deferred
		ensure
			Result_not_void: Result /= Void
		end
	
	build_object_tree_item is
			-- Tree item representing the managed object located at `address'.
		local
			item: EV_TREE_ITEM
			title: STRING
			main_item: EV_TREE_ITEM
			ost: OBJECT_STONE
			has_attributes: BOOLEAN
			has_onces: BOOLEAN
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.to_tree_item%N")
			end
			attributes_loaded := False
			onces_loaded := False
			create title.make (50)
			title.append (object_type_and_value)
			create main_item.make_with_text (title)
			create ost.make (address, " ", dtype)
			main_item.set_accept_cursor (ost.stone_cursor)
			main_item.set_deny_cursor (ost.X_stone_cursor)
			main_item.set_pebble (ost)
			main_item.set_data (address)
			main_item.set_pixmap (Pixmaps.Icon_object_symbol)

				-- Nota: now we assume there are attributes and onces
				-- an empty tree item is better than a big computation
			has_attributes := True
			has_onces := True

			if has_attributes or dtype.is_special or dtype.is_tuple or is_special or dtype.is_external then
				create attr_item.make_with_text (Interface_names.l_Object_attributes)
				attr_item.set_pixmap (Pixmaps.Icon_attributes)
				ost.set_associated_ev_item (attr_item)
				main_item.extend (attr_item)
				attr_item.extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_Dummy))
				attr_item.expand_actions.extend (agent on_expand (attributes_id))
				attr_item.collapse_actions.extend (agent on_unexpand (attributes_id))
			end
			if has_onces then
				create once_item.make_with_text (Interface_names.l_Once_functions)
				once_item.set_pixmap (Pixmaps.Icon_once_objects)
				main_item.extend (once_item)
				create item.make_with_text (Interface_names.l_Dummy)
					--|  Add expand actions.
				once_item.extend (item)
				once_item.expand_actions.extend (agent on_expand (onces_id))
				once_item.collapse_actions.extend (agent on_unexpand (onces_id))
			end
			main_item.expand_actions.extend (agent on_expand (main_id))
			main_item.collapse_actions.extend (agent on_unexpand (main_id))
			object_tree_item := main_item
		end

	apply_layout is
			-- Apply wanted layout for tree item `ti'
			-- which means expand or not tree item
		do
			if
				attr_item /= Void
				and display_attributes
				and display
			then
				attr_item.expand
			end
			if
				once_item /= Void
				and display_onces
				and display
			then
				once_item.expand
			end
			if display then
				object_tree_item.expand
			end
		end

	build_and_attach_to_parent (parent: EV_TREE_NODE_LIST) is
			-- Generate a tree item representing the managed object located at `address' and attach it to `parent'.
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.attach_to_tree_item%N")
			end
			build_object_tree_item
			attach_to_parent (parent)
		end
		
	attach_to_parent (parent: EV_TREE_NODE_LIST) is
			-- Generate a tree item representing the managed object located at `address' and attach it to `parent'.
		require
			object_tree_item_not_void: object_tree_item /= Void
		do
			if to_front then
				parent.put_front (object_tree_item)
			else
				parent.extend (object_tree_item)
			end
			apply_layout
		end
		
feature {EB_OBJECT_TOOL} -- Status setting

	set_display_attributes (b: BOOLEAN) is
			-- Should attributes be displayed in the future?
		do
			display_attributes := b
		end

	set_display_onces (b: BOOLEAN) is
			-- Should onces be displayed in the future?
		do
			display_onces := b
		end

	set_display_special (b: BOOLEAN) is
			-- Should special attributes be displayed in the future?
		do
			display_special := b
		end

	set_display (b: BOOLEAN) is
			-- Should attributes be displayed in the future?
		do
			display := b
		end

	set_front (f: BOOLEAN) is
			-- Future tree items will be added in first position of their parent if `f'.
		do
			to_front := f
		end

feature {EB_SET_SLICE_SIZE_CMD} -- Size settings

	set_lower (min: INTEGER) is
			-- Set `spec_lower' to `min'.
		do
			spec_lower := min
		end

	set_higher (max: INTEGER) is
			-- Set `spec_higher' to `max'.
		do
			spec_higher := max
		end
		
feature {EB_SET_SLICE_SIZE_CMD} -- Refreshing

	refresh is
			-- Reload attributes (useful if `Current' represents a special object)
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			obj_is_special: BOOLEAN
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.refresh%N")
			end
			attr_item.wipe_out
			attr_item.expand_actions.wipe_out
			attr_item.collapse_actions.wipe_out
			attributes_loaded := True

			list := refreshed_sorted_children
			obj_is_special := is_sorted_children_about_special
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
				if obj_is_special then
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

feature {NONE} -- Refreshing implementation

	is_sorted_children_about_special: BOOLEAN
			-- Is current related to special object
			-- this value is set during refreshed_sorted_children

	refreshed_sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Sorted children used by refresh
			-- set `is_sorted_children_about_special' attribute
		deferred
		end

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Specific Implementation

	sorted_attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		deferred
		end

	load_attributes_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the associated attributes object.
		require
			attributes_not_loaded_yet: not attributes_loaded
		local
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			ti: EV_TREE_ITEM
			ti_list: ARRAYED_LIST [EV_TREE_ITEM]
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.load_attributes_under%N")
			end
				--| Remove dummy item
			parent.start
			parent.remove

				--| add the real childrens
			list := sorted_attributes
			if list /= Void then
					--| Build the tree_item
				from
					create ti_list.make (list.count)
					list_cursor := list.new_cursor
					list_cursor.start
				until
					list_cursor.after
				loop
					ti := debug_value_to_item (list_cursor.item)
					ti_list.extend (ti)
					list_cursor.forth
				end
					--| Now add to the tree
				parent.append (ti_list)
			end
			attributes_loaded := True
		end

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		require
			parent_not_void: parent /= Void
			once_list_not_void: a_once_list /= Void
		deferred
		end

feature {NONE} -- Implementation (once)

	load_onces_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the once functions associated object.
		local
			flist: LIST [E_FEATURE]
		do
			flist := dtype.once_functions
			fill_onces_with_list (parent, flist, Void)
			onces_loaded := True
		end

	fill_onces (parent: EV_TREE_ITEM) is
			-- Fill `parent' with the once functions of the debug_value it is in.
		local
			flist: LIST [E_FEATURE]
			dv: ABSTRACT_DEBUG_VALUE
		do
			dv ?= parent.data
			parent.expand_actions.wipe_out
			if dv /= Void then
				flist := dv.dynamic_class.once_functions
				fill_onces_with_list (parent, flist, dv)
			end
		end

feature -- Access

	object_tree_item: EV_TREE_ITEM

feature {NONE} -- Implementation

	main_id: INTEGER is unique
	attributes_id: INTEGER is unique
	onces_id: INTEGER is unique
			-- These constants represent all kinds of expandable items.

	to_front: BOOLEAN
			-- Should `Current' add its tree items in first or last position of the parent?

	once_item: EV_TREE_ITEM
			-- Tree item containing the once functions.

	attr_item: EV_TREE_ITEM
			-- Tree item containing the attributes.

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

	debug_value_to_item (dv: ABSTRACT_DEBUG_VALUE): EV_TREE_ITEM is
			-- Convert `dv' into a tree item.
		do
			Result := tool.debug_value_to_tree_item (dv)
		end

feature {NONE} -- Implementation

	fill_item (item: EV_TREE_ITEM) is
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
			item.expand_actions.wipe_out
			dv ?= item.data
			if dv /= Void then
				list := dv.sorted_children
				if list /= Void and then not list.is_empty then
					create folder_item.make_with_text (Interface_names.l_Object_attributes)
					folder_item.set_pixmap (Pixmaps.Icon_attributes)
					item.extend (folder_item)

					from
						list_cursor := list.new_cursor
						list_cursor.start
					until
						list_cursor.after
					loop
						folder_item.extend (debug_value_to_item (list_cursor.item))
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
					end
					folder_item.expand					
				end
				if dv.dynamic_class = Void then
					--| Why do we have Void dynamic_class ?
					--| ANSWER : because of external class in dotnet system
					--| UPDATE: should be fixed by returning SYSTEM_OBJECT
				else
					flist := dv.dynamic_class.once_functions
					if not flist.is_empty then
						create folder_item.make_with_text (Interface_names.l_Once_functions)
						folder_item.set_pixmap (Pixmaps.Icon_once_objects)
						item.extend (folder_item)
						create new_item.make_with_text (Interface_names.l_Dummy)
							--| Add expand actions.
						folder_item.extend (new_item)
						folder_item.set_data (dv)
						folder_item.expand_actions.extend (agent fill_onces (folder_item))
					end
				end
			end
				-- We remove the dummy item.
			item.start
			item.remove
		end

	on_expand (id: INTEGER) is
			-- `id' stands for the kind of expansion detected (attributes, onces, or main).
		do
			inspect id
			when attributes_id then
				display_attributes := True
				if not attributes_loaded then
					load_attributes_under (attr_item)
				end
				if attr_item.is_empty then
					attr_item.set_text (attr_item.text + " : None")
				end
			when onces_id then
				display_onces := True
				if not onces_loaded then
					load_onces_under (once_item)
				end
				if once_item.is_empty then
					once_item.set_text (once_item.text + " : None")
				end
			when main_id then
				display := True
			end
		end

	on_unexpand (id: INTEGER) is
			-- `id' stands for the kind of unexpansion detected (attributes, onces, or main).
		do
			inspect id
			when attributes_id then
				display_attributes := False
				display_special := False
			when onces_id then
				display_onces := False
			when main_id then
				display := False
			end
		end

	onces_loaded: BOOLEAN
			-- Were the onces of `Current' already loaded?

	attributes_loaded: BOOLEAN
			-- Were the attributes of `Current' already loaded?

invariant
	invariant_clause: -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_OBJECT_DISPLAY_PARAMETERS
