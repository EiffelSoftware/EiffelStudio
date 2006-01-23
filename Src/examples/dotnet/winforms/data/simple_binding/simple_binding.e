indexing
	description:"Simple binding example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	SIMPLE_BINDING

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
		local
			dob_binding: WINFORMS_BINDING
			return: WINFORMS_BINDING
		do
			initialize_components

				-- Set up the bindings so that each field on the form is
				-- bound to a property of Customer
			return := text_box_id.data_bindings.add ("Text", cust_list, "")
			return := text_box_title.data_bindings.add ("Text", cust_list, "")
			return := text_box_last_name.data_bindings.add ("Text", cust_list, "")
			return := text_box_first_name.data_bindings.add ("Text", cust_list, "")

				-- We want to format the date so handle the format and parse events for the
				-- DOB text box
			create dob_binding.make ("Text", cust_list, "")
			dob_binding.add_format (
				(create {WINFORMS_CONVERT_EVENT_HANDLER}.make (Current,
					$text_box_dob_format_date)))
			dob_binding.add_parse (
				(create {WINFORMS_CONVERT_EVENT_HANDLER}.make (Current,
					$text_box_dob_parse_date)))
			text_box_dob.data_bindings.add_binding (dob_binding)
			return := text_box_address.data_bindings.add_string ("Text", cust_list, "")

				-- We want to handle position changing events for the DATA VCR Panel
				-- Position is managed by the Form's BindingContext so hook the position
				-- changed event on the BindingContext
			binding_context.item (cust_list).add_position_changed (
				create {EVENT_HANDLER}.make (Current, $customers_position_changed))

				-- Set up the initial text for the DATA VCR Panel
			text_box_position.set_text ("Record " + (binding_context.item (cust_list).position + 1).out + " of " + cust_list.count.out)

				-- Set the minimum form size to the client size + the height of the title bar
			set_minimum_size (create {DRAWING_SIZE}.make (368, (413 +
				{WINFORMS_SYSTEM_INFORMATION}.caption_height)))

			{WINFORMS_APPLICATION}.run (Current)
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container

	text_box_dob, text_box_position: WINFORMS_TEXT_BOX
			-- System.Windows.Forms.TextBox

	label_dob: WINFORMS_LABEL
			-- System.Windows.Forms.Label

	button_move_first, button_move_prev, button_move_next, button_move_last: WINFORMS_BUTTON
			-- System.Windows.Forms.Button 

	text_box_title, text_box_last_name, text_box_address, text_box_first_name, text_box_id: WINFORMS_TEXT_BOX
			-- System.Windows.Forms.TextBox

	label_title, label_address, label_last_name, label_first_name, label_id: WINFORMS_LABEL
			-- System.Windows.Forms.Label

	panel_vcr_control: WINFORMS_PANEL
			--System.Windows.Forms.Panel 

	cust_list: CUSTOMER_LIST is
			-- Customer list
		once
			create Result
			Result.initialize
		ensure
			non_void_result: Result /= Void
		end

