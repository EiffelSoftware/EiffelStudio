indexing
	description: "Objects that create controls to extend a certain widget type."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXTENDIBLE_CONTROLS

inherit
	EV_FRAME
		redefine
			initialize,
			is_in_default_state
		end
		
	GB_WIDGET_UTILITIES
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	make_with_text_control (an_any_item: like current_type) is
			-- Create `Current' with an EV_TEXT for input.
		do
			default_create
			current_type := an_any_item
			create text_control
			text_control.set_text (initial_text)
			text_control.change_actions.extend (agent update_extend_button)
			input_control_holder.extend (text_control)
		end
		
	make_with_combo_control (an_any_item: like current_type; types: ARRAY [STRING]) is
			-- Create `Current' with a combo box for input, corresponding to `types'.
		local
			list_item: EV_LIST_ITEM
			counter: INTEGER
		do
			default_create
			current_type := an_any_item
			create combo_control
			from
				counter := 1
			until
				counter > types.count
			loop
				create list_item.make_with_text (types @ counter)
				combo_control.extend (list_item)
				counter := counter + 1
			end
			input_control_holder.extend (combo_control)
			combo_control.change_actions.extend (agent extend_item)
		end
		
		
	initialize is
			--
		local
			horizontal_box: EV_HORIZONTAL_BOX
		do	
			set_text ("Insertion/Removal")
			create internal_vertical_box	
			internal_vertical_box.set_padding_width (5)
			internal_vertical_box.set_border_width (5)
			create horizontal_box
			horizontal_box.set_padding_width (5)
			create input_control_holder
			horizontal_box.extend (input_control_holder)
			create help_control.make_with_text ("?")
			help_control.select_actions.extend (agent show_help)
			horizontal_box.extend (help_control)
			horizontal_box.disable_item_expand (help_control)
			help_control.set_minimum_width (help_control.minimum_height)
			create extend_button.make_with_text ("Extend")
			extend_button.select_actions.extend (agent extend_item)
			create wipe_out_button.make_with_text ("Wipe_out")
			wipe_out_button.select_actions.extend (agent wipe_out_item)
			internal_vertical_box.extend (horizontal_box)
			internal_vertical_box.extend (extend_button)
			internal_vertical_box.extend (wipe_out_button)
			extend (internal_vertical_box)
			is_initialized := True
		end

feature -- Access

feature -- Measurement

feature -- Status report

	help: STRING is
			-- Instructions on how to use the control.
		deferred
		end
		

feature -- Status setting

	extend_item is
			-- Add a new item to `any_item'.
		deferred
		end
		
	wipe_out_item is
			-- Wipe_out `any_item'.
		deferred
		end

feature -- Cursor movement

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

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- (export status {NONE})
		do
			Result := True	
		end

feature {NONE} -- Implementation

	initial_text: STRING is
			-- Initial text for new items.
		deferred
		end

	show_help is
			-- Display help for `Current'.
		local
			information_dialog: EV_INFORMATION_DIALOG
		do
			create information_dialog.make_with_text (help)
			information_dialog.show_modal_to_window (parent_window (Current))
		end
		
	update_extend_button is
			-- Update `extend_button' based on current state of `text_control'.
		do
			if text_control.text.is_empty then
				extend_button.disable_sensitive
			elseif not extend_button.is_sensitive then
				extend_button.enable_sensitive
			end
		end
		

	current_type: EV_ANY
		-- The item on which operations must take place.

	text_control: EV_TEXT_FIELD
		-- A text field for input.
		
	combo_control: EV_COMBO_BOX
		-- A combo box for input.
		
	input_control_holder: EV_CELL
		-- A control to hold either `text_control' or
		-- `combo_control' depending on the way in which
		-- `Current' was made.
		
	help_control: EV_BUTTON
		-- A help button.
		
	extend_button: EV_BUTTON
		-- A button for extension.
		
	wipe_out_button: EV_BUTTON
		-- A button for wiping out contents.
		
	internal_vertical_box: EV_VERTICAL_BOX
		-- A box inside `Current' into which controls are placed.

invariant
	current_type_not_void: current_type /= Void

end -- class EXTENDIBLE_CONTROLS
