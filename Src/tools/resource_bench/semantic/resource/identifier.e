note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Identifiers

class
	IDENTIFIER 

inherit
	S_IDENTIFIER
		redefine
			action
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

	TDS_CONTROL_CONSTANTS
		export	
			{NONE} all
		undefine
			is_equal, copy
		end

create
	make

feature

	action
		local
			accelerators: TDS_ACCELERATORS
			dialog: TDS_DIALOG
			stringtable: TDS_STRINGTABLE
			menu: TDS_MENU
			toolbar: TDS_TOOLBAR
		do
			accelerators ?= tds.current_resource
			dialog ?= tds.current_resource
			menu ?= tds.current_resource
			stringtable ?= tds.current_resource
			toolbar ?= tds.current_resource

                        inspect 
				tds.identifier_type

	 		when Dialog_x then
				dialog.set_x (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Dialog_y)

			when Dialog_y then
				dialog.set_y (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Dialog_width)

			when Dialog_width then
				dialog.set_width (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Dialog_height)

			when Dialog_height then
				dialog.set_height (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Normal)



			when Option_characteristic then
				tds.current_resource.options.set_characteristic (token.string_value)

			when Option_language then
				tds.current_resource.options.set_language (token.string_value)

			when Option_version then
				tds.current_resource.options.set_version (token.string_value)

			when Option_caption then
				tds.current_resource.options.set_caption (token.string_value)

			when Option_class then
				tds.current_resource.options.set_class (token.string_value)

			when Option_exstyle then
				tds.last_style.set_style (token.string_value)
				tds.current_resource.options.set_style (tds.last_style)
	        
			when Option_font_size then
				tds.current_resource.options.set_font_size (tds.convert_identifier(token.string_value))
				tds.set_identifier_type (Option_font_type)

			when Option_font_type then
				tds.current_resource.options.set_font_type (token.string_value)
				tds.set_identifier_type (Option_font_weight)

			when Option_font_weight then
				tds.current_resource.options.set_font_weight (tds.convert_identifier(token.string_value))
				tds.set_identifier_type (Option_font_italic)

			when Option_font_italic then
				tds.current_resource.options.set_font_italic (token.string_value.to_boolean)

			when Option_menu then
				tds.current_resource.options.set_menu (token.string_value)

			when Option_style then
				tds.last_style.set_style (token.string_value)
				tds.current_resource.options.set_style (tds.last_style)


			
			when Control_type then
				new_control (dialog, token.string_value)
				tds.set_identifier_type (Control_text)

			when Control_text then
				dialog.current_control.set_text (token.string_value)
				tds.set_identifier_type (Control_id)

			when Control_id then
				dialog.current_control.set_id (token.string_value)
				tds.set_identifier_type (Control_x)

			when Control_x then
				dialog.current_control.set_x (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Control_y)

			when Control_y then
				dialog.current_control.set_y (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Control_width)

			when Control_width then
				dialog.current_control.set_width (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Control_height)

			when Control_height then
				dialog.current_control.set_height (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Control_style)

			when Control_style then
				tds.last_style.set_style (token.string_value)
				dialog.current_control.set_style (tds.last_style)

			when Control_exstyle then
				tds.last_style.set_style (token.string_value)
				dialog.current_control.set_style (tds.last_style)


			
			when Generic_Control_text then
				dialog.current_control.set_text (token.string_value)
				tds.set_identifier_type (Generic_Control_id)

			when Generic_Control_id then
				dialog.current_control.set_id (token.string_value)
				tds.set_identifier_type (Generic_Control_class)

			when Generic_Control_class then
				dialog.current_control.set_class_name (token.string_value)
				tds.set_identifier_type (Generic_Control_style)

			when Generic_Control_style then
				tds.last_style.set_style (token.string_value)
				dialog.current_control.set_style (tds.last_style)

			when Generic_Control_x then
				dialog.current_control.set_x (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Generic_Control_y)

			when Generic_Control_y then
				dialog.current_control.set_y (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Generic_Control_width)

			when Generic_Control_width then
				dialog.current_control.set_width (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Generic_Control_height)

			when Generic_Control_height then
				dialog.current_control.set_height (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Generic_Control_exstyle)

			when Generic_Control_exstyle then
				tds.last_style.set_style (token.string_value)
				dialog.current_control.set_style (tds.last_style)



			when Stringtable_id then
				stringtable.current_string.set_id (token.string_value)
				tds.set_identifier_type (Stringtable_text)

			when Stringtable_text then
				stringtable.current_string.set_text (token.string_value)


			
			when Menu_text then
				menu.current_menu.item.current_item.set_text (token.string_value)
				tds.set_identifier_type (Menu_command)

			when Menu_command then
				menu.current_menu.item.current_item.set_command_id (token.string_value)
				tds.set_identifier_type (Menu_flags)

			when Menu_flags then
				menu.current_menu.item.current_item.insert_flags (token.string_value)



			when Accelerators_event then
				accelerators.current_accelerator.set_event (token.string_value)
				tds.set_identifier_type (Accelerators_id)

			when Accelerators_id then
				accelerators.current_accelerator.set_id_value (token.string_value)
				tds.set_identifier_type (Accelerators_type)

			when Accelerators_type then
				accelerators.current_accelerator.set_type (token.string_value)
				tds.set_identifier_type (Accelerators_options)

			when Accelerators_options then
				accelerators.current_accelerator.insert_options (token.string_value)


			when Toolbar_width then
				toolbar.set_width (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Toolbar_height)

			when Toolbar_height then
				toolbar.set_height (tds.convert_identifier (token.string_value))
				tds.set_identifier_type (Normal)

			else
				tds.set_token (token.string_value)
			end
		end


