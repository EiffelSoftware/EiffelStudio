indexing
	description: "Registrar client, user interface to add registrants and registrations."

class
	REGISTRATION_CLIENT_UNCHECKED
alias
	"RegistrationClient.ClientUnchecked"

inherit
	SYSTEM_WINFORMS_FORM
	
create
	make

feature {NONE} -- Initialization

	make is
			-- create {a new client window.
		local
			return_value: INTEGER
		do
			initialize_gui
			create registrar.make_registrar
			create input_checker.make
			return_value := showdialog
		end

feature -- Access
	
	registrar: REGISTRAR
			-- Proxy to registrar object

feature -- GUI components

	title_combo_box: SYSTEM_WINFORMS_COMBOBOX
			-- Title combo box
	
	first_name_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- First name single line edit
			
	last_name_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- Last name single line edit
			
	company_name_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- Company name single line edit
			
	address_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- Address single line edit
			
	city_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- City name single line edit
			
	state_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- State code single line edit
			
	zip_code_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- Zip code single line edit
			
	country_text_box: SYSTEM_WINFORMS_TEXTBOX
			-- Country name single line edit

	quantity_up_down: SYSTEM_WINFORMS_NUMERICUPDOWN
			-- Participants number single line edit

	discount_plan_combo_box: SYSTEM_WINFORMS_COMBOBOX
			-- Discount plan type combo box

	preconference_check_box: SYSTEM_WINFORMS_CHECKBOX
			-- Pre-conference check box
			
	wet_check_box: SYSTEM_WINFORMS_CHECKBOX
			-- WET check box
			
	conference_check_box: SYSTEM_WINFORMS_CHECKBOX
			-- Conference check box
			
	eiffel_summit_check_box: SYSTEM_WINFORMS_CHECKBOX
			-- Eiffel summit check box
			
	postconference_check_box: SYSTEM_WINFORMS_CHECKBOX
			-- Post-conference check box
	
	title_label: SYSTEM_WINFORMS_LABEL
			-- Title label
			
	first_name_label: SYSTEM_WINFORMS_LABEL
			-- First name label
			
	last_name_label: SYSTEM_WINFORMS_LABEL
			-- Last name label
			
	company_name_label: SYSTEM_WINFORMS_LABEL
			-- Company name label
			
	address_label: SYSTEM_WINFORMS_LABEL
			-- Address label
			
	city_label: SYSTEM_WINFORMS_LABEL
			-- City label
			
	state_label: SYSTEM_WINFORMS_LABEL
			-- State label
			
	zip_code_label: SYSTEM_WINFORMS_LABEL
			-- Zip code label
			
	country_label: SYSTEM_WINFORMS_LABEL
			-- Country label
			
	quantity_label: SYSTEM_WINFORMS_LABEL
			-- Number of participants label
			
	discount_plan_label: SYSTEM_WINFORMS_LABEL
			-- Discount plan label
			
	registration_type_label: SYSTEM_WINFORMS_LABEL
			-- Type of registration label
	
	ok_button: SYSTEM_WINFORMS_BUTTON
			-- OK Button

feature {NONE} -- Implementation

	input_checker: INPUT_CHECKER
			-- Data validity checker

on_ok_event_handler (sender: ANY; arguments: SYSTEM_EVENTARGS) is
		-- Process ok button activation.
	local
		message_result: INTEGER
	do
		registrar.add_registrant (title_combo_box.text, first_name_text_box.text,
				last_name_text_box.text, company_name_text_box.text, address_text_box.text,
				city_text_box.text, state_text_box.text, zip_code_text_box.text,
				country_text_box.text)
		if registrar.last_operation_successful then
			registrar.add_registration (registrar.last_registrant_identifier, quantity_up_down.value.tostring,
				discount_plan_combo_box.text, preconference_check_box.checked,
				wet_check_box.checked, conference_check_box.checked,
				eiffel_summit_check_box.checked, postconference_check_box.checked)
		end
		if registrar.last_operation_successful then
			message_result := message_box_factory.show ("Registration successfully stored.", "Registration Success")
		else
			message_result := message_box_factory.show (registrar.last_error_message, "Registration Failure")
		end
	end

	initialize_gui is
			-- Initialize form.
		local
			on_ok_event_handler_delegate: SYSTEM_EVENTHANDLER
			type: SYSTEM_TYPE
			titles, plans: ARRAY [STRING]
			decimal: SYSTEM_DECIMAL
		do
			set_text ("TOOLS Registration")
			set_borderstyle (3)
			setsize (450, 600)

			create title_label.make_label
			title_label.set_text ("Title:")
			title_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 30))
			
			create title_combo_box.make_combobox
			title_combo_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 30))
			create titles.make (5)
			titles.put (0, "Mr.")
			titles.put (1, "Ms.")
			titles.put (2, "Miss")
			titles.put (3, "Mrs.")
			titles.put (4, "Dr.")
			title_combo_box.items.set_all (titles)--<<"Mr.", "Ms.", "Miss", "Mrs.", "Dr.">>)
			title_combo_box.set_text ("Mr.")
			
			create first_name_label.make_label
			first_name_label.set_text ("First Name:")
			first_name_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 60))
			
			create first_name_text_box.make_textbox
			first_name_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 60))
			first_name_text_box.setsize (150, 20)
			
			create last_name_label.make_label
			last_name_label.set_text ("Last Name:")
			last_name_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 90))
			
			create last_name_text_box.make_textbox
			last_name_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 90))
			last_name_text_box.setsize (150, 20)
			
			create company_name_label.make_label
			company_name_label.set_text ("Company Name:")
			company_name_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 120))
			
			create company_name_text_box.make_textbox
			company_name_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 120))
			company_name_text_box.setsize (150, 20)
			
			create address_label.make_label
			address_label.set_text ("Address:")
			address_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 150))
			
			create address_text_box.make_textbox
			address_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 150))
			address_text_box.setsize (150, 20)
			
			create city_label.make_label
			city_label.set_text ("City:")
			city_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 180))
			
			create city_text_box.make_textbox
			city_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 180))
			city_text_box.setsize (150, 20)
			
			create state_label.make_label
			state_label.set_text ("State:")
			state_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 210))
			
			create state_text_box.make_textbox
			state_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 210))
			state_text_box.setsize (40, 20)
			
			create zip_code_label.make_label
			zip_code_label.set_text ("Zip Code:")
			zip_code_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 240))
			
			create zip_code_text_box.make_textbox
			zip_code_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 240))
			zip_code_text_box.setsize (50, 20)
			
			create country_label.make_label
			country_label.set_text ("Country:")
			country_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 270))
			
			create country_text_box.make_textbox
			country_text_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 270))
			country_text_box.setsize (50, 20)
			
			create quantity_label.make_label
			quantity_label.set_text ("Number of participants:")
			quantity_label.setsize (200, 30)
			quantity_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 300))
			
			create quantity_up_down.make_numericupdown
			decimal.make_decimal (1)
			quantity_up_down.set_increment (decimal)
			quantity_up_down.set_minimum (decimal)
			quantity_up_down.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 300))
			quantity_up_down.set_decimalplaces (0)
			quantity_up_down.setsize (50, 20)
			
			create discount_plan_label.make_label
			discount_plan_label.set_text ("Registering as:")
			discount_plan_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 330))
			
			create discount_plan_combo_box.make_combobox
			discount_plan_combo_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 330))
			discount_plan_combo_box.set_text ("Regular")
			create plans.make (4)
			plans.put (0, "Regular")
			plans.put (1, "Non-academic Authors")
			plans.put (2, "Full-Time Students")
			plans.put (3, "Full-Time Faculty Members")
			discount_plan_combo_box.items.set_all (plans)
			discount_plan_combo_box.setsize (150, 20)
			
			create registration_type_label.make_label
			registration_type_label.set_text ("Registering for:")
			registration_type_label.set_location (create {SYSTEM_DRAWING_POINT}.make_point (30, 360))
			
			create preconference_check_box.make_checkbox
			preconference_check_box.set_text ("Pre-conference")
			preconference_check_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 360))
			
			create wet_check_box.make_checkbox
			wet_check_box.set_text ("WET")
			wet_check_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 390))
			
			create conference_check_box.make_checkbox
			conference_check_box.set_text ("Conference")
			conference_check_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 420))

			create eiffel_summit_check_box.make_checkbox
			eiffel_summit_check_box.set_text ("Eiffel Summit")
			eiffel_summit_check_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 450))

			create postconference_check_box.make_checkbox
			postconference_check_box.set_text ("Post-conference")
			postconference_check_box.set_location (create {SYSTEM_DRAWING_POINT}.make_point (250, 480))

			create ok_button.make_button
			ok_button.set_location (create {SYSTEM_DRAWING_POINT}.make_point (185, 530))
			ok_button.setsize (80, 30)
			ok_button.set_text ("Register")
			type := type_factory.GetType_System_String ("System.EventHandler");
			on_ok_event_handler_delegate ?= delegate_factory.CreateDelegate_System_Type_System_Object (type, Current, "on_ok_event_handler")
			ok_button.addonclick (on_ok_event_handler_delegate)
			
			controls.add (title_combo_box)
			controls.add (first_name_text_box)
			controls.add (last_name_text_box)
			controls.add (company_name_text_box)
			controls.add (address_text_box)
			controls.add (city_text_box)
			controls.add (state_text_box)
			controls.add (zip_code_text_box)
			controls.add (country_text_box)
			controls.add (quantity_up_down)
			controls.add (discount_plan_combo_box)
			controls.add (preconference_check_box)
			controls.add (wet_check_box)
			controls.add (conference_check_box)
			controls.add (eiffel_summit_check_box)
			controls.add (postconference_check_box)
			controls.add (title_label)
			controls.add (first_name_label)
			controls.add (last_name_label)
			controls.add (company_name_label)
			controls.add (address_label)
			controls.add (city_label)
			controls.add (state_label)
			controls.add (zip_code_label)
			controls.add (country_label)
			controls.add (quantity_label)
			controls.add (discount_plan_label)
			controls.add (registration_type_label)
			controls.add (ok_button)
		end
		
	delegate_factory: SYSTEM_DELEGATE
			-- Statics needed to create a delegate.

	type_factory: SYSTEM_TYPE
			-- Statics needed to create a type.
			
	message_box_factory: SYSTEM_WINFORMS_MESSAGEBOX

end -- class REGISTRATION_CLIENT_CHECKED
