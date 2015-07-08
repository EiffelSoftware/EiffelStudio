note
	description: "Summary description for {WDOCS_EDIT_FORM}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_FORM

inherit
	CMS_FORM
		rename
			make as make_form
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (a_action: READABLE_STRING_8; a_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			response := a_response
			make_form (a_action, a_id)
			initialize_form
		end

	initialize_form
		local
			tf: WSF_FORM_TEXTAREA
			bt_preview, bt_save: WSF_FORM_SUBMIT_INPUT
		do
			create tf.make ("source")
			tf.set_cols (100)
			tf.set_rows (25)
			tf.set_description ("Use wikitext formatting to provide the content.")
			tf.set_description_collapsible (True)
			tf.set_label ("Content")
			extend (tf)
			content_widget := tf

			create bt_preview.make_with_text ("preview", "Preview")
--			bt_preview.set_formaction (r.url (l_docloc + "/preview", Void))
--			bt_preview.set_formtarget ("blank")
			extend (bt_preview)
			preview_button := bt_preview

			create bt_save.make_with_text ("save", "Save")
			extend (bt_save)
			save_button := bt_save
		end

	response: CMS_RESPONSE

feature -- Form

	content_widget: WSF_FORM_TEXTAREA
	preview_button,
	save_button: WSF_FORM_SUBMIT_INPUT

end
