indexing
	description	: "Dialog that let the user create a new pixmap"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PAINTBRUSH_CREATE_NEW_PIXMAP_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
		redefine
			show_modal_to_window
		end
	
	PAINTBRUSH_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the dialog
		do
			internal_desired_background_color := (create {EV_STOCK_COLORS}).White
			internal_desired_width := 128
			internal_desired_height := 128
			
			build_interface
			update_preview_pixmap
		end
		
feature -- Access

	desired_background_color: EV_COLOR is
			-- Currently selected color for the background of the new image
		require
			ok_selected: ok_selected
		do
			Result := internal_desired_background_color
		end
			
	desired_width: INTEGER is
			-- Width for the new image
		require
			ok_selected: ok_selected
		do
			Result := internal_desired_width
		end
	
	desired_height: INTEGER is
			-- Height for the new image
		require
			ok_selected: ok_selected
		do
			Result := internal_desired_height
		end
			
	ok_selected: BOOLEAN
			-- Has the "OK" button been selected?

feature -- Operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			ok_selected := False
			Precursor (a_window)
		end

feature {NONE} -- Implementation

	build_interface is
			-- Create the interface for this dialog
		local
			width_label: EV_LABEL
			height_label: EV_LABEL
			width_hbox: EV_HORIZONTAL_BOX
			height_hbox: EV_HORIZONTAL_BOX
			main_vbox: EV_VERTICAL_BOX
			image_dimension_vbox: EV_VERTICAL_BOX
			image_dimension_frame: EV_FRAME
			bgcolor_label: EV_LABEL
			change_background_color_button: EV_BUTTON
			bgcolor_hbox: EV_HORIZONTAL_BOX
			image_characteristics_frame: EV_FRAME
			ok_button: EV_BUTTON
			cancel_button: EV_BUTTON
			buttons_box: EV_HORIZONTAL_BOX
			llabel: EV_LABEL
		do
				-- Create the dialog
			default_create

				-- Create the widgets for entering "Width" and "Height"
			create width_label.make_with_text (Interface_names.Width)
			create height_label.make_with_text (Interface_names.Height)
			width_label.set_minimum_width (width_label.width.max (height_label.width))
			height_label.set_minimum_width (width_label.width.max (height_label.width))
			create width_textfield.make_with_text (internal_desired_width.out)
			width_textfield.change_actions.extend (agent check_width_textfield_for_integer)
			create height_textfield.make_with_text (internal_desired_height.out)
			height_textfield.change_actions.extend (agent check_height_textfield_for_integer)
			
				-- Layout the widgets for entering "Width" and "Height"
			create width_hbox
			width_hbox.set_padding (Layout_constants.Small_padding_size)
			width_hbox.extend (width_label)
			width_hbox.disable_item_expand (width_label)
			width_hbox.extend (width_textfield)
			create height_hbox
			height_hbox.set_padding (Layout_constants.Small_padding_size)
			height_hbox.extend (height_label)
			height_hbox.disable_item_expand (height_label)
			height_hbox.extend (height_textfield)
			create image_dimension_vbox
			image_dimension_vbox.set_border_width (Layout_constants.Default_border_size)
			image_dimension_vbox.set_padding (Layout_constants.Default_padding_size)
			image_dimension_vbox.extend (width_hbox)
			image_dimension_vbox.extend (height_hbox)
			create image_dimension_frame.make_with_text (Interface_names.Image_dimensions)
			image_dimension_frame.extend (image_dimension_vbox)
			
				-- Create the widgets for entering the "backgound color"
			create bgcolor_label.make_with_text (Interface_names.Background_color)
			create preview_pixmap
			preview_pixmap.set_background_color (internal_desired_background_color)
			create change_background_color_button.make_with_text (Interface_names.Change)
			Layout_constants.set_default_size_for_button (change_background_color_button)
			change_background_color_button.select_actions.extend (agent change_background_color)
			create bgcolor_hbox
			bgcolor_hbox.set_border_width (Layout_constants.Default_border_size)
			bgcolor_hbox.set_padding (Layout_constants.Default_padding_size)
			bgcolor_hbox.extend (bgcolor_label)
			bgcolor_hbox.disable_item_expand (bgcolor_label)
			bgcolor_hbox.extend (preview_pixmap)
			bgcolor_hbox.disable_item_expand (preview_pixmap)
			bgcolor_hbox.extend (change_background_color_button)
			bgcolor_hbox.disable_item_expand (change_background_color_button)
			bgcolor_hbox.extend (create {EV_CELL})
			preview_pixmap.set_minimum_size (32, change_background_color_button.height)
			preview_pixmap.set_size (32, change_background_color_button.height)
			
			create image_characteristics_frame.make_with_text (Interface_names.Image_characteristics)
			image_characteristics_frame.extend (bgcolor_hbox)

			create ok_button.make_with_text (Interface_names.Ok)
			Layout_constants.set_default_size_for_button (ok_button)
			ok_button.select_actions.extend (agent on_ok)
			create cancel_button.make_with_text (Interface_names.Cancel)
			Layout_constants.set_default_size_for_button (cancel_button)
			cancel_button.select_actions.extend (agent destroy)
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.extend (create {EV_CELL})
			buttons_box.extend (ok_button)
			buttons_box.disable_item_expand (ok_button)
			buttons_box.extend (cancel_button)
			buttons_box.disable_item_expand (cancel_button)
			
			create main_vbox
			main_vbox.set_border_width (Layout_constants.Default_border_size)
			main_vbox.set_padding (Layout_constants.Default_padding_size)
			main_vbox.extend (image_dimension_frame)
			main_vbox.extend (image_characteristics_frame)
			main_vbox.extend (buttons_box)
			
			set_title (Interface_names.New_image)
			disable_user_resize
			extend (main_vbox)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end
		
	update_preview_pixmap is
			-- Update the preview of the desired background color
		do
			preview_pixmap.set_background_color (internal_desired_background_color)
			preview_pixmap.clear
		end
		
	change_background_color is
			-- Let the user change the background color
		local
			std_color_dialog: EV_COLOR_DIALOG
		do
				-- Display the standard color dialog
			create std_color_dialog
			std_color_dialog.set_color (internal_desired_background_color)
			std_color_dialog.show_modal_to_window (Current)
			
				-- If the user has clicked "Ok", then change the
				-- `selected_color' and update the preview.
			if std_color_dialog.selected_button.is_equal ("OK") then
				internal_desired_background_color := std_color_dialog.color
				update_preview_pixmap
			end
		end
		
	check_width_textfield_for_integer is
			-- Check that the text field `width_textfield' hold an integer value,
			-- if so commit the new value, otherwise reset it to `desired_width'
		require
			width_textfield_valid: width_textfield /= Void
			internal_desired_width_positive: internal_desired_width > 0
		do
			check_textfield_for_integer (width_textfield, internal_desired_width)
			internal_desired_width := width_textfield.text.to_integer
		ensure
			width_textfield_not_empty: width_textfield.text /= Void
			width_textfield_is_integer: width_textfield.text.is_integer
			width_textfield_is_positive: width_textfield.text.to_integer > 0
		end
		
	check_height_textfield_for_integer is
			-- Check that the text field `height_textfield' hold an integer value,
			-- if so commit the new value, otherwise reset it to `desired_height'
		require
			height_textfield_valid: height_textfield /= Void
			internal_desired_height_positive: internal_desired_height > 0
		do
			check_textfield_for_integer (height_textfield, internal_desired_height)
			internal_desired_height := height_textfield.text.to_integer
		ensure
			height_textfield_not_empty: height_textfield.text /= Void
			height_textfield_is_integer: height_textfield.text.is_integer
			height_textfield_is_positive: height_textfield.text.to_integer > 0
		end
		
	check_textfield_for_integer (a_textfield: EV_TEXT_FIELD; default_value: INTEGER) is
			-- Check that the text field `a_textfield' hold an integer value,
			-- otherwise reset it to `default_value'
		require
			default_value_positive: default_value > 0
			a_textfield_valid: a_textfield /= Void
		local
			curr_value_text: STRING
		do
			curr_value_text := a_textfield.text
			if (curr_value_text = Void) or else 
				(not curr_value_text.is_integer) or else
				(curr_value_text.to_integer <= 0)
			then
				a_textfield.set_text (default_value.out)
			end
		ensure
			a_textfield_not_empty: a_textfield.text /= Void
			a_textfield_is_integer: a_textfield.text.is_integer
			a_textfield_is_positive: a_textfield.text.to_integer > 0
		end
		
	 on_ok is
			-- Select `ok' and destroy the dialog
		do
			ok_selected := True
			destroy
		end
		
	preview_pixmap: EV_PIXMAP
			-- Pixmap used to preview the background color.

	width_textfield: EV_TEXT_FIELD
			-- Text field for the "Width"
	
	height_textfield: EV_TEXT_FIELD
			-- Text field for the "Height"
	
	internal_desired_background_color: EV_COLOR
			-- Currently selected color for the background of the new image
			
	internal_desired_width: INTEGER
			-- Width for the new image
	
	internal_desired_height: INTEGER
			-- Height for the new image
			
end -- class CREATE_NEW_PIXMAP_DIALOG
