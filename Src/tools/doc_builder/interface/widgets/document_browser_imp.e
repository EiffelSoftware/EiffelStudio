indexing
	description: "Document browser interface layout."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DOCUMENT_BROWSER_IMP

inherit			
	EV_VERTICAL_BOX
		rename
			border_width as box_border_width,
			padding_width as box_padding_width
		redefine
			initialize
		end

	CONSTANTS
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor
			initialize_constants
			
				-- Create all widgets.
			create toolbar_box
			create l_ev_horizontal_box_1
			create toolbar
			create refresh_button
			create l_ev_horizontal_box_2
			create l_ev_label_1
			create address_bar
			create browser_box
			
				-- Build_widget_structure.
			extend (toolbar_box)
			toolbar_box.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (toolbar)
			toolbar.extend (refresh_button)
			toolbar_box.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_1)
			l_ev_horizontal_box_2.extend (address_bar)
			extend (browser_box)
			
			set_padding_width (padding_width)
			set_border_width (border_width)
			disable_item_expand (toolbar_box)
			toolbar_box.set_padding_width (padding_width)
			toolbar_box.set_border_width (border_width)
			toolbar_box.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_1.set_padding_width (padding_width)
			l_ev_horizontal_box_1.set_border_width (border_width)		
			refresh_button.set_tooltip ("Refresh")
			refresh_button.set_pixmap (icon_refresh_ico)
			l_ev_horizontal_box_2.set_padding_width (padding_width)
			l_ev_horizontal_box_2.set_border_width (border_width)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Address")
			l_ev_label_1.align_text_left
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	toolbar_box, browser_box: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	toolbar: EV_TOOL_BAR
	refresh_button: EV_TOOL_BAR_BUTTON
	l_ev_label_1: EV_LABEL
	address_bar: EV_COMBO_BOX

feature {NONE} -- Implementation
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
end -- class DOCUMENT_BROWSER_IMP
