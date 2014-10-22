note
	description: "Summary description for {WDOCS_CONTROL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_CONTROL

inherit
	EV_VERTICAL_BOX
		redefine
			create_interface_objects, initialize, is_in_default_state,
			refresh_now
		end

create
	make

feature {NONE} -- Initialization

	make (a_portnumber: INTEGER)
		do
			port_number := a_portnumber
			default_create
		end

	initialize
			-- Initialize `Current'.
		do
				-- Call `user_initialization'.
			user_initialization
			Precursor
		end

	create_interface_objects
			-- Create objects
		do
			create grid
			create wiki_page_select_actions
			create url_requested_actions
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			g: EV_GRID
			but: EV_BUTTON
		do
			create vb
			extend (vb)
			vb.set_border_width (3)
			vb.set_padding_width (3)

			create lab.make_with_text ("Wiki docs")
			vb.extend (lab)
			vb.disable_item_expand (lab)

			g := grid
			g.enable_single_row_selection
			g.enable_tree
			g.row_select_actions.extend (agent on_row_selected)
			g.row_expand_actions.extend (agent on_row_expanded)
			g.row_collapse_actions.extend (agent on_row_collapsed)
			vb.extend (g)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create but.make_with_text_and_action ("Refresh", agent on_refresh_requested)
			hb.extend (but)
			create but.make_with_text_and_action ("Edit", agent on_edit_requested)
			hb.extend (but)
		end

feature -- Access

	port_number: INTEGER

	new_wdocs_manager: WDOCS_EDIT_MANAGER
		local
			cfg: WDOCS_INI_CONFIG
		do
			create cfg.make (create {PATH}.make_from_string ("eiffel-lang-app.ini"))
			create Result.make (cfg.documentation_dir.extended (cfg.documentation_default_version), cfg.documentation_default_version, cfg.temp_dir)
			Result.set_server_url ("http://localhost:" + port_number.out)
		end

	grid: EV_GRID

	wiki_page_select_actions: ACTION_SEQUENCE [TUPLE [WIKI_PAGE]]

	url_requested_actions: ACTION_SEQUENCE [TUPLE [READABLE_STRING_8]]

feature -- Basic operation

	refresh_now
		local
			wdocs: WDOCS_MANAGER
			glab: EV_GRID_LABEL_ITEM
			g: like grid
			l_book_name: READABLE_STRING_GENERAL
			i: INTEGER
		do
			Precursor

			g := grid
			g.clear
			g.wipe_out
			g.set_row_count_to (1)
			g.set_column_count_to (1)
			wdocs := new_wdocs_manager
			i := 0
			across
				wdocs.book_names as ic
			loop
				l_book_name := ic.item
				i := i + 1
				g.set_row_count_to (i)
				create glab.make_with_text (l_book_name)
				g.row (i).set_data (l_book_name)
				g.row (i).ensure_expandable
				g.set_item (1, i, glab)
			end
			g.column (1).resize_to_content
		end

	on_wiki_page_selected (wp: WIKI_PAGE)
		do
			wiki_page_select_actions.call ([wp])
		end

	on_row_selected (r: EV_GRID_ROW)
		do
			if attached wiki_page_from_row (r) as wp then
				on_wiki_page_selected (wp)
			end
		end

	on_row_expanded (r: EV_GRID_ROW)
		local
			glab: EV_GRID_LABEL_ITEM
			i: INTEGER
			j: INTEGER
		do
			if attached wiki_page_from_row (r) as wp and then attached wp.pages as l_pages then
				i := r.index
				j := 0
				across
					l_pages as ic
				loop
					j := j + 1
					r.insert_subrow (j)
					create glab.make_with_text (ic.item.title)
					r.subrow (j).set_item (1, glab)
					r.subrow (j).set_data (ic.item)
					if ic.item.has_page then
						r.subrow (j).ensure_expandable
					end
				end
				grid.column (1).resize_to_content
			end
		end

	on_row_collapsed (r: EV_GRID_ROW)
		local
			i,n: INTEGER
			g: like grid
		do
			from
				i := r.index
				n := r.subrow_count_recursive
				g := grid
			until
				n = 0
			loop
				g.remove_row (i + n)
				i := i - 1
			end
		end

	on_refresh_requested
		do
			new_wdocs_manager.refresh_data
			refresh_now
		end

	on_edit_requested
		do
			if attached grid.selected_rows as l_rows and then l_rows.count = 1 then
				if attached wiki_page_from_row (l_rows.first) as wp then
					edit_page (wp)
				end
			end
		end

	edit_page (wp: WIKI_PAGE)
		local
			dlg: like edit_dialog
		do
			dlg := edit_dialog
			if dlg = Void or else dlg.is_destroyed then
				create dlg.make (new_wdocs_manager)
				edit_dialog := dlg
				dlg.wiki_text_updated_actions.extend (agent on_page_edited)
				dlg.wiki_page_saved_actions.extend (agent on_page_saved)
				dlg.set_size (600, 500)
			end
			dlg.set_page (wp)
			dlg.show
		end

	on_page_edited (a_page: detachable WIKI_PAGE; a_text: READABLE_STRING_8)
		do
			on_preview_requested (a_page, a_text)
		end

	on_page_saved (a_page: WIKI_PAGE)
		do
			if attached new_wdocs_manager.page_url (a_page) as u then
				url_requested_actions.call ([u])
			end
		end

	on_preview_requested (a_page: detachable WIKI_PAGE; a_text: READABLE_STRING_8)
		local
			s: STRING
			p, l_wiki_path, l_xhtml_path: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			l_wiki_page: WIKI_PAGE
			url: PATH_URI
			l_wdocs_manager: like new_wdocs_manager
		do
			l_wdocs_manager := new_wdocs_manager
			l_wdocs_manager.set_edited_page (a_page)
			p := l_wdocs_manager.tmp_dir.extended ("app-live-preview")
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			l_wiki_path := p.extended ("preview").appended_with_extension ("wiki")
			l_xhtml_path := p.extended ("preview").appended_with_extension ("html")

			create f.make_with_path (l_wiki_path)
			f.create_read_write
			f.put_string (a_text)
			f.close

			create l_wiki_page.make ("Preview", "Preview")
			l_wiki_page.get_structure (l_wiki_path)

			create s.make_empty
			append_wiki_page_xhtml_to (l_wiki_page, l_wdocs_manager, s)

			create f.make_with_path (l_xhtml_path)
			f.create_read_write
			f.put_string (s)
			f.close

			create url.make_from_path (l_xhtml_path.absolute_path.canonical_path)
			url_requested_actions.call ([url.string])
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_manager: WDOCS_MANAGER; a_output: STRING)
		local
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
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
	edit_dialog: detachable WDOCS_EDIT_DIALOG

	wiki_page_from_row (r: EV_GRID_ROW): detachable WIKI_PAGE
		do
			if not r.is_destroyed then
				if attached {WIKI_PAGE} r.data as l_wp then
					Result := l_wp
				elseif attached {READABLE_STRING_GENERAL} r.data as l_book_name then
					if attached new_wdocs_manager.book (l_book_name) as wb then
						Result := wb.root_page
					end
				end
			end
		end

feature -- Status report

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

feature -- Element change

	set_port_number (p: INTEGER)
		do
			port_number := p
		end

feature {NONE} -- Implementation


end
