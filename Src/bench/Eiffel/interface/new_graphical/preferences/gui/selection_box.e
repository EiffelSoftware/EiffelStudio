indexing
	description	: "Class which allows entering a value corresponding to a data."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	SELECTION_BOX

inherit
	RESOURCE_OBSERVATION_MANAGER

feature {NONE} -- Initialization

	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
		require
			box_exists: h /= Void
			caller_exists: new_caller /= Void
		local
			empty_cell: EV_CELL
			h2: EV_HORIZONTAL_BOX
			label_box: EV_VERTICAL_BOX
		do
			parent := h
			caller := new_caller

			create label
			create label_box
			label_box.extend (create {EV_CELL})
			label_box.extend (label)
			label_box.disable_item_expand (label)
			label_box.extend (create {EV_CELL})

			build_change_item_widget

			create h2
			h2.set_padding (Layout_constants.Small_padding_size)
			h2.extend (label_box)
			h2.disable_item_expand (label_box)
			h2.extend (change_item_widget)

			create change_item_box
			create empty_cell
			empty_cell.set_minimum_height (Layout_constants.Small_padding_size)
			change_item_box.extend (empty_cell)
			change_item_box.disable_item_expand (empty_cell)
			change_item_box.extend (h2)
			change_item_box.disable_item_expand (h2)
			change_item_box.extend (create {EV_CELL})
		end

feature -- Display

	hide is
			-- hide Current.
		do
			resource := Void
			parent.prune (change_item_box)
		end

	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			resource := new_resource
			update_label (resource)
			parent.extend (change_item_box)
		end

feature {NONE} -- Implementation

	change_item_box: EV_VERTICAL_BOX
			-- Box containing the widget to change the item and the label

	change_item_widget: EV_WIDGET
			-- Widget to change the item

	parent: EV_BOX
			--  Parent of Current

	label: EV_LABEL
			-- Label

	resource: RESOURCE
			-- Resource.

	caller: PREFERENCE_WINDOW
			-- Caller

	update_resource is
			-- Update resource
		do
			if observer_manager.get_data_observer (resource) /= Void then
				observer_manager.update_observer (resource)
			end
		end

	build_change_item_widget is
				-- Create and setup `change_item_widget'.
		deferred
		ensure
			widget_created: change_item_widget /= Void
		end

	update_label (res: RESOURCE) is
			-- Update `label' with `res' content.
		local
			s: STRING
			description: STRING
		do
			description := res.description
			if description /= Void and then not description.is_empty then
				s := clone (description)
			else
				s := clone (res.name)
				s.replace_substring_all ("_", " ")
			end
			s.prune_all ('%N')
			s.prune_all ('%T')
			s.prune_all ('%R')
			
			if not s.is_empty then
				label.set_text (s)
			else
				label.set_text ("Unknown item")
			end
		end

feature {NONE} -- Private constants

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Vision2 layout constants
		once
			create Result
		end

invariant
	selection_box__parent_exists: 
		parent /= Void

	selection_box__hide_consistency: 
		change_item_box.parent = Void implies resource = Void

	selection_box__display_consistency: 
		change_item_box.parent /= Void implies resource /= Void 

end -- class SELECTION_BOX
