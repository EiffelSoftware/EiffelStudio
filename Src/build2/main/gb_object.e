indexing
	description: "Object representing a Build object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT
	
inherit
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_XML_OBJECT_BUILDER
		export
			{NONE} all
			{ANY} object_handler
		end
	
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
	EV_ANY_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_ID
		export
			{NONE} all
		end
	
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		end
		
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_DIGIT_CHECKER
		export
			{NONE} all
			{ANY} generating_type
		end

feature {GB_OBJECT_HANDLER} -- Initialization
	
	make_with_type (a_type: STRING) is
			-- Create `Current' with type `a_type'.
			-- Do not instantiate `object' from type.
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
				-- The names should never be `Void'.
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create instance_referers.make (0)
			create edited_name.make (0)
			expanded_in_box := True
			create children.make (0)
		ensure
			type_assigned: type = a_type
		end
		
	make_with_type_and_object (a_type: STRING; an_object: EV_ANY) is
			-- Create `Current', attach `an_object' to `object' and
			-- `a_type' to `type'.
		require
			a_type_not_void: a_type /= Void
			an_object_not_void: an_object /= Void
			type_matches_object: type_matches_object (a_type, an_object)
		do
			object := an_object
			type := a_type
			build_display_object
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create edited_name.make (0)
			create children.make (0)
			expanded_in_box := True
			id := new_id
		ensure
			type_assigned: type = a_type
			object_assigned: object = an_object
		end

feature -- Access

	id: INTEGER
		-- A unique id representing `Current'.
		-- This is stored in the XML.
		
	is_top_level_object: BOOLEAN is
			-- Is `Current' a top level object in the structure?
			-- i.e. is it represented by an individual class?
		do
			Result := window_selector_item /= Void
		end
		
	is_instance_of_top_level_object: BOOLEAN is
			-- Does `Current' represent a top level object within the system.
		do
			Result := associated_top_level_object > 0
		end

	associated_top_level_object: INTEGER
		-- The id of the top level object `Current' represents,
		-- or `0' if NONE.
		
	associated_top_level_object_on_loading: INTEGER
		-- The associated top level object as retrieved from the XML. This reset to 0 by
		-- `update_object_as_instance_representation' which then sets `associated_top_level_object' to the same value.
		-- This is only used temporarily while loading/importing projects.
		
	window_selector_item: GB_WINDOW_SELECTOR_ITEM
		-- Representation of `Current' in `window_selector'.

	object: EV_ANY
		-- The vision2 object that `Current' represents.
		
	display_object: EV_ANY
		-- The representation of `object' used in `build_window'.
		
	layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Representation of `object' used in GB_LAYOUT_CONSTRUCTOR.
		
	name: STRING
		-- User set name for `Current'.
		
	events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
		-- All events connected to `Current'.
		
	children: ARRAYED_LIST [GB_OBJECT]
			-- `Result' is all children of `Current', ordered
			-- as encountered within `Current'.
		
	constants: HASH_TABLE [GB_CONSTANT_CONTEXT, STRING]
		-- All constants connected to `Current'.
		
	instance_referers: HASH_TABLE [INTEGER, INTEGER]
		-- All instances of `Current' that exist in the current system.
		-- Only valid for top level objects. The data and the key are both
		-- the id of the object that is represented. As the objects object may be rebuilt,
		-- we must not store the GB_OBJECT, but instead the id so we can simply look up the
		-- object from this id whenever needed. If the actual associated object has changed,
		-- this does not matter.
		
	type: STRING
		-- A type corresponding to the current vision2 object.
		-- Contains "EV_" at start.
		
	expanded_in_box: BOOLEAN
		-- Does `Current' expand while parented in an EV_BOX?
		
	is_expanded: BOOLEAN
		-- Is representation of `Current' currently expanded?
		-- Used to expand and collapse `layout_constructor_item' as required
		-- when displaying or hiding `Current'. 
		
	short_type: STRING is
			-- Result is a short version of type with "EV_" removed from start.
		require
			valid_type: type.count > 4 and type.substring (1, 3).is_equal ("EV_")
		do
			Result := type.substring (4, type.count)
		ensure
			Result_correct : ("EV_" + Result).is_equal (type)
		end
		
	parent_object: GB_OBJECT
			-- `Result' is object containing `Current'.
			-- `Void' if none.
		
	top_level_parent_object: GB_OBJECT is
			-- `Result' is top level object containing `Current'.
			-- That is, the object that has no parent object of its own.
			-- Will return `Current' if `Current' has no `parent_object'.
		local
			a_parent_object: GB_OBJECT
		do
			from
				a_parent_object := Current
			until
				a_parent_object = Void
			loop
				Result := a_parent_object
				a_parent_object := a_parent_object.parent_object
				if a_parent_object /= Void then
					Result := a_parent_object
				end
			end
		ensure
			result_not_void: Result /= Void
		end
		
	all_children_recursive (a_list: ARRAYED_LIST [GB_OBJECT]) is
			-- Add all children of `Current' recursively, to
			-- `a_list'.
		require
			a_list_not_void: a_list /= Void
		do
			from
				children.start
			until
				children.off
			loop
				a_list.extend (children.item)
				children.item.all_children_recursive (a_list)
				children.forth
			end
		end

	flatten is
			-- Flatten `Current' so that it is no longer a representation of a top level object and is a
			-- completely flat widget structure.
		require
			is_instance_of_top_level_object: is_instance_of_top_level_object
		local
			associated_object: GB_OBJECT
		do
				-- Ensure that for all objects contained in `Current' the association is removed.
			unconnect_instance_referers (object_handler.deep_object_from_id (associated_top_level_object), Current)

			associated_object := object_handler.object_from_id (associated_top_level_object)
			associated_object.instance_referers.remove (id)
			if associated_top_level_object /= 0 then
				remove_associated_top_level_object
				connect_display_object_events
				represent_as_non_locked_instance
				update_representations_for_name_or_type_change
			end
			if layout_item.is_expandable then
				-- `layout_item' may be empty and therefore not expandable.
				layout_item.expand
			end
		ensure
			not_is_instance_of_top_level_object: not is_instance_of_top_level_object
		end
		
	shallow_flatten is
			-- Flatten `Current' so that it is no longer a representation of a top level object, although
			-- all instances of other top level objects within the structure are retained.
		require
			is_instance_of_top_level_object: is_instance_of_top_level_object
		do
				-- Ensure that for all objects contained in `Current' the association is removed.
			unconnect_instance_referers (object_handler.deep_object_from_id (associated_top_level_object), Current)
			internal_shallow_flatten (Current, object_handler.deep_object_from_id (associated_top_level_object))
			if layout_item.is_expandable then
				-- `layout_item' may be empty and therefore not expandable.
				layout_item.expand
			end
		ensure
			not_is_instance_of_top_level_object: not is_instance_of_top_level_object
		end

	new_top_level_representation: GB_OBJECT is
			-- `Result' is a copy of `Current' with a new set of id's, representing
			-- an instance of a top level widget.
		local
			xml_store: GB_XML_STORE
			a_list: ARRAYED_LIST [GB_OBJECT]
		do
			create xml_store
			xml_store.store_individual_object (Current)
			Result := new_object (xml_store.last_stored_individual_object, True)
			
				-- Modify id of `Result' so that it is not the same as that of `Current'.
			create a_list.make (20)
			Result.all_children_recursive (a_list)
			Result.set_id (new_id)
				-- Only add `Result' to objects now that we have the new id.
			object_handler.add_object_to_objects (Result)
			
				-- Ensure that the new locked object cannot have objects inserted through it's `display_object'.
				-- Note that you can still pick the object as we do not unconnect the pick events are we do for all
				-- children recursively.
			Result.unconnect_display_object_drop_events
			from
				a_list.start
			until
				a_list.off
			loop
				a_list.item.set_id (new_id)
				object_handler.add_object_to_objects (a_list.item)
				
					-- Now unconnect events from the display object to prevent users
					-- from modifying the structure of a locked representation.
				a_list.item.unconnect_display_object_drop_events
				a_list.item.unconnect_display_object_pick_events
				a_list.forth
			end
				-- Remove the old name.
			Result.set_name ("")
				-- Set the text for `layout_item'.
			Result.represent_as_locked_instance
			
				-- We must check that we are actually a top level object, as otherwise if
				-- we have nested representations, it does not need to be done.
			if is_top_level_object then
				Result.set_associated_top_level_object (Current)
					-- Ensure that all representations of `Result' reflect this change.
				Result.update_representations_for_name_or_type_change
			end
		ensure
