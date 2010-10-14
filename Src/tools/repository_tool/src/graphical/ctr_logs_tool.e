note
	description: "Summary description for {CTR_LOGS_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_LOGS_TOOL

inherit
	CTR_TOOL
		redefine
			make,
			focus_widget
		end

	CTR_SHARED_RESOURCES

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
		do
			create {ARRAYED_LIST [like current_views.item]} current_views.make (1)
			Precursor (a_name)
		end

	build_interface (a_container: EV_CONTAINER)
		local
			g: like grid
			c: like sd_content
			mtb: SD_TOOL_BAR
			tbbut: SD_TOOL_BAR_BUTTON
			tbtoggbut: SD_TOOL_BAR_TOGGLE_BUTTON
		do
			create g
			grid := g

			a_container.extend (g)


			c := sd_content
--			g.enable_single_row_selection
			g.enable_multiple_row_selection
			g.enable_row_separators
			g.enable_column_separators
			g.set_separator_color (grid_separator_color)
			g.set_column_count_to (4)
			g.enable_partial_dynamic_content
			g.set_dynamic_content_function (agent on_logs_compute_grid_item (g, ?,?))
			g.column (cst_revision_column).set_title ("rev")
			g.column (cst_author_column).set_title ("author")
			g.column (cst_log_column).set_title ("message")
			g.column (cst_date_column).set_title ("date")
			c.set_short_title ("Logs ...")
			c.set_long_title ("Logs ...")
			g.enable_selection_on_single_button_click
--			g.disable_selection_on_click
			g.pointer_button_press_item_actions.extend (agent on_item_pointer_pressed)
			g.pointer_button_release_item_actions.extend (agent on_item_pointer_released)
			g.row_select_actions.extend (agent on_log_row_selected)
			g.pointer_double_press_item_actions.extend (agent on_log_item_double_clicked)
			create mtb.make

			create tbtoggbut.make
			tbtoggbut.set_pixmap (icons.new_text_small_toolbar_button_standard_icon ("Hide-Read"))
			tbtoggbut.select_actions.extend (agent (ai_togg: SD_TOOL_BAR_TOGGLE_BUTTON)
					do
						if ai_togg.is_selected then
							add_filter (unread_filter)
						else
							remove_filter (unread_filter)
						end
					end(tbtoggbut))
			mtb.extend (tbtoggbut)

			create tbbut.make
			tbbut.set_pixmap (icons.new_mark_all_read_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent mark_all_read_logs)
			mtb.extend (tbbut)

			mtb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create tbbut.make
			tbbut.set_pixmap (icons.new_check_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent check_current_repositories)
			mtb.extend (tbbut)

			mtb.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create tbbut.make
			tbbut.set_pixmap (icons.new_archive_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent archive_selected_row_logs)
			mtb.extend (tbbut)


			create tbtoggbut.make
			tbtoggbut.set_pixmap (icons.new_text_small_toolbar_button_standard_icon ("With Archive"))
			tbtoggbut.select_actions.extend (agent (ai_togg: SD_TOOL_BAR_TOGGLE_BUTTON)
					do
						if ai_togg.is_selected then
							import_archive_logs
						else
							reload
						end
					end(tbtoggbut))
			mtb.extend (tbtoggbut)

--			create tbbut.make
--			tbbut.set_pixmap (icons.new_text_small_toolbar_button_standard_icon ("Import archive"))
--			tbbut.select_actions.extend (agent import_archive_logs)
--			mtb.extend (tbbut)

			create tbbut.make
			tbbut.set_pixmap (icons.new_remove_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent delete_selected_row_logs)
			mtb.extend (tbbut)

			mtb.compute_minimum_size
			c.set_mini_toolbar (mtb)

			g.key_press_actions.extend (agent on_key_pressed)
		end

