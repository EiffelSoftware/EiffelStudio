indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Generic_statement -> "CONTROL" text "," id "," class "," Styles_list "," x "," y "," width
--			"," height Optional_extended_styles_list

class GENERIC_STATEMENT

inherit
	S_GENERIC_STATEMENT
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

	TDS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature 

	pre_action is
		local
			generic: TDS_GENERIC_STATEMENT
			dialog: TDS_DIALOG
		do     
			!! generic.make
			generic.set_wel_code (true)

			dialog ?= tds.current_resource
			dialog.set_current_control (generic)

			tds.set_identifier_type (Generic_control_text)
		end

	post_action is
		local
			dialog: TDS_DIALOG
			a_control: TDS_CONTROL_STATEMENT

		do     
			dialog ?= tds.current_resource
			a_control := get_control (dialog.current_control)
			
			dialog.set_current_control (a_control)

			tds.set_identifier_type (Normal)
		end

feature {NONE}

	control: TDS_CONTROL_STATEMENT
			-- Copy of the generic control.

	get_control (a_control: TDS_CONTROL_STATEMENT) : TDS_CONTROL_STATEMENT is
		local
			style: TDS_STYLE
		do
			!! style.make

			if (a_control.class_name.is_equal ("%"Button%"")) or (a_control.class_name.is_equal ("%"BUTTON%"")) then
				style.set_style ("BS_AUTO3STATE")
				if (a_control.style.is_present (style)) then
					!TDS_AUTO3STATE_STATEMENT! control.make
				end

				style.set_style ("BS_AUTOCHECKBOX")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_AUTOCHECKBOX_STATEMENT! control.make
				end

				style.set_style ("BS_AUTORADIOBUTTON")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_AUTORADIOBUTTON_STATEMENT! control.make
				end

				style.set_style ("BS_CHECKBOX")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_CHECKBOX_STATEMENT! control.make
				end

				style.set_style ("BS_DEFPUSHBUTTON")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_DEFPUSHBUTTON_STATEMENT! control.make
				end

				style.set_style ("BS_GROUPBOX")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_GROUPBOX_STATEMENT! control.make
				end

				style.set_style ("BS_PUSHBOX")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_PUSHBOX_STATEMENT! control.make
				end

				style.set_style ("BS_PUSHBUTTON")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_PUSHBUTTON_STATEMENT! control.make
				end

				style.set_style ("BS_RADIOBUTTON")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_RADIOBUTTON_STATEMENT! control.make
				end

				style.set_style ("BS_3STATE")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_3STATE_STATEMENT! control.make
				end

			elseif (a_control.class_name.is_equal ("%"Static%"")) or (a_control.class_name.is_equal ("%"STATIC%"")) then
				style.set_style ("SS_CENTER")
				if (a_control.style.is_present (style)) then
					!TDS_CTEXT_STATEMENT! control.make
				end

				style.set_style ("SS_LEFT")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_LTEXT_STATEMENT! control.make
				end

				style.set_style ("SS_RIGHT")
				if  (not finished) and (a_control.style.is_present (style)) then
					!TDS_RTEXT_STATEMENT! control.make
				end

				style.set_style ("SS_ICON")
				if (not finished) and (a_control.style.is_present (style)) then
					!TDS_ICON_STATEMENT! control.make
				end

			elseif (a_control.class_name.is_equal ("%"Edit%"")) or (a_control.class_name.is_equal ("%"EDIT%""))then
				!TDS_EDITTEXT_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"Listbox%"")) or (a_control.class_name.is_equal ("%"LISTBOX%"")) then
				!TDS_LISTBOX_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"Scrollbar%"")) or (a_control.class_name.is_equal ("%"SCROLLBAR%"")) then
				!TDS_SCROLLBAR_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"Combobox%"")) or (a_control.class_name.is_equal ("%"COMBOBOX%"")) then
				!TDS_COMBOBOX_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"SysTreeView32%"")) then
				!TDS_TREEVIEW_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"msctls_progress32%"")) then
				!TDS_PROGRESSBAR_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"msctls_statusbar32%"")) then
				!TDS_STATUSBAR_STATEMENT! control.make

			elseif (a_control.class_name.is_equal ("%"msctls_trackbar32%"")) then
				!TDS_TRACKBAR_STATEMENT! control.make
			end

			if (not finished) then
				control := a_control
			else
				control.dupplicate (a_control)
			end

			Result := control
		end

	finished: BOOLEAN is
			-- Test if `control' is not Void.
		do	
			Result := control /= Void
		end

end -- class GENERIC_STATEMENT

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
