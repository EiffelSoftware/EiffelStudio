indexing
	description: "Objects that manipulate/have knowledge of Vision2 objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ANY
	
	
inherit
	ANY
		redefine
			default_create
		end
		
	GB_SHARED_OBJECT_EDITORS
		
	INTERNAL
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create
		end
		
	GB_SHARED_COMMAND_HANDLER
	
	GB_XML_UTILITIES
		undefine
			default_create
		end

feature -- Initialization
		
	default_create is
			-- Create `Current'.
			-- Create `objects' to hold 2 items.
		do
			create objects.make (2)
		end
		
feature -- Access

	parent_editor: GB_OBJECT_EDITOR
		-- Object editor containing `Current'.
		
	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		deferred
		end
		
	first: like ev_type is
			-- First entry in `objects'. This corresponds to
			-- the display component.
		require
			objects_not_empty: not objects.is_empty
		do
			Result := objects.first
		ensure
			Result_not_void: Result /= Void
		end
		
	initialize_attribute_editor (editor: GB_OBJECT_EDITOR_ITEM) is
			-- Perform necessary initialization on `editor'.
		require
			editor_not_void: editor /= Void
		do
			editor.set_type_represented (type)
			editor.set_creating_class (Current)
		end
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
			-- Redefined in descendents. For example, see
			-- GB_EV_SENSITIVE.
		require
			objects_not_void: objects /= Void
			objects_has_at_least_one_item: objects.count >= 1
		do
			create Result
			Result.set_type_represented (type)
			Result.set_creating_class (Current)
		ensure
			result_not_void: Result /= Void
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		deferred
		end
		

	objects: ARRAYED_LIST [like ev_type]
		-- All objects to which `Current' represents.
		-- Modifications must be made to all items
		-- identically.

feature -- Status setting

	add_object (an_object: like ev_type) is
			-- Add `an_object' to `objects'.
		require
			an_object_not_void: an_object /= Void
		do
			objects.extend (an_object)
		ensure
			objects.has (an_object)
		end
		
	set_parent_editor (an_editor: GB_OBJECT_EDITOR) is
			-- Assign `an_editor' to `parent_editor'.
		require
			an_editor_not_void: an_editor /= Void
		do
		 parent_editor := an_editor
		ensure
			object_editor_assigned: parent_editor = an_editor
		end
		
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		require
			element_not_void: element /= Void
				-- `Current' has been generated dynamically as needed, so there is
				-- no reason for objects to have more than one representation of the
				-- widget that we wish to work with at this point.
			objects_only_has_one_item: objects.count = 1
		deferred
		ensure
				-- Why are we calling generate_xml on an GB_EV_ANY
				-- That does not have any attributes to store?
				-- This ensures we do not.
				-- As we only store the attributes if necessary, this does not hold.
				-- Maybe there is a way we can implement it with some kind of variable
				-- For now, remove.
				--	at_least_one_element_added: element.count > old element.count
		end
		
feature {GB_XML_LOAD, GB_XML_OBJECT_BUILDER} -- Status setting
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		require
			element_not_void: element /= Void
		deferred
		end
		
feature {GB_DEFERRED_BUILDER} -- Status setting
		
	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Redefine in any descendents that must perform part of
			-- their building at the end of the load/build cycle.
			-- Example  - GB_EV_BOX
		do
			-- Does nothing by default
		end

feature {GB_CODE_GENERATOR} -- Status setting

	generate_code (element: XML_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of settings held in `Current' which is
			-- in a compilable format.
			-- `element' is the XML element that contains information about `Current'.
			-- So if `Current' is GB_EV_CONTAINER, `element' is <CONTAINER> in XML.
			-- `info' is info retrieved from the XML during the prepass stage, and contains
			-- all necessary information about the object that `Current' represents.
			-- Note that `info' therefore contains `element' within `supported_type_elements'.
		require
			element_not_void: element /= Void
			info_not_void: info /= Void
			info_contains_element: info.supported_type_elements.has (element)
			info_name_not_empty_if_not_window: not info.type.is_equal (Ev_titled_window_string) implies not info.name.is_empty
			info_name_empty_if_window: info.type.is_equal (Ev_titled_window_string) implies System_status.current_project_settings.client_of_window = not info.name.is_empty
		deferred
		end
		

feature {GB_OBJECT} -- Status setting

	set_up_user_events (vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
			-- Some objects such as EV_TOGGLE_BUTTON can be modified
			-- by the user in the display window. We need to set up events
			-- on `vision2_object' so that we can notify the system that the
			-- change has taken place. There are only a few such events
			-- like these, but we need to be able to handle them.
			-- Does nothing by default, but must be redefined in descendents
			-- where an event must be handled.
		do
			
		end		

feature {NONE} -- Implementation

	ev_type: EV_ANY is
		
		-- Vision2 type represented by `Current'.
		-- Only used with `like' in descendents.
		-- Always `Void'.
		deferred
		end

	for_all_objects (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on every item in `objects'.
		do
			from
				objects.start
			until
				objects.off
			loop
				p.call ([objects.item])
				objects.forth
			end
			enable_project_modified
		end
		
	for_first_object (p: Procedure [EV_ANY, TUPLE]) is
			-- Call `p' on the first_item in `objects'.
		do
			objects.start
			p.call ([objects.item])
			enable_project_modified
		end
		
		
	update_editors is
			-- Short version for calling everywhere.
		do
			update_editors_for_property_change (objects.first, type, parent_editor)			
		end
		
	strip_leading_indent (s: STRING): STRING is
			-- If `s' starts with `indent' then strip this indent.
			-- This is used in the code generation routines.
		do
			if s.substring (1, indent.count).is_equal (indent) then
				Result := s.substring (indent.count + 1, s.count)
			else
				Result := s
			end
		end
		
	enable_project_modified is
			-- Call enable_project_modified on `system_status' and
			-- update commands to reflect this.
		do	
			-- We update the system settings to reflect
			-- the fact that a user modification has taken place.
			-- This enables us to do things such as enable the save
			-- options.
			system_status.enable_project_modified
			command_handler.update
		end

invariant

	ev_type_is_void: ev_type = Void

end -- class GB_EV_ANY
