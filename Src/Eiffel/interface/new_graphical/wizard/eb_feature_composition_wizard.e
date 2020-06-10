note
	description:
		"Wizard to create features and insert them in a specific%N%
		%feature clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_COMPOSITION_WIZARD

inherit
	EV_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create wizard.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			default_create
			set_title (interface_names.b_create_new_feature)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			create vb
			vb.set_padding (layout_constants.small_padding_size)
			vb.set_border_width (layout_constants.default_border_size)
			build_selector
			vb.extend (feature_select)
			vb.disable_item_expand (feature_select)

			create feature_editor_frame
			vb.extend (feature_editor_frame)

			set_default_editor
			create hb
			hb.set_padding (layout_constants.small_padding_size)
			hb.extend (create {EV_CELL})
			create ok_button.make_with_text (Interface_names.b_Ok)
			ok_button.select_actions.extend (agent on_ok)
			extend_button (hb, ok_button)
			create cancel_button.make_with_text (Interface_names.b_Cancel)
			cancel_button.select_actions.extend (agent on_cancel)
			extend_button (hb, cancel_button)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			show_actions.extend (agent (feature_editor.feature_name_field).select_all)
			show_actions.extend (agent set_focus_to_feature_name_field)
		end

	set_default_editor
			-- Select the default editor.
		do
			create {EB_FUNCTION_EDITOR} feature_editor
			feature_editor_frame.extend (feature_editor)
			if not attr_button.is_selected then
				attr_button.enable_select
			end
		end

	build_selector
			-- Create `feature_select' radio group.
		local
			h_box: EV_HORIZONTAL_BOX
		do
			create feature_select.make_with_text (interface_names.l_select_feature_type)
			create h_box
			extend_no_expand (h_box, create {EV_CELL})
			h_box.i_th (1).set_minimum_width (layout_constants.default_padding_size)
			feature_select.extend (h_box)
			create proc_button.make_with_text (interface_names.l_procedure)
			h_box.extend (proc_button)
			proc_button.select_actions.extend (agent on_proc_select)
			create func_button.make_with_text (interface_names.l_function)
			h_box.extend (func_button)
			func_button.select_actions.extend (agent on_func_select)
			create attr_button.make_with_text (interface_names.l_Attribute)
			h_box.extend (attr_button)
			attr_button.select_actions.extend (agent on_attr_select)
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button labeled "OK".

	cancel_button: EV_BUTTON
			-- Button labeled "Cancel".

	code: STRING_32
			-- Current text of the feature in the wizard.
		do
			Result := feature_editor.code
		end

	clause_export: STRING_32
			-- User selected export clause.
		do
			Result := feature_editor.feature_clause_selector.export_field.text
			Result.to_lower
			if Result.is_equal ("any") then
				create Result.make (0)
			end
		end

	clause_comment: STRING_32
			-- User selected feature clause.
		do
			Result := feature_editor.feature_clause_selector.comment_field.text
		end

	feature_name: STRING_32
			-- User selected name for feature.
		do
			Result := feature_editor.feature_name_field.text
		end

	feature_type: STRING_32
			-- Return type if attribute or function.
		local
			qe: EB_QUERY_EDITOR
		do
			qe ?= feature_editor
			if qe /= Void then
				Result := qe.type
			end
		end

	feature_arguments: STRING_32
			-- Arguments of current feature if any.
		local
			qe: EB_QUERY_EDITOR
		do
			qe ?= feature_editor
			if qe /= Void then
				Result := qe.arguments_code
			end
		end

	generate_setter_procedure: BOOLEAN
			-- Should a set-procedure be generated?
		local
			e: EB_QUERY_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.generate_setter_procedure
			end
		end

	setter_name: STRING_32
			-- Name of set-procedure if any.
		local
			e: EB_QUERY_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.setter_name
			end
		end

	precondition: STRING_32
			-- Precondition selected for set-procedure.
			-- Void if none.
		local
			e: EB_ATTRIBUTE_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.precondition
			end
		end

	invariant_part: STRING_32
			-- Invariant for feature. Void if none.
		local
			e: EB_ATTRIBUTE_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.invariant_part
			end
		end

feature -- Status setting

	set_client_type (c: ES_CLASS)
			-- Set client type to `c'.
		do
			feature_editor.set_client_type (c)
		end

	set_supplier_type (s: ES_CLASS)
			-- Create a supplier of type `s'.
			-- (Could disable user selection...)
		do
			feature_editor.set_supplier_type (s)
			feature_editor.set_type (s.name_32)
		end

	set_name_number (a_number: INTEGER)
			-- Assign `a_number' to `name_number'.
		local
			qe: EB_QUERY_EDITOR
		do
			qe ?= feature_editor
			if qe /= Void then
				qe.set_name_number (a_number)
			end
		ensure
			a_number_assigned: feature_editor.name_number = a_number
		end

feature -- Status report

	valid_content: BOOLEAN
			-- Is user input valid for code generation?
		do
			Result := feature_editor.valid_content
		end

	ok_clicked: BOOLEAN
			-- Was "OK" clicked?
			-- ie should code be generated?

feature {NONE} -- Implementation

	on_proc_select
			-- User selected "procedure".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_procedure then
				fe := feature_editor
				create {EB_PROCEDURE_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_height (minimum_height)
			end
		end

	on_func_select
			-- User selected "function".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_function then
				fe := feature_editor
				create {EB_FUNCTION_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_height (minimum_height)
			end
		end

	on_attr_select
			-- User selected "attribute".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_attribute then
				fe := feature_editor
				create {EB_ATTRIBUTE_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_height (minimum_height)
			end
		end

	on_ok
			-- OK button was clicked.
		do
			ok_clicked := True
			if feature_editor.valid_content then
				hide
			else
				feature_editor.show_error (Current)
			end
		end

	on_cancel
			-- Cancel button was clicked.
		do
			ok_clicked := False
			hide
		end

	set_focus_to_feature_name_field
			-- Assign focus to feature name field.
		do
			feature_editor.feature_name_field.set_focus
		end

	feature_select: EV_FRAME
			-- Containing of the radio buttons.

	proc_button, func_button, attr_button: EV_RADIO_BUTTON
			-- Radio buttons to select feature type.

	feature_editor: EB_FEATURE_EDITOR
			-- Feature edit component.

	feature_editor_frame: EV_FRAME;
			-- Container of `feature_editor'.

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