--| FIXME is this not implementable/true?
--			bi_directional_reference: Result.associated_top_level_object /= Void and instance_referers.has (Result.id) and Result.associated_top_level_object = Current
		end
		
	represent_as_locked_instance is
			-- Ensure pixmap representation of `Current' is that of a locked type.
		local
			pixmap, l_pixmap: EV_PIXMAP
		do
			pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_locked_color")
			l_pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name (type.as_lower).twin
			l_pixmap.draw_sub_pixmap (0, 0, pixmap, create {EV_RECTANGLE}.make (0, 0, pixmap.width, pixmap.height))
			layout_item.set_pixmap (l_pixmap)
			layout_item.wipe_out
			layout_item.set_data ("Represents a top level object, so no children may be added.")
		ensure
			layout_item_empty: layout_item.count = 0
			layout_item_has_data: layout_item.data /= Void
		end
		
	represent_as_non_locked_instance is
			-- Ensure pixmap representation of `Current' is not that of a locked type.
		do
			layout_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name (type.as_lower).twin)
			layout_item.set_data (Void)
			from
				children.start
			until
				children.off
			loop
				layout_item.extend (children.item.layout_item)
				children.forth
			end
		ensure
			layout_item_children_set: layout_item.count = children.count
			laytou_item_has_not_data: layout_item.data = Void
		end
		
	connect_instance_referers (original_object, instance_object:GB_OBJECT) is
			-- Recursively add a similar referring link from evey child in `Current'
			-- to every child of `instance_object' that is not part of a nested structure.
		require
			objects_differ: original_object /= instance_object
			objects_not_void: original_object /= Void and instance_object /= Void
		local
			original_linear_representation, new_linear_representation: ARRAYED_LIST [GB_OBJECT]
		do
			create new_linear_representation.make (20)
			create original_linear_representation.make (20)
			instance_object.all_children_recursive (new_linear_representation)
			original_object.all_children_recursive (original_linear_representation)
			check
				same_object_count: new_linear_representation.count = original_linear_representation.count
			end
			from
				new_linear_representation.start
				original_linear_representation.start
			until
				new_linear_representation.off
			loop
				original_linear_representation.item.instance_referers.put (new_linear_representation.item.id, new_linear_representation.item.id)
				if is_top_level_object then
					original_linear_representation.item.layout_item.set_data ("pop")
				end
				original_linear_representation.forth
				new_linear_representation.forth
			end
		end

	unconnect_instance_referers (original_object, an_object:GB_OBJECT) is
			-- Recursively remove a referring link from evey child in `Current'
			-- to every child of `an_object'.
		require
			objects_differ: original_object /= an_object
			objects_not_void: original_object /= Void and an_object /= Void
		local
			original_linear_representation, new_linear_representation: ARRAYED_LIST [GB_OBJECT]
		do
			create new_linear_representation.make (20)
			create original_linear_representation.make (20)
			an_object.all_children_recursive (new_linear_representation)
			original_object.all_children_recursive (original_linear_representation)
			check
				same_object_count: new_linear_representation.count = original_linear_representation.count
			end
			from
				new_linear_representation.start
				original_linear_representation.start
			until
				new_linear_representation.off
			loop
				original_linear_representation.item.instance_referers.remove (new_linear_representation.item.id)
				original_linear_representation.forth
				new_linear_representation.forth
			end
		end
		
	update_instances (p: PROCEDURE [EV_ANY, TUPLE]) is
			-- For all `instance_refers' of `Current', call `p' on
			-- all representations.
		require
			p_not_void: p /= Void
		local
			l_display: GB_DISPLAY_OBJECT
			current_object: GB_OBJECT
		do
			from
				instance_referers.start
			until
				instance_referers.off
			loop
				current_object := object_handler.deep_object_from_id (instance_referers.item_for_iteration)
				p.call ([current_object.object])
				l_display ?= current_object.display_object
				if l_display /= Void then
					p.call ([l_display.item])
				else
					p.call ([current_object.display_object])
				end
				current_object.update_instances (p)
				instance_referers.forth
			end
		end
		
	update_first_instances (p: PROCEDURE [EV_ANY, TUPLE]) is
			-- For all `instance_refers' of `Current', call `p' on
			-- the first representation only.
		require
			p_not_void: p /= Void
		local
			current_object: GB_OBJECT
		do
			from
				instance_referers.start
			until
				instance_referers.off
			loop
				current_object := object_handler.deep_object_from_id (instance_referers.item_for_iteration)
				p.call ([current_object.object])
				current_object.update_instances (p)
				instance_referers.forth
			end
		end
		
	actual_type: STRING is
			-- `Result' is type of `an_object'.
		do
			if is_instance_of_top_level_object then
				Result := object_handler.deep_object_from_id (associated_top_level_object).name.as_upper	
			else
				Result := type.substring (4, type.count)
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	destroy_recursive is
			-- Destroy `Current' and recursively destroy all children.
		local
			all_children: ARRAYED_LIST [GB_OBJECT]
		do
			destroy
			create all_children.make (50)
			all_children_recursive (all_children)
			from
				all_children.start
			until
				all_children.off
			loop
				all_children.item.destroy
				all_children.forth
			end
		end

	destroy is
			-- Destroy `Current'.
		do
				-- Note that both `layout_item' or `window_selector_item' may be reparented to
				-- another object, so if this is the case, do nothing.
			if layout_item.object = Current then
				layout_item.destroy
			end
			if window_selector_item /= Void and then window_selector_item.object = Current then
				window_selector_item.tree_item.destroy
			end
			
			children.wipe_out
			parent_object := Void
			events.wipe_out
			instance_referers.clear_all
			from
				constants.start
			until
				constants.off
			loop
					-- Note that `destroy' removes the current item so there is
					-- no need to explicitly iterate.
				constants.item_for_iteration.destroy
			end
		ensure
			children_empty: children.is_empty
			constants_empty: constants.is_empty
			instance_referers_empty: instance_referers.is_empty
		end

feature {GB_COMMAND_ADD_OBJECT, GB_OBJECT_HANDLER} -- Basic operation
		
	build_objects is
			-- Create display and build objects for `Current'.
		require
			object_void: object = Void
			display_object = Void
		do
			if object = Void then
				create_object_from_type
				build_display_object
				
					-- We must only set up these events for widgets, as items do not have the correct
					-- events that we can hook to.
				if type_conforms_to (dynamic_type_from_string (type), dynamic_type_from_string (Ev_widget_string)) then
					set_up_display_object_events (display_object, object)	
				end
			end
		ensure
			object_not_void: object /= Void
			display_object_not_void: display_object /= Void
		end		

