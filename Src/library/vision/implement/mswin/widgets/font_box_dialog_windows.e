indexing 
	description: "Dialog for choosing fonts for Windows"
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	FONT_BOX_DIALOG_WINDOWS
  
inherit
	WEL_CHOOSE_FONT_DIALOG
		rename
			make as wel_make,
			item as wel_item
		select
			destroy_item,
			exists,
			wel_item
		end
			
	COLORED_FOREGROUND_WINDOWS

	DIALOG_WINDOWS
		rename
			destroy_item as dialog_destroy_item,
			exists as dialog_exists,
			set_title as dialog_set_title,
			set_font as dialog_set_font,
			title as dialog_title,
			wel_parent as dialog_parent,
			wel_item as dialog_item,
			font as dialog_font
		redefine
			is_popped_up,
			popdown,
			dialog_realize,
			realize,
			unrealize,
			class_name,
			default_style,
			children_count
		end

	FONT_B_D_I 
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end
creation
	make
 
feature -- Initialization

	make (a_font_box_d: FONT_BOX_D; oui_parent: COMPOSITE) is
			-- Create a font box
		do
			wel_make
			!! private_attributes
			parent ?= oui_parent.implementation
			a_font_box_d.set_dialog_imp (Current)
			managed := True
		end

feature -- Access

	font: FONT is
			-- Selected font
		local
			font_windows: FONT_WINDOWS
			wel_font: WEL_FONT
		do
			!! wel_font.make_indirect (log_font)
			!! Result.make
			font_windows ?= Result.implementation
			check
				font_windows_not_void: font_windows /= Void
			end
			font_windows.make_by_wel (wel_font)
		end

feature -- Status setting

	set_font (f: FONT) is
			-- Edit `a_font'.			
		local
			fontw: FONT_WINDOWS
		do
			fontw ?= f.implementation
			set_log_font (fontw.wel_log_font)	
		end

	dialog_realize is
			-- Display a file selection dialog box
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			realized := True
			is_popped_up := True
			wc ?= parent
			activate (wc)
			if selected then
				ok_actions.execute (Current, Void)
			else
				cancel_actions.execute (Current, Void)
			end
		end

	popdown is
			-- Pop down the font dialog, no effect under Windows
		do
			is_popped_up := False
		end
 
	realize is
			-- Realize widget
		do
			realized := true
		end

	unrealize is
			-- Unrealizes the font dialog, no effect under Windows.
		do
			realized := False
		end

	is_popped_up: BOOLEAN 
			-- Is this widget popped up?

feature -- Element change

	add_ok_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	add_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.add (Current, a_command, arg)
		end

	add_apply_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	hide_apply_button is
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	hide_cancel_button is	
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	hide_ok_button is
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_apply_button is 
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_cancel_button is
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	show_ok_button is
			-- Always visible
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

feature -- Removal

	remove_apply_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			apply_actions.remove (Current, a_command, arg)
		end

	remove_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.remove (Current, a_command, arg)
		end

	remove_ok_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.remove (Current, a_command, arg)	
		end	

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionFontBoxDialog"
		end

feature {NONE} -- Inapplicable

	build is
		do
		end

	default_style: INTEGER is
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	children_count: INTEGER is
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	set_label_font, set_text_font, set_button_font (f: FONT) is
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

	text_font, label_font, button_font : FONT is
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

end -- FONT_BOX_DIALOG_WINDOWS
 
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

