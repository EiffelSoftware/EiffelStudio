indexing
	description:
		"Wizard to create features and insert them in a specific%N%
		%feature clause."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_COMPOSITION_WIZARD

inherit
	EV_DIALOG
		redefine
			initialize
		end

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

feature {NONE} -- Initialization

	initialize is
			-- Create wizard.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			Precursor
			set_title ("Create feature")
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
			ok_button.select_actions.extend (~on_ok)
			extend_button (hb, ok_button)
			create cancel_button.make_with_text (Interface_names.b_Cancel)
			cancel_button.select_actions.extend (~on_cancel)
			extend_button (hb, cancel_button)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			set_maximum_height (height)
		end

	set_default_editor is
			-- Select the default editor.
		do
			create {EB_PROCEDURE_EDITOR} feature_editor
			feature_editor_frame.extend (feature_editor)
			if not proc_button.is_selected then
				proc_button.enable_select
			end
		end

	build_selector is
			-- Create `feature_select' radio group.
		local
			vb: EV_HORIZONTAL_BOX
		do
			create feature_select.make_with_text ("Select feature type")
			create vb
			feature_select.extend (vb)
			create proc_button.make_with_text ("Procedure")
			vb.extend (proc_button)
			proc_button.select_actions.extend (~on_proc_select)
			create func_button.make_with_text ("Function")
			vb.extend (func_button)
			func_button.select_actions.extend (~on_func_select)
			create attr_button.make_with_text ("Attribute")
			vb.extend (attr_button)
			attr_button.select_actions.extend (~on_attr_select)
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button labeled "OK".

	cancel_button: EV_BUTTON
			-- Button labeled "Cancel".

	code: STRING is
			-- Current text of the feature in the wizard.
		do
			Result := feature_editor.code
		end

	clause_export: STRING is
			-- User selected export clause.
		do
			Result := feature_editor.feature_clause_selector.export_field.text
			if Result = Void then
				create Result.make (0)
			else
				Result.to_lower
				if Result.is_equal ("any") then
					create Result.make (0)
				end
			end
		end

	clause_comment: STRING is
			-- User selected feature clause.
		do
			Result := feature_editor.feature_clause_selector.comment_field.text
			if Result = Void then
				create Result.make (0)
			end
		end

	feature_name: STRING is
			-- User selected name for feature.
		do
			Result := feature_editor.feature_name_field.text
		end

	feature_type: STRING is
			-- Return type if attribute or function.
		local
			qe: EB_QUERY_EDITOR
		do
			qe ?= feature_editor
			if qe /= Void then
				Result := qe.type
			end
		end

	generate_setter_procedure: BOOLEAN is
			-- Should a set-procedure be generated?
		local
			e: EB_ATTRIBUTE_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.generate_setter_procedure
			end
		end

	precondition: STRING is
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

	invariant_part: STRING is
			-- Invariant for feature. Void if none.
		local
			e: EB_ATTRIBUTE_EDITOR
		do
			e ?= feature_editor
			if e /= Void then
				Result := e.invariant_part
			end
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
			Result := feature_editor.valid_content
		end

	ok_clicked: BOOLEAN
			-- Was "OK" clicked?
			-- ie should code be generated?

feature {NONE} -- Implementation

	on_proc_select is
			-- User selected "procedure".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_procedure then
				fe := feature_editor
				create {EB_PROCEDURE_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_maximum_height (height)
			end
		end

	on_func_select is
			-- User selected "function".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_function then
				fe := feature_editor
				create {EB_FUNCTION_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_maximum_height (height)
			end
		end

	on_attr_select is
			-- User selected "attribute".
		local
			fe: like feature_editor
		do
			if not feature_editor.is_attribute then
				fe := feature_editor
				create {EB_ATTRIBUTE_EDITOR} feature_editor
				feature_editor.adapt (fe)
				feature_editor_frame.replace (feature_editor)
				set_maximum_height (minimum_height)
			end
		end

	on_ok is
			-- OK button was clicked.
		do
			ok_clicked := True
			hide
		end

	on_cancel is
			-- Cancel button was clicked.
		do
			ok_clicked := False
			hide
		end

	feature_select: EV_FRAME
			-- Containing of the radio buttons.

	proc_button, func_button, attr_button: EV_RADIO_BUTTON
			-- Radio buttons to select feature type.

	feature_editor: EB_FEATURE_EDITOR
			-- Feature edit component.

	feature_editor_frame: EV_FRAME
			-- Container of `feature_editor'.

end -- class EB_FEATURE_COMPOSITION_WIZARD