feature {GB_EV_BOX_EDITOR_CONSTRUCTOR, GB_COMMAND_CHANGE_TYPE} -- Basic operation

	enable_expanded_in_box is
			-- Ensure `expanded_in_box' is `True'.
		do
			expanded_in_box := True
		ensure
			is_expanded: expanded_in_box
		end
		
	disable_expanded_in_box is
			-- Ensure `expanded_in_box' is `False'.
		do
			expanded_in_box := False
		ensure
			not_expanded: not expanded_in_box
		end
		
feature {GB_OBJECT, GB_OBJECT_HANDLER, GB_COMMAND_ADD_OBJECT, GB_COMMAND_CONVERT_TO_TOP_LEVEL} -- Status Setting

	set_parent (a_parent_object: GB_OBJECT) is
			-- Assign `a_parent_object' to `parent_object'.
			-- `a_parent_object' may be Void, when removing from a parent.
		do
			parent_object := a_parent_object
		ensure
			parent_set: parent_object = a_parent_object
		end
		
	set_associated_top_level_object (an_object: GB_OBJECT) is
			-- Set `an_object' as `associated_top_level_object'.
		require
			an_object_not_void: an_object /= Void
			an_object_is_top_level_object: an_object.is_top_level_object
		do
			associated_top_level_object := an_object.id
		ensure
			object_associated: associated_top_level_object = an_object.id
		end
		
	remove_associated_top_level_object is
			-- Reset associated top level object.
		require
			has_associated_top_level_object: is_instance_of_top_level_object
		do
			associated_top_level_object := 0
		ensure
			no_association: not is_instance_of_top_level_object
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_COMMAND_CHANGE_TYPE} -- Deletion
			
	delete is
			-- Perform any necessary pre processing for
			-- a deletion of `Current' from the system.
		do
			-- Redefine in descendents that need to handle
			-- special processing for a delete.
		end

feature {GB_XML_STORE, GB_XML_LOAD, GB_XML_OBJECT_BUILDER, GB_XML_IMPORT}

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of sepecific attributes of `Current'
			-- in `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_integer (element, Id_string, id)
			if not name.is_empty then
				add_element_containing_string (element, name_string, name)
			end
			add_element_containing_integer (element, "Expanded", is_expanded.to_integer)
			if is_instance_of_top_level_object then
				add_element_containing_integer (element, reference_id_string, associated_top_level_object)
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update `Current' based on information held in `element'.
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Id_String)
				-- Although every saved object should have an ID, 
				-- we allow there to be none, to maintain backwards compatibility.
			if element_info /= Void then
				id := (element_info.data).to_integer	
			end
			element_info := full_information @ (name_string)
			if element_info /= Void then
				set_name (element_info.data)
			end
			element_info := full_information @ ("Expanded")
			if element_info /= Void then
				if element_info.data.to_integer = 1 then
					is_expanded := True
				end
			end
			element_info := full_information @ reference_id_string
			if element_info /= Void then
				associated_top_level_object_on_loading := element_info.data.to_integer
			else
				associated_top_level_object_on_loading := 0
			end
		end

