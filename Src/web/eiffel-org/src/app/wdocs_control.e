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

	EV_SHARED_APPLICATION
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_wdocs: WDOCS_EDIT_MANAGER)
		do
			wdocs_manager := a_wdocs
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
			create edit_button.make_with_text ("Edit")
			create delete_page_button.make_with_text ("Delete")
			create new_page_button.make_with_text ("Add Page")
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
			consts: EV_LAYOUT_CONSTANTS
			s: STRING_32
		do
			create consts
			create vb
			extend (vb)
			vb.set_border_width (3)
			vb.set_padding_width (3)

			create s.make_from_string_general ("Wiki #")
			if attached wdocs_manager.version_id as vid then
				s.append_string_general (vid)
			end
			create lab.make_with_text (s)
			vb.extend (lab)
			lab.pointer_button_press_actions.extend (agent on_wiki_version_clicked (lab, ?,?,?,?,?,?,?,?))
			vb.disable_item_expand (lab)

			g := grid
			g.enable_single_row_selection
			g.enable_tree
			g.row_select_actions.extend (agent on_row_selected)
			g.row_deselect_actions.extend (agent on_row_deselected)
			g.row_expand_actions.extend (agent on_row_expanded)
			g.row_collapse_actions.extend (agent on_row_collapsed)
			vb.extend (g)

			create hb
			hb.set_padding_width (consts.tiny_padding_size)
			hb.set_border_width (consts.small_border_size)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create but.make_with_text_and_action ("Refresh", agent on_refresh_requested)
			hb.extend (but)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)

			but := edit_button
			but.select_actions.extend (agent on_edit_requested)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)
			but.disable_sensitive

			but := delete_page_button
			but.select_actions.extend (agent on_page_delete_requested)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)
			but.disable_sensitive

			but := new_page_button
			but.select_actions.extend (agent on_new_page_requested)
			hb.extend (but)
			but.set_minimum_width (consts.default_button_width)
			but.disable_sensitive
		end

feature -- Access

	port_number: INTEGER

	wdocs_manager: WDOCS_EDIT_MANAGER

	grid: EV_GRID

	wiki_page_select_actions: ACTION_SEQUENCE [TUPLE [WIKI_PAGE]]

	url_requested_actions: ACTION_SEQUENCE [TUPLE [READABLE_STRING_8]]

feature -- Access: window

	associated_window: detachable WDOCS_WINDOW

	set_associated_window (w: like associated_window)
		do
			associated_window := w
		end

feature -- Element change		

	set_wdocs_manager (a_wdocs: like wdocs_manager)
		do
			wdocs_manager := a_wdocs
			if attached associated_window as w then
				w.set_manager (a_wdocs)
			end
			on_refresh_requested
		end

feature -- Widgets

	edit_button,
	new_page_button,
	delete_page_button: EV_BUTTON

