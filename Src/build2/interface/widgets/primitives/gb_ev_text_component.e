
indexing
	description: "Objects that manipulate objects of type EV_TEXT_COMPONENT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_COMPONENT
	
	-- The following properties from EV_TEXT_COMPONENT are manipulated by `Current'.
	-- Is_editable - Performed on the real object and the display_object child.

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			set_up_user_events,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_TEXT_COMPONENT
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXT_COMPONENT"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			
			create editable_button.make_with_text ("Is editable?")
			Result.extend (editable_button)
			editable_button.select_actions.extend (agent set_is_editable)
			editable_button.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			editable_button.select_actions.block
			
			if first.is_editable then
				editable_button.enable_select
			else
				editable_button.disable_select
			end
			
			editable_button.select_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if not first.is_editable then
				add_element_containing_string (element, Is_editable_string, False_string)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_editable_string)
			if element_info /= Void and then element_info.data.is_equal (False_string) then
				for_all_objects (agent {EV_TEXT_COMPONENT}.disable_edit)	
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name, a_type: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Is_editable_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := a_name + ".enable_edit"
				else
					Result := a_name + ".disable_edit"
				end
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	set_up_user_events (vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
		do
			user_event_widget := vision2_object
			objects.extend (an_object)
			objects.extend (vision2_object)
			user_event_widget.change_actions.force_extend (agent start_timer)
		end	
	
	start_timer is
			-- Start a timer, which is used as a delay between an event begin
			-- received by `user_event_widget' and `check_state'.
		local
			timer: EV_TIMEOUT
		do
			create timer.make_with_interval (10)
			timer.actions.extend (agent check_state)
			timer.actions.extend (agent timer.destroy)
		end
		
	check_state is
			-- Update the display window representation of
			-- the gauge, to reflect change from user.
		do
			objects.first.set_text (user_event_widget.text)
			update_editors
		end
		
	user_event_widget: like ev_type
		-- Used to handle the events on the builder window.
		
	set_is_editable is
			-- Update editable status for all objects to reflect `editable_button'.
		do
			if editable_button.is_selected then
				for_all_objects (agent {EV_TEXT_COMPONENT}.enable_edit)
			else
				for_all_objects (agent {EV_TEXT_COMPONENT}.disable_edit)
			end
		end
		
	editable_button: EV_CHECK_BUTTON
		-- Used to control is_editable state.
	
	Is_editable_string: STRING is "Is_editable"

end -- class GB_EV_TEXT_COMPONENT