feature {GB_LAYOUT_CONSTRUCTOR_ITEM, GB_OBJECT_HANDLER, GB_WINDOW_SELECTOR, GB_COMMAND_DELETE_OBJECT, GB_COMMAND_ADD_OBJECT} -- Status setting

	set_layout_item (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Assign `a_layout_item' to `layout_item'.
		require
			layout_item_not_void: a_layout_item /= Void
		do
			layout_item ?= a_layout_item
			layout_item.set_object (Current)
			build_drop_actions_for_layout_item
		ensure
			layout_item_set: layout_item = a_layout_item
			layout_item_object_set: layout_item.object = Current
		end
		
	remove_child (an_object: GB_OBJECT) is
			-- Removed `an_object' and all its representations from `Current'.
		require
			object_not_void: an_object /= Void
			contained: children.has (an_object)
		do
			unparent_ev_object (an_object.object)
			unparent_ev_object (an_object.display_object)
	
			layout_item.prune_all (an_object.layout_item)
			remove_child_from_children (an_object)
			
				-- Notify the system that we have modified something.
			system_status.enable_project_modified
			command_handler.update
		ensure
			not_contained: not children.has (an_object)
		end
		
		
feature {GB_OBJECT_HANDLER, GB_ID_COMPRESSOR} -- Status setting

	assign_id is
			-- Assign a new `id' to `Current'.
		require
			id_not_assigned: id = 0
		do
			id := new_id
		ensure
			id_set: id >= 0
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_BUILDER_WINDOW, GB_WINDOW_SELECTOR_ITEM} -- Element change

	create_object_from_type is
			-- Create an object of type `type' and assign
			-- to `object'.
		require
			no_object_associated: object = Void
		do
			object := vision2_object_from_type (type)
		ensure
			object_initialized: object /= Void
		end
		
	can_add_child (object_representation: ANY): BOOLEAN is
			-- May an object represented by `object_representation' be added
			-- to `Current'. `object_representation' may be either a GB_COMPONENT or a 
			-- GB_OBJECT. We do not just create an object from the component and use that,
			-- as this can be very slow, and this feature is called many times during
			-- a pick and drop.
		require
			object_representation_not_void: object_representation /= Void
		local
			env: EV_ENVIRONMENT
			an_object, local_parent_object: GB_OBJECT
			a_component: GB_COMPONENT
			new_short_type, new_type: STRING
			funct_result: BOOLEAN
			color_stone: GB_COLOR_STONE
			colorizeable: EV_COLORIZABLE
			all_dependents: HASH_TABLE [GB_OBJECT, INTEGER]
		do
			color_stone ?= object_representation
			if color_stone /= Void then
				colorizeable ?= object
				Result := colorizeable /= Void
			else
				an_object ?= object_representation
					-- We get the new type of the object to be added. With this
					-- information, we can then see if `Current' will accept
					-- a child of this type.
				if an_object /= Void then
					new_type := an_object.type
					new_short_type := an_object.short_type
				else
					-- If we are not an object, then we must be a component.
					a_component ?= object_representation
					check
						is_component: a_component /= Void
					end
					new_type := a_component.root_element_type
					new_short_type := new_type.substring (4, new_type.count)
				end
				Result := True
				create env
					-- If shift is pressed `object_representation' must be added to the parent.
				if env.application.shift_pressed and not an_object.is_instance_of_top_level_object then
					local_parent_object := parent_object
				else
					local_parent_object := Current
				end
					-- Firstly, ensure that we do not drop an object into a representation of a top level object.
				if local_parent_object /= Void and then local_parent_object.is_instance_of_top_level_object then
					Result := False
					set_status_text ("Cannot parent object in locked instance of " + object_handler.deep_object_from_id (local_parent_object.associated_top_level_object).name)
				end
				
					-- Now restrict the dropping of top level structures into other top level structures
					-- that would cause a cyclic inheritance hierarchy.
				if Result and an_object /= Void and then an_object.window_selector_item /= Void then
					create all_dependents.make (4)
					all_dependents_recursive (an_object, all_dependents)
					all_dependents.extend (an_object, an_object.id)
					Result := not all_dependents.has (Current.id)
					if not Result then
						set_status_text (cyclic_inheritance_error)
					end
				end
					-- If we are at the top level and shift is pressed, there is no parent.
				if Result and local_parent_object /= Void then
					Result := not local_parent_object.is_full
							-- We only need to check this if we are not a component,
							-- as this means there is no way we could be contained in `Current'.
					if an_object /= Void then
						funct_result := local_parent_object.override_drop_on_child (an_object)
						if not funct_result then
								-- Now display output if we are attempting to insert the object in itself
								-- or one of its children.
							display_parent_in_child_message (an_object, local_parent_object, new_type)			
						end
						Result := Result and funct_result
					end
					funct_result := local_parent_object.accepts_child (new_type)
						-- We now display information in status bar regarding full status.
					display_invalid_drop_message (local_parent_object, new_type, funct_result)
					Result := Result and funct_result
				else
					Result := False
				end
				if Result then
					status_bar_label.remove_text
				end
			end
		end
		
	all_dependents_recursive (an_object: GB_OBJECT; dependents: HASH_TABLE [GB_OBJECT, INTEGER]) is
			-- Add all top level objects which `an_object' is dependent on to `dependents'. Does not
			-- include `an_object' itself.
		require
			object_not_void: an_object /= Void
			dependents_not_void: dependents /= Void
		local
			current_object, dependent_object: GB_OBJECT
		do
			from
				an_object.children.start
			until
				an_object.children.off
			loop
				current_object := an_object.children.item
				
				if current_object.is_instance_of_top_level_object then
					dependent_object := object_handler.deep_object_from_id (current_object.associated_top_level_object)
					if not dependents.has (dependent_object.id) then
							-- Only add if it is not already contained as an object may rely on another
							-- object multiple times in it's structure.
						dependents.put (dependent_object, dependent_object.id)
					end
					all_dependents_recursive (dependent_object, dependents)
				else
					all_dependents_recursive (current_object, dependents)
				end
				an_object.children.forth
			end
		end		

	create_layout_item is
			-- Create a layout_item associated with `Current'.
		require
			no_layout_item_associated: layout_item = Void
		do
			create layout_item.make (Current)
			build_drop_actions_for_layout_item
		ensure
			lyout_item_initialized: layout_item /= Void
			layout_item_not_parented: layout_item.parent = Void
		end
		
feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT} -- Access
		
	accepts_child (a_type: STRING):BOOLEAN is
			-- Does `Current' accept `an_object'.
			-- Redefine in descendents to allow children
			-- of correct type to be added.
		require
			type_not_void: a_type /= Void
		do
			Result := False
		end
		
feature {GB_INTEGER_INPUT_FIELD, GB_STRING_INPUT_FIELD, GB_PIXMAP_INPUT_FIELD, GB_EV_ANY} -- Basic operations

	add_constant_context (context: GB_CONSTANT_CONTEXT) is
			-- Add `context' to `constants'.
			-- Overwrites an existing context for the same attribute if any.
		require
			context_not_void: context /= Void
			context_object_is_current: context.object = Current
		do
			constants.force (context, context.property + context.attribute)
		ensure
			constants.has (context.property + context.attribute)
		end

