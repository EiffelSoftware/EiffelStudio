note
	description: "Summary description for {WDOCS_EDIT_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_DIALOG

inherit
	EV_DIALOG
		redefine
			create_interface_objects,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_title ("Wiki page editing")
		end

	create_interface_objects
		do
			Precursor
			create wiki_text_updated_actions
			create wiki_page_saved_actions
			create edit_box.make
		end

	initialize
		local
			l_edit: like edit_box
		do
			Precursor
			l_edit := edit_box

			extend (l_edit.widget)

			l_edit.close_actions.extend (agent destroy_and_exit_if_last)
			set_default_cancel_button (l_edit.cancel_button)
--			set_default_push_button (l_edit.apply_button)

			l_edit.updated_actions.extend (agent on_updated)
			l_edit.saved_actions.extend (agent on_saved)
		end

feature -- Access

	edit_box: WDOCS_EDIT_BOX

	wiki_text_updated_actions: ACTION_SEQUENCE [TUPLE [page: detachable WIKI_PAGE; editor: detachable WDOCS_EDITOR; text: READABLE_STRING_8]]

	wiki_page_saved_actions: ACTION_SEQUENCE [TUPLE [page: WIKI_PAGE; editor: detachable WDOCS_EDITOR; title_updated: BOOLEAN]]

feature -- Events

	on_updated
		do
			wiki_text_updated_actions.call ([edit_box.page, edit_box, edit_box.wiki_text])
		end

	on_saved (a_page: WIKI_PAGE; a_title_updated: BOOLEAN)
		do
			wiki_page_saved_actions.call ([a_page, edit_box, a_title_updated])
		end

feature -- Element change

	set_page (wp: WIKI_PAGE; m: WDOCS_EDIT_MANAGER)
		do
			edit_box.set_page (wp, m)
		end

end
