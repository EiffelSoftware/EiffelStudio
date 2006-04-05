indexing
	description: "Object representing a Build object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT

inherit

	GB_XML_OBJECT_BUILDER
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

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end

feature {GB_OBJECT_HANDLER} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_type (a_type: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with type `a_type' and assign `a_components' to `components'.
			-- Do not instantiate `object' from type.
		require
			a_type_not_void: a_type /= Void
			a_components_not_void: a_components /= Void
		do
			components := a_components
			type := a_type
				-- The names should never be `Void'.
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create instance_referers.make (0)
			create all_client_representations.make (0)
			create edited_name.make (0)
			expanded_in_box := True
			create children.make (0)
		ensure
			type_assigned: type = a_type
			components_set: components = a_components
		end

	make_with_type_and_object (a_type: STRING; an_object: EV_ANY; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', attach `an_object' to `object',
			-- `a_type' to `type' and `a_components' to `components'.
		require
			a_type_not_void: a_type /= Void
			an_object_not_void: an_object /= Void
			type_matches_object: type_matches_object (a_type, an_object)
			a_components_not_void: a_components /= Void
		do
			components := a_components
			object := an_object
			type := a_type
			build_display_object
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create edited_name.make (0)
			create children.make (0)
			create all_client_representations.make (0)
			expanded_in_box := True
			id := components.id_handler.new_id
		ensure
			type_assigned: type = a_type
			object_assigned: object = an_object
			components_set: components = a_components
		end

feature -- Access

	id: INTEGER
		-- A unique id representing `Current'.
		-- This is stored in the XML.

	is_top_level_object: BOOLEAN is
			-- Is `Current' a top level object in the structure?
			-- i.e. is it represented by an individual class?
		do
			Result := widget_selector_item /= Void
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

	widget_selector_item: GB_WIDGET_SELECTOR_ITEM
		-- Representation of `Current' in `widget_selector'.

	all_client_representations: ARRAYED_LIST [EV_TREE_ITEM]
		-- All representations of `Current' in the client hierarchy of the `widget_selector'.

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

	generate_as_client: BOOLEAN
		-- Should `Current' be generated as a client of the EiffelVision2 type?

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
		local
			cursor: CURSOR
		do
			cursor := children.cursor
			from
				children.start
			until
				children.off
			loop
				a_list.extend (children.item)
				children.item.all_children_recursive (a_list)
				children.forth
			end
			children.go_to (cursor)
		ensure
			children_index_not_changed: old children.index = children.index
		end

	new_copy: GB_OBJECT is
			-- `Result' is a copy of `Current' with no link to the original.
		local
			xml_store: GB_XML_STORE
			a_list: ARRAYED_LIST [GB_OBJECT]
		do
			create xml_store.make_with_components (components)
			xml_store.store_individual_object (Current)
			Result := new_object (xml_store.last_stored_individual_object, True)
					-- Modify id of `Result' so that it is not the same as that of `Current'.
			create a_list.make (20)
			Result.all_children_recursive (a_list)
			Result.set_id (components.id_handler.new_id)
			components.object_handler.add_object_to_objects (Result)
			from
				a_list.start
			until
				a_list.off
			loop
				a_list.item.set_id (components.id_handler.new_id)
				components.object_handler.add_object_to_objects (a_list.item)

				a_list.forth
			end
		end

	new_top_level_representation: GB_OBJECT is
			-- `Result' is a copy of `Current' with a new set of id's, representing
			-- an instance of a top level widget.
		local
			xml_store: GB_XML_STORE
			a_list: ARRAYED_LIST [GB_OBJECT]
		do
			create xml_store.make_with_components (components)
			xml_store.store_individual_object (Current)
			Result := new_object (xml_store.last_stored_individual_object, True)

				-- Modify id of `Result' so that it is not the same as that of `Current'.
			create a_list.make (20)
			Result.all_children_recursive (a_list)
			Result.set_id (components.id_handler.new_id)
				-- Only add `Result' to objects now that we have the new id.
			components.object_handler.add_object_to_objects (Result)

				-- Ensure that the new locked object cannot have objects inserted through it's `display_object'.
				-- Note that you can still pick the object as we do not unconnect the pick events are we do for all
				-- children recursively.
			Result.unconnect_display_object_drop_events
			from
				a_list.start
			until
				a_list.off
			loop
				a_list.item.set_id (components.id_handler.new_id)
				components.object_handler.add_object_to_objects (a_list.item)

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

	new_top_level_representation_strict: GB_OBJECT is
			-- `Result' is a newly built version of `Current' with all ids
			-- identical to the originals. This completely replaces `Current'
			-- which must be destroyed. Note this is as of yet untested for
			-- window objects, and it is unlikely that it will work.
		local
			xml_store: GB_XML_STORE
			a_list: ARRAYED_LIST [GB_OBJECT]
			old_object, old_child_object: GB_OBJECT
			original_children: ARRAYED_LIST [GB_OBJECT]
			a_new_object: GB_OBJECT
			iterated_referer: INTEGER
		do
			create original_children.make (50)
			all_children_recursive (original_children)
			create xml_store.make_with_components (components)
			xml_store.store_individual_object (Current)
			Result := new_object (xml_store.last_stored_individual_object, True)

				-- Modify id of `Result' so that it is not the same as that of `Current'.
			create a_list.make (20)
			Result.all_children_recursive (a_list)
				-- Only add `Result' to objects now that we have the new id.
			old_object := components.object_handler.deep_object_from_id (Result.id)
			check
				old_object_is_current: old_object = Current
			end
			components.object_handler.objects.remove (Result.id)
			components.object_handler.deleted_objects.remove (Result.id)
			components.object_handler.add_object_to_objects (Result)
			from
				old_object.instance_referers.start
			until
				old_object.instance_referers.off
			loop
				Result.instance_referers.put (old_object.instance_referers.item_for_iteration, old_object.instance_referers.item_for_iteration)
				old_object.instance_referers.forth
			end
			check
				old_and_new_children_match: original_children.count = a_list.count
			end
			from
				a_list.start
				original_children.start
			until
				a_list.off
			loop
				old_child_object := original_children.item
				a_new_object := a_list.item
				from
					old_child_object.instance_referers.start
				until
					old_child_object.instance_referers.off
				loop
					iterated_referer := old_child_object.instance_referers.item_for_iteration
					a_new_object.instance_referers.put (iterated_referer, iterated_referer)
					old_child_object.instance_referers.forth
				end
				check
					instance_referers_equal: a_new_object.instance_referers.count = old_child_object.instance_referers.count
				end
				a_list.forth
				original_children.forth
			end

				-- Ensure that the new locked object cannot have objects inserted through it's `display_object'.
				-- Note that you can still pick the object as we do not unconnect the pick events are we do for all
				-- children recursively.
			Result.unconnect_display_object_drop_events
			from
				a_list.start
			until
				a_list.off
			loop
				components.object_handler.objects.remove (a_list.item.id)
				components.object_handler.deleted_objects.remove (a_list.item.id)
				components.object_handler.add_object_to_objects (a_list.item)

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

				-- We must check that we are actually an instance of a top level object, as otherwise if
				-- we have nested representations, it does not need to be done.
			if is_instance_of_top_level_object then
				Result.set_associated_top_level_object (components.object_handler.deep_object_from_id (associated_top_level_object))
					-- Ensure that all representations of `Result' reflect this change.
				Result.update_representations_for_name_or_type_change
			end

				-- Now destroy all of the original objects that used to represent `Current' as
				-- they are no longer required. If this is not performed, there are
				-- GDI leaks on Windows.
			old_object.destroy
			from
				original_children.start
			until
				original_children.off
			loop
				original_children.item.destroy
				original_children.forth
			end
		ensure
			object_handler_objects_not_changed: old components.object_handler.objects = components.object_handler.objects and
				old components.object_handler.deleted_objects = components.object_handler.deleted_objects
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
			layout_item.pointer_double_press_actions.force_extend (agent (components.tools.layout_constructor).target_associated_top_object (Current))
		ensure
			chidren_index_not_changed: old children.index = children.index
			layout_item_empty: layout_item.count = 0
			layout_item_has_data: layout_item.data /= Void
		end

	represent_as_non_locked_instance is
			-- Ensure pixmap representation of `Current' is not that of a locked type.
		local
			cursor: CURSOR
		do
			layout_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name (type.as_lower).twin)
			layout_item.set_data (Void)
			layout_item.pointer_button_press_actions.wipe_out
			cursor := children.cursor
			from
				children.start
			until
				children.off
			loop
				if children.item.layout_item.parent = Void then
					layout_item.extend (children.item.layout_item)
				end
				children.forth
			end
			children.go_to (cursor)
		ensure
			chidren_index_not_changed: old children.index = children.index
			layout_item_children_set: layout_item.count = children.count
			layout_item_has_not_data: layout_item.data = Void
		end

	connect_instance_referers (original_object, instance_object:GB_OBJECT) is
			-- Recursively add a similar referring link from evey child in `original_object'
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
				current_object := components.object_handler.deep_object_from_id (instance_referers.item_for_iteration)
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
				current_object := components.object_handler.deep_object_from_id (instance_referers.item_for_iteration)
				p.call ([current_object.object])
				current_object.update_instances (p)
				instance_referers.forth
			end
		end

	actual_type: STRING is
			-- `Result' is type of `an_object'.
		do
			if is_instance_of_top_level_object then
				Result := components.object_handler.deep_object_from_id (associated_top_level_object).name.as_upper
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
		local
			a_display_object: GB_DISPLAY_OBJECT
		do
				-- Note that both `layout_item' or `widget_selector_item' may be reparented to
				-- another object, so if this is the case, do nothing.
			if layout_item.object = Current then
				layout_item.destroy
			end
			if widget_selector_item /= Void and then widget_selector_item.object = Current then
				widget_selector_item.destroy
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
				-- Destroy the EiffelVision2 objects representing `Current'.
			object.destroy
			object := Void
			a_display_object ?= display_object
			if a_display_object /= Void then
				a_display_object.child.destroy
			end
			display_object.destroy
			display_object := Void
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

feature {GB_OBJECT, GB_OBJECT_HANDLER, GB_COMMAND_ADD_OBJECT, GB_COMMAND_CONVERT_TO_TOP_LEVEL, GB_COMMAND_FLATTEN_OBJECT} -- Status Setting

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
			associated_top_level_object_on_loading := 0
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

feature {GB_XML_STORE, GB_XML_LOAD, GB_XML_OBJECT_BUILDER, GB_XML_IMPORT} -- XML handling

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of specific attributes of `Current'
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
			if generate_as_client then
				add_element_containing_boolean (element, client_string, generate_as_client)
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
			element_info ?= full_information @ client_string
			if element_info /= Void then
				enable_client_generation
			end
		end

feature {GB_LAYOUT_CONSTRUCTOR_ITEM, GB_OBJECT_HANDLER, GB_WIDGET_SELECTOR, GB_COMMAND} -- Status setting

	set_layout_item (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Assign `a_layout_item' to `layout_item'.
		require
			layout_item_not_void: a_layout_item /= Void
		do
			layout_item ?= a_layout_item
			layout_item.set_object (Current)
			build_drop_actions_for_layout_item (layout_item)
			layout_item.set_pebble_function (agent retrieve_pebble)
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
			components.system_status.mark_as_dirty
		ensure
			not_contained: not children.has (an_object)
		end

feature {GB_OBJECT_EDITOR, GB_PROJECT_SETTINGS} -- Status setting

	enable_client_generation is
			-- Ensure `Current' is generated using EiffelVision2 as a client.
		do
			generate_as_client := True
		end

	disable_client_generation is
			-- Ensure `Current' is generated inheriting from EiffelVision2.
		do
			generate_as_client := False
		end

feature {GB_OBJECT_HANDLER, GB_ID_COMPRESSOR} -- Status setting

	assign_id is
			-- Assign a new `id' to `Current'.
		require
			id_not_assigned: id = 0
		do
			id := components.id_handler.new_id
		ensure
			id_set: id >= 0
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_BUILDER_WINDOW, GB_WIDGET_SELECTOR_ITEM, GB_PASTE_OBJECT_COMMAND} -- Element change

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
			local_parent_object: GB_OBJECT
			new_short_type, new_type: STRING
			funct_result: BOOLEAN
			color_stone: GB_COLOR_STONE
			colorizeable: EV_COLORIZABLE
			an_object_stone: GB_OBJECT_STONE
			standard_object_stone: GB_STANDARD_OBJECT_STONE
		do
			color_stone ?= object_representation
			if color_stone /= Void then
				colorizeable ?= object
				Result := colorizeable /= Void
			else
				an_object_stone ?= object_representation
				new_type := an_object_stone.object_type
				new_short_type := new_type.substring (4, new_type.count)
				Result := True

				create env
					-- If shift is pressed `object_representation' must be added to the parent.
				if env.application.shift_pressed and not an_object_stone.is_instance_of_top_level_object then
					local_parent_object := parent_object
				else
					local_parent_object := Current
				end
					-- Firstly, ensure that we do not drop an object into a representation of a top level object.
				if local_parent_object /= Void and then local_parent_object.is_instance_of_top_level_object then
					Result := False
					components.status_bar.set_status_text ("Cannot parent object in locked instance of " + components.object_handler.deep_object_from_id (local_parent_object.associated_top_level_object).name)
				end

				if Result and an_object_stone /= Void then
					Result := has_clashing_dependencies (an_object_stone)
					if not Result then
						components.status_bar.set_status_text (cyclic_inheritance_error)
					end
				end

					-- If we are at the top level and shift is pressed, there is no parent.
				if Result and local_parent_object /= Void then
					Result := not local_parent_object.is_full
							-- We only need to check this if we are not a component,
							-- as this means there is no way we could be contained in `Current'.
					standard_object_stone ?= an_object_stone
					if standard_object_stone /= Void then
						funct_result := local_parent_object.override_drop_on_child (standard_object_stone.object)
						if not funct_result then
								-- Now display output if we are attempting to insert the object in itself
								-- or one of its children.
							display_parent_in_child_message (standard_object_stone.object, local_parent_object, new_type)
						end
						Result := Result and funct_result
					end
					funct_result := local_parent_object.accepts_child (new_type)
						-- We now display information in status bar regarding full status.
					display_invalid_drop_message (local_parent_object, new_short_type, funct_result)
					Result := Result and funct_result
				else
					Result := False
				end
				if Result then
					components.status_bar.clear_status_bar
				end
			end
		end

	has_clashing_dependencies (an_object_stone: GB_OBJECT_STONE): BOOLEAN is
			-- Does `an_object_stone' represent an object that has nested dependencies so
			-- that if it were inserted within `Current' it would cause a cyclic inheritance
			-- hierarchy?
		require
			an_object_stone_not_void: an_object_stone /= Void
		local
			all_dependents: HASH_TABLE [GB_OBJECT, INTEGER]
			actual_object: GB_OBJECT
			instance_objects: HASH_TABLE [INTEGER, INTEGER]
		do
			Result := True
			create all_dependents.make (4)
			instance_objects := an_object_stone.all_contained_instances
			from
				instance_objects.start
			until
				instance_objects.off
			loop
				actual_object := components.object_handler.deep_object_from_id (instance_objects.item_for_iteration)
				all_dependents.clear_all
				all_dependents_recursive (actual_object, all_dependents)
				all_dependents.put (actual_object, actual_object.id)
				from
					all_dependents.start
				until
					all_dependents.off
				loop
					all_dependents.forth
				end
				Result := Result and not all_dependents.has (Current.id)
				instance_objects.forth
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
			cursor: CURSOR
		do
			cursor := an_object.children.cursor
			from
				an_object.children.start
			until
				an_object.children.off
			loop
				current_object := an_object.children.item

				if current_object.is_instance_of_top_level_object then
					dependent_object := components.object_handler.deep_object_from_id (current_object.associated_top_level_object)
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
			an_object.children.go_to (cursor)
		ensure
			children_index_not_changed: old an_object.children.index = an_object.children.index
		end

	create_layout_item is
			-- Create a layout_item associated with `Current'.
		require
			no_layout_item_associated: layout_item = Void
		do
			create layout_item.make (Current, components)
			build_drop_actions_for_layout_item (layout_item)
		ensure
			lyout_item_initialized: layout_item /= Void
			layout_item_not_parented: layout_item.parent = Void
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT, GB_PASTE_OBJECT_COMMAND} -- Access

	accepts_child (a_type: STRING):BOOLEAN is
			-- Does `Current' accept `an_object'.
			-- Redefine in descendents to allow children
			-- of correct type to be added.
		require
			type_not_void: a_type /= Void
		do
			Result := False
		end

feature {GB_INPUT_FIELD, GB_EV_ANY, GB_EV_EDITOR_CONSTRUCTOR} -- Basic operations

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
			components.object_handler.recursive_do_all (an_object, agent ensure_names_unique (?))
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
			an_object_index, an_index: INTEGER
		do
			insert_position := parent_object.children.index_of (Current, 1)

				-- We must now check that the item being inserted before is not contained in the same parent as `Current'.
				-- If this is the case, and the item is before `Current' in the parent, then we must use an insert_position
				-- one less than normal.
			if parent_object.children.has (an_object) then
				an_object_index := parent_object.children.index_of (an_object, 1)
				an_index := parent_object.children.index_of (Current, 1)
				if an_object_index < an_index and then insert_position <= an_index then
					insert_position := insert_position - 1
				end
			end
			create command_add.make (parent_object, an_object, insert_position, components)
			command_add.execute
		ensure
			object_contained_if_not_top_level: not an_object.is_top_level_object implies parent_object.children.has (an_object)
			children_count_increased: old an_object.parent_object /= parent_object implies parent_object.children.count = old parent_object.children.count + 1
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
			components.object_handler.recursive_do_all (an_object, agent ensure_names_unique (?))
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
				create command_add.make (Current, an_object,layout_item.count, components)
			else
				create command_add.make (Current, an_object, layout_item.count + 1, components)
			end
			command_add.execute
				-- Now we expand the layout item.
			if layout_item.is_expandable and not layout_item.is_expanded then
				layout_item.expand
			end
		ensure
			object_contained_if_not_top_level: not an_object.is_top_level_object implies children.has (an_object)
			children_count_increased: old an_object.parent_object /= Current implies children.count = old children.count + 1
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

feature {GB_ID_COMPRESSOR, GB_OBJECT} -- Basic operations

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
				instance_referers.put (conversion_data @ linear.item, conversion_data @ linear.item)
				linear.forth
			end
			if is_instance_of_top_level_object then
				associated_top_level_object := conversion_data @ associated_top_level_object
			end
		ensure
			conversion_completed: id = conversion_data.item (old id)
			-- All instance referers converted also. Not easy to write as a postcondition.
		end

feature {GB_COMMAND, GB_OBJECT_HANDLER, GB_OBJECT, GB_WIDGET_SELECTOR} -- Basic operation

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
			if is_top_level_object then
				layout_item.set_text (name.as_upper)
			else
				layout_item.set_text (name_and_type)
			end
			if is_top_level_object then
					-- Update the widget selector item name.
				widget_selector_item.update_to_reflect_name_change
			end
			from
				all_client_representations.start
			until
				all_client_representations.off
			loop
					-- FIXME This "if" statement is a bit of a hack.
					-- The client representation does not have a reference back to its `object'
					-- so we are unable to know if we are a top level object or not. We simply rely
					-- on the structure of the client heirarchy to determine this, as a top level client
					-- item must always have at least one child, while the children may have none.
				if all_client_representations.item.count > 0  then
					all_client_representations.item.set_text (name.as_upper)
				else
					all_client_representations.item.set_text (name_and_type)
				end
				all_client_representations.forth
			end
		end

feature {GB_OBJECT_HANDLER, GB_TITLED_WINDOW_OBJECT, GB_OBJECT, GB_LAYOUT_CONSTRUCTOR_ITEM, GB_COMMAND_FLATTEN_OBJECT} -- Implementation

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
				pick_and_dropable.drop_actions.extend (agent handle_object_drop (?))
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
				components.tools.Layout_constructor.highlight_object (create {GB_STANDARD_OBJECT_STONE}.make_with_object (Current))
			elseif application.ctrl_pressed then
					-- If the ctrl key is pressed, then we must
					-- start a new object editor for `Current', instead
					-- of beginning the pick and drop.
				components.object_editors.new_object_editor (Current)
			else
				Result := create {GB_STANDARD_OBJECT_STONE}.make_with_object (Current)
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
					gb_ev_any.set_components (components)
					gb_ev_any.default_create
					if gb_ev_any.has_user_events then
						gb_ev_any.set_up_user_events (Current, a_display_object, an_object)
					end
				end
				supported_types.forth
			end
		end

feature {GB_OBJECT, GB_PASTE_OBJECT_COMMAND} -- Implementation

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
					if components.object_handler.object_contained_in_object (an_object, Current) or
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

feature {GB_WIDGET_SELECTOR_ITEM, GB_GENERAL_UTILITIES} -- Implementation

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

feature {GB_LAYOUT_CONSTRUCTOR, GB_OBJECT_HANDLER, GB_OBJECT} -- Implementation

	build_drop_actions_for_layout_item (tree_item: EV_TREE_ITEM) is
			-- Build the drop actions for the layout item.
			-- Wipe out any existing actions.
		require
			tree_item_not_void: tree_item /= Void
		do
			tree_item.drop_actions.wipe_out
			tree_item.drop_actions.extend (agent handle_object_drop (?))
			tree_item.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end

feature {GB_BUILDER_WINDOW, GB_WIDGET_SELECTOR_ITEM} -- Implementation

	handle_object_drop (object_pebble: GB_OBJECT_STONE) is
			--
		local
			component_pebble: GB_COMPONENT_OBJECT_STONE
		do
			component_pebble ?= object_pebble
			if component_pebble /= Void then
				add_new_component_wrapper (component_pebble.component)
			else
				add_new_object_wrapper (object_pebble.object)
			end
		end

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
			if components.digit_checker.digit_pressed then
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
					counter > components.digit_checker.digit or object_full
				loop
					a_new_object := components.object_handler.build_object_from_string_and_assign_id (new_type)
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

feature {GB_WIDGET_SELECTOR_ITEM, GB_OBJECT_HANDLER} -- Implementation

	set_widget_selector_item (a_widget_selector_item: GB_WIDGET_SELECTOR_ITEM) is
			-- Assign `a_widget_selector_item' to `widget_selector_item'.
		require
			item_not_void: a_widget_selector_item /= Void
		do
			widget_selector_item := a_widget_selector_item
			widget_selector_item.set_object (Current)
		ensure
			item_set: widget_selector_item = a_widget_selector_item
			widget_selector_item_object_set: widget_selector_item.object = Current
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_COMMAND, GB_WIDGET_SELECTOR} -- Implementation

	add_client_representation (client_object: GB_OBJECT) is
			-- Add a client representation for `client_object' to the `widget_selector_item'
			-- which it is a representation.
		require
			is_top_level_object: is_top_level_object
			client_object_not_void: client_object /= void
			client_object_is_instance_of_current: client_object.associated_top_level_object = id
			parented_correctly: client_object.top_level_parent_object /= client_object
		local
			tree_item: EV_TREE_ITEM
			pixmap, l_pixmap: EV_PIXMAP
			client_item: EV_TREE_ITEM
			parent_item: EV_TREE_ITEM
			top_object: GB_OBJECT
		do
			if widget_selector_item.tree_item.is_empty then
				create client_item.make_with_text ("Clients")
				client_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_format_clients_color"))
				widget_selector_item.tree_item.extend (client_item)
			else
				client_item ?= widget_selector_item.tree_item.first
			end
			top_object := client_object.top_level_parent_object
			parent_item ?= client_item.retrieve_item_by_data (top_object.id, True)
			if parent_item = Void then
				create parent_item.make_with_text (top_object.name.as_upper)
				top_object.all_client_representations.extend (parent_item)
				parent_item.set_pixmap ((create {GB_SHARED_PIXMAPS}).pixmap_by_name (top_object.type.as_lower).twin)
				parent_item.set_data (top_object.id)
				parent_item.select_actions.extend (agent select_client_object (top_object))
				parent_item.set_pebble_function (agent top_object.retrieve_pebble)
				top_object.build_drop_actions_for_layout_item (parent_item)
				add_to_tree_node_alphabetically (client_item, parent_item)
			end
			check
				not_already_contained: parent_item.retrieve_item_by_data (client_object.id, True) = Void
			end
			pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_locked_color")
			l_pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name (type.as_lower).twin
			l_pixmap.draw_sub_pixmap (0, 0, pixmap, create {EV_RECTANGLE}.make (0, 0, pixmap.width, pixmap.height))
			create tree_item.make_with_text (name_and_type_from_object (client_object))
			client_object.all_client_representations.extend (tree_item)
			tree_item.set_data (client_object.id)
			tree_item.set_pixmap (l_pixmap)
			tree_item.set_pebble_function (agent client_object.retrieve_pebble)
			tree_item.select_actions.extend (agent select_client_object (client_object))
			client_object.build_drop_actions_for_layout_item (tree_item)
			parent_item.extend (tree_item)
			if client_item.is_expanded then
				check
					parent_item_is_expandable: parent_item.is_expandable
				end
				parent_item.expand
			end
		end

	select_client_object (client_object: GB_OBJECT) is
			-- Select `client_object' within `layout_constructor'.
		require
			client_object_not_void: client_object /= Void
		local
			client_top_level_parent: GB_OBJECT
		do
			if not client_object.layout_item.is_selectable then
				client_top_level_parent := client_object.top_level_parent_object
				components.tools.layout_constructor.set_root_window (client_top_level_parent)
				components.tools.widget_selector.update_display_and_builder_windows (client_top_level_parent)
			end
			client_object.layout_item.enable_select
		end

	remove_client_representation_recursively is
			-- Remove all client representations from `Current' and all children
			-- recursively.
		local
			cursor: CURSOR
		do
			if is_instance_of_top_level_object then
				components.object_handler.deep_object_from_id (associated_top_level_object).remove_client_representation (Current)
			else
				cursor := children.cursor
				from
					children.start
				until
					children.off
				loop
					children.item.remove_client_representation_recursively
					children.forth
				end
				children.go_to (cursor)
			end
		ensure
			children_index_not_changed: old children.index = children.index
		end

	add_client_representation_recursively is
			-- Add all client representations for  `Current' and all children
			-- recursively.
		local
			cursor: CURSOR
		do
			if is_instance_of_top_level_object then
				components.object_handler.deep_object_from_id (associated_top_level_object).add_client_representation (Current)
			else
				cursor := children.cursor
				from
					children.start
				until
					children.off
				loop
					children.item.add_client_representation_recursively
					children.forth
				end
				children.go_to (cursor)
			end
		ensure
			children_index_not_changed: old children.index = children.index
		end

	remove_client_representation (client_object: GB_OBJECT) is
			-- Remove a client representation for `client_object' from the `widget_selector_item'
			-- which it is a representation.
		require
			is_top_level_object: is_top_level_object
			client_object_not_void: client_object /= Void
			client_object_is_instance_of_current: client_object.associated_top_level_object = id
		local
			tree_item: EV_TREE_ITEM
			client_item: EV_TREE_ITEM
			parent_item: EV_TREE_ITEM
			top_object: GB_OBJECT
		do
			client_item ?= widget_selector_item.tree_item.first
			if client_item /= Void then
				top_object := client_object.top_level_parent_object
				parent_item ?= client_item.retrieve_item_by_data (top_object.id, True)
				if parent_item /= Void then
					tree_item ?= parent_item.retrieve_item_by_data (client_object.id, True)
					parent_item.prune_all (tree_item)
					check
						representation_contained: client_object.all_client_representations.has (tree_item)
					end
					client_object.all_client_representations.prune_all (tree_item)
					if parent_item.is_empty then
						client_item.prune_all (parent_item)
						check
							representation_contained: top_object.all_client_representations.has (parent_item)
						end
						top_object.all_client_representations.prune_all (parent_item)
						if client_item.is_empty then
							widget_selector_item.tree_item.prune_all (client_item)
						end
					end
				end
			end
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
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			if application.shift_pressed then
				status_start := "Parent of p"
			else
				status_start := "P"
			end
			if obj2.is_full and obj2.children.count = 0 then
				components.status_bar.set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children.")
			elseif not does_accept_child then
				components.status_bar.set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children of type " + new_type + ".")
			else
				titled_window_object ?= obj2
				if titled_window_object /= Void then
					if new_type.is_equal (menu_bar_string) then
						if titled_window_object.object.menu_bar /= Void then
							components.status_bar.set_status_text (status_start + "ointed target (" + obj2.short_type + ") already has a menu bar.")
						end
					elseif obj2.is_full then
						components.status_bar.set_status_text (status_start + "ointed target (" + obj2.short_type + ") is full.")
					end
				elseif obj2.is_full then
					components.status_bar.set_status_text (status_start + "ointed target (" + obj2.short_type + ") is full.")
				end
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
				components.status_bar.set_status_text ("Cannot parent " + new_type + " in itself.")
			else
				components.status_bar.set_status_text ("Cannot parent " + new_type + " in one of its children.")
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
					not components.object_handler.string_is_feature_name (temp_name, top_level_parent_object) and
					not components.object_handler.string_is_object_name (temp_name, top_level_parent_object, False)
				loop
					temp_name := original_name + counter.out
					counter := counter + 1
				end
				an_object.set_name (temp_name)
			end
		end

feature {GB_OBJECT_HANDLER, GB_CLIPBOARD} -- Implementation

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
				l_object := components.object_handler.object_from_id (associated_top_level_object_on_loading)
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
					l_object.instance_referers.put (Current.id, Current.id)
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

					-- Special check required for when calling this feature from
					-- the clipboard. In this situation, the client representation is
					-- added later.
				if top_level_parent_object.widget_selector_item /= Void then--/= Current then
					l_object.add_client_representation (Current)
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
			instance_viewer: GB_INSTANCE_VIEWER
		do
			list := an_object.instance_referers.linear_representation
			from
				list.start
			until
				list.off or current_result = False
			loop
				if ids.has (list.item) then
					current_result.set_item (False)
					if components.system_status.is_in_debug_mode then
						create instance_viewer.make_with_object (components.object_handler.object_from_id (list.item))
					end
				else
					ids.put (list.item, list.item)
				end
				if current_result.item then
					referred_object := components.object_handler.deep_object_from_id (list.item)
					if referred_object /= Void then
						Result := instance_referers_recursively_unique (referred_object, current_result, ids)
					end
				end
				list.forth
			end
			Result := current_result
		end

	instance_referers_nested_strutures_match: BOOLEAN is
			-- Does the nested structure of all instance referers of `Current' match that of `Current'?
		local
			cursor: CURSOR
			current_linear_representation, new_linear_representation: ARRAYED_LIST [GB_OBJECT]
			current_object: GB_OBJECT
		do
			Result := True
			cursor := instance_referers.cursor
			create current_linear_representation.make (20)
			all_children_recursive (current_linear_representation)
			from
				instance_referers.start
			until
				instance_referers.off or Result = False
			loop
				create new_linear_representation.make (20)
				current_object := components.object_handler.deep_object_from_id (instance_referers.item_for_iteration)
				if current_object.parent_object /= Void then

					current_object.all_children_recursive (new_linear_representation)
					if new_linear_representation.count /= current_linear_representation.count then
						Result := False
					else
						check
							counts_equal: new_linear_representation.count = current_linear_representation.count
						end
						from
							new_linear_representation.start
							current_linear_representation.start
						until
							new_linear_representation.off or Result = False
						loop
							if not new_linear_representation.item.type.is_equal (current_linear_representation.item.type) then
								Result := False
							end
							new_linear_representation.forth
							current_linear_representation.forth
						end
					end

				end
				instance_referers.forth
			end
			instance_referers.go_to (cursor)
			if not result then
				do_nothing
			end
		ensure
			index_not_changed: old instance_referers.item_for_iteration = instance_referers.item_for_iteration
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
	all_client_representations_not_void: all_client_representations /= Void
	constants_not_void: constants /= Void
	events_not_void: events /= Void
	top_level_object_has_widget_selector_item: is_top_level_object implies (widget_selector_item /= Void)
	instance_referers_recursively_unique: components.object_handler.objects.has (id) implies instance_referers_recursively_unique (Current, True, create {HASH_TABLE [INTEGER, INTEGER]}.make (10))
	nested_structures_equal: ((not components.system_status.is_object_structure_changing) and (components.object_handler.deleted_objects.item (id) /= Void)) implies instance_referers_nested_strutures_match
-- Cannot check this at the moment as when the `associated_top_level_object' is set, the other link is performed seperately. Check calls of `new_top_level_representation'.
--	bi_directional_top_level_object_link: is_instance_of_top_level_object and components.object_handler.deep_object_from_id (associated_top_level_object) /= Void implies components.object_handler.deep_object_from_id (associated_top_level_object).instance_referers.has (id)

-- Not True, any object within the structure may have instance referers, as properties must be updated.
--	only_top_level_objects_have_instance_referers: not is_top_level_object implies instance_referers.is_empty

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


end -- class GB_OBJECT