feature -- Basic operations
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := True
		end
		
	add_new_component_in_parent (a_component: GB_COMPONENT) is
			-- Add `a_component' to parent of `Current', before `Current'.
		require
			has_parent_object: parent_object /= Void
			object_parent_not_full: not parent_object.is_full
			component_not_void: a_component /= Void
		local
			an_object: GB_OBJECT
		do
			an_object := a_component.object
			object_handler.recursive_do_all (an_object, agent ensure_names_unique (?))
			ensure_names_unique (an_object)
			add_new_object_in_parent (an_object)
		ensure
			parent_count_increased: parent_object.children.count = old parent_object.children.count + 1
		end

	add_new_object_in_parent (an_object: GB_OBJECT) is
			-- Add `an_object' to parent of `Current', before `Current'.
		require
			has_parent_object: parent_object /= Void
			object_not_void: an_object /= Void
			object_parent_not_full: not parent_object.is_full		
		local
			command_add: GB_COMMAND_ADD_OBJECT
			insert_position: INTEGER
		do
			insert_position := parent_object.children.index_of (Current, 1)
			
				-- We must now check that the item being inserted before is not contained in the same parent as `Current'.
				-- If this is the case, and the item is before `Current' in the parent, then we must use an insert_position
				-- one less than normal.
			if parent_object.children.has (an_object) and
			insert_position < parent_object.children.index_of (Current, 1) then
				insert_position := insert_position - 1
			end
			create command_add.make (parent_object, an_object, insert_position)
			command_add.execute
		ensure
			object_contained_if_not_top_level: not an_object.is_top_level_object implies parent_object.children.has (an_object)
			children_count_increased: parent_object.children.count = old parent_object.children.count + 1
		end
		
	add_new_component (a_component: GB_COMPONENT) is
			-- Add object representation of `a_component' to `Current'.
		require
			component_not_void: a_component /= Void
			object_not_full: not is_full
		local
			an_object: GB_OBJECT
		do
			an_object := a_component.object
			object_handler.recursive_do_all (an_object, agent ensure_names_unique (?))
			ensure_names_unique (an_object)
			add_new_object (an_object)
		ensure
			count_increased: children.count = old children.count + 1
		end

	add_new_object (an_object: GB_OBJECT) is
			-- Add `an_object' to `Current'.
		require
			object_not_void: an_object /= Void
			not_full: not is_full
		local
			command_add: GB_COMMAND_ADD_OBJECT
		do
				-- `an_object' may already be contained in `Current'.
				-- If this is the case, then the insert position is the number of
				-- items held in the layout item, as we are effectively moving it to the end.
			if children.has (an_object) then
				create command_add.make (Current, an_object,layout_item.count)
			else
				create command_add.make (Current, an_object, layout_item.count + 1)
			end
			command_add.execute
				-- Now we expand the layout item.
			if layout_item.is_expandable and not layout_item.is_expanded then
				layout_item.expand
			end
		ensure
			object_contained_if_not_top_level: not an_object.is_top_level_object implies children.has (an_object)
			children_count_increased: children.count = old children.count + 1
			layout_item_not_void: an_object.layout_item /= Void
		end
		
	set_id (a_new_id: INTEGER) is
			-- Assign `new_id' to `id'.
		require
			non_negative: a_new_id >= 0
		do
			id := a_new_id
		ensure
			id_assigned: id = a_new_id
		end
		
feature {GB_ID_COMPRESSOR, GB_OBJECT}

	update_internal_id_references (conversion_data: HASH_TABLE [INTEGER, INTEGER]) is
			-- For all ids, used in `Current', including `id', and ids used in any
			-- properties, convert from their current_value  to hash_table [current_value] value.
		require
			conversion_data_not_void: conversion_data /= Void
			conversion_data_has_entry: conversion_data.item (id) /= 0
		local
			linear: LINEAR [INTEGER]
		do
			id := conversion_data @ id
			
			linear := instance_referers.linear_representation
			instance_referers.clear_all
			from
				linear.start
			until
				linear.off
			loop
				instance_referers.extend (conversion_data @ linear.item, conversion_data @ linear.item)
				linear.forth
			end
			if is_instance_of_top_level_object then
				associated_top_level_object := conversion_data @ associated_top_level_object
			end
		ensure
			conversion_completed: id = conversion_data.item (old id)
			-- All instance referers converted also. Not easy to write as a postcondition.
		end

