indexing
	description: "button in a menu"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	MENU_B_IMP

inherit

	MENU_B_I

	BUTTON_IMP
		redefine
			realized,
			set_text,
			text,
			width,
			height,
			unrealize,
			set_insensitive
		end
creation
	make

feature {NONE} -- Initialization

	make (a_menu_b: MENU_B; man: BOOLEAN; oui_parent: MENU) is
		local
			mp: MENU_PULL
		do
			!! private_attributes
			text := a_menu_b.identifier
			parent ?= oui_parent.implementation
			mp ?= oui_parent
			attach_menu (mp)
			a_menu_b.set_font_imp (Current)
			managed := man
		end

feature -- Access

	associated_menu: MENU_PULL

	text: STRING

	width: INTEGER is
		local
			system_font: WEL_SYSTEM_FONT
		do
			!! system_font.make
			Result := (text.count + 1) * system_font.log_font.width
		end	
	
	height: INTEGER is
		local
			system_font: WEL_SYSTEM_FONT
		do
			!! system_font.make
			Result := system_font.log_font.height
		end	

feature -- Status setting

	set_text (new_text: STRING) is
		do
			text := new_text
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set sensitivity of Current to reflect `flag'.
		do
			{BUTTON_IMP} Precursor (flag)
			if flag then
				associated_menu.set_insensitive
			else
				associated_menu.set_sensitive
			end
		end

feature -- Element change

	wel_set_text (a_text: STRING) is
		do
		end;

	wel_disabled: BOOLEAN is
		do
		end;

	realize is
		do
			realized := True			
		end

	unrealize is 
		do
			realized := false
		end

	wel_enable is
			-- Enable current button.
		do
		end;

	wel_disable is
			-- Disable current button.
		do
		end;


	wel_destroy is
		do
		end

	realized: BOOLEAN 
	
feature {NONE} -- Inapplicable

	default_style: INTEGER is
		do
		end

	class_name: STRING is
		do
		end

	process_notification (notification_code: INTEGER) is
		do
		end
		
	attach_menu (a_menu: MENU_PULL) is
		do
			associated_menu := a_menu
		end

	wel_hide, wel_set_focus, enable, disable, invalidate, 
	wel_release_capture, wel_set_capture, wel_show  is
		do
		end

	wel_set_menu (wel_menu: WEL_MENU) is
		do
		end

	wel_parent: WEL_COMPOSITE_WINDOW

	client_rect: WEL_RECT

	wel_shown, exists, enabled: BOOLEAN

	wel_children: LINKED_LIST [WEL_WINDOW]

	wel_set_width, wel_set_height, wel_set_x, wel_set_y (i:INTEGER) is do end

	absolute_x, absolute_y, wel_width, wel_height, wel_x, wel_y: INTEGER

	wel_text: STRING

	resize, wel_move (new_width, new_height: INTEGER) is
		do
		end

	set_z_order (flags: POINTER) is
		do
		end

	wel_item: POINTER

	disable_default_processing is
		do
		end

	wel_font: WEL_FONT

	wel_set_font (f:WEL_FONT) is
		do
		end
end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

