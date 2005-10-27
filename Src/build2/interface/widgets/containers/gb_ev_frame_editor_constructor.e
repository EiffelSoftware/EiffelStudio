indexing
	description: "Builds an attribute editor for modification of objects of type EV_FRAME."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_FRAME_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_FRAME
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_FRAME"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			create label.make_with_text ("Style")
			Result.extend (label)
			create combo_box
			Result.extend (combo_box)
			combo_box.disable_edit
			create item_lowered.make_with_text (Ev_frame_lowered_string)
			combo_box.extend (item_lowered)
			create item_raised.make_with_text (Ev_frame_raised_string)
			combo_box.extend (item_raised)
			create item_etched_in.make_with_text (Ev_frame_etched_in_string)
			combo_box.extend (item_etched_in)
			create item_etched_out.make_with_text (Ev_frame_etched_out_string)
			combo_box.extend (item_etched_out)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			combo_box.select_actions.block
			inspect first.style
			when Ev_frame_lowered then
				item_lowered.enable_select
			when Ev_frame_raised then
				item_raised.enable_select
			when Ev_frame_etched_in then
				item_etched_in.enable_select
			when Ev_frame_etched_out then
				item_etched_out.enable_select
			else
				check
					Error: False
				end
			end

			combo_box.select_actions.resume
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to do here.
		end

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			for_all_objects (agent {EV_FRAME}.set_style (style_from_text (combo_box.selected_item.text)))
		end
		
	style_from_text (text: STRING): INTEGER is
			-- `Result' is value of Ev_frame_constants matching `text'.
		do
			if text.is_equal (Ev_frame_lowered_string) then
				Result := Ev_frame_lowered
			elseif text.is_equal (Ev_frame_raised_string) then
				Result := Ev_frame_raised
			elseif text.is_equal (Ev_frame_etched_in_string) then
				Result := Ev_frame_etched_in
			elseif text.is_equal (Ev_frame_etched_out_string) then
				Result := Ev_frame_etched_out
			else
				check
					False
				end
			end
		end

	combo_box: EV_COMBO_BOX
		-- Holds current selection.
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	Style_string: STRING is "Style"
	
	Ev_frame_lowered_string: STRING is "Ev_frame_lowered"
	Ev_frame_raised_string: STRING is "Ev_frame_raised"
	Ev_frame_etched_in_string: STRING is "Ev_frame_etched_in"
	Ev_frame_etched_out_string: STRING is "Ev_frame_etched_out"
	
	item_lowered, item_raised, item_etched_in, item_etched_out: EV_LIST_ITEM

end -- class GB_EV_FRAME_EDITOR_CONSTRUCTOR
