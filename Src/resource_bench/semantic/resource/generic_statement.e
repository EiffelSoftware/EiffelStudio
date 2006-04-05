indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			is_equal, copy
		end

	TDS_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class GENERIC_STATEMENT

