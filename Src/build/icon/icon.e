indexing
	description: "Icon: Picture symbol and text label."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class ICON 

inherit

	CONSTANTS

	CENTERED_BULLETIN
		rename
			make as bulletin_make,
			make_unmanaged as bulletin_make_unmanaged,
			identifier as oui_identifier
		redefine
			set_managed,
			add_button_press_action,
			set_size,
			set_width,
			set_height
		end

feature 

	init_y: INTEGER is 24	

	source_button: PICT_COLOR_B is
		do
			Result := button
		end

	symbol: PIXMAP
			-- Icon picture

	label: STRING
			-- Icon label

	set_symbol (s: PIXMAP) is
			-- Set icon symbol.
		require
			valid_argument: s /= Void
		local
			was_managed: BOOLEAN
		do
			symbol := s
			if s.is_valid and then widget_created then
				button.unmanage
				button.set_pixmap (s)
				button.manage
				update_positions
			end
		end

	set_label (s: STRING) is
			-- Set icon label.
		require
			not_void: s /= Void
		local
			was_managed: BOOLEAN
		do
			label := clone (s)
			if widget_created then
				icon_label.unmanage
				icon_label.set_y (init_y)
				icon_label.set_text (label)
				icon_label.manage
			end
			if icon_label /= Void then
				if button /= Void then
					set_width (icon_label.width.max (button.width))
				else
					set_width (icon_label.width)
				end	
				update_positions
			end
		end

	widget_created: BOOLEAN is
		do
			Result := implementation /= Void
		end

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height'.
		do 
			{CENTERED_BULLETIN} Precursor (new_width, new_height)
			update_positions
		end

	set_width (new_width:INTEGER) is
			-- Set height to `new_width'.
		do 
			{CENTERED_BULLETIN} Precursor (new_width)
			update_positions
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do 
			{CENTERED_BULLETIN} Precursor (new_height)
			update_positions
		end

feature {NONE} -- Interface section

	button: ACTIVE_PICT_COLOR_B
	icon_label: LABEL
	
	update_label is
		do
			if label.empty then
				icon_label.unmanage
			else
				icon_label.manage
			end
		end

feature  -- Interface section

	frozen make_unmanaged (a_parent: COMPOSITE) is
			-- Create current unmanaged.
			--| It is frozen since it is called by
			--| the icon box.
		require
			not_created: not widget_created
		do
			bulletin_make_unmanaged (Widget_names.bulletin, a_parent)
			!! button.make_unmanaged (Widget_names.pcbutton, Current)
			button.set_x_y (1, 1)
			if 
				symbol /= Void and
				symbol.is_valid
			then 
				button.set_pixmap (symbol)
			end
			!! icon_label.make_unmanaged (Widget_names.label, Current)
			icon_label.set_left_alignment
			icon_label.allow_recompute_size
			if (label /= Void) and then not label.empty then
				icon_label.set_y (init_y)
				icon_label.set_text (label)
			else
				icon_label.set_text ("")
			end
			update_positions
			set_widget_default
		end

	frozen make_visible (a_parent: COMPOSITE) is
			-- Create current unmanaged.
			--| It is frozen since it is called by
			--| the icon box.
		require
			not_created: not widget_created
		do
			make_unmanaged (a_parent)
			set_managed (true)	
		end

	set_widget_default is
			-- Set default behaviour after widget
			-- has been created
		do
			-- Do nothing
		end

	add_activate_action (a_command: COMMAND an_argument: ANY) is
		do
			button.add_activate_action (a_command, an_argument)
		end

	add_button_press_action (i: INTEGER a_command: COMMAND an_argument: ANY) is
		do
			button.add_button_press_action (i, a_command, an_argument)
		end

	set_managed (b: BOOLEAN) is
		do
			if b then 
				if not icon_label.text.empty then
					icon_label.manage
				end
				button.manage
				manage
				update_positions
			else 
				unmanage
				if button.managed then
					button.unmanage
				end
				if icon_label.managed then
					icon_label.unmanage
				end
			end
		end

feature {EB_BOX}

	update_attributes is
			-- Update Current colors and font attributes.
		require
			exists: widget_created
		local
			color: COLOR	
			font: FONT
			res: like Resources
		do
			res := Resources
			color := parent.background_color
			if color /= Void then
				set_background_color (color)
				icon_label.set_background_color (color)
			end	
			color := res.foreground_color
			if color /= Void then
				button.set_foreground_color (color)
				icon_label.set_foreground_color (color)
			end
			font := res.default_font
			if font /= Void then
				icon_label.set_font (font)
			end
		end

feature {NONE} -- Update position

	update_positions is
			-- Center the button in the bulletin.
		do
			if button /= Void and is_centered then
				if label = Void or else label.empty then
					button.set_x_y (1, 1)
				else
					button.set_x_y ((width // 2) - (button.width // 2), 1)
					icon_label.set_x_y ((width //2) - (icon_label.width // 2), init_y)
				end
			end
		end

end