feature -- Access

	focus_widget: detachable EV_WIDGET
			-- Real widget to focus, when `set_focus' is called
		do
			Result := grid
		end

	current_log: detachable REPOSITORY_LOG

	current_repository: detachable REPOSITORY_DATA
		do
			if current_views.count > 0 then
				Result := current_views.first.repo
			end
		end

	current_repositories: LIST [REPOSITORY_DATA]
		do
			Result := repositories_from_views (current_views)
		end

	current_views: LIST [REPOSITORY_DATA_VIEW]

	filter: detachable REPOSITORY_LOG_FILTER

	review_enabled: BOOLEAN

	grid: ES_GRID

feature -- Element change

	add_filter (f: REPOSITORY_LOG_FILTER)
		local
			o_filter: like filter
			grp: REPOSITORY_LOG_GROUP_FILTER
		do
			o_filter := filter
			if o_filter = Void then
				filter := f
			elseif attached {REPOSITORY_LOG_GROUP_FILTER} o_filter as g then
				g.add_filter (f)
			else
				create grp.make (2)
				grp.add_filter (o_filter)
				grp.add_filter (f)
				filter := f
			end
			if o_filter /= filter then
				custom_update (False)
			end
		end

	remove_filter (f: REPOSITORY_LOG_FILTER)
		local
			o_filter: like filter
		do
			o_filter := filter
			if o_filter = Void then
				-- do nothing
			elseif attached {REPOSITORY_LOG_GROUP_FILTER} o_filter as g then
				g.remove_filter (f)
			elseif o_filter = f then
				filter := Void
			end
			if o_filter /= filter then
				custom_update (False)
			end
		end

	reload
		do
			if attached current_repositories as reps then
				across
					reps as c
				loop
					c.item.reload_logs
				end
			end
			update
		end

	update
		do
			custom_update (True)
		end

	custom_update (a_reload: BOOLEAN)
		local
			g: like grid
			l_sorted_logs: ARRAYED_LIST [REPOSITORY_LOG]
			l_sorter: like log_sorter
			l_filter: detachable REPOSITORY_LOG_FILTER
			lst: like current_views
			n,r: INTEGER
			rdata: REPOSITORY_DATA
			plst: ARRAYED_LIST [REPOSITORY_DATA]
			prev: detachable REPOSITORY_LOG
		do
			if review_enabled then
				show_review_bar
			else
				hide_review_bar
			end
			g := grid
			g.set_row_count_to (0)
			lst := current_views
			if lst.count > 0 then
				create plst.make (lst.count)
				from lst.start until lst.after loop
					rdata := lst.item.repo
					if not plst.has (rdata) then
						plst.force (rdata)
						if a_reload then
							rdata.load_logs
						end
						if attached rdata.logs as l_logs then
							n := n + l_logs.count
						end
					end
					lst.forth
				end
				if n > 0 then
					create l_sorted_logs.make (n)
					from lst.start until lst.after loop
						rdata := lst.item.repo
						if attached rdata.logs as l_logs then
							l_filter := lst.item.filter
--							debug
--								create {REPOSITORY_LOG_PATH_FILTER} l_filter.make ("/trunk/Src/C")
--								create {REPOSITORY_LOG_AUTHOR_FILTER} l_filter.make ("jfiat")
--							end

							across
								l_logs as c
							loop
								n := n - 1
								if l_filter /= Void then
									if l_filter.matched (c.item) then
										l_sorted_logs.force (c.item)
									end
								else
									l_sorted_logs.force (c.item)
								end
							end
						end
						lst.forth
					end
					check n = 0 end
					if l_sorted_logs.count > 0 then
						l_sorter := log_sorter
						l_sorter.reverse_sort (l_sorted_logs)
						l_filter := filter
						from l_sorted_logs.start until l_sorted_logs.after loop
							if attached l_sorted_logs.item as l_log then
								if l_log = prev then --| remove duplicates
									l_sorted_logs.remove
								else
									if l_filter /= Void then
										if l_filter.matched (l_log) then
											l_sorted_logs.forth
										else
											l_sorted_logs.remove
										end
									else
										l_sorted_logs.forth
									end
								end
								prev := l_log
							else
								l_sorted_logs.remove
							end
						end
						n := l_sorted_logs.count
						if n > 0 then
							g.insert_new_rows (n, 1)

							from
								r := 1
								l_sorted_logs.start
							until
								l_sorted_logs.after
							loop
								if attached l_sorted_logs.item as l_log then
--									g.insert_new_row (g.row_count + 1)
--									l_row := g.row (g.row_count)
									g.row (r).set_data (l_log)
									r := r + 1
								end
								l_sorted_logs.forth
							end
						end
					end
				end
			end
			sd_content.set_long_title (grid.row_count.out + " logs")
		end

	reset
		do
			current_log := Void
			if attached repository_colors as h then
				h.wipe_out
			end
			filter := Void
			hide_search_bar
		end

	same_views (r1, r2: like current_views): BOOLEAN
		local
			bak: like current_views
		do
			bak := r1
			Result := r2.count = bak.count
			if Result then
				bak := bak.twin
				across
					r2 as c
				until
					not bak.has (c.item)
				loop
					bak.prune_all (c.item)
				end
				Result := bak.count = 0
			end
		end

	update_current_repositories (a_data: like current_views)
		local
			update_needed: BOOLEAN
		do
			if not same_views (current_views, a_data) then
				update_needed := True
				current_views.wipe_out
				if a_data.count > 0 then
					current_views.fill (a_data)
				end
				current_log := Void
			end
			if
				attached repositories_from_views (a_data) as crepos and then
				crepos.count = 1
			then
				review_enabled := crepos.first.review_enabled
			else
				review_enabled := False --a_repo /= Void and then a_repo.review_enabled
			end
			if update_needed then
				update
			end
		end

	check_current_repositories
		do
			if attached ctr_window as w then
				if attached current_views as rlst and then rlst.count > 0 then
					across
						rlst as c
					loop
						w.check_repository (c.item.repo)
					end
				end
			end
		end

feature -- Search

	search_bar: detachable CTR_LOGS_SEARCH_BOX

	build_search_bar
		local
			box: like search_bar
		do
			create box.make (Current)
			search_bar := box

			container.extend (box.widget)
			container.disable_item_expand (box.widget)
		end

	show_search_bar
		do
			if search_bar = Void then
				build_search_bar
			end
			if attached search_bar as b then
				if not b.shown then
					b.reset
				end
				b.show
			end
		end

	hide_search_bar
		do
			if attached search_bar as b then
				b.hide
			end
			filter := Void
		end

--	toggle_search_bar
--		do
--			if attached search_bar as b then
--				if b.shown then
--					hide_search_bar
--				else
--					show_search_bar
--				end
--			else
--				show_search_bar
--			end
--		end

feature -- Review		

	review_bar: detachable CTR_LOGS_REVIEW_BOX

	update_review_bar
		do
			if attached review_bar as r then
				r.update_current_log (current_log)
			end
		end

	build_review_bar
		local
			box: like review_bar
		do
			create box.make (Current)
			review_bar := box

			container.put_front (box.widget)
			container.disable_item_expand (box.widget)
		end

	show_review_bar
		do
			if review_bar = Void then
				build_review_bar
			end
			if attached review_bar as b then
				b.reset
				b.show
			end
		end

	hide_review_bar
		do
			if attached review_bar as b then
				b.hide
			end
		end

feature -- Basic operations

	update_log (a_log: REPOSITORY_LOG)
		local
			r,n: INTEGER
			g: like grid
			l_row: detachable EV_GRID_ROW
		do
			g := grid
			from
				r := 1
				n := g.row_count
			until
				r > n or l_row /= Void
			loop
				l_row := g.row (r)
				if l_row.data /= a_log then
					l_row := Void
				end
				r := r + 1
			end
			if l_row /= Void then
				compute_row (a_log, l_row)
			end
			if a_log = current_log then
				if attached review_bar as rbar then
					rbar.update_current_log (a_log)
				end
			end
		end

feature {CTR_WINDOW} -- Implementation

	repositories_from_views (a_data: like current_views): LIST [REPOSITORY_DATA]
		do
			create {ARRAYED_LIST [REPOSITORY_DATA]} Result.make (a_data.count)
			if a_data.count > 0 then
				from
					a_data.start
				until
					a_data.after
				loop
					if not Result.has (a_data.item.repo) then
						Result.force (a_data.item.repo)
					end
					a_data.forth
				end
			end
		end

	request_update_logs_layout
		local
			l_update_logs_layout_action: like update_logs_layout_action
		do
			l_update_logs_layout_action := update_logs_layout_action
			if l_update_logs_layout_action = Void then
				create l_update_logs_layout_action.make (agent update_logs_layout, 100)
				update_logs_layout_action := l_update_logs_layout_action
			end
			l_update_logs_layout_action.request_call (Void)
		end

	update_logs_layout_action: detachable EV_DELAYED_ACTION_ARGS [detachable TUPLE]

	update_logs_layout
		local
			g: like grid
			w1, w: INTEGER
		do
			if attached update_logs_layout_action as d_act then
				d_act.cancel_request
				update_logs_layout_action := Void
			end

			w1 := 0
			g := grid
			if attached g.column (cst_revision_column) as col then
				col.set_width (col.required_width_of_item_span (1, g.row_count) + 4)
				w1 := w1 + col.width
			end
			if attached g.column (cst_date_column) as col then
				col.set_width (col.required_width_of_item_span (1, g.row_count) + 4)
				w1 := w1 + col.width
			end
			if attached g.column (cst_author_column) as col then
				col.set_width (col.required_width_of_item_span (1, g.row_count) + 4)
				w1 := w1 + col.width
			end
			if attached g.column (cst_log_column) as col then
				w := g.viewable_width
				col.set_width (w - w1 - g.vertical_scroll_bar.width)
			end
		end

	compute_row (a_log: REPOSITORY_LOG; a_row: EV_GRID_ROW)
		require
			row_has_log: a_row.data = a_log
		local
			glab_buts: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
			glab: EV_GRID_LABEL_ITEM
			c: INTEGER
			stats: like {REPOSITORY_LOG_REVIEW}.stats
		do
			if a_log.has_review and then attached a_log.review as l_review then
				c := 0
				stats := l_review.stats
				if stats.approved > 0 then
					c := c + 1
				end
				if stats.refused > 0 then
					c := c + 1
				end
				if stats.question > 0 then
					c := c + 1
				end

				create glab_buts.make_with_text (a_log.id)
				if stats.approved > stats.refused then
					glab_buts.set_foreground_color (colors.dark_green)
				elseif stats.approved < stats.refused then
					glab_buts.set_foreground_color (colors.dark_red)
				end

				glab_buts.set_pixmaps_on_right_count (c)
				if stats.question > 0 then
					glab_buts.put_pixmap_on_right (icons.review_question_icon, c)
					c := c - 1
				end
				if stats.approved > 0 then
					glab_buts.put_pixmap_on_right (icons.review_approved_icon, c)
					c := c - 1
				end
				if stats.refused > 0 then
					glab_buts.put_pixmap_on_right (icons.review_refused_icon, c)
				end
				a_row.set_item (cst_revision_column, glab_buts)
			else
				a_row.set_item (cst_revision_column, create {EV_GRID_LABEL_ITEM}.make_with_text (a_log.id))
			end
			create glab.make_with_text (a_log.single_line_message)
			a_row.set_item (cst_log_column, glab)
			a_row.set_item (cst_author_column, create {EV_GRID_LABEL_ITEM}.make_with_text (a_log.author))
			a_row.set_item (cst_date_column, create {EV_GRID_LABEL_ITEM}.make_with_text (a_log.date))

			if current_views.count > 1 then
				a_row.set_foreground_color (repository_color (a_log.parent))
			else
				a_row.set_foreground_color (Void)
			end

			if a_log.unread then
				mark_log_unread (a_row)
			end
		end

	on_logs_compute_grid_item (g: EV_GRID; c,r: INTEGER): EV_GRID_ITEM
		local
			gitem: detachable EV_GRID_ITEM
		do
			if attached g.row (r) as l_row then
				if attached {REPOSITORY_LOG} l_row.data as r_log then
					compute_row (r_log, l_row)
				end
				if l_row.count >= c then
					gitem := l_row.item (c)
				end
			end
			if gitem /= Void then
				Result := gitem
			else
				create Result
				g.set_item (c, r, Result)
			end
			request_update_logs_layout
		end

	on_log_row_selected (r: EV_GRID_ROW)
		local
			w: like ctr_window
		do
			if
				attached {REPOSITORY_LOG} r.data as rlog
			then
				rlog.mark_read
				mark_log_read (r)
				w := ctr_window
				if w /= Void then
					w.update_catalog_row_by_data (rlog.parent)
				end
				if current_log /= rlog then
					if grid.selected_rows.count <= 1 then
						current_log := rlog
						update_review_bar
						if w /= Void then
							w.info_tool.update_current_log (rlog)
						end
					else
						current_log := Void
						update_review_bar
						if w /= Void then
							w.info_tool.update_current_log (Void)
						end
					end
				end
			end
		end

	on_key_pressed (a_key: EV_KEY)
		do
			inspect a_key.code
			when {EV_KEY_CONSTANTS}.key_delete then
				if ev_application.shift_pressed then
					delete_selected_row_logs
				end
			when {EV_KEY_CONSTANTS}.key_a then
				if ev_application.ctrl_pressed then
					select_all_rows
				end
			when {EV_KEY_CONSTANTS}.key_f then
				if ev_application.ctrl_pressed then
					show_search_bar
				end
			when {EV_KEY_CONSTANTS}.key_insert then
				toggle_read_status_on_selected_row_logs
			else
			end
		end

	on_item_pointer_released (a_x, a_y, a_but: INTEGER; a_cell: detachable EV_GRID_ITEM)
		do
			if a_but = 1 and then a_cell /= Void and then attached a_cell.row as r then
				on_log_row_selected (r)
			end
		end

	on_item_pointer_pressed (a_x, a_y, a_but: INTEGER; a_cell: detachable EV_GRID_ITEM)
		do
			if a_cell /= Void and then attached a_cell.row as r and then attached r.parent as g then
				if a_but = 1 then
--					ev_application.add_idle_action_kamikaze (agent on_log_row_selected (r))
--					on_log_row_selected (r)
				else
					if attached new_row_log_menu (r) as m then
						m.show_at (g, a_x - g.virtual_x_position, a_y - g.virtual_y_position)
					end
				end
			end
		end

	new_row_log_menu (r: EV_GRID_ROW): detachable EV_MENU
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			l_username: detachable STRING
			rev_data: detachable REPOSITORY_LOG_REVIEW
			user_rev_data: detachable like {REPOSITORY_LOG_REVIEW}.user_review
		do
			if attached {REPOSITORY_LOG} r.data as l_log then
				create m.make_with_text (l_log.id)
				create mi.make_with_text (l_log.id)
				mi.disable_sensitive
				m.extend (mi)
				m.extend (create {EV_MENU_SEPARATOR})
				if l_log.parent.review_enabled then
					if attached l_log.parent.review_username as u then
						l_username := u
					end

					create mi.make_with_text ("Review #" + l_log.id)
					mi.disable_sensitive
					m.extend (mi)

					if l_log.has_review then
						rev_data := l_log.review
						if rev_data /= Void and l_username /= Void then
							user_rev_data := rev_data.user_review (l_username, Void)
						end
					end

					create mci.make_with_text ("Approve")
					if user_rev_data /= Void and then user_rev_data.is_approved_status then
						mci.enable_select
						mci.select_actions.extend (agent (ia_log: REPOSITORY_LOG; ia_rev: detachable REPOSITORY_LOG_REVIEW; ia_usr: detachable STRING)
							local
								rev: detachable REPOSITORY_LOG_REVIEW
							do
								if ia_usr /= Void then
									rev := ia_rev
									if rev = Void then
										create rev.make
									end
									rev.unapprove (ia_usr)
									ia_log.parent.store_log_review (ia_log, rev)
									update_log (ia_log)
								end
							end(l_log, rev_data, l_username)
						)
					else
						mci.select_actions.extend (agent (ia_log: REPOSITORY_LOG; ia_rev: detachable REPOSITORY_LOG_REVIEW; ia_usr: detachable STRING)
							local
								rev: detachable REPOSITORY_LOG_REVIEW
							do
								if ia_usr /= Void then
									rev := ia_rev
									if rev = Void then
										create rev.make
									end
									rev.approve (ia_usr)
									ia_log.parent.store_log_review (ia_log, rev)
									update_log (ia_log)
								end
							end(l_log, rev_data, l_username)
						)
					end
					m.extend (mci)
					create mci.make_with_text ("Refuse")
					if user_rev_data /= Void and then user_rev_data.is_refused_status then
						mci.enable_select
						mci.select_actions.extend (agent (ia_log: REPOSITORY_LOG; ia_rev: detachable REPOSITORY_LOG_REVIEW; ia_usr: detachable STRING)
							local
								rev: detachable REPOSITORY_LOG_REVIEW
							do
								if ia_usr /= Void then
									rev := ia_rev
									if rev = Void then
										create rev.make
									end
									rev.unrefuse (ia_usr)
									ia_log.parent.store_log_review (ia_log, rev)
									update_log (ia_log)
								end
							end(l_log, rev_data, l_username)
						)
					else
						mci.select_actions.extend (agent (ia_log: REPOSITORY_LOG; ia_rev: detachable REPOSITORY_LOG_REVIEW; ia_usr: detachable STRING)
							local
								rev: detachable REPOSITORY_LOG_REVIEW
							do
								if ia_usr /= Void then
									rev := ia_rev
									if rev = Void then
										create rev.make
									end
									rev.refuse (ia_usr)
									ia_log.parent.store_log_review (ia_log, rev)
									update_log (ia_log)
								end
							end(l_log, rev_data, l_username)
						)
					end
					m.extend (mci)
					create mci.make_with_text ("Comment")
					if user_rev_data /= Void and then user_rev_data.is_question_status then
						mci.enable_select
					end
					m.extend (mci)

					m.extend (create {EV_MENU_SEPARATOR})
					create mi.make_with_text ("Submit Review")
					m.extend (mi)
					if user_rev_data = Void then
						mi.disable_sensitive
					elseif not user_rev_data.is_remote then
						mi.enable_sensitive
						mi.select_actions.extend (agent (ia_log: REPOSITORY_LOG)
								do
									if
										attached ia_log.review as l_review and then
										attached ia_log.parent.review_client as l_client
									then
										l_client.submit (ia_log, l_review)
										if l_client.last_error_occurred then
											print (l_client.last_error_to_string + "%N")
										end
									end
								end(l_log)
						)
					end
				end

					--| Read/delete/...
				m.extend (create {EV_MENU_SEPARATOR})
				create mci.make_with_text ("Read")
				if l_log.unread then
					mci.select_actions.extend (agent (ia_r: EV_GRID_ROW; ia_log: REPOSITORY_LOG)
						do
							mark_log_read (ia_r)
							ia_log.mark_read
						end(r, l_log))
				else
					mci.select_actions.extend (agent (ia_r: EV_GRID_ROW; ia_log: REPOSITORY_LOG)
						do
							mark_log_unread (ia_r)
							ia_log.mark_unread
						end(r, l_log))
					mci.enable_select
				end
				m.extend (mci)

				create mi.make_with_text ("Delete")
				mi.select_actions.extend (agent delete_row_log (r, True))
				m.extend (mi)

				Result := m
			end
		end

	on_log_item_double_clicked (a_x, a_y, a_but: INTEGER; a_cell: detachable EV_GRID_ITEM)
		do
			if a_cell /= Void and then attached a_cell.row as r then
				show_log_diff_from_row (r)
			end
		end

	show_log_diff_from_row (r: EV_GRID_ROW)
		do
			if attached {REPOSITORY_LOG} r.data as l_log then
				if current_log /= l_log then
					on_log_row_selected (r)
				end
				if attached ctr_window as w then
					w.show_log_diff (l_log)
				else
					print (l_log.diff)
				end
			end
		end

	select_all_rows
		local
			g: like grid
			r,n: INTEGER
		do
			g := grid
			from
				r := 1
				n := g.row_count
			until
				r > n
			loop
				g.row (r).enable_select
				r := r + 1
			end
		end

	import_archive_logs
		local
			s: STRING
		do
			s := "Import archives"
			if attached current_repositories as reps and then reps.count > 1 then
				s.append_string (" for multiple repositories")
			elseif attached current_repository as crep then
				s.append_string (" for [" + crep.repository_location + "]")
			end
			console_log (s)
			if attached current_repositories as reps and then reps.count > 0 then
				from
					reps.start
				until
					reps.after
				loop
					if attached reps.item as rep then
						rep.import_archive_logs
					end
					reps.forth
				end
			end
			update
			update_info_tool
		end

	archive_selected_row_logs
		local
			s: STRING
		do
			if attached grid.selected_rows as l_rows and then l_rows.count > 0 then
				s := "Archiving " + l_rows.count.out + " entries"
				if attached current_repositories as reps and then reps.count > 1 then
					s.append_string (" from multiple repositories")
				elseif attached current_repository as crep then
					s.append_string (" from [" + crep.repository_location + "]")
				end
				console_log (s)

				across
					l_rows as c
				loop
					if attached {REPOSITORY_LOG} c.item.data as l_log then
						c.item.disable_select
						l_log.archive
						c.item.hide
					end
				end
				current_log := Void
				update_info_tool
			end
		end

	mark_all_read_logs
		local
			g: like grid
			r,n: INTEGER
			w: like ctr_window
			plst: detachable ARRAYED_LIST [REPOSITORY_DATA]
		do
			g := grid
			n := g.row_count
			if n > 0 then
				w := ctr_window
				if w /= Void then
					create plst.make (repositories_from_views (current_views).count)
				end
				from
					r := 1
				until
					r > n
				loop
					if attached {REPOSITORY_LOG} g.row (r).data as l_log then
						if l_log.unread then
							l_log.mark_read
							mark_log_read (g.row (r))
							if plst /= Void and then not plst.has (l_log.parent) then
								plst.force (l_log.parent)
							end
						end
					end
					r := r + 1
				end
				if w /= Void and plst /= Void and then plst.count > 0 then
					across
						plst as c
					loop
						w.update_catalog_row_by_data (c.item)
					end
				end
			end
		end

	update_info_tool
		do
			if attached ctr_window as w then
				w.info_tool.update_current_repository (current_repository)
			end
		end

	delete_selected_row_logs
		do
			if attached grid.selected_rows as l_rows and then l_rows.count > 0 then
				across
					l_rows as c
				loop
					delete_row_log (c.item, False)
				end
				current_log := Void
				update_info_tool
			end
		end

	delete_row_log (r: EV_GRID_ROW; update_now: BOOLEAN)
		do
			if attached {REPOSITORY_LOG} r.data as l_log then
				r.disable_select
				l_log.delete
				r.hide
				if update_now and current_log = l_log then
					current_log := Void
					update_info_tool
				end
			end
		end

	toggle_read_status_on_selected_row_logs
		local
			w: like ctr_window
		do
			if attached grid.selected_rows as l_rows and then l_rows.count > 0 then
				w := ctr_window
				across
					l_rows as c
				loop
					if attached {REPOSITORY_LOG} c.item.data as l_log then
						if l_log.unread then
							l_log.mark_read
							mark_log_read (c.item)
						else
							l_log.mark_unread
							mark_log_unread (c.item)
						end
						if w /= Void then
							w.update_catalog_row_by_data (l_log.parent)
						end
					end
				end
			end
		end

	mark_log_unread (a_row: EV_GRID_ROW)
		local
			n,c: INTEGER
			ft: EV_FONT
		do
			n := a_row.count
			if n > 0 then
				ft := font_unread_log
				from
					c := 1
				until
					c > n
				loop
					if attached {EV_GRID_LABEL_ITEM} a_row.item (c) as l_lab then
						l_lab.set_font (ft)
					end
					c := c + 1
				end
			end
		end

	mark_log_read (a_row: EV_GRID_ROW)
		local
			n,c: INTEGER
			ft: EV_FONT
		do
			n := a_row.count
			if n > 0 then
				ft := font_read_log
				from
					c := 1
				until
					c > n
				loop
					if attached {EV_GRID_LABEL_ITEM} a_row.item (c) as l_lab then
						l_lab.set_font (ft)
					end
					c := c + 1
				end
			end
		end

	repository_color (a_data: REPOSITORY_DATA): detachable EV_COLOR
		require
			current_views.count > 1
		local
			h: like repository_colors
		do
			h := repository_colors
			if h = Void then
				create h.make (current_views.count)
				repository_colors := h
			end
			if h.has_key (a_data) then
				Result := h.found_item
			else
				inspect
					h.count
				when 1 then	Result := colors.blue
				when 2 then	Result := colors.red
				when 3 then	Result := colors.green
				when 4 then	Result := colors.magenta
				when 5 then	Result := colors.cyan
				else        Result := colors.black
				end
				h.force (Result, a_data)
			end
		end

	repository_colors: detachable HASH_TABLE [EV_COLOR, REPOSITORY_DATA]

feature {NONE} -- Constants

	unread_filter: REPOSITORY_LOG_READ_STATUS_FILTER
		once
			create Result.make_read (False)
		end

	cst_revision_column: INTEGER = 1
	cst_date_column: INTEGER = 2
	cst_author_column: INTEGER = 3
	cst_log_column: INTEGER = 4


end
