indexing
	description:
		"Combobox that lets the user select a type%N%
		%If that type has generics, displays more type selectors."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_SELECTOR

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Build interface.
		local
			hb: EV_HORIZONTAL_BOX
		do
			Precursor
			create hb
			create name_field
			name_field.set_minimum_width (60)
			extend (name_field)
			disable_item_expand (last)
			extend (new_label (": "))
			disable_item_expand (last)
			create type_selector
			hb.extend (type_selector)
			hb.disable_item_expand (hb.last)
			create remove_button
			remove_button.set_pixmap (Pixmaps.icon_delete_small @ 1)
			remove_button.set_minimum_size (16, 16)
			hb.extend (remove_button)
			hb.disable_item_expand (hb.last)
			hb.set_padding (Layout_constants.small_padding_size)
			extend (hb)
		end

feature -- Access

	name_field: EB_FEATURE_NAME_EDIT
			-- Argument label text box.
	
	type_selector: EB_TYPE_SELECTOR
			-- Argument type selection widget.
			
	remove_button: EV_BUTTON
			-- Button to remove `Current' from its container.
			-- Does nothing until `set_remove_procedure' gets called.

	code: STRING is
			-- Generated code.
		local
			t: STRING
		do
			t := name_field.text
			create Result.make (10)
			if t /= Void then
				Result.append (t)
				Result.append (": ")
				Result.append (type_selector.code)
			end
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		local
			t: STRING
		do
			t := name_field.text
			Result := t /= Void and then not t.is_empty
		end

feature -- Status setting

	add_semicolon is
			-- Append a semicolon label at the end of `Current'.
		do
			extend (new_label (";"))
			disable_item_expand (last)
		end

	remove_semicolon is
			-- Remove the semicolon label at the end of `Current'.
		local
			lbl: EV_LABEL
		do
			lbl ?= last
			if lbl /= Void then
				prune_all (lbl)
			end
		end
		
feature -- Element change

	set_name (a_name: STRING) is
			-- Put `a_name' in `name_field'.
		do
			if a_name.is_empty then
				name_field.remove_text
			else
				name_field.set_text (a_name)
			end
		end

	set_remove_procedure (proc: PROCEDURE [ANY, TUPLE]) is
			-- Make `remove_button' call `proc'.
		require
			proc_exists: proc /= Void
		do
			remove_button.select_actions.wipe_out
			remove_button.select_actions.extend (proc)
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
		end

end -- class EB_ARGUMENT_SELECTOR
