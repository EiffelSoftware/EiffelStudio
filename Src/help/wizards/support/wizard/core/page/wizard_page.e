note
	description: "Summary description for {WIZARD_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_PAGE

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_8)
		do
			create items.make (0)
			create data.make (a_id)
			create fields.make_caseless (0)
			create page_id.make_from_string (a_id)
			create update_actions
		end

feature -- Access

	page_id: IMMUTABLE_STRING_8

	title: detachable IMMUTABLE_STRING_32

	subtitle: detachable IMMUTABLE_STRING_32

	previous_page: detachable WIZARD_PAGE

	validation: detachable PROCEDURE [WIZARD_PAGE]

	update_actions: ACTION_SEQUENCE [TUPLE]

feature -- Access: data

	items: ARRAYED_LIST [WIZARD_PAGE_ITEM]

	fields: STRING_TABLE [WIZARD_INPUT_FIELD]

	data: WIZARD_PAGE_DATA

	field_value alias "[]" (a_field_id: READABLE_STRING_8): detachable READABLE_STRING_32
			-- Data related to existing field `a_field_id'.
		require
			associated_field_exists: fields.has (a_field_id)
		do
			Result := data.item (a_field_id)
		end

	boolean_field_value alias "&" (a_field_id: READABLE_STRING_8): BOOLEAN
			-- Boolean data related to existing field `a_field_id'.
		require
			associated_field_exists: fields.has (a_field_id)
		do
			Result := data.boolean_item (a_field_id)
		end

feature -- Status report	

	has_header: BOOLEAN
		do
			Result := title /= Void or subtitle /= Void or (attached reports as lst and then not lst.is_empty)
		end

	has_reports: BOOLEAN
		do
			Result := attached reports as lst and then not lst.is_empty
		end

	has_error: BOOLEAN
		do
			Result := attached reports as lst and then across lst as ic some ic.item.type = error_report_type  end
		end

	has_warning: BOOLEAN
		do
			Result := attached reports as lst and then across lst as ic some ic.item.type = warning_report_type  end
		end

feature -- Debug report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string_general (page_id)
		end

feature -- Element change

	set_data (a_data: like data)
		do
			data := a_data
			apply_data
		end

	set_title (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				title := Void
			else
				create title.make_from_string_general (t)
			end
		end

	set_subtitle (t: detachable READABLE_STRING_GENERAL)
		do
			if t = Void then
				subtitle := Void
			else
				create subtitle.make_from_string_general (t)
			end
		end

	set_previous_page (a_prev: detachable WIZARD_PAGE)
		do
			previous_page := a_prev
		end

feature -- Element change

	set_validation (act: like validation)
		do
			validation := act
		end


feature -- UI fields building

	extend (a_item: WIZARD_PAGE_ITEM)
		do
			items.extend (a_item)
			if attached {WIZARD_INPUT_FIELD} a_item as f then
				fields.force (f, f.id)
			end
		end

feature -- UI building

	frozen add_section_text (a_text: READABLE_STRING_GENERAL)
		do
			extend (new_section_item (a_text))
		end

	frozen add_text (a_text: READABLE_STRING_GENERAL)
		do
			extend (new_text_item (a_text))
		end

	frozen add_fixed_size_text (a_text: READABLE_STRING_GENERAL)
		do
			extend (new_fixed_size_text_item (a_text))
		end

feature -- Helpers

	frozen add_string_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL)
		do
			extend (new_string_question (a_prompt, a_field_id, a_description))
		end

	frozen add_directory_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL)
		do
			extend (new_directory_question (a_prompt, a_field_id, a_description))
		end

	frozen add_boolean_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL)
		do
			extend (new_boolean_question (a_prompt, a_field_id, a_description))
		end

	frozen add_integer_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL)
		do
			extend (new_integer_question (a_prompt, a_field_id, a_description))
		end

feature -- Helper Factory

	new_section_item (a_text: READABLE_STRING_GENERAL): WIZARD_PAGE_SECTION_ITEM
		do
			create Result.make (a_text)
		end

	new_text_item (a_text: READABLE_STRING_GENERAL): WIZARD_PAGE_TEXT_ITEM
		do
			create Result.make (a_text)
		end

	new_fixed_size_text_item (a_text: READABLE_STRING_GENERAL): WIZARD_PAGE_TEXT_ITEM
		do
			create Result.make (a_text)
			Result.set_is_fixed_size (True)
		end

	new_string_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): WIZARD_STRING_QUESTION
		deferred
		end

	new_directory_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): WIZARD_DIRECTORY_QUESTION
		deferred
		end

	new_boolean_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): WIZARD_BOOLEAN_QUESTION
		deferred
		end

	new_integer_question (a_prompt: READABLE_STRING_GENERAL; a_field_id: READABLE_STRING_8; a_description: detachable READABLE_STRING_GENERAL): WIZARD_INTEGER_QUESTION
		deferred
		end

feature -- Basic operations

	validate
			-- Validate input field value.
		local
			l_field: WIZARD_INPUT_FIELD
		do
			reset_reports

			across
				fields as ic
			loop
				l_field := ic.item
				l_field.validate (Current)
				data.force (l_field.text, l_field.id)
			end
			if attached validation as act then
				act.call ([Current])
			end
		end

feature {WIZARD, WIZARD_APPLICATION, WIZARD_PAGE} -- Implementation

	reuse
		deferred
		end

	apply_data
		local
			l_field: WIZARD_INPUT_FIELD
		do
			update_actions.call (Void)
			across
				fields as ic
			loop
				l_field := ic.item
				if attached data.item (l_field.id) as v then
					l_field.set_text (v)
				end
			end
		end

feature -- Reporting

	reset_reports
		do
			reports := Void
		end

	reports: detachable ARRAYED_LIST [TUPLE [message: IMMUTABLE_STRING_32; type: INTEGER]]

	report (m: READABLE_STRING_GENERAL; a_type: INTEGER)
		local
			lst: like reports
			l_message: IMMUTABLE_STRING_32
		do
			lst := reports
			if lst = Void then
				create lst.make (1)
				reports := lst
			end
			if attached {IMMUTABLE_STRING_32} m as imm32 then
				l_message := imm32
			else
				create l_message.make_from_string_general (m)
			end
			lst.force ([l_message, a_type])
		end

	report_information (m: READABLE_STRING_GENERAL)
		do
			report (m, information_report_type)
		end

	report_warning (m: READABLE_STRING_GENERAL)
		do
			report (m, warning_report_type)
		end

	report_error (m: READABLE_STRING_GENERAL)
		do
			report (m, error_report_type)
		end

	information_report_type: INTEGER = 1
	warning_report_type: INTEGER = 2
	error_report_type: INTEGER = 3


end