feature -- Docking

	sd_edit_button,
	sd_new_page_button,
	sd_delete_page_button: detachable SD_TOOL_BAR_BUTTON

	sd_content: SD_CONTENT
		local
			l_content: like internal_sd_content
			l_mini_tb: SD_TOOL_BAR
			l_mini_but: SD_TOOL_BAR_BUTTON
		do
			l_content := internal_sd_content
			if l_content = Void then
				create l_content.make_with_widget (Current, "Controller")
				l_content.set_long_title ("Controller")
				create l_mini_tb.make

				create l_mini_but.make
				l_mini_but.set_text ("Refresh")
				l_mini_but.set_name ("refresh_button")
				l_mini_but.set_tooltip ("Re-index wiki documentation files.")
				l_mini_but.select_actions.extend (agent on_refresh_requested)
				l_mini_tb.extend (l_mini_but)

				create l_mini_but.make
				l_mini_but.set_text ("Edit")
				l_mini_but.set_name ("edit_button")
				l_mini_but.set_tooltip ("Edit")
				l_mini_but.select_actions.extend (agent on_edit_requested)
				sd_edit_button := l_mini_but
				l_mini_tb.extend (l_mini_but)

				create l_mini_but.make
				l_mini_but.set_text ("New")
				l_mini_but.set_name ("newpage_button")
				l_mini_but.set_tooltip ("Add a new page.")
				l_mini_but.select_actions.extend (agent on_new_page_requested)
				sd_new_page_button := l_mini_but
				l_mini_tb.extend (l_mini_but)

				create l_mini_but.make
				l_mini_but.set_text ("Del")
				l_mini_but.set_name ("delete_button")
				l_mini_but.set_tooltip ("Delete selected page.")
				l_mini_but.select_actions.extend (agent on_page_delete_requested)
				sd_delete_page_button := l_mini_but
				l_mini_tb.extend (l_mini_but)

				l_content.set_mini_toolbar (l_mini_tb)
				l_mini_tb.compute_minimum_size

				internal_sd_content := l_content
			end
			Result := l_content
		end

	enable_mini_toolbar
		local
			l_content: like sd_content
			l_mini_tb: SD_TOOL_BAR
			l_mini_but: SD_TOOL_BAR_BUTTON
		do
			l_content := sd_content
			if l_content.mini_toolbar = Void then
				create l_mini_tb.make

				create l_mini_but.make
				l_mini_but.enable_displayed
				l_mini_but.set_text ("Refresh")
				l_mini_but.set_name ("refresh")
				l_mini_but.set_tooltip ("Re-index wiki documentation files.")
				l_mini_but.select_actions.extend (agent on_refresh_requested)
				l_mini_tb.extend (l_mini_but)

				l_content.set_mini_toolbar (l_mini_tb)
				l_mini_tb.show
			end
		end

	internal_sd_content: detachable like sd_content

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
			wdocs := wdocs_manager
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

	on_wiki_version_clicked (a_lab: EV_LABEL; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			d: DIRECTORY
			ut: FILE_UTILITIES
			v: READABLE_STRING_32
			l_version_id: detachable READABLE_STRING_GENERAL
		do
			if attached wdocs_manager.version_id as vid then
				l_version_id := vid
			else
				l_version_id := ""
			end
			create d.make_with_path (wdocs_manager.wiki_database_path.parent)
			if d.exists then
				create m.make_with_text ("Select Wiki version")
				across
					d.entries as ic
				loop
					v := ic.item.name
					if
						ic.item.is_current_symbol
						or ic.item.is_parent_symbol
						or v.starts_with (".")
					then

					elseif ut.directory_path_exists (d.path.extended (v)) then
						create mi.make_with_text (v)
						if wdocs_manager.is_version_id (v) then
							mi.set_text (mi.text + " *")
						end
						m.extend (mi)
						mi.select_actions.extend (agent (ia_lab: EV_TEXTABLE; ia_version: READABLE_STRING_32)
							local
								l_manager: WDOCS_EDIT_MANAGER
							do
								if not wdocs_manager.is_version_id (ia_version) then
									create l_manager.make (wdocs_manager.wiki_database_path.parent.extended (ia_version), ia_version, wdocs_manager.tmp_dir)
									ia_lab.set_text ({STRING_32} "Wiki #" + ia_version)
									if attached {EV_APPLICATION} ev_application as l_app then
										l_app.add_idle_action_kamikaze (agent set_wdocs_manager (l_manager))
									end
								end
							end(a_lab, v)
							)
					end
				end
				if not m.is_empty then
					m.show_at (a_lab, a_x, a_y)
				end
			end
		end

	on_wiki_page_selected (wp: WIKI_PAGE)
		do
			edit_button.enable_sensitive
			if attached sd_edit_button as sd_but then
				sd_but.enable_sensitive
			end

			new_page_button.enable_sensitive
			if attached sd_new_page_button as sd_but then
				sd_but.enable_sensitive
			end

			if not wp.has_page then
				delete_page_button.enable_sensitive
				if attached sd_delete_page_button as sd_but then
					sd_but.enable_sensitive
				end
			else
				delete_page_button.disable_sensitive
				if attached sd_delete_page_button as sd_but then
					sd_but.disable_sensitive
				end
			end

			wiki_page_select_actions.call ([wp])
		end

	on_row_selected (r: EV_GRID_ROW)
		do
			if attached wiki_page_from_row (r) as wp then
				on_wiki_page_selected (wp)
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		do
			delete_page_button.disable_sensitive
			edit_button.disable_sensitive
			new_page_button.disable_sensitive

			if attached sd_edit_button as sd_but then
				sd_but.disable_sensitive
			end
			if attached sd_new_page_button as sd_but then
				sd_but.disable_sensitive
			end
			if attached sd_delete_page_button as sd_but then
				sd_but.disable_sensitive
			end
		end

	on_row_expanded (r: EV_GRID_ROW)
		local
			glab: EV_GRID_LABEL_ITEM
			i: INTEGER
			j: INTEGER
			man: like wdocs_manager
		do
			if attached wiki_page_from_row (r) as wp and then attached wp.pages as l_pages then
				man := wdocs_manager
				i := r.index
				j := 0
				across
					l_pages as ic
				loop
					j := j + 1
					r.insert_subrow (j)
					create glab.make_with_text (man.wiki_page_link_title (ic.item))
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
				n := n - 1
			end
			r.ensure_expandable
		end

	on_refresh_requested
		do
			wdocs_manager.refresh_data
			refresh_now
		end

	on_new_page_requested
		local
			dlg: EV_DIALOG
			lab: EV_LABEL
			tf: EV_TEXT_FIELD
			but: EV_BUTTON
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			if attached selected_wiki_page as wp then
				create dlg.make_with_title ("Add Page")
				create vb
				dlg.extend (vb)
				create lab.make_with_text ("Enter a valid wiki name:")
				vb.extend (lab)
				vb.disable_item_expand (lab)
				create tf.make_with_text ("New Page")
				vb.extend (tf)
				vb.disable_item_expand (tf)
				create hb
				vb.extend (hb)

				create but.make_with_text_and_action ("Ok", agent (ia_wp: WIKI_PAGE; ia_tf: EV_TEXT_FIELD; ia_dlg: EV_DIALOG)
						do
							if attached ia_tf.text as l_title and then not l_title.is_whitespace then
								wdocs_manager.create_page_under (ia_wp, l_title)
								refresh_now
								ia_dlg.destroy_and_exit_if_last
							else
									-- FIXME: Report invalid wiki name!									
							end
						end(wp, tf, dlg)
					)
				hb.extend (create {EV_CELL})
				hb.extend (but)
				hb.disable_item_expand (but)
				dlg.set_default_push_button (but)

				create but.make_with_text_and_action ("Cancel", agent do end)
				hb.extend (but)
				hb.disable_item_expand (but)
				hb.extend (create {EV_CELL})
				dlg.set_default_cancel_button (but)

				if attached associated_window as w then
					dlg.show_modal_to_window (w)
				else
					dlg.show
				end
			end
		end

	on_page_delete_requested
		local
			dlg: EV_CONFIRMATION_DIALOG
		do
			if attached selected_wiki_page as wp then
				create dlg.make_with_text ({STRING_32} "Delete wiki page [[" + wp.title + "]]?" )
				dlg.set_buttons_and_actions (<<"Cancel", "Delete">>, <<Void, agent delete_page (wp)>>)

				if attached associated_window as w then
					dlg.show_modal_to_window (w)
				else
					dlg.show
				end
			end
		end

	on_edit_requested
		do
			if attached selected_wiki_page as wp then
				edit_page (wp)
			end
		end

	save_wiki_page (wp: WIKI_PAGE; a_text: READABLE_STRING_8)
		require
			path_set: wp.path /= Void
		do
			wdocs_manager.save_wiki_text (wp, a_text)
		end

	delete_page (wp: WIKI_PAGE)
		require
			path_set: wp.path /= Void
		do
			wdocs_manager.delete_page (wp)
			refresh_now
		end

	edit_page (wp: WIKI_PAGE)
		local
			dlg: like edit_dialog
		do
			initialize_edit_tool
			if attached edit_tool as l_edit_tool then
				l_edit_tool.set_page (wp, wdocs_manager)
				l_edit_tool.show
			else
				dlg := edit_dialog
				if dlg = Void or else dlg.is_destroyed then
					create dlg.make
					edit_dialog := dlg
					dlg.wiki_text_updated_actions.extend (agent on_page_edited)
					dlg.wiki_page_saved_actions.extend (agent on_page_saved)
					dlg.set_size (600, 500)
				end
				dlg.set_page (wp, wdocs_manager)

				if attached associated_window as w then
					dlg.show_modal_to_window (w)
				else
					dlg.show
				end
			end
		end

	on_page_edited (a_page: detachable WIKI_PAGE; a_editor: detachable WDOCS_EDITOR; a_text: READABLE_STRING_8)
		do
			on_preview_requested (a_page, a_editor, a_text)
		end

	on_page_saved (a_page: WIKI_PAGE; a_editor: detachable WDOCS_EDITOR; a_title_updated: BOOLEAN)
		do
			if a_title_updated then
				on_refresh_requested
			end
			if attached wdocs_manager.page_url (a_page) as u then
				url_requested_actions.call ([u])
			end
		end

	on_preview_requested (a_page: detachable WIKI_PAGE; a_editor: detachable WDOCS_EDITOR; a_text: READABLE_STRING_8)
		local
			s: STRING
			p, l_wiki_path, l_xhtml_path: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			l_wiki_page: WIKI_BOOK_PAGE
			url: PATH_URI
			l_wdocs_manager: like wdocs_manager
		do
			l_wdocs_manager := wdocs_manager
			l_wdocs_manager.set_edited_page (a_page, a_editor)
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

			l_wiki_page := l_wdocs_manager.new_wiki_page ("Preview", "Preview")
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
			wvis: WDOCS_WIKI_XHTML_GENERATOR
		do
			create l_xhtml.make_empty

			create wvis.make (l_xhtml)
			wvis.set_link_resolver (a_manager)
			wvis.set_image_resolver (a_manager)
			wvis.set_template_resolver (a_manager)
			wvis.set_file_resolver (a_manager)
			wvis.visit_page (a_wiki_page)
			a_output.append (l_xhtml)
		end

	initialize_edit_tool
		local
			l_tool: like edit_tool
		do
			if
				attached associated_window as w and then
				attached w.sd_manager as sd_manager
			then
				l_tool := edit_tool
				if l_tool = Void then
					create l_tool.make (wdocs_manager)
					l_tool.wiki_text_updated_actions.extend (agent on_page_edited)
					l_tool.wiki_page_saved_actions.extend (agent on_page_saved)
					if attached l_tool.sd_content as l_editor then
						sd_manager.contents.extend (l_editor)
					end
					edit_tool := l_tool
				end
			end
		end

	edit_dialog: detachable WDOCS_EDIT_DIALOG

	edit_tool: detachable WDOCS_EDIT_TOOL

feature -- Helpers

	selected_wiki_page: detachable WIKI_PAGE
		do
			if attached grid.selected_rows as l_rows and then l_rows.count = 1 then
				Result := wiki_page_from_row (l_rows.first)
			end
		end

	wiki_page_from_row (r: EV_GRID_ROW): detachable WIKI_PAGE
		do
			if not r.is_destroyed then
				if attached {WIKI_PAGE} r.data as l_wp then
					Result := l_wp
				elseif attached {READABLE_STRING_GENERAL} r.data as l_book_name then
					if attached wdocs_manager.book (l_book_name) as wb then
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

end
