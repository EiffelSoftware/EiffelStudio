note
	description: "Summary description for {CTR_LOGS_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_INFO_TOOL

inherit
	CTR_TOOL
		redefine
			focus_widget
		end

	EV_SHARED_APPLICATION

	CTR_SHARED_GUI_PREFERENCES

create
	make

feature {NONE} -- Initialization

	build_interface (a_container: EV_CONTAINER)
		local
			g: like grid
			c: like sd_content
			mtb: SD_TOOL_BAR
			tbbut: SD_TOOL_BAR_BUTTON
		do
			create g
			grid := g
			a_container.extend (g)
			c := sd_content

			g.enable_multiple_row_selection
			g.set_column_count_to (2)
			g.disable_row_height_fixed
			g.enable_tree
			g.hide_tree_node_connectors
			g.hide_header
			g.key_release_actions.extend (agent on_key_released)

			c.set_short_title ("Info ...")
			c.set_long_title ("Info")
			create mtb.make
			create tbbut.make
			tbbut.set_pixmap (icons.new_diff_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent show_info_diff)
			mtb.extend (tbbut)

			create tbbut.make
			tbbut.set_pixmap (icons.new_text_small_toolbar_button_standard_icon ("Open Data Folder"))
			tbbut.select_actions.extend (agent open_data_folder)
			mtb.extend (tbbut)

			mtb.compute_minimum_size
			c.set_mini_toolbar (mtb)

			if attached preferences as prefs then
				changes_expanded := prefs.info_tool_changes_expanded_pref.value
			end
		end

