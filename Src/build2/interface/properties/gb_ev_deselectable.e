indexing
	description: "Objects that manipulate objects of type EV_DESELECTABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_DESELECTABLE
	
	-- The following properties from EV_DESELECTABLE are manipulated by `Current'.
	-- Is_selectable - Performed on the real object and the display_object.

inherit
	GB_EV_ANY
		redefine
			set_up_user_events,
			attribute_editor,
			ev_type
		end
		
	XML_UTILITIES
		undefine
			default_create
		end

feature -- Access


	ev_type: EV_DESELECTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_DESELECTABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			first_object: EV_DESELECTABLE
		do
			Result := Precursor {GB_EV_ANY}
			first_object := objects.first
			create check_button.make_with_text (is_selected_string)
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_selected)
			check_button.select_actions.extend (agent update_editors)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.is_selected then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end
		
	set_up_user_events (vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
		local
			widget: EV_WIDGET
			item: EV_ITEM
		do
			--| For now, just deal with widgets. At some point items may be supported also.
		user_event_widget := vision2_object
		widget ?= vision2_object
		check
			we_are_dealing_with_a_widget: widget /= Void
		end
		io.putstring (widget.out)
		objects.extend (an_object)
		objects.extend (vision2_object)
		widget.pointer_button_release_actions.force_extend (agent start_timer)
		widget.key_release_actions.force_extend (agent start_timer)
		--	io.putstring ("Setting up events for deselctable%N")
	--	vision2_object
		end	
		
		start_timer is
				--
			local
				timer: EV_TIMEOUT
			do
				io.putstring ("Start timer called%N")
				create timer.make_with_interval (10)
				timer.actions.extend (agent check_state)
				timer.actions.extend (agent timer.destroy)
			end
			
		check_state is
				--
			do
				io.putstring ("Check state called%N")
				if user_event_widget.is_selected then
					io.putstring ("Is selected%N")
					objects.first.enable_select
					update_editors
				else
					io.putstring ("Is not selected%N")
					objects.first.disable_select
					update_editors
				end
			end
			
	user_event_widget: like ev_type		
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			new_type_element: XML_ELEMENT
		do
			add_element_containing_boolean (element, is_selected_string, objects.first.is_selected)
		end

	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (is_selected_string)
			if element_info.data.is_equal (True_string) then
				for_all_objects (agent {EV_DESELECTABLE}.enable_select)
			else
				for_all_objects (agent {EV_DESELECTABLE}.disable_select)
			end
		end


feature {NONE} -- Implementation

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_selected is
			-- Update sensitive state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_DESELECTABLE}.enable_select)
			else
				for_all_objects (agent {EV_DESELECTABLE}.disable_select)
			end
		end


	-- Constants for XML
	
	is_selected_string: STRING is "Is_selected"


end -- class GB_EV_DESELECTABLE