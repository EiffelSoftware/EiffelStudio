note
	description: "Summary description for {WDOCS_EDIT_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_EDIT_BOX

create
	make

feature {NONE} -- Initialization

	make (a_manager: WDOCS_EDIT_MANAGER)
		do
			manager := a_manager
			create close_actions
			create updated_actions
			create saved_actions
			build_widget
			reset
		end

	build_widget
		local
			lab: EV_LABEL
			box: EV_VERTICAL_BOX
			src: EV_TEXT
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			cbut: EV_CHECK_BUTTON
		do
			create box
			widget := box

			create lab.make_with_text ("Editing ...")
			box.extend (lab)
			box.disable_item_expand (lab)

			create src
			box.extend (src)
			source_text := src
			src.change_actions.extend (agent on_text_changed)

			create hb
			box.extend (hb)
			box.disable_item_expand (hb)

			create but.make_with_text_and_action ("Reset", agent on_reset_operation)
			hb.extend (but)

			create but.make_with_text_and_action ("Cancel", agent on_cancel_operation)
			hb.extend (but)
			cancel_button := but

			create but.make_with_text_and_action ("Apply", agent on_apply_operation)
			hb.extend (but)
			apply_button := but

			create but.make_with_text_and_action ("Save", agent on_save_operation)
			hb.extend (but)
			save_button := but

			create cbut.make_with_text ("Preview ?")
			cbut.select_actions.extend (agent on_preview_selected (cbut))
			hb.extend (cbut)
			preview_check_button := cbut
		end

feature -- Element change

	set_page (wp: like page)
		do
			manager.reload_data
			manager.set_edited_page (wp)
			page := wp
			reset
			if wp = Void or else wp.path = Void then
				save_button.disable_sensitive
			end
		end

feature -- Access

	wiki_text: READABLE_STRING_8
		do
			Result := source_text.text
		end

	manager: WDOCS_EDIT_MANAGER

	page: detachable WIKI_PAGE

feature -- Access: callbacks

	updated_actions: ACTION_SEQUENCE [TUPLE]

	saved_actions: ACTION_SEQUENCE [TUPLE [page: WIKI_PAGE]]

	close_actions: ACTION_SEQUENCE [TUPLE]

feature -- Access: widget

	widget: EV_WIDGET

	cancel_button,
	apply_button,
	save_button: EV_BUTTON
	preview_check_button: EV_CHECK_BUTTON

feature {NONE} -- Implementation: widget

	source_text: EV_TEXT

feature -- Basic operation

	reset
		local
			s: detachable STRING
			l_done: BOOLEAN
		do
			if attached page as wp and then attached wp.path as p then
				s := wiki_text_from_file (p)
			end
			if s = Void then
				source_text.set_text ("")
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
			updated_actions.call (Void)
		end

feature -- Events

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
			close_actions.call (Void)
		end

	on_apply_operation
		do
			updated_actions.call (Void)
		end

	on_save_operation
		local
			f: RAW_FILE
		do
			on_apply_operation
			if attached page as p and then attached p.path as l_path then
				create f.make_with_path (l_path)
				if f.exists then
					backup_file (f)
				end
				save_content_to_file (wiki_text, f)
				saved_actions.call ([p])
			end
			close_actions.call (Void)
		end

	on_preview_selected (cbut: EV_CHECK_BUTTON)
		local
--			s: STRING
--			p, l_wiki_path, l_xhtml_path: PATH
--			d: DIRECTORY
--			f: PLAIN_TEXT_FILE
--			l_wiki_page: WIKI_PAGE
		do
--			p := manager.tmp_dir.extended ("app-live-preview")
--			create d.make_with_path (p)
--			if not d.exists then
--				d.recursive_create_dir
--			end
--			l_wiki_path := p.extended (page.title).appended_with_extension ("wiki")
--			l_xhtml_path := p.extended (page.title).appended_with_extension ("xhtml")

--			create f.make_with_path (l_wiki_path)
--			f.create_read_write
--			f.put_string (wiki_text)
--			f.close

--			create l_wiki_page.make (page.title, page.parent_key)
--			l_wiki_page.get_structure (l_wiki_path)

--			create s.make_empty
--			append_wiki_page_xhtml_to (l_wiki_page, manager, s)

--			create f.make_with_path (l_xhtml_path)
--			f.create_read_write
--			f.put_string (s)
--			f.close
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
--			l_wiki_page_date_time: detachable DATE_TIME
--			l_version_id: READABLE_STRING_GENERAL
		do
--			l_version_id := a_manager.version_id


			create l_xhtml.make_empty

			create wvis.make (l_xhtml)
			wvis.set_link_resolver (a_manager)
			wvis.set_image_resolver (a_manager)
			wvis.set_template_resolver (a_manager)
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

	wiki_text_from_file (fn: PATH): detachable STRING
		local
			f: RAW_FILE
			l_done: BOOLEAN
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
					l_done := False
				until
					l_done
				loop
					f.read_stream (2_048)
					Result.append (f.last_string)
					l_done := f.exhausted or f.end_of_file or f.last_string.count < 2_048
				end
				f.close
				Result.prune_all ('%R')
			end
		end

	backup_file (a_file: FILE)
		require
			a_file.is_closed
		local
			bak: RAW_FILE
		do
			if a_file.exists and then a_file.is_access_readable then
				create bak.make_with_path (a_file.path.appended_with_extension ("bak"))
				if not bak.exists or else bak.is_access_writable then
					bak.create_read_write
					a_file.open_read
					a_file.copy_to (bak)
					a_file.close
					bak.close
				end
			end
		end

	save_content_to_file (a_content: READABLE_STRING_8; a_file: FILE)
		require
			a_file.is_closed
		local
			l_close_after_saving: BOOLEAN
		do
			if not a_file.exists or else a_file.is_access_writable then
				a_file.open_write
				a_file.put_string (a_content)
				a_file.close
			end
		end


end