feature {GB_COMMAND_NAME_CHANGE, GB_OBJECT_HANDLER, GB_OBJECT, GB_COMMAND_CHANGE_TYPE, GB_WINDOW_SELECTOR, GB_COMMAND_CONVERT_TO_TOP_LEVEL} -- Basic operation

	set_name (new_name: STRING) is
			-- Assign `new_name' to `name'.
		require
			name_not_void: new_name /= Void
			--| FIXME while building a new top level representation of an object,
			--| we temporarily set the name to one already in use as we load it from XML.
			--| it is changed after, but prevents the following precondition from being permitted.
			--no_object_has_name: not object_handler.name_in_use (new_name, Current)
		do
			name := new_name
			edited_name := new_name
			update_representations_for_name_or_type_change
		ensure
			name_assigned: name.is_equal (new_name)
			edited_name_set: name.is_equal (new_name)
		end
		
	update_representations_for_name_or_type_change is
			-- Update all representations of `Current' to reflect a change
			-- of name or type.
		local
			name_and_type: STRING
		do
			name_and_type := name_and_type_from_object (Current)
			layout_item.set_text (name_and_type)			
			if is_top_level_object then
					-- Update the window selector item name.
				window_selector_item.update_to_reflect_name_change
			end
		end

feature {GB_OBJECT_HANDLER, GB_TITLED_WINDOW_OBJECT, GB_OBJECT} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		require
			display_object_void: display_object = Void
		local
			pick_and_dropable: EV_PICK_AND_DROPABLE
		do
			display_object ?= vision2_object_from_type (type)
			pick_and_dropable ?= display_object
			connect_display_object_events
		ensure
			display_object_not_void: display_object /= Void
		end
		
	connect_display_object_events is
			-- Connect events to `display_object' to permit interactive building.
		require
			has_display_object: display_object /= Void
		local
			pick_and_dropable: EV_PICK_AND_DROPABLE
		do
			pick_and_dropable ?= display_object
			if pick_and_dropable /= Void then
					-- Firstly remove any previous events
				pick_and_dropable.drop_actions.wipe_out
				
					-- Now connect the new events
				pick_and_dropable.set_pebble_function (agent retrieve_pebble)
				pick_and_dropable.drop_actions.extend (agent add_new_component_wrapper (?))
				pick_and_dropable.drop_actions.extend (agent add_new_object_wrapper (?))
				pick_and_dropable.drop_actions.set_veto_pebble_function (agent can_add_child (?))
				pick_and_dropable.drop_actions.extend (agent set_color)
			end
		end
		
	unconnect_display_object_pick_events is
			-- Unconnect pick events from `display_object' to restrict interactive building.
			-- For example we do not permit a user to modify the structure if the object is
			-- part of a representation of a top level object.
		require
			has_display_object: display_object /= Void
		local
			pick_and_dropable: EV_PICK_AND_DROPABLE
		do
			pick_and_dropable ?= display_object
			if pick_and_dropable /= Void then
				pick_and_dropable.remove_pebble
			end
		end
		
	unconnect_display_object_drop_events is
			-- Unconnect drop events from `display_object' to restrict interactive building.
			-- For example we do not permit a user to modify the structure if the object is
			-- part of a representation of a top level object.
		require
			has_display_object: display_object /= Void
		local
			pick_and_dropable: EV_PICK_AND_DROPABLE
		do
			pick_and_dropable ?= display_object
			if pick_and_dropable /= Void then
				pick_and_dropable.drop_actions.wipe_out
				pick_and_dropable.drop_actions.set_veto_pebble_function (Void)
			end
		end

	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_TYPE_SELECTOR_ITEM.
		do
			if application.ctrl_pressed and application.shift_pressed then
					-- If ctrl and shift is pressed, we must highlight
					-- the object in the layout constructor.
				Layout_constructor.highlight_object (Current)
			elseif application.ctrl_pressed then
					-- If the ctrl key is pressed, then we must
					-- start a new object editor for `Current', instead
					-- of beginning the pick and drop.
				new_object_editor (Current)
			else
				type_selector.update_drop_actions_for_all_children (Current)
				Result := Current
			end
		end

	set_up_display_object_events (a_display_object, an_object: EV_ANY) is
			-- Add events necessary for `display_object'.
			-- Some objects such as EV_TOGGLE_BUTTON can be modified
			-- by the user in the display window. We need to set up events
			-- on `display_object' so that we can notify the system that the
			-- change has taken place. There are only a few such events
			-- like these, but we need to be able to handle them.
		require
			display_object_not_void: a_display_object /= Void
			object_not_void: an_object /= Void
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
		do
			create handler
			supported_types := handler.supported_types.twin
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (display_object, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.default_create
					if gb_ev_any.has_user_events then
						gb_ev_any.set_up_user_events (Current, a_display_object, an_object)
					end
				end
				supported_types.forth
			end
		end
		
feature {GB_OBJECT} -- Implementation
		
	override_drop_on_child (an_object: GB_OBJECT): BOOLEAN is
			-- If `Current' is held within `an_object' or
			-- `Current' is `an_object' then do not allow drop.
		require
			an_object_not_void: an_object /= Void
		do
			Result := True
				
				-- If an object is Void then we are transporting a type.
			if an_object /= Void then
					-- Check that the object is fully instantiated, and is not still
					-- representing a type.
				if an_object.object /= Void then
					if object_handler.object_contained_in_object (an_object, Current) or
					Current = an_object then
						Result := False
					end
				end
			end
		end
		
feature {GB_OBJECT_EDITOR, GB_GENERAL_UTILITIES} -- Implementation

	edited_name: STRING
		-- The name being entered for `Current' in an object editor.
		
	set_edited_name (a_name: STRING) is
			-- Assign `a_name' to `edited_name'.
		require
			name_not_void: a_name /= Void
		do
			edited_name := a_name
			update_representations_for_name_or_type_change
		ensure
			name_set: edited_name.is_equal (a_name)
		end

	cancel_edited_name is
			-- Assign `name' to `edited_name'.
		do
			edited_name := name
			update_representations_for_name_or_type_change
		end
		
feature {GB_WINDOW_SELECTOR_ITEM, GB_GENERAL_UTILITIES} -- Implementation

	output_name: STRING is
			-- Representation of `name' of `Current'
			-- Used so that we do not have to distinguish between the
			-- cases where we are editing a name or not editing a name.
			-- When we are not editing, `edited_name' and `name' are
			-- identical.
		do
			if edited_name.is_equal (name) then
				Result := name
			else
				Result := edited_name
			end
		ensure
			result_not_void: Result /= Void
		end
	
feature {GB_CODE_GENERATOR} -- Implementation

	extend_xml_representation (child_name: STRING): STRING is
			-- `Result' is XML representation of code required to extend
			-- the current_object_type.
		require
			name_not_void: child_name /= Void
		do
			Result := "extend (" + child_name + ")"
		ensure
			result_not_void: Result /= Void
		end
		
feature {GB_LAYOUT_CONSTRUCTOR, GB_OBJECT_HANDLER} -- Implementation

	build_drop_actions_for_layout_item is
			-- Build the drop actions for the layout item.
			-- Wipe out any existing actions.
		require
			layout_item_not_void: layout_item /= Void
		do
			layout_item.drop_actions.wipe_out
			layout_item.drop_actions.extend (agent add_new_object_wrapper (?))
			layout_item.drop_actions.extend (agent add_new_component_wrapper (?))
			layout_item.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end
		
feature {GB_BUILDER_WINDOW} -- Implementation

	add_new_object_wrapper (an_object: GB_OBJECT) is
			-- If shift pressed then add `an_object' to
			-- parent of `Current', else add to `Current'.
		require
			object_not_void: an_object /= Void
		local
			env: EV_ENVIRONMENT
			new_type: STRING
			a_new_object: GB_OBJECT
			counter: INTEGER
			object_full: BOOLEAN
		do
			create env
			if not env.application.shift_pressed then
				check
					object_not_full: not is_full
				end
				add_new_object (an_object)
			else
				add_new_object_in_parent (an_object)
			end
			if digit_checker.digit_pressed then
				new_type := an_object.type
				if not env.application.shift_pressed then
					object_full := is_full
				else
					object_full := parent_object.is_full
				end
				from
					counter := 1
				until
						-- Ensure that we do not attempt to insert more items than
						-- are accepted.
					counter > digit_checker.digit or object_full
				loop
					a_new_object := object_handler.build_object_from_string_and_assign_id (new_type)
					if not env.application.shift_pressed then
						add_new_object (a_new_object)
						object_full := is_full
					else
						add_new_object_in_parent (a_new_object)
						object_full := parent_object.is_full
					end
					counter := counter + 1
				end
			end
		end
		
	add_new_component_wrapper (a_component: GB_COMPONENT) is
			-- If shift pressed then add `a_component' to
			-- parent of `Current', else add to `Current'.
		require
			component_not_void: a_component /= Void
		do
			if not environment.application.shift_pressed then
				check
					object_not_full: not is_full
				end
				add_new_component (a_component)
			else
				add_new_component_in_parent (a_component)
			end
		end
		
	set_color (color_stone: GB_COLOR_STONE) is
			-- Assign color of `color_stone' to `Current'.
		require
			color_stone_not_void: color_stone /= Void
		local
			colorizeable: EV_COLORIZABLE
			a_display_object: GB_DISPLAY_OBJECT
		do
			colorizeable ?= display_object
			if colorizeable /= Void then
				if color_stone.is_foreground then
					colorizeable.set_foreground_color (color_stone.color.twin)
					colorizeable ?= object
					colorizeable.set_foreground_color (color_stone.color.twin)
					a_display_object ?= display_object
					if a_display_object /= Void then
						colorizeable ?= a_display_object.child
						colorizeable.set_foreground_color (color_stone.color.twin)
					end
				else
					colorizeable.set_background_color (color_stone.color.twin)
					colorizeable ?= object
					colorizeable.set_background_color (color_stone.color.twin)
					a_display_object ?= display_object
					if a_display_object /= Void then
						colorizeable ?= a_display_object.child
						colorizeable.set_background_color (color_stone.color.twin)
					end
				end
			end
		end
		