feature {NONE}

	new_control (dialog: TDS_DIALOG; type: STRING)
			-- Create a typed control.
			-- Combobox, edittext and listbox controls are created by Specific_statement.
		local
			control: TDS_CONTROL_STATEMENT
		do
			if (type.is_equal ("AUTO3STATE")) then
				create {TDS_AUTO3STATE_STATEMENT} control.make

			elseif (type.is_equal ("AUTOCHECKBOX")) then
				create {TDS_AUTOCHECKBOX_STATEMENT} control.make

			elseif (type.is_equal ("AUTORADIOBUTTON")) then
				create {TDS_AUTORADIOBUTTON_STATEMENT} control.make

			elseif (type.is_equal ("CHECKBOX")) then
				create {TDS_CHECKBOX_STATEMENT} control.make

--			elseif (type.is_equal ("COMBOBOX")) then
--				!TDS_COMBOBOX_STATEMENT! control.make

			elseif (type.is_equal ("CTEXT")) then
				create {TDS_CTEXT_STATEMENT} control.make

			elseif (type.is_equal ("DEFPUSHBUTTON")) then
				create {TDS_DEFPUSHBUTTON_STATEMENT} control.make

--			elseif (type.is_equal ("EDITTEXT")) then
--				!TDS_EDITTEXT_STATEMENT! control.make

			elseif (type.is_equal ("GROUPBOX")) then
				create {TDS_GROUPBOX_STATEMENT} control.make

			elseif (type.is_equal ("ICON")) then
				create {TDS_ICON_STATEMENT} control.make

--			elseif (type.is_equal ("LISTBOX")) then
--				!TDS_LISTBOX_STATEMENT! control.make

			elseif (type.is_equal ("LTEXT")) then
				create {TDS_LTEXT_STATEMENT} control.make

			elseif (type.is_equal ("PUSHBOX")) then
				create {TDS_PUSHBOX_STATEMENT} control.make

			elseif (type.is_equal ("PUSHBUTTON")) then
				create {TDS_PUSHBUTTON_STATEMENT} control.make

			elseif (type.is_equal ("RADIOBUTTON")) then
				create {TDS_RADIOBUTTON_STATEMENT} control.make

			elseif (type.is_equal ("RTEXT")) then
				create {TDS_RTEXT_STATEMENT} control.make

			elseif (type.is_equal ("SCROLLBAR")) then
				create {TDS_SCROLLBAR_STATEMENT} control.make

			elseif (type.is_equal ("STATE3")) then
				create {TDS_3STATE_STATEMENT} control.make

			end
				
			control.set_wel_code (true)
			dialog.set_current_control (control)
		end

note
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
end -- class IDENTIFIER
