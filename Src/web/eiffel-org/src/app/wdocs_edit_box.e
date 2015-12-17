note
	description: "Summary description for {WDOCS_EDIT_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_BOX

inherit
	WDOCS_EDITOR

	EV_SHARED_APPLICATION

	WDOCS_DATA_ACCESS

create
	make,
	make_embedded

feature {NONE} -- Initialization

	make
		do
			create close_actions
			create updated_actions
			create saved_actions
			build_widget
			reset
		end

	make_embedded
		do
			is_embedded := True
			make
		end

	build_widget
		local
			lab: EV_LABEL
			box: EV_VERTICAL_BOX
			l_name_tf: EV_TEXT_FIELD
			src: EV_TEXT
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			cbut: EV_CHECK_BUTTON
			consts: EV_LAYOUT_CONSTANTS
		do
			create consts
			create box
			widget := box


			create hb
			box.extend (hb)
			box.disable_item_expand (hb)

			create lab.make_with_text ("Editing:")
			hb.extend (lab)
			hb.disable_item_expand (lab)

			create l_name_tf.make_with_text ("")
			hb.extend (l_name_tf)
			name_field := l_name_tf

				-- toolbar			
			create hb
			hb.set_padding_width (consts.tiny_padding_size)
			hb.set_border_width (consts.small_border_size)
			box.extend (hb)
			box.disable_item_expand (hb)

			create but.make_with_text_and_action ("+Link", agent on_insert_wiki_link_menu_event)
			hb.extend (but)
			create but.make_with_text_and_action ("+Image", agent on_insert_wiki_image_menu_event)
			hb.extend (but)
			create but.make_with_text_and_action ("+Template", agent on_insert_wiki_template_menu_event)
			hb.extend (but)
			create but.make_with_text_and_action ("H1", agent apply_heading_on_text_selection (1))
			hb.extend (but)
			create but.make_with_text_and_action ("H2", agent apply_heading_on_text_selection (2))
			hb.extend (but)
			create but.make_with_text_and_action ("H3", agent apply_heading_on_text_selection (3))
			hb.extend (but)
			create but.make_with_text_and_action ("Bold", agent apply_bold_on_text_selection)
			hb.extend (but)
			create but.make_with_text_and_action ("Italic", agent apply_italic_on_text_selection)
			hb.extend (but)

				-- Source/text
			create src
			box.extend (src)
			source_text := src
			src.change_actions.extend (agent on_text_changed)
			src.key_press_actions.extend (agent on_key_pressed)

				-- Apply/Save...
			create hb
			hb.set_padding_width (consts.tiny_padding_size)
			hb.set_border_width (consts.small_border_size)
			box.extend (hb)
			box.disable_item_expand (hb)

			create but.make_with_text_and_action ("Reset", agent on_reset_operation)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)

			create but.make_with_text_and_action ("Cancel", agent on_cancel_operation)
			if not is_embedded then
				hb.extend (but)
			end
			but.set_minimum_width (consts.default_button_width)
			cancel_button := but

			create but.make_with_text_and_action ("Apply", agent on_apply_operation)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)
			apply_button := but

			create but.make_with_text_and_action ("Save", agent on_save_operation)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)
			save_button := but

			create cbut.make_with_text ("Preview ?")
			cbut.select_actions.extend (agent on_preview_selected (cbut))
			hb.extend (cbut)
			preview_check_button := cbut
			cbut.enable_select
		end

feature -- Element change

	set_page (wp: like page; m: WDOCS_EDIT_MANAGER)
		do
			manager := m
			m.reload_data
			m.set_edited_page (wp, Current)
			page := wp
			reset
			if wp = Void or else wp.path = Void then
				save_button.disable_sensitive
			end
		end

	set_manager	(m: like manager)
		do
			manager := m
		end

feature -- Access

	is_embedded: BOOLEAN

	wiki_text: READABLE_STRING_8
		do
			Result := source_text.text
		end

	manager: detachable WDOCS_EDIT_MANAGER

	page: detachable WIKI_PAGE

feature -- Access: callbacks

	updated_actions: ACTION_SEQUENCE [TUPLE]

	saved_actions: ACTION_SEQUENCE [TUPLE [page: WIKI_PAGE; title_updated: BOOLEAN]]

	close_actions: ACTION_SEQUENCE [TUPLE]

feature -- Access: widget

	widget: EV_WIDGET

	cancel_button,
	apply_button,
	save_button: EV_BUTTON
	preview_check_button: EV_CHECK_BUTTON

	name_field: EV_TEXT_FIELD