feature {GB_LAYOUT_CONSTRUCTOR_ITEM} -- Implementation

	register_expand is
			-- Assign `True' to `is_expanded'.
		do
			is_expanded := True
		ensure
			is_expanded: is_expanded
		end
		
	register_collapse is
			-- Assign `False' to `is_expanded'.
		do
			is_expanded := False
		ensure
			not_expanded: not is_expanded
		end
		
feature {GB_WINDOW_SELECTOR_ITEM, GB_OBJECT_HANDLER} -- Implementation
		
	set_window_selector_item (a_window_selector_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Assign `a_window_selector_item' to `window_selector_item'.
		require
			item_not_void: a_window_selector_item /= Void
		do
			window_selector_item := a_window_selector_item
			window_selector_item.set_object (Current)
		ensure
			item_set: window_selector_item = a_window_selector_item
			window_selector_item_object_set: window_selector_item.object = Current
		end
		
feature -- Contract Support

	type_matches_object (a_type: STRING; an_object: ANY): BOOLEAN is
			-- Is `an_object' an instance of `a_type'?
		require
			a_type_not_void: a_type /= Void
			an_object_not_void: an_object /= Void
		do
			Result := is_instance_of (an_object, dynamic_type_from_string (a_type))
		end
		
feature {NONE} -- Implementation

	vision2_object_from_type (a_type: STRING): EV_ANY is
			-- `Result' is a vision2 object of type `a_type'
		require
			a_type_not_void: a_type /= Void
		local
			passed: BOOLEAN
			an_object: EV_ANY
		do
			passed := feature {ISE_RUNTIME}.check_assert (False)
			an_object ?= new_instance_of (dynamic_type_from_string (type))
			an_object.default_create
			if passed then
				passed := feature {ISE_RUNTIME}.check_assert (True)
			end
			Result := an_object
		ensure
			result_not_void: Result /= Void
		end
		
	display_invalid_drop_message (obj2: GB_OBJECT; new_type: STRING; does_accept_child: BOOLEAN) is
			-- Display message in status bar indicating the invalid drop status of `obj2'.
			-- `new_type' is the type of the transported object, and `does_accept_child' is
			-- result of last call to `override_drop_on_child' which is False if the child is
			-- of the wrong type to be contained.
		require
			target_not_void: obj2 /= Void
			new_type_not_empty: new_type /= Void and not (new_type.count = 0)
		local
			status_start: STRING
		do
			if application.shift_pressed then
				status_start := "Parent of p"
			else
				status_start := "P"
			end
			if obj2.is_full and obj2.children.count = 0 then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children.")
			elseif not does_accept_child then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children of type " + new_type + ".")
			elseif obj2.is_full then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") is full.")
			end
		end
		
		
	display_parent_in_child_message (obj1, obj2: GB_OBJECT; new_type: STRING) is
			-- Display message in status bar indicating that `ob1' cannot be parented
			-- in `obj2' as `ob2' is `obj1' or is parent of `obj1'.
		require
			obj1_not_void: obj1 /= Void
			obj2_not_void: obj2 /= Void
			new_type_not_void: new_type /= Void
		do
			if obj1 = obj2 then
				set_status_text ("Cannot parent " + new_type + " in itself.")
			else
				set_status_text ("Cannot parent " + new_type + " in one of its children.")
			end
		end
		
	add_child (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to child list of `Current'.
		require
			an_object_not_void: an_object /= Void
			valid_insert_position: position >= 0 and position <= children.count + 1
			not_contained: not children.has (an_object)
		do
			children.go_i_th (position)
			children.put_left (an_object)
			an_object.set_parent (Current)
		ensure
			contained: children.has (an_object)
		end
		
	ensure_names_unique (an_object: GB_OBJECT) is
			-- Ensure that name of `an_object' is unique, and does not
			-- clash with any feature names also.
		require
			object_not_void: an_object /= Void
		local
			temp_name, original_name: STRING
			counter: INTEGER
		do
			if not an_object.name.is_empty then
				from
					original_name := an_object.name
					temp_name := original_name
					counter := 1
				until
					not object_handler.string_is_feature_name (temp_name, top_level_parent_object) and
					not object_handler.string_is_object_name (temp_name, top_level_parent_object, False)
				loop
					temp_name := original_name + counter.out
					counter := counter + 1
				end
				an_object.set_name (temp_name)	
			end
		end
		
	internal_shallow_flatten (current_object, associated_object: GB_OBJECT) is
			-- Recursively flatten all instance representations of `Current' object to `associated_object' if the
			-- current structure is not a representation of another top level object. If it is, reconnect
			-- all instance referers in the `current_object' structure to those in the `associated_object' structure.
		require
			current_object_not_void: current_object /= Void
			associated_object_not_void: associated_object /= Void
			current_object.children.count = associated_object.children.count
		local
			current_object_children, associated_object_children: ARRAYED_LIST [GB_OBJECT]
			current_item, current_associated_item: GB_OBJECT
		do
			if current_object.associated_top_level_object /= 0 then
				current_object.remove_associated_top_level_object
				current_object.connect_display_object_events
				current_object.represent_as_non_locked_instance
				current_object.update_representations_for_name_or_type_change
			end
			associated_object.instance_referers.remove (current_object.id)
			
			current_object_children := current_object.children
			associated_object_children := associated_object.children
			from
				current_object_children.start
				associated_object_children.start
			until
				current_object_children.off
			loop
				current_item := current_object_children.item
				current_associated_item := associated_object_children.item			
				if current_associated_item.associated_top_level_object > 0 then
						-- If the current associated object has a reference to a top level object then we must
						-- set the current object as an association to this top level object directly.
					current_item.set_associated_top_level_object (object_handler.deep_object_from_id (current_associated_item.associated_top_level_object))
					connect_instance_referers (object_handler.deep_object_from_id (current_associated_item.associated_top_level_object), current_item)
					
						-- Ensure that the representations are updated to reflect the fact that they are locked.
					current_item.represent_as_locked_instance
					current_item.update_representations_for_name_or_type_change
				else
					internal_shallow_flatten (current_item, current_associated_item)
				end
				
				associated_object_children.forth
				current_object_children.forth
			end
		ensure
			current_object_is_not_top_level_instance: not current_object.is_instance_of_top_level_object
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation

	remove_child_from_children (an_object: GB_OBJECT) is
			-- Remove `an_object' from `Current'.
		require
			object_not_void: an_object /= Void
		do
			children.prune_all (an_object)
			an_object.set_parent (Void)
		ensure
			object_not_parented: an_object.parent_object = Void
		end
		
	update_object_as_instance_representation is
			-- Update `Current' to reflect the fact that it is a representation
			-- of another top level object, only if `associated_top_level_object' > 0.
		local
			l_object: GB_OBJECT
			all_children: ARRAYED_LIST [GB_OBJECT]
			current_parent: GB_OBJECT
			inside_nested: BOOLEAN
		do
			if associated_top_level_object_on_loading > 0 then
					-- Retrieve the object which `Current' represents.
				l_object := object_handler.object_from_id (associated_top_level_object_on_loading)
					-- Now reset `associated_top_level_object_on_loading'.
				associated_top_level_object_on_loading := 0
				check
					object_not_void: object /= Void
				end
					
				from
					current_parent := parent_object	
				until
					current_parent = Void or inside_nested
				loop
					if current_parent.associated_top_level_object > 0 or
					current_parent.associated_top_level_object_on_loading > 0 then
						inside_nested := True
					end
					current_parent ?= current_parent.parent_object
				end
					-- Check that we only perform the connection if we are not a nested within
					-- another top level object. This is because when we add the referers of a top level nested object
					-- it includes all internal referers, and this connection (if inside a top level object) is performed
					-- when the top level object has its referers connected.
				if not inside_nested then
						-- Add `Current' as an instance referer of `l_object'.
					l_object.instance_referers.extend (Current.id, Current.id)
					connect_instance_referers (l_object, Current)
				end

					-- Set `l_object' as the top object `Current' represents.
				set_associated_top_level_object (l_object)
				represent_as_locked_instance
				update_representations_for_name_or_type_change
				
				
					-- Now update the builder window representations of all children recursively so that
					-- a user may not build directly within them as they should be locked.
				unconnect_display_object_drop_events
				create all_children.make (50)
				all_children_recursive (all_children)
				from
					all_children.start
				until
					all_children.off
				loop
					all_children.item.unconnect_display_object_drop_events
					all_children.item.unconnect_display_object_pick_events
					all_children.forth
				end
			end
		ensure
			associated_object_set: old associated_top_level_object_on_loading > 0 implies associated_top_level_object = old associated_top_level_object_on_loading
			original_associated_object_reset: associated_top_level_object_on_loading = 0
		end
		
feature {NONE} -- Contract support

	instance_referers_recursively_unique (an_object: GB_OBJECT; current_result: BOOLEAN_REF; ids: HASH_TABLE [INTEGER, INTEGER]): BOOLEAN is
			-- Are all instance referers reachable recursively from `an_object' all unique? Pass `current_result' as False and an empty `ids'
			-- to use
		require
			object_not_void: an_object /= Void
			current_result_not_void: current_result /= Void
			ids_not_void: ids /= Void
		local
			list: ARRAYED_LIST [INTEGER]
			referred_object: GB_OBJECT
		do
			list := an_object.instance_referers.linear_representation
			from
				list.start
			until
				list.off
			loop
				if ids.has (list.item) then
					current_result.set_item (False)
				else
					ids.extend (list.item, list.item)
				end
				referred_object := object_handler.deep_object_from_id (list.item)
				if referred_object /= Void then
					Result := instance_referers_recursively_unique (referred_object, current_result, ids)
				end
				list.forth
			end
			Result := current_result
		end
		
feature {GB_EV_EDITOR_CONSTRUCTOR} -- Implementation

	real_display_object: EV_ANY is
			-- Actual Vision2 obejct used by `display_object'. We need this query,
			-- as some descendents redefined `display_object' and build a small widget
			-- structure to represent it.
		do
			Result := display_object
		ensure
			Result_not_void: Result /= Void
		end

invariant
	children_not_void: children /= Void
	instance_referers_not_void: instance_referers /= Void
	constants_not_void: constants /= Void
	events_not_void: events /= Void
	top_level_object_has_window_selector_item: is_top_level_object implies (window_selector_item /= Void)
	instance_referers_recursively_unique: object_handler.objects.has (id) implies instance_referers_recursively_unique (Current, True, create {HASH_TABLE [INTEGER, INTEGER]}.make (10))
-- Cannot check this at the moment as when the `associated_top_level_object' is set, the other link is performed seperately. Check calls of `new_top_level_representation'.
--	bi_directional_top_level_object_link: is_instance_of_top_level_object and object_handler.deep_object_from_id (associated_top_level_object) /= Void implies object_handler.deep_object_from_id (associated_top_level_object).instance_referers.has (id)

-- Not True, any object within the structure may have instance referers, as properties must be updated.
--	only_top_level_objects_have_instance_referers: not is_top_level_object implies instance_referers.is_empty


end -- class GB_OBJECT