feature -- Access

	current_log: detachable REPOSITORY_LOG

	current_repository: detachable REPOSITORY_DATA

	grid: ES_GRID

	focus_widget: detachable EV_WIDGET
			-- Real widget to focus, when `set_focus' is called
		do
			Result := grid
		end


feature -- Actions

	on_key_released	(k: EV_KEY)
		local
			s: detachable STRING_32
		do
			inspect k.code
			when {EV_KEY_CONSTANTS}.key_C, {EV_KEY_CONSTANTS}.key_INSERT then
				if
					ev_application.ctrl_pressed and
					not ev_application.alt_pressed and
					not ev_application.shift_pressed
				then
					create s.make_empty
					if
						attached grid.selected_rows as l_rows and then
						not l_rows.is_empty
					then
						create s.make_empty
						from
							l_rows.start
						until
							l_rows.after
						loop
							s.append_string (grid_row_to_string (l_rows.item))
							l_rows.forth
							if not l_rows.off then
								s.append_character ('%N')
							end
						end
					end
					ev_application.clipboard.set_text (s)
				end
			else
				-- default
			end
		end

	grid_row_to_string (a_row: EV_GRID_ROW): STRING_32
			-- Row's text to string
		local
			i,n: INTEGER
		do
			create Result.make_empty
			n := a_row.count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					if attached a_row.item (i) as l_item then
						if attached {EV_GRID_LABEL_ITEM} l_item as l_lab then
							Result.append_string (l_lab.text)
						else
						end
					end
					i := i + 1
					if i <= n then
						Result.append_character ('%T')
					end

				end
			end
		end

feature -- Element change

	update
		local
			g: like grid
			l_row, l_subrow: detachable EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			mlab: CTR_INFO_MESSAGE_GRID_ITEM
			grtxt: EV_GRID_RICH_LABEL_ITEM
--			gcb: EV_GRID_CHECKABLE_LABEL_ITEM
--			gtxt: EV_GRID_TEXT_ITEM
			md: like smart_log_message
			repo: REPOSITORY_DATA
			cst_info_title_col: INTEGER
			cst_info_value_col: INTEGER
			n: INTEGER
		do
			g := grid
			g.wipe_out
			g.row_expand_actions.wipe_out
			g.resize_actions.wipe_out
			cst_info_title_col := 2
			cst_info_value_col := 1

			if attached {REPOSITORY_SVN_LOG} current_log as rsvnlog then
				cst_info_title_col := 2
				cst_info_value_col := 1 -- 2

				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
--				l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Info"))
				create grtxt--.make_with_text ("revision " + rsvnlog.id + " by " + rsvnlog.author + " (" + rsvnlog.date + ")")
				grtxt.add_formatted_text ("revision ", Void, Void)
				grtxt.add_formatted_text (rsvnlog.id, info_highlight_fgcolor, font_bold)
				grtxt.add_formatted_text (" by ", Void, Void)
				grtxt.add_formatted_text (rsvnlog.author, info_highlight_fgcolor, font_bold)
				grtxt.add_formatted_text (" (" + rsvnlog.date + ")", Void, font_comment)
				l_row.set_item (cst_info_value_col, grtxt)

				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
--				create glab.make_with_text ("Message")
--				glab.align_text_top
--				l_row.set_item (cst_info_title_col, glab)
				repo := rsvnlog.parent
				md  := smart_log_message (rsvnlog, repo.tokens_keys)
				create mlab.make_with_text (md.message)
				mlab.set_foreground_color (info_highlight_fgcolor)
				mlab.set_font (message_font)
				mlab.align_text_top
				mlab.set_top_border (3)
				mlab.set_bottom_border (5)
				l_row.set_item (cst_info_value_col, mlab)

				if attached mlab.font as ft then
					l_row.set_height (ft.string_size (mlab.text).height + mlab.bottom_border + mlab.top_border)
				end

				if attached repo.tokens as l_tokens and then l_tokens.count > 0 then
					across l_tokens as tok loop
						if attached md.matches.item (tok.item.key) as lst then
							n := n + lst.count
						end
					end
					if n > 0 then
						if n > 1 then
							g.insert_new_row (g.row_count + 1)
							l_row := g.row (g.row_count)
							l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (n.out + " references"))
						else
							l_row := Void
						end

						across
							l_tokens as tok
						loop
							if attached md.matches.item (tok.item.key) as lst then
								from
									lst.start
								until
									lst.after
								loop
									if attached repo.token_url (tok.key, lst.item) as l_url then
										if l_row /= Void then
											g.insert_new_row_parented (g.row_count + 1, l_row)
										else
											g.insert_new_row (g.row_count + 1)
										end
										l_subrow := g.row (g.row_count)
--										l_subrow.set_item (cst_info_title_col, create {EV_GRID_ITEM})
										create glab.make_with_text (tok.item.key + " #" + lst.item + ": " + l_url)
										glab.set_data (l_url)
										glab.pointer_double_press_actions.force_extend (agent open_url (l_url))
										l_subrow.set_item (cst_info_value_col, glab)
									end
									lst.forth
								end
								if l_row /= Void and then l_row.is_expandable then
									l_row.expand
								end
							end
						end
					end
				end

				if attached rsvnlog.svn_revision.paths as l_changes and then l_changes.count > 0 then
--					g.insert_new_row (g.row_count + 1)
					l_row := Void
					if l_changes.count > 1 then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)

						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_changes.count.out + " nodes changed"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (rsvnlog.svn_revision.common_parent_path + " (..)"))
						l_row.expand_actions.extend (agent set_changes_expanded (True))
						l_row.collapse_actions.extend (agent set_changes_expanded (False))
					end

					across
						l_changes as l_paths
					loop
						if l_row /= Void then
							g.insert_new_row_parented (g.row_count + 1, l_row)
						else
							g.insert_new_row (g.row_count + 1)
						end

						l_subrow := g.row (g.row_count)
						l_subrow.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_paths.item.action))
						create glab.make_with_text (l_paths.item.path)
						l_subrow.set_item (cst_info_value_col, glab)
						glab.pointer_double_press_actions.force_extend (agent show_info ("service.diff.text", l_paths.item.path))
					end
					if l_row /= Void and then l_row.is_expandable and changes_expanded then
						l_row.expand
					end
				end


--				g.insert_new_row (g.row_count + 1)
				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
--				l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Diff"))

				if rsvnlog.has_diff then
					create glab.make_with_text ("Double click to SHOW diff")
					glab.pointer_double_press_actions.force_extend (agent show_info_diff) --popup_diff (rsvnlog))
					l_row.set_item (cst_info_value_col, glab)
				else
					create glab.make_with_text ("Double click to GET diff")
					glab.pointer_double_press_actions.force_extend (agent show_info_diff)
					l_row.set_item (cst_info_value_col, glab)
				end

				if attached rsvnlog.parent.repository_option ("service.diff.web") then
					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					create glab.make_with_text ("Double click to view changes online")
					glab.pointer_double_press_actions.force_extend (agent show_info ("service.diff.web", Void))
					l_row.set_item (cst_info_value_col, glab)
				end

				request_update_grid_layout (cst_info_title_col, cst_info_value_col)
			elseif attached {REPOSITORY_SVN_DATA} current_repository as rsvnrepo then
				cst_info_title_col := 1
				cst_info_value_col := 2

				if attached rsvnrepo.info as rinfo then
					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Revision"))
					l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (rinfo.revision.out))

					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Localisation"))
					l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (rinfo.localisation))

					if attached rinfo.last_changed_rev as l_rev then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last rev"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_rev.out))
					end
					if attached rinfo.last_changed_author as l_author then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last author"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_author))
					end
					if attached rinfo.last_changed_date as l_date then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last Date"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_date))
					end

					if attached rinfo.repository_root as l_root then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Repo Root"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_root))
					end

					if attached rinfo.repository_uuid as l_uuid then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Repo UUID"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_uuid))
					end

					if attached rinfo.url as l_url then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (cst_info_title_col, create {EV_GRID_LABEL_ITEM}.make_with_text ("Url"))
						l_row.set_item (cst_info_value_col, create {EV_GRID_LABEL_ITEM}.make_with_text (l_url))
					end

					request_update_grid_layout (cst_info_title_col, cst_info_value_col)
				end
			end
			g.row_expand_actions.force_extend (agent request_update_grid_layout (cst_info_title_col,cst_info_value_col))
			g.resize_actions.force_extend (agent request_update_grid_layout (cst_info_title_col,cst_info_value_col))
		end

	request_update_grid_layout (cst_info_title_col, cst_info_value_col: INTEGER)
		do
			ev_application.add_idle_action_kamikaze (agent update_grid_layout (cst_info_title_col, cst_info_value_col))
		end

	update_grid_layout (cst_info_title_col, cst_info_value_col: INTEGER)
		local
			g: like grid
			ww, w1, w2: INTEGER
			col: EV_GRID_COLUMN
			r,c,n: INTEGER
		do
			g := grid
				-- Update layout columns
			ww := g.viewable_width
			if g.column_count >= cst_info_title_col then
				col := g.column (cst_info_title_col)
				w1 := col.required_width_of_item_span (1, g.row_count) + 5
			end
			if g.column_count >= cst_info_value_col then
				col := g.column (cst_info_value_col)
				w2 := col.required_width_of_item_span (1, g.row_count) + 5
			end
			w2 := w2.max (ww - w1)
			if g.column_count >= cst_info_title_col then
				g.column (cst_info_title_col).set_width (w1)
			end
			if g.column_count >= cst_info_value_col then
				g.column (cst_info_value_col).set_width (w2)
			end
			from
				r := 1
			until
				r > g.row_count
			loop
				from
					c := 1
					n := g.row (r).count
				until
					c > n
				loop
					if attached {CTR_INFO_MESSAGE_GRID_ITEM} g.item (c, r) as m then
						m.update
						g.row (r).set_height (m.required_height_after_update)
					end
					c := c + 1
				end
				r := r + 1
			end
		end

	update_current_log (v: like current_log)
		do
			current_repository := Void
			current_log := v
			update
		end

	update_current_repository (v: like current_repository)
		do
			current_log := Void
			current_repository := v
			update
		end

feature {NONE} -- Smart log message

	smart_token_handler: detachable CTR_SMART_TOKEN_HANDLER
			-- Smart token handler

	smart_log_message (a_log: REPOSITORY_LOG; a_patterns: detachable ARRAY [detachable STRING]): like {CTR_SMART_TOKEN_HANDLER}.smart_log_message
		local
			h: like smart_token_handler
		do
			h := smart_token_handler
			if h = Void then
				create h
				smart_token_handler := h
			end
			Result := h.smart_log_message (a_log, a_patterns)
		end

feature {NONE} -- Implementation

	open_url (a_url: STRING)
		local
			e: CTR_EXTERNAL_TOOLS
		do
			create e
			e.open_url (a_url)
		end

	open_data_folder
		local
			exec: EXECUTION_ENVIRONMENT
			s: detachable STRING
			rep: like current_repository
		do
			if attached current_repository as r then
				rep := r
			elseif attached current_log as l_log then
				rep := l_log.parent
			end
			if
				rep /= Void and then
				attached {REPOSITORY_FILE_STORAGE} rep.storage as fs
			then
				s := fs.data_folder_name
			end
			if s /= Void then
				create exec
				if attached exec.get ("COMSPEC") as l_comspec then
					s := l_comspec + " /C start " + s
				else
					s := "explorer " + s
				end
				exec.launch (s)
			end
		end

--	popup_diff (a_log: REPOSITORY_LOG)
--		do
--			if attached ctr_window as w then
--				w.popup_diff (a_log)
--			end
--		end

	show_info_diff
		do
			show_info ("service.diff.file", Void)
			if attached ctr_window as w then
				if attached current_log as l_log then
					w.show_log_diff (l_log)
				end
			end
		end

	show_info (a_service: STRING; a_path: detachable STRING)
		do
			if attached ctr_window as w then
				if attached current_log as l_log then
					w.show_log (a_service, l_log, a_path)
				end
			end
		end

	changes_expanded: BOOLEAN

	set_changes_expanded (b: BOOLEAN)
		do
			changes_expanded := b
			if attached preferences as prefs then
				prefs.info_tool_changes_expanded_pref.set_value (b)
			end
		end

end