feature {NONE} -- Implementation: widget

	source_text: EV_TEXT

feature -- Basic operation

	reset
		local
			s: detachable READABLE_STRING_8
		do
			if attached page as wp then
				if attached manager as m then
					s := m.wiki_text (wp)
					name_field.set_text (wp.title)
				else
					name_field.remove_text
				end
			else
				name_field.remove_text
			end
			if s = Void then
				source_text.remove_text
			else
				source_text.set_text (s)
			end
		end

feature -- UI

	request_invoke_updated_actions
		local
			l_timer: like invoke_updated_actions_timer
		do
			l_timer := invoke_updated_actions_timer
			if l_timer = Void then
				create l_timer.make_with_interval (1_000)
				invoke_updated_actions_timer := l_timer
				l_timer.actions.extend (agent invoke_updated_actions)
			end
			l_timer.set_interval (1_000)
		end

	invoke_updated_actions_timer: detachable EV_TIMEOUT

	invoke_updated_actions
		do
			if attached invoke_updated_actions_timer as l_timer then
				l_timer.destroy
				invoke_updated_actions_timer := Void
			end
			if page /= Void then
				updated_actions.call (Void)
			end
		end

feature -- Editor operation

	insert_link_at_text_position (a_wiki_name: STRING; a_title: detachable READABLE_STRING_8)
		do
			if a_title /= Void then
				source_text.insert_text ("[[" + a_wiki_name + "|" + a_title + "]]")
			else
				source_text.insert_text ("[[" + a_wiki_name + "]]")
			end
		end

	insert_image_at_text_position (a_wiki_name: STRING; a_title: detachable READABLE_STRING_8)
		do
			if a_title /= Void then
				source_text.insert_text ("[[Image:" + a_wiki_name + "|thumb|center|220px|" + a_title + "]]")
			else
				source_text.insert_text ("[[Image:" + a_wiki_name + "|thumb|center|220px]]")
			end
		end

	insert_template_at_text_position (a_wiki_name: STRING; a_code: detachable READABLE_STRING_8)
		do
			if a_code /= Void then
				source_text.insert_text ("{{" + a_wiki_name + "|" + a_code + "}}%N")
			else
				source_text.insert_text ("{{" + a_wiki_name + "}}%N")
			end
		end

	apply_heading_on_text_selection (a_level: INTEGER)
		local
			s: STRING
		do
			if
				attached source_text.selected_text as l_selected_text and then
				not l_selected_text.is_empty
			then
				source_text.delete_selection
				create s.make_filled ('=', a_level)
				source_text.insert_text (s + " " + l_selected_text + " " + s + "%N")
			end
		end

	apply_bold_on_text_selection
		do
			if
				attached source_text.selected_text as l_selected_text and then
				not l_selected_text.is_empty
			then
				source_text.delete_selection
				source_text.insert_text ("'''" + l_selected_text + "'''")
			end
		end

	apply_italic_on_text_selection
		do
			if
				attached source_text.selected_text as l_selected_text and then
				not l_selected_text.is_empty
			then
				source_text.delete_selection
				source_text.insert_text ("''" + l_selected_text + "''")
			end
		end

