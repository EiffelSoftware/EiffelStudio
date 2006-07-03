indexing
	description: "Dialog that allows to choose what kind of external to add."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_EXTERNAL_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	PROPERTY_GRID_LAYOUT
		undefine
			default_create,
			copy
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create,
			copy
		end

	EB_LAYOUT_CONSTANTS
		undefine
			default_create,
			copy
		end


create
	default_create,
	make_with_title

feature {NONE} -- Initialization

	initialize is
			-- Initialize.
		local
			vb: EV_VERTICAL_BOX
			hb1, hb: EV_HORIZONTAL_BOX
			cl: EV_CELL
			rb: EV_RADIO_BUTTON
		do
			Precursor {EV_DIALOG}

			set_title (dialog_external_add)

			create hb1
			extend (hb1)
			append_margin (hb1)
			create vb
			hb1.extend (vb)
			append_margin (vb)
			create element_container
			vb.extend (element_container)

			create rb.make_with_text_and_action (external_include, agent on_include)
			element_container.extend (rb)
			create rb.make_with_text_and_action (external_object, agent on_object)
			element_container.extend (rb)
			create rb.make_with_text_and_action (external_library, agent on_library)
			element_container.extend (rb)
			create rb.make_with_text_and_action (external_make, agent on_make)
			element_container.extend (rb)
			create rb.make_with_text_and_action (external_resource, agent on_resource)
			element_container.extend (rb)

			append_small_margin (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.set_padding (default_padding_size)
			create cl
			hb.extend (cl)
			create ok_button.make_with_text_and_action (ev_ok, agent on_ok)
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			ok_button.set_minimum_width (default_button_width)
			create cancel_button.make_with_text_and_action (ev_cancel, agent on_cancel)
			hb.extend (cancel_button)
			hb.disable_item_expand (cancel_button)
			cancel_button.set_minimum_width (default_button_width)

			append_margin (vb)
			append_margin (hb1)

			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
		end

feature -- Access

	is_ok: BOOLEAN
			-- Did the dialog close with an ok?

	is_include: BOOLEAN
			-- Was include as type of the new external choosen?
	is_object: BOOLEAN
			-- Was object as type of the new external choosen?
	is_library: BOOLEAN
			-- Was library as type of the new external choosen?
	is_make: BOOLEAN
			-- Was makefile as type of the new external choosen?
	is_resource: BOOLEAN
			-- Was ressource as type of the new external choosen?

feature {NONE} -- GUI elements

	element_container: EV_VERTICAL_BOX
			-- Container to add new elements.

	cancel_button: EV_BUTTON
			-- Cancel button.

	ok_button: EV_BUTTON
			-- Ok Button.

feature {NONE} -- Agents

	on_include is
			-- Include was choosen.
		do
			is_include := True
			is_object := False
			is_library := False
			is_make := False
			is_resource := False
		end

	on_object is
			-- Object was choosen.
		do
			is_include := False
			is_object := True
			is_library := False
			is_make := False
			is_resource := False
		end

	on_library is
			-- Library was choosen.
		do
			is_include := False
			is_object := False
			is_library := True
			is_make := False
			is_resource := False
		end

	on_make is
			-- Make was choosen.
		do
			is_include := False
			is_object := False
			is_library := False
			is_make := True
			is_resource := False
		end

	on_resource is
			-- Resource was choosen.
		do
			is_include := False
			is_object := False
			is_library := False
			is_make := False
			is_resource := True
		end

	on_ok is
			-- Ok was pressed.
		do
			is_ok := True
			destroy
		end

	on_cancel is
			-- Cancel was pressed.
		do
			is_ok := False
			destroy
		end

invariant
	elements: is_initialized implies ok_button /= Void and cancel_button /= Void
	one_type: is_include implies not (is_object or is_make or is_resource)

end
