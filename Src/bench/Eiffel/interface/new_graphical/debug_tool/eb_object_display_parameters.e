indexing
	description: "Flags describing what should be displayed for an object in the object tool."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_OBJECT_DISPLAY_PARAMETERS

inherit
	SHARED_DEBUG
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end
	EB_CONSTANTS
		export
			{NONE} all
		end
	EB_DEBUG_TOOL_DATA
		export
			{NONE} all
		end
	VALUE_TYPES
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make (n_type: CLASS_C; n_addr: STRING) is
			-- Initialize `Current' and associate it with object
			-- of dynamic type `n_type', named `n_name' and located at address `n_addr'.
		require
			valid_address: n_addr /= Void
		do
			display_attributes := True
			display_onces := False
			display_special := True
			display := True
			dtype := n_type
			address := n_addr
			spec_lower := min_slice_ref.item
			spec_higher := max_slice_ref.item
		end

	make_from_debug_value (val: ABSTRACT_DEBUG_VALUE) is
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
			make (val.dynamic_class, addr)
		end

	make_from_stack_element (elem: CALL_STACK_ELEMENT) is
			-- Initialize `Current' and associate it with object
			-- represented by `elem'.
		do
			make (elem.dynamic_class, elem.object_address)
		end

feature -- Access

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

	object_full_output: STRING is
			-- Full ouput representation for related object
		deferred
		ensure
			Result_not_void: Result /= Void
		end
	
	to_tree_item (parent: EV_TREE_NODE_LIST) is
			-- Generate a tree item representing the managed object located at `address' and attach it to `parent'.
		local
			item: EV_TREE_ITEM
			title: STRING
			main_item: EV_TREE_ITEM
			ost: OBJECT_STONE
			has_attributes: BOOLEAN
			has_onces: BOOLEAN
			ft: FEATURE_TABLE
			f: FEATURE_I
		do
			debug ("debug_recv")
				print ("EB_OBJECT_DISPLAY_PARAMETERS.to_tree_item%N")
			end
			attributes_loaded := False
			onces_loaded := False
			create title.make (50)
			title.append (dtype.external_class_name)
			title.append_character (' ')
			title.append (object_full_output)
			create main_item.make_with_text (title)
			create ost.make (address, " ", dtype)
			main_item.set_accept_cursor (ost.stone_cursor)
			main_item.set_deny_cursor (ost.X_stone_cursor)
			main_item.set_pebble (ost)
			main_item.set_data (address)
			main_item.set_pixmap (Pixmaps.Icon_object_symbol)
			if to_front then
				parent.put_front (main_item)
			else
				parent.extend (main_item)
			end
				-- We detect which subtrees to display.
			ft := dtype.feature_table
			from
				ft.start
			until
				ft.after
			loop
				f := ft.item_for_iteration
				if f.is_attribute and then not f.is_none_attribute then
					has_attributes := True
				elseif f.is_once then
					has_onces := True
				end
				ft.forth
			end

			if has_attributes or dtype.is_special or dtype.is_tuple or is_special then
				create attr_item.make_with_text (Interface_names.l_Object_attributes)
				attr_item.set_pixmap (Pixmaps.Icon_attributes)
				ost.set_associated_tree_item (attr_item)
				main_item.extend (attr_item)
				attr_item.extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_Dummy))
				attr_item.expand_actions.extend (agent on_expand (attributes_id))
				attr_item.collapse_actions.extend (agent on_unexpand (attributes_id))
				if
					display_attributes and
					display
				then
					attr_item.expand
				end
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
				if
					display_onces and
					display
				then
					once_item.expand
				end
			end
			if display then
				main_item.expand
			end
			main_item.expand_actions.extend (agent on_expand (main_id))
			main_item.collapse_actions.extend (agent on_unexpand (main_id))
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

	load_attributes_under (parent: EV_TREE_NODE_LIST) is
			-- Fill in `parent' with the once functions associated object.
		require
			attributes_not_loaded_yet: not attributes_loaded
		deferred
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
		local
			ost: OBJECT_STONE
		do
			create Result.make_with_text (dv.name + ": " + dv.dump_value.type_and_value)
			Result.set_pixmap (icons @ (dv.kind))
			Result.set_data (dv)
			if dv.expandable then
				Result.extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_Dummy))
				Result.expand_actions.extend (agent fill_item (Result))
			end
			if dv.address /= Void and then not dv.is_external_type then
					--| For now we don't support this for external type
				create ost.make (dv.address, dv.name, dv.dynamic_class)
				ost.set_associated_tree_item (Result)
				Result.set_pebble (ost)
				Result.set_accept_cursor (ost.stone_cursor)
				Result.set_deny_cursor (ost.X_stone_cursor)
			end
		end

feature {NONE} -- Implementation

	fill_item (item: EV_TREE_ITEM) is
			-- If a tree item was expandable, fill it with its children. (Not the onces)
		local
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			dv: ABSTRACT_DEBUG_VALUE
			folder_item: EV_TREE_ITEM
			new_item: EV_TREE_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			flist: LIST [E_FEATURE]
		do
			item.expand_actions.wipe_out
			dv ?= item.data
			if dv /= Void then
				list := dv.children
				if not list.is_empty then
					create folder_item.make_with_text (Interface_names.l_Object_attributes)
					folder_item.set_pixmap (Pixmaps.Icon_attributes)
					item.extend (folder_item)

					from
						list.start
					until
						list.after
					loop
						folder_item.extend (debug_value_to_item (list.item))
						list.forth
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
					--| FIXME: JFIAT : why do we have Void dynamic_class ?
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
			when onces_id then
				display_onces := True
				if not onces_loaded then
					load_onces_under (once_item)
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

end -- class EB_OBJECT_DISPLAY_PARAMETERS
