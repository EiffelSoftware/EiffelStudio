indexing
	description: "Registrar client, user interface to add registrants and registrations."

class
	REGISTRATION_CLIENT_UNCHECKED
alias
	"RegistrationClient.ClientUnchecked"

inherit
	SYSTEM_WINDOWS_FORMS_FORM
	
create
	make

feature {NONE} -- Initialization

	make is
			-- create {a new client window.
		local
			return_value: SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			initialize_gui
			create registrar.make_registrar
			return_value := show_dialog
		end

feature -- Access
	
	registrar: REGISTRAR
			-- Proxy to registrar object

feature -- GUI components

	title_combo_box: SYSTEM_WINDOWS_FORMS_COMBOBOX
			-- Title combo box
	
	first_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- First name single line edit
			
	last_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Last name single line edit
			
	company_name_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Company name single line edit
			
	address_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Address single line edit
			
	city_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- City name single line edit
			
	state_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- State code single line edit
			
	zip_code_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Zip code single line edit
			
	country_text_box: SYSTEM_WINDOWS_FORMS_TEXTBOX
			-- Country name single line edit

	quantity_up_down: SYSTEM_WINDOWS_FORMS_NUMERICUPDOWN
			-- Participants number single line edit

	discount_plan_combo_box: SYSTEM_WINDOWS_FORMS_COMBOBOX
			-- Discount plan type combo box

	preconference_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Pre-conference check box
			
	wet_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- WET check box
			
	conference_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Conference check box
			
	eiffel_summit_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Eiffel summit check box
			
	postconference_check_box: SYSTEM_WINDOWS_FORMS_CHECKBOX
			-- Post-conference check box
	
	title_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Title label
			
	first_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- First name label
			
	last_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Last name label
			
	company_name_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Company name label
			
	address_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Address label
			
	city_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- City label
			
	state_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- State label
			
	zip_code_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Zip code label
			
	country_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Country label
			
	quantity_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Number of participants label
			
	discount_plan_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Discount plan label
			
	registration_type_label: SYSTEM_WINDOWS_FORMS_LABEL
			-- Type of registration label
	
	ok_button: SYSTEM_WINDOWS_FORMS_BUTTON
			-- OK Button

feature {NONE} -- Implementation

	on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
			-- Process ok button activation.
		local
			message_result: expanded SYSTEM_WINDOWS_FORMS_DIALOGRESULT
		do
			registrar.add_registrant (title_combo_box.get_text, first_name_text_box.get_text,
					last_name_text_box.get_text, company_name_text_box.get_text, address_text_box.get_text,
					city_text_box.get_text, state_text_box.get_text, zip_code_text_box.get_text,
					country_text_box.get_text)
			if registrar.last_operation_successful then
				registrar.add_registration (registrar.last_registrant_identifier, quantity_up_down.get_value.to_string,
					discount_plan_combo_box.get_text, preconference_check_box.get_checked,
					wet_check_box.get_checked, conference_check_box.get_checked,
					eiffel_summit_check_box.get_checked, postconference_check_box.get_checked)
			end
			if registrar.last_operation_successful then
				message_result := message_box_factory.show_string_string ("Registration successfully stored.", "Registration Success")
			else
				message_result := message_box_factory.show_string_string (registrar.last_error_message, "Registration Failure")
			end
		end

	initialize_gui is
			-- Initialize form.
		local
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			type: SYSTEM_TYPE
			decimal: SYSTEM_DECIMAL
			border_styles: SYSTEM_WINDOWS_FORMS_FORMBORDERSTYLE
			a_size: SYSTEM_DRAWING_SIZE
			a_point: SYSTEM_DRAWING_POINT
		do
			set_text ("TOOLS Registration")
			set_form_border_style (Border_styles.fixed_dialog)
			a_size.make_size_1 (380, 600)
			set_size (a_size)

			create title_label.make_label
			title_label.set_text ("Title:")
			a_point.make_point (30, 30)
			title_label.set_location (a_point)
			
			create title_combo_box.make_combobox
			a_point.make_point (180,30)
			title_combo_box.set_location (a_point)
			title_combo_box.get_items.add_range (<<"Mr.", "Ms.", "Miss", "Mrs.", "Dr.">>)
			title_combo_box.set_text ("Mr.")
			
			create first_name_label.make_label
			first_name_label.set_text ("First Name:")
			a_point.make_point (30, 60)
			first_name_label.set_location (a_point)
			
			create first_name_text_box.make_textbox
			a_point.make_point (180, 60)
			first_name_text_box.set_location (a_point)
			a_size.make_size_1 (150,20)
			first_name_text_box.set_size (a_size)
			
			create last_name_label.make_label
			last_name_label.set_text ("Last Name:")
			a_point.make_point (30, 90)
			last_name_label.set_location (a_point)
			
			create last_name_text_box.make_textbox
			a_point.make_point (180, 90)
			last_name_text_box.set_location (a_point)
			last_name_text_box.set_size (a_size)
			
			create company_name_label.make_label
			company_name_label.set_text ("Company Name:")
			a_point.make_point (30, 120)
			company_name_label.set_location (a_point)
			
			create company_name_text_box.make_textbox
			a_point.make_point (180, 120)
			company_name_text_box.set_location (a_point)
			company_name_text_box.set_size (a_size)
			
			create address_label.make_label
			address_label.set_text ("Address:")
			a_point.make_point (30, 150)
			address_label.set_location (a_point)
			
			create address_text_box.make_textbox
			a_point.make_point (180, 150)
			address_text_box.set_location (a_point)
			address_text_box.set_size (a_size)
			
			create city_label.make_label
			city_label.set_text ("City:")
			a_point.make_point (30, 180)
			city_label.set_location (a_point)
			
			create city_text_box.make_textbox
			a_point.make_point (180, 180)
			city_text_box.set_location (a_point)
			city_text_box.set_size (a_size)
			
			create state_label.make_label
			state_label.set_text ("State:")
			a_point.make_point (30, 210)
			state_label.set_location (a_point)
			
			create state_text_box.make_textbox
			a_point.make_point (180, 210)
			state_text_box.set_location (a_point)
			a_size.make_size_1 (40, 20)
			state_text_box.set_size (a_size)
			
			create zip_code_label.make_label
			zip_code_label.set_text ("Zip Code:")
			a_point.make_point (30, 240)
			zip_code_label.set_location (a_point)
			
			create zip_code_text_box.make_textbox
			a_point.make_point (180, 240)
			zip_code_text_box.set_location (a_point)
			a_size.make_size_1 (50, 20)
			zip_code_text_box.set_size (a_size)
			
			create country_label.make_label
			country_label.set_text ("Country:")
			a_point.make_point (30, 270)
			country_label.set_location (a_point)
			
			create country_text_box.make_textbox
			a_point.make_point (180, 270)
			country_text_box.set_location (a_point)
			country_text_box.set_size (a_size)
			
			create quantity_label.make_label
			quantity_label.set_text ("Number of participants:")
			a_size.make_size_1 (180, 30)
			quantity_label.set_size (a_size)
			a_point.make_point (30, 300)
			quantity_label.set_location (a_point)
			
			create quantity_up_down.make_numericupdown
			decimal.make_decimal (1)
			quantity_up_down.set_increment (decimal)
			quantity_up_down.set_minimum (decimal)
			a_point.make_point (180, 300)
			quantity_up_down.set_location (a_point)
			quantity_up_down.set_decimal_places (0)
			a_size.make_size_1 (50, 20)
			quantity_up_down.set_size (a_size)
			
			create discount_plan_label.make_label
			discount_plan_label.set_text ("Registering as:")
			a_point.make_point (30, 330)
			discount_plan_label.set_location (a_point)
			
			create discount_plan_combo_box.make_combobox
			a_point.make_point (180, 330)
			discount_plan_combo_box.set_location (a_point)
			discount_plan_combo_box.set_text ("Regular")
			discount_plan_combo_box.get_items.add_range (<<"Regular", "Non-academic Authors", "Full-Time Students", "Full-Time Faculty Members">>)
			a_size.make_size_1 (150, 20)
			discount_plan_combo_box.set_size (a_size)
			
			create registration_type_label.make_label
			registration_type_label.set_text ("Registering for:")
			a_point.make_point (30, 360)
			registration_type_label.set_location (a_point)
			
			create preconference_check_box.make_checkbox
			preconference_check_box.set_text ("Pre-conference")
			a_point.make_point (180, 360)
			preconference_check_box.set_location (a_point)
			
			create wet_check_box.make_checkbox
			wet_check_box.set_text ("WET")
			a_point.make_point (180, 390)
			wet_check_box.set_location (a_point)
			
			create conference_check_box.make_checkbox
			conference_check_box.set_text ("Conference")
			a_point.make_point (180, 420)
			conference_check_box.set_location (a_point)

			create eiffel_summit_check_box.make_checkbox
			eiffel_summit_check_box.set_text ("Eiffel Summit")
			a_point.make_point (180, 450)
			eiffel_summit_check_box.set_location (a_point)

			create postconference_check_box.make_checkbox
			postconference_check_box.set_text ("Post-conference")
			a_point.make_point (180, 480)
			a_size.make_size_1 (200, 25)
			postconference_check_box.set_size (a_size)
			postconference_check_box.set_location (a_point)

			create ok_button.make_button
			a_point.make_point (150, 530)
			ok_button.set_location (a_point)
			a_size.make_size_1 (80, 25)
			ok_button.set_size (a_size)
			ok_button.set_text ("Register")
			type := type_factory.get_type_string ("System.EventHandler");
			on_ok_event_handler_delegate ?= delegate_factory.create_delegate_type_object_string (type, Current, "on_ok_event_handler")
			ok_button.add_click (on_ok_event_handler_delegate)
			
			get_controls.add (title_combo_box)
			get_controls.add (first_name_text_box)
			get_controls.add (last_name_text_box)
			get_controls.add (company_name_text_box)
			get_controls.add (address_text_box)
			get_controls.add (city_text_box)
			get_controls.add (state_text_box)
			get_controls.add (zip_code_text_box)
			get_controls.add (country_text_box)
			get_controls.add (quantity_up_down)
			get_controls.add (discount_plan_combo_box)
			get_controls.add (preconference_check_box)
			get_controls.add (wet_check_box)
			get_controls.add (conference_check_box)
			get_controls.add (eiffel_summit_check_box)
			get_controls.add (postconference_check_box)
			get_controls.add (title_label)
			get_controls.add (first_name_label)
			get_controls.add (last_name_label)
			get_controls.add (company_name_label)
			get_controls.add (address_label)
			get_controls.add (city_label)
			get_controls.add (state_label)
			get_controls.add (zip_code_label)
			get_controls.add (country_label)
			get_controls.add (quantity_label)
			get_controls.add (discount_plan_label)
			get_controls.add (registration_type_label)
			get_controls.add (ok_button)
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate.

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type.
			
	message_box_factory: SYSTEM_WINDOWS_FORMS_MESSAGEBOX

end -- class REGISTRATION_CLIENT_CHECKED