feature -- Dialog

	popup (a_widget: EV_WIDGET; a_parent: detachable EV_WIDGET): EV_POPUP_WINDOW
		local
			pop: EV_POPUP_WINDOW
			w,h: INTEGER
		do
			create pop.make_with_shadow
			pop.extend (a_widget)
			if a_parent /= Void then
				w := a_parent.width
				h := a_parent.height
				w := (0.9 * w).truncated_to_integer
				h := (0.9 * h).truncated_to_integer
				pop.set_position (a_parent.screen_x + (a_parent.width - w) // 2, a_parent.screen_y + (a_parent.height - h) // 2)
			else
			end
			w := a_widget.minimum_width.max (w)
			h := a_widget.minimum_height.max (h)
			pop.set_size (w, h)

			pop.show_actions.extend_kamikaze (agent a_widget.set_focus)
			pop.focus_out_actions.extend (agent pop.destroy)

			Result := pop
		end

	popup_menu (a_menu: EV_MENU; a_parent: detachable EV_WIDGET)
		local
			g: EV_GRID
			pop: like popup
		do
			create g
			pop := popup (g, a_parent)

			g.enable_tree
			g.set_column_count_to (1)
			g.row_expand_actions.extend (agent (i_g: EV_GRID; i_r: EV_GRID_ROW) do i_g.column (1).resize_to_content end (g, ?))
			append_menu_to_grid (a_menu, g, agent pop.destroy)
			g.column (1).resize_to_content
			g.set_minimum_width (g.column (1).width + 3)

			pop.show
		end

feature -- Events

	close
		do
			close_actions.call (Void)
		end

	on_key_pressed (a_key: EV_KEY)
		local
		do
			if
				attached {EV_APPLICATION} ev_application as l_app and then
				l_app.ctrl_pressed and then
				not l_app.shift_pressed
			then
				if l_app.alt_pressed then
					if a_key.code = {EV_KEY_CONSTANTS}.key_L then
						on_insert_wiki_link_menu_event
					elseif a_key.code = {EV_KEY_CONSTANTS}.key_I then
						on_insert_wiki_image_menu_event
					elseif a_key.code = {EV_KEY_CONSTANTS}.key_T then
						on_insert_wiki_template_menu_event
					end
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_S then
					on_save_operation
				end
			end
		end

	on_insert_wiki_link_menu_event
		local
			m,sm: EV_MENU
			l_current_book_name: detachable READABLE_STRING_GENERAL
		do
			create m.make_with_text ("Insert Wiki link")
			if attached manager as l_manager then
				l_current_book_name := l_manager.current_book_name_for (Current)

				if
					l_current_book_name /= Void and then
					attached {WIKI_BOOK} l_manager.book (l_current_book_name) as l_book
				then
					create sm.make_with_text (l_current_book_name)
					append_wiki_link_to_menu (l_book.pages, sm)
					if not sm.is_empty then
						m.extend (sm)
					end
				end
				across
					l_manager.book_names as ic
				loop
					if
						l_current_book_name = Void
						or else not l_current_book_name.is_case_insensitive_equal (ic.item)
					then
						if attached l_manager.book (ic.item) as l_book then
							create sm.make_with_text (ic.item)
							append_wiki_link_to_menu (l_book.pages, sm)
							if not sm.is_empty then
								m.extend (sm)
							end
						end
					end
				end
			else
				create sm.make_with_text ("INTERNAL_ERROR: missing manager!")
				m.extend (sm)
			end

			popup_menu (m, source_text)
--			m.show
		end

	append_menu_to_grid (a_menu: EV_MENU; a_grid: EV_GRID; a_post_selected_action: detachable PROCEDURE)
		require
			is_tree_enabled: a_grid.is_tree_enabled
		local
			glab: EV_GRID_LABEL_ITEM
			r,sr: EV_GRID_ROW
		do
			a_grid.insert_new_row (a_grid.row_count + 1)
			r := a_grid.row (a_grid.row_count)
			create glab.make_with_text (a_menu.text)
			r.set_item (1, glab)
			across
				a_menu.select_actions as ic
			loop
				glab.select_actions.extend (ic.item)
			end
			if a_post_selected_action /= Void then
				glab.select_actions.extend (a_post_selected_action)
			end

			across
				a_menu as ic
			loop
				if attached {EV_MENU} ic.item as m then
					append_menu_to_grid (m, a_grid, a_post_selected_action)
				else
					r.insert_subrow (r.subrow_count + 1)
					sr := r.subrow (r.subrow_count)
					create glab.make_with_text (ic.item.text)
					across
						ic.item.select_actions as act_ic
					loop
						glab.select_actions.extend (act_ic.item)
					end
					if a_post_selected_action /= Void then
						glab.select_actions.extend (a_post_selected_action)
					end
					sr.set_item (1, glab)
				end
			end
		end

	append_wiki_link_to_menu (a_pages: ITERABLE [WIKI_PAGE]; a_menu: EV_MENU)
		local
			lnk: EV_MENU_ITEM
		do
			across
				a_pages as ic
			loop
				create lnk.make_with_text (ic.item.title)
				lnk.select_actions.extend (agent insert_link_at_text_position (ic.item.title, Void))
				a_menu.extend (lnk)
			end
		end

	on_insert_wiki_image_menu_event
		local
			m,sm: EV_MENU
			lnk: EV_MENU_ITEM
			l_current_book_name: detachable READABLE_STRING_GENERAL
			utf: UTF_CONVERTER
		do
			create m.make_with_text ("Insert Wiki Image")
			if attached manager as l_manager then
				l_current_book_name := l_manager.current_book_name_for (Current)
				across
					l_manager.storage.images_path_by_title_and_book as ic
				loop
					if not ic.item.is_empty then
						if ic.key.is_whitespace then
							create sm.make_with_text ("Global")
						else
							create sm.make_with_text (ic.key)
						end
						across
							ic.item as img_ic
						loop
							create lnk.make_with_text (img_ic.key)
							lnk.select_actions.extend (agent insert_image_at_text_position (utf.escaped_utf_32_string_to_utf_8_string_8 (img_ic.key), Void)) --
							sm.extend (lnk)
						end
						if not sm.is_empty then
							m.extend (sm)
						end
					end
				end
			else
				create sm.make_with_text ("INTERNAL_ERROR: Missing manager!")
				m.extend (sm)
			end
--			m.show
			popup_menu (m, source_text)
		end

	on_insert_wiki_template_menu_event
		local
			m,sm: EV_MENU
			lnk: EV_MENU_ITEM
			l_current_book_name: detachable READABLE_STRING_GENERAL
			utf: UTF_CONVERTER
		do
			create m.make_with_text ("Insert Wiki Template")
			if attached manager as l_manager then
				l_current_book_name := l_manager.current_book_name_for (Current)
				across
					l_manager.storage.templates_path_by_title_and_book as ic
				loop
					if not ic.item.is_empty then
						if ic.key.is_whitespace then
							create sm.make_with_text ("Global")
						else
							create sm.make_with_text (ic.key)
						end
						across
							ic.item as tpl_ic
						loop
							create lnk.make_with_text (tpl_ic.key)
							lnk.select_actions.extend (agent insert_template_at_text_position (utf.escaped_utf_32_string_to_utf_8_string_8 (tpl_ic.key), Void)) --
							sm.extend (lnk)
						end
						if not sm.is_empty then
							m.extend (sm)
						end
					end
				end
			else
				create sm.make_with_text ("INTERNAL_ERROR: Missing manager!")
				m.extend (sm)
			end
--			m.show
			popup_menu (m, source_text)
		end

	on_text_changed
		do
			if preview_check_button.is_selected then
				request_invoke_updated_actions
			end
		end

	on_reset_operation
		do
			reset
			updated_actions.call (Void)
		end

	on_cancel_operation
		do
			on_reset_operation
			close
		end

	on_apply_operation
		do
			updated_actions.call (Void)
		end

	on_save_operation
		do
			on_apply_operation
			if attached page as wp then
				if attached manager as l_manager then
					l_manager.save_wiki_text (wp, wiki_text)
					if
						attached name_field.text as l_name and then
						not l_name.is_whitespace and then
						not l_name.is_case_insensitive_equal_general (wp.title)
					then
							-- Title changed!
						l_manager.change_page_title (wp, l_name)
						saved_actions.call ([wp, True])
					else
						saved_actions.call ([wp, False])
					end
				end
			end
			if not is_embedded then
				close
			end
		end

	on_preview_selected (cbut: EV_CHECK_BUTTON)
		do
			request_invoke_updated_actions
			if cbut.is_selected then
				apply_button.disable_sensitive
--				apply_button.hide
			else
				apply_button.enable_sensitive
--				apply_button.show
			end
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_xhtml: detachable STRING_8
			wvis: WDOCS_WIKI_XHTML_GENERATOR
--			p: PATH
--			d: DIRECTORY
--			f: PLAIN_TEXT_FILE
--			l_wiki_page_date_time: detachable DATE_TIME
--			l_version_id: READABLE_STRING_GENERAL
		do
--			l_version_id := a_manager.version_id

			create l_xhtml.make_empty

			create wvis.make (l_xhtml)
			wvis.set_link_resolver (a_manager)
			wvis.set_image_resolver (a_manager)
			wvis.set_template_resolver (a_manager)
			wvis.set_file_resolver (a_manager)
			wvis.visit_page (a_wiki_page)

			l_xhtml.append ("<ul class=%"wdocs-index%">")
--			if
--				a_book_name /= Void and then
--				attached a_manager.page (a_book_name, a_wiki_page.parent_key) as l_parent_page and then
--				l_parent_page /= a_wiki_page
--			then
--				l_xhtml.append ("<li><em>Parent</em> &lt;")
--				append_wiki_page_link (req, l_version_id, a_book_name, l_parent_page, False, l_xhtml)
--				l_xhtml.append ("&gt;</li>")
--			end
--			a_wiki_page.sort
--			if attached a_wiki_page.pages as l_sub_pages then
--				across
--					l_sub_pages as ic
--				loop
--					l_xhtml.append ("<li>")
--					append_wiki_page_link (req, l_version_id, a_book_name, ic.item, False, l_xhtml)
--					l_xhtml.append ("</li>")
--				end
--			end
--			l_xhtml.append ("</ul>")

			a_output.append (l_xhtml)
		end

end
