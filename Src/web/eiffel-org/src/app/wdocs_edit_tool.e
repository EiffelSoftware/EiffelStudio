note
	description: "Summary description for {WDOCS_EDIT_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_TOOL

create
	make

feature {NONE} -- Initialization

	make (a_manager: WDOCS_EDIT_MANAGER)
		do
			create_interface_objects
			initialize
		end

	create_interface_objects
		do
			create widget
			create wiki_text_updated_actions
			create wiki_page_saved_actions
			create edit_box.make_embedded
		end

	initialize
		local
			l_edit: like edit_box
		do
			l_edit := edit_box

			widget.extend (l_edit.widget)

			l_edit.close_actions.extend (agent on_close_requested)
--			set_default_cancel_button (l_edit.cancel_button)
--			set_default_push_button (l_edit.apply_button)

			l_edit.updated_actions.extend (agent on_updated)
			l_edit.saved_actions.extend (agent on_saved)
		end

feature -- Access

	widget: EV_VERTICAL_BOX

	edit_box: WDOCS_EDIT_BOX

	wiki_text_updated_actions: ACTION_SEQUENCE [TUPLE [page: detachable WIKI_PAGE; editor: detachable WDOCS_EDITOR; text: READABLE_STRING_8]]

	wiki_page_saved_actions: ACTION_SEQUENCE [TUPLE [page: WIKI_PAGE; editor: detachable WDOCS_EDITOR; title_updated: BOOLEAN]]

feature -- Docking

	sd_content: SD_CONTENT
		local
			l_content: like internal_sd_content
			l_mini_tb: SD_TOOL_BAR
			l_mini_but: SD_TOOL_BAR_BUTTON
		do
			l_content := internal_sd_content
			if l_content = Void then
				create l_content.make_with_widget (widget, "Editor")
				l_content.set_long_title ("Wiki Editor")
--				l_content.set_type ({SD_ENUMERATION}.editor)
				create l_mini_tb.make

				create l_mini_but.make
				l_mini_but.set_text ("Reset")
				l_mini_but.set_name ("reset_button")
				l_mini_but.set_tooltip ("Reset to previous wiki page.")
				l_mini_but.select_actions.extend (agent edit_box.on_reset_operation)
				l_mini_tb.extend (l_mini_but)

				l_content.set_mini_toolbar (l_mini_tb)
				l_mini_tb.compute_minimum_size

				l_content.close_request_actions.extend (agent on_closed)

				internal_sd_content := l_content
			end
			Result := l_content
		end

	internal_sd_content: detachable like sd_content

feature -- Events

	show
		do
			sd_content.show
		end

	hide
		do
			sd_content.hide
		end

	on_close_requested
		do
			hide
		end

	on_closed
		do
			edit_box.on_cancel_operation
		end

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