feature -- Implementation

	initialize_components is
			-- Initialize windows components.
		do
			create components.make
			create text_box_title.make
			create label_first_name.make
			create text_box_id.make
			create button_move_next.make
			create button_move_prev.make
			create label_title.make
			create text_box_last_name.make
			create label_dob.make
			create text_box_position.make
			create text_box_dob.make
			create panel_vcr_control.make
			create text_box_address.make
			create label_last_name.make
			create label_id.make
			create button_move_first.make
			create label_address.make
			create text_box_first_name.make
			create button_move_last.make

			set_text ("Customer Details")
			set_auto_scale_base_size (create {DRAWING_SIZE}.make (5, 13))
			set_client_size (create {DRAWING_SIZE}.make (368, 413))

			label_id.set_location (create {DRAWING_POINT}.make (8, 32))
			label_id.set_text ("ID:")
			label_id.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_id.set_tab_index (1)
			text_box_id.set_location (create {DRAWING_POINT}.make (88, 30))
			text_box_id.set_read_only (True)
			text_box_id.set_enabled (False)
			text_box_id.set_tab_stop (False)
			text_box_id.set_tab_index (2)
			text_box_id.set_size (create {DRAWING_SIZE}.make (203, 20))

			label_title.set_location (create {DRAWING_POINT}.make (8, 72))
			label_title.set_text ("&Title:")
			label_title.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_title.set_tab_index (3)
			text_box_title.set_location (create {DRAWING_POINT}.make (88, 70))
			text_box_title.set_tab_index (4)
			text_box_title.set_size (create {DRAWING_SIZE}.make (70, 20))

			label_first_name.set_location (create {DRAWING_POINT}.make (8, 112))
			label_first_name.set_text ("&First Name:")
			label_first_name.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_first_name.set_tab_index (5)
			text_box_first_name.set_location (create {DRAWING_POINT}.make (88, 112))
			text_box_first_name.set_tab_index (6)
			text_box_first_name.set_anchor 
				({WINFORMS_ANCHOR_STYLES}.Top | {WINFORMS_ANCHOR_STYLES}.left |
				{WINFORMS_ANCHOR_STYLES}.right)
			text_box_first_name.set_size (create {DRAWING_SIZE}.make (243, 20))
			
			label_last_name.set_location (create {DRAWING_POINT}.make (8, 154))
			label_last_name.set_text ("&Last Name:")
			label_last_name.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_last_name.set_tab_index (7)
			text_box_last_name.set_location (create {DRAWING_POINT}.make (88, 152))
			text_box_last_name.set_tab_index (8)
			text_box_last_name.set_anchor (
				{WINFORMS_ANCHOR_STYLES}.Top | {WINFORMS_ANCHOR_STYLES}.left |
				{WINFORMS_ANCHOR_STYLES}.right)
			text_box_last_name.set_size (create {DRAWING_SIZE}.make (243, 20))

			label_dob.set_location (create {DRAWING_POINT}.make (8, 194))
			label_dob.set_text ("&Date of Birth:")
			label_dob.set_size (create {DRAWING_SIZE}.make (92, 16))
			label_dob.set_tab_index (9)
			text_box_dob.set_location (create {DRAWING_POINT}.make (88, 192))
			text_box_dob.set_tab_index (10)
			text_box_dob.set_anchor (
				{WINFORMS_ANCHOR_STYLES}.top | {WINFORMS_ANCHOR_STYLES}.left |
				{WINFORMS_ANCHOR_STYLES}.right)
			text_box_dob.set_size (create {DRAWING_SIZE}.make (243, 20))

			label_address.set_location (create {DRAWING_POINT}.make (8, 232))
			label_address.set_text ("&address:")
			label_address.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_address.set_tab_index (11)
			text_box_address.set_location (create {DRAWING_POINT}.make (88, 232))
			text_box_address.set_multiline (True)
			text_box_address.set_accepts_return (True)
			text_box_address.set_tab_index (12)
			text_box_address.set_anchor (
				{WINFORMS_ANCHOR_STYLES}.Top |
				{WINFORMS_ANCHOR_STYLES}.Bottom |
				{WINFORMS_ANCHOR_STYLES}.right | {WINFORMS_ANCHOR_STYLES}.left)
			text_box_address.set_size (create {DRAWING_SIZE}.make (264, 88))

			button_move_next.set_location (create {DRAWING_POINT}.make (184, 8))
			button_move_next.set_flat_style ({WINFORMS_FLAT_STYLE}.flat)
			button_move_next.set_size (create {DRAWING_SIZE}.make (32, 32))
			button_move_next.set_tab_index (33)
			button_move_next.set_anchor ({WINFORMS_ANCHOR_STYLES}.top)
			button_move_next.set_text (">")
			button_move_next.add_click (
				create {EVENT_HANDLER}.make (Current, $button_move_next_click))

			button_move_prev.set_location (create {DRAWING_POINT}.make (48, 8))
			button_move_prev.set_flat_style ({WINFORMS_FLAT_STYLE}.flat)
			button_move_prev.set_size (create {DRAWING_SIZE}.make (32, 32))
			button_move_prev.set_tab_index (31)
			button_move_prev.set_text ("<")
			button_move_prev.add_click (
				create {EVENT_HANDLER}.make (Current, $button_move_prev_click))

			text_box_position.set_location (create {DRAWING_POINT}.make (88, 14))
			text_box_position.set_read_only (True)
			text_box_position.set_border_style ({WINFORMS_BORDER_STYLE}.fixed_single)
			text_box_position.set_enabled (False)
			text_box_position.set_tab_stop (False)
			text_box_position.set_anchor ({WINFORMS_ANCHOR_STYLES}.left)
			text_box_position.set_size (create {DRAWING_SIZE}.make (88, 20))

			panel_vcr_control.set_border_style ({WINFORMS_BORDER_STYLE}.fixed_single)
			panel_vcr_control.set_location (create {DRAWING_POINT}.make (88, 344))
			panel_vcr_control.set_size (create {DRAWING_SIZE}.make (264, 48))
			panel_vcr_control.set_tab_index (32)
			panel_vcr_control.set_anchor ({WINFORMS_ANCHOR_STYLES}.Bottom)
			panel_vcr_control.set_text ("panel1")

			button_move_first.set_location (create {DRAWING_POINT}.make (8, 8))
			button_move_first.set_flat_style ({WINFORMS_FLAT_STYLE}.flat)
			button_move_first.set_size (create {DRAWING_SIZE}.make (32, 32))
			button_move_first.set_tab_index (30)
			button_move_first.set_text ("|<")
			button_move_first.add_click (
				create {EVENT_HANDLER}.make (Current, $button_move_first_click))

			button_move_last.set_location (create {DRAWING_POINT}.make (224, 8))
			button_move_last.set_flat_style ({WINFORMS_FLAT_STYLE}.flat)
			button_move_last.set_size (create {DRAWING_SIZE}.make (32, 32))
			button_move_last.set_tab_index (34)
			button_move_last.set_anchor ({WINFORMS_ANCHOR_STYLES}.Top)
			button_move_last.set_text (">|")
			button_move_last.add_click (
				create {EVENT_HANDLER}.make (Current, $button_move_last_click))

			panel_vcr_control.controls.add (text_box_position)
			panel_vcr_control.controls.add (button_move_first)
			panel_vcr_control.controls.add (button_move_prev)
			panel_vcr_control.controls.add (button_move_next)
			panel_vcr_control.controls.add (button_move_last)

			controls.add (text_box_dob)
			controls.add (label_dob)
			controls.add (panel_vcr_control)
			controls.add (text_box_title)
			controls.add (label_title)
			controls.add (text_box_address)
			controls.add (label_address)
			controls.add (text_box_last_name)
			controls.add (label_last_name)
			controls.add (text_box_address)
			controls.add (label_address)
			controls.add (text_box_first_name)
			controls.add (label_first_name)
			controls.add (text_box_id)
			controls.add (label_id)
		end

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := True
			retry
		end

	text_box_dob_format_date (sender: SYSTEM_OBJECT; e: WINFORMS_CONVERT_EVENT_ARGS) is
			-- Format the Date Field in long date form for display in the TextBox.
		local
			l_string: SYSTEM_STRING
			l_date: SYSTEM_DATE_TIME
		do
			l_string ?= e.desired_type
			l_date ?= e.value
			if l_string /= Void and l_date /= Void then
				e.set_value (l_date.to_long_date_string)
			end
		end

	text_box_dob_parse_date (sender: SYSTEM_OBJECT; e: WINFORMS_CONVERT_EVENT_ARGS) is
			-- Parse the textbox contents and turn them back into a date.
		local
			rescued: BOOLEAN
			l_string: SYSTEM_STRING
			l_date: SYSTEM_DATE_TIME
		do
			if not rescued then
				l_string ?= e.desired_type
				l_date ?= e.value
				if l_string /= Void and l_date /= Void then
					e.set_value ({SYSTEM_DATE_TIME}.parse (l_string))
				end
			end
		rescue
			rescued := True
			retry
		end

	button_move_first_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- When the MoveFirst button is clicked set the position for the CustomersList
			-- to the first record
		do
			binding_context.item (cust_list).set_position (0)
		end

	button_move_last_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- When the MoveLast button is clicked set the position for the CustomersList
			-- to the last record
		do
			binding_context.item (cust_list).set_position (cust_list.count - 1)
		end

	button_move_next_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- When the MoveNext button is clicked increment the position for the CustomersList
		do
			if binding_context.item (cust_list).position < cust_list.count - 1 then
				binding_context.item (cust_list).set_position (binding_context.item (cust_list).position + 1)
			end
		end

	button_move_prev_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- When the MovePrev button is clicked decrement the position for the CustomersList
		do
			if binding_context.item (cust_list).position > 0 then
				binding_context.item (cust_list).set_position (binding_context.item (cust_list).position - 1)
			end
		end

	customers_position_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Position has changed - update the DATA VCR panel
		do
			text_box_position.set_text ({SYSTEM_STRING}.Format(
				"Record {0} of {1}",
				binding_context.item (cust_list).position + 1,
				cust_list.count))
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class SIMPLE_BINDING
