indexing 
	decription: "OPTION_BUTTON_WINDOWS for Windows - this delegates to an OPTION_PULL"
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	OPTION_BUTTON_WINDOWS

inherit
	BUTTON_WINDOWS
		redefine
			realized,
			unrealize
		end

	OPTION_B_I

creation
	make

feature -- Initialization

	make (an_option_button: OPTION_B; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create an option_b
		do
			!! private_attributes
			an_option_button.set_font_imp (Current)
			managed := man
			parent ?= oui_parent.implementation
		end

	set_option_pull (opw: OPT_PULL_I) is
			-- Set the option pull to `opw'
		do
			opt_pull := opw
		end


feature -- Access

	realized: BOOLEAN 
			-- Is this widget realized?

feature -- Status report

	selected_button: BUTTON is
			-- Button which is selected.
		do
			if opt_pull /= Void then
				Result := opt_pull.selected_button
			end
		end

	title_width: INTEGER
			-- Width of the title

	title: STRING 

	opt_pull: OPT_PULL_I
			-- Associated option pull to delegate to

feature -- Status setting

	realize is
		do
			realized := true
		end

	set_selected_button (a_button: BUTTON) is
			-- Set the selected button to `a_button'
		do
			if opt_pull /= Void then
				opt_pull.set_selected_button (a_button)
			end
		end

	set_title (a_title: STRING) is
		do
			title := clone (a_title)
		end

	unrealize is
		do
			realized := false
		end

feature -- Element change

	attach_menu (a_menu: OPT_PULL) is
			-- Implemented with parent in make
		do
			opt_pull ?= a_menu.implementation
		end

feature -- Removal

	remove_title is
		do
		end

feature {NONE} -- Inapplicable

	process_notification (n: INTEGER) is
		do
		end
		
	wel_destroy, wel_hide, wel_set_focus, enable, disable, invalidate, 
	wel_release_capture, wel_set_capture, wel_show  is
		do
		end

	wel_set_menu (wel_menu: WEL_MENU) is
		do
		end

	wel_parent: WEL_COMPOSITE_WINDOW
	wel_set_text (s: STRING) is do end
	client_rect: WEL_RECT
	wel_shown, enabled, exists: BOOLEAN
	wel_children: LINKED_LIST [WEL_WINDOW]
	wel_set_width, wel_set_height, wel_set_x, wel_set_y (i:INTEGER) is do end
	absolute_x, absolute_y, wel_width, wel_height, wel_x, wel_y: INTEGER
	wel_text: STRING
	resize, wel_move (new_width, new_height: INTEGER) is
		do
		end

	set_z_order (flags: INTEGER) is
		do
		end

	wel_item: POINTER
	wel_font: WEL_FONT

 	wel_set_font (f:WEL_FONT) is
		do
		end

	disable_default_processing is
		do
		end

end -- OPTION_BUTTON_WINDOWS
 
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
