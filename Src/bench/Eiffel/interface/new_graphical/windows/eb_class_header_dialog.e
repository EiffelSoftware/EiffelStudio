indexing
	description:
		"Dialogs that let the user edit the name and formal generics of a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_HEADER_DIALOG

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
			-- Build interface.
		local
			local_button: EV_RADIO_BUTTON
			fvb, vb_top, vb, vb_label, vb_text_field: EV_VERTICAL_BOX
			hb, hb_name, hb_old: EV_HORIZONTAL_BOX
			f_bottom, f_top: EV_FRAME
			l: EV_LABEL
			sep: EV_HORIZONTAL_SEPARATOR
		do
			Precursor
			set_title (Interface_names.t_Diagram_class_header)
		
			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.default_border_size)
			create f_top
			create vb_top
			vb_top.set_padding (Layout_constants.small_padding_size)
			create current_name
			create hb_old
			hb_old.extend (current_name)
			hb_old.disable_item_expand (current_name)
			vb_top.extend (create {EV_CELL})
			vb_top.extend (hb_old)
			create sep
			vb_top.extend (sep)
			vb_top.disable_item_expand (sep)
			create vb_label
			vb_label.set_padding (Layout_constants.small_padding_size)
			vb_label.set_border_width (Layout_constants.default_border_size)
			create hb_name
			create l.make_with_text ("New name:")
			vb_label.extend (l)
			vb_label.disable_item_expand (l)
			vb_label.extend (create {EV_CELL})
			create l.make_with_text ("Formal generics:")
			vb_label.extend (l)
			vb_label.disable_item_expand (l)
			hb_name.extend (vb_label)
			hb_name.disable_item_expand (vb_label)
			create vb_text_field
			vb_text_field.set_padding (Layout_constants.small_padding_size)
			vb_text_field.set_border_width (Layout_constants.default_border_size)
			create name_field
			name_field.set_minimum_height (22)
			vb_text_field.extend (name_field)
			vb_text_field.disable_item_expand (name_field)
			create generics_field
			generics_field.set_minimum_height (22)
			vb_text_field.extend (generics_field)
			vb_text_field.disable_item_expand (generics_field)
			hb_name.extend (vb_text_field)
			vb_top.extend (hb_name)
			vb_top.disable_item_expand (hb_name)
			f_top.extend (vb_top)
			vb.extend (f_top)

			create f_bottom
			create fvb
			fvb.set_padding (Layout_constants.small_padding_size)
			fvb.set_border_width (Layout_constants.default_border_size)
			f_bottom.extend (fvb)
			create local_button.make_with_text ("Change name locally")
			fvb.extend (local_button)
			create global_button.make_with_text ("Global search/replace of name in compiled classes")
			fvb.extend (global_button)
			create non_compiled_button.make_with_text ("Global search/replace of name in entire universe")
			fvb.extend (non_compiled_button)
			vb.extend (f_bottom)
			global_button.enable_select

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			hb.set_padding (Layout_constants.small_padding_size)
			hb.extend (create {EV_CELL})

			create ok_button.make_with_text_and_action (Interface_names.b_Ok, ~on_ok_pressed)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel_text, ~on_cancel_pressed)
			extend_button (hb, ok_button)
			extend_button (hb, cancel_button)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Status report

	ok_pressed: BOOLEAN
			-- Did the user confirm the action?

	global_replace: BOOLEAN is
			-- Should the class name be replaced globally.
			-- (As opposed to just in the header and class-end)
		do
			Result := global_replace_compiled or global_replace_universe
		end

	global_replace_compiled: BOOLEAN is
			-- Should the class name be replaced globally.
			-- (As opposed to just in the header and class-end)
		do
			Result := global_button.is_selected
		end

	global_replace_universe: BOOLEAN is
			-- Should class names be replaced in classes that
			-- are in the universe but not compiled?
		do
			Result := non_compiled_button.is_selected
		end

feature -- Access

	ok_button: EV_BUTTON
			-- Button with label "OK".
			
	cancel_button: EV_BUTTON
			-- Button with label "Cancel".

	name: STRING is
			-- Class name typed by user.
		do
			Result := name_field.text
		end

	generics: STRING is
			-- Formal generics typed by user.
		do
			Result := generics_field.text
		end

feature -- Element change

	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			current_name.set_text ("   Class name:           " + a_name)
			if a_name.is_empty then
				name_field.remove_text			
			else
				name_field.set_text (a_name)
			end
		end

	set_generics (a_string: STRING) is
			-- Assign `a_string' to `generics'.
		require
			a_string_not_void: a_string /= Void
		do
			generics_field.set_text (a_string)
		ensure
			assigned: generics.is_equal (a_string)
		end

feature {NONE} -- Implementation

	name_field, generics_field: EV_TEXT_FIELD
	global_button: EV_RADIO_BUTTON
	non_compiled_button: EV_RADIO_BUTTON
	current_name: EV_LABEL

	on_ok_pressed is
			-- The user pressed OK.
		do
			ok_pressed := True
			destroy
		end

	on_cancel_pressed is
			-- The user pressed Cancel.
		do
			ok_pressed := False
			destroy
		end

end -- class EB_CLASS_HEADER_DIALOG