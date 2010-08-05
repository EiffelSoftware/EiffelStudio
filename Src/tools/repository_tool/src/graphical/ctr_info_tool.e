note
	description: "Summary description for {CTR_LOGS_TOOL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_INFO_TOOL

inherit
	CTR_TOOL

	EV_SHARED_APPLICATION

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

			g.enable_single_row_selection
			g.set_column_count_to (2)
			g.disable_row_height_fixed
			g.enable_tree
			g.hide_tree_node_connectors
			g.hide_header
			c.set_short_title ("Info ...")
			c.set_long_title ("Info")
			create mtb.make
			create tbbut.make
			tbbut.set_pixmap (icons.new_diff_small_toolbar_button_icon)
			tbbut.select_actions.extend (agent show_info_diff)
			mtb.extend (tbbut)

			create tbbut.make
			tbbut.set_pixmap (icons.new_custom_text_small_toolbar_button_icon ("Open Data Folder"))
			tbbut.select_actions.extend (agent open_data_folder)
			mtb.extend (tbbut)

			mtb.compute_minimum_size
			c.set_mini_toolbar (mtb)
		end

feature -- Access

	current_log: detachable REPOSITORY_LOG

	current_repository: detachable REPOSITORY_DATA

	grid: EV_GRID

feature -- Element change

	update
		local
			g: like grid
			l_row, l_subrow: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			grtxt: EV_GRID_RICH_LABEL_ITEM
--			gcb: EV_GRID_CHECKABLE_LABEL_ITEM
--			gtxt: EV_GRID_TEXT_ITEM
			md: like smart_log_message
			repo: REPOSITORY_DATA
		do
			g := grid
			g.wipe_out
			if attached {REPOSITORY_SVN_LOG} current_log as rsvnlog then
				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
				l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Info"))
				create grtxt--.make_with_text ("revision " + rsvnlog.id + " by " + rsvnlog.author + " (" + rsvnlog.date + ")")
				grtxt.add_formatted_text ("revision ", Void, Void)
				grtxt.add_formatted_text (rsvnlog.id, info_highlight_fgcolor, font_bold)
				grtxt.add_formatted_text (" by ", Void, Void)
				grtxt.add_formatted_text (rsvnlog.author, info_highlight_fgcolor, font_bold)
				grtxt.add_formatted_text (" (" + rsvnlog.date + ")", Void, font_comment)


				l_row.set_item (2, grtxt)

				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
				create glab.make_with_text ("Message")
				glab.align_text_top

				l_row.set_item (1, glab)
				repo := rsvnlog.parent

				md  := smart_log_message (rsvnlog, repo.tokens_keys)
				create glab.make_with_text (md.message)
				glab.set_foreground_color (info_highlight_fgcolor)
				glab.set_font (message_font)
				glab.align_text_top
				glab.set_top_border (3)
				glab.set_bottom_border (5)
--				glab.pointer_double_press_actions.extend (agent )
				l_row.set_item (2, glab)
				if attached glab.font as ft then
					l_row.set_height (ft.string_size (glab.text).height + glab.bottom_border + glab.top_border)
				end

--				if
--					repo.has_issue_url and then
--					attached md.matches.item ("bug") as l_issues
--				then
--					from
--						l_issues.start
--					until
--						l_issues.after
--					loop
--						if attached repo.issue_url (l_issues.item) as l_url then
--							g.insert_new_row_parented (g.row_count + 1, l_row)
--							l_subrow := g.row (g.row_count)
--							l_subrow.set_item (1, create {EV_GRID_ITEM})
--							create glab.make_with_text ("bug #" + l_issues.item + ": " + l_url)
--							glab.set_data (l_url)
--							glab.pointer_double_press_actions.force_extend (agent open_url (l_url))
--							l_subrow.set_item (2, glab)
--						end
--						l_issues.forth
--					end
--					if l_row.is_expandable then
--						l_row.expand
--					end
--				end

				if attached repo.tokens as l_tokens and then l_tokens.count > 0 then
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
									g.insert_new_row_parented (g.row_count + 1, l_row)
									l_subrow := g.row (g.row_count)
									l_subrow.set_item (1, create {EV_GRID_ITEM})
									create glab.make_with_text (tok.item.key + " #" + lst.item + ": " + l_url)
									glab.set_data (l_url)
									glab.pointer_double_press_actions.force_extend (agent open_url (l_url))
									l_subrow.set_item (2, glab)
								end
								lst.forth
							end
							if l_row.is_expandable then
								l_row.expand
							end
						end
					end
				end

--				if
----					attached rsvnlog.parent as repo and then
--					repo.has_test_url and then
--					attached md.matches.item ("test") as l_tests
--				then
--					from
--						l_tests.start
--					until
--						l_tests.after
--					loop
--						if attached repo.test_url (l_tests.item) as l_url then
--							g.insert_new_row_parented (g.row_count + 1, l_row)
--							l_subrow := g.row (g.row_count)
--							l_subrow.set_item (1, create {EV_GRID_ITEM})
--							create glab.make_with_text ("test #" + l_tests.item + ": " + l_url)
--							glab.set_data (l_url)
--							glab.pointer_double_press_actions.force_extend (agent open_url (l_url))
--							l_subrow.set_item (2, glab)
--						end
--						l_tests.forth
--					end
--					if l_row.is_expandable then
--						l_row.expand
--					end
--				end
--				if
----					attached rsvnlog.parent as repo and then
--					repo.has_test_url and then
--					attached md.matches.item ("incr") as l_tests
--				then
--					from
--						l_tests.start
--					until
--						l_tests.after
--					loop
--						if attached repo.test_url (l_tests.item) as l_url then
--							g.insert_new_row_parented (g.row_count + 1, l_row)
--							l_subrow := g.row (g.row_count)
--							l_subrow.set_item (1, create {EV_GRID_ITEM})
--							create glab.make_with_text ("incr #" + l_tests.item + ": " + l_url)
--							glab.set_data (l_url)
--							glab.pointer_double_press_actions.force_extend (agent open_url (l_url))
--							l_subrow.set_item (2, glab)
--						end
--						l_tests.forth
--					end
--					if l_row.is_expandable then
--						l_row.expand
--					end
--				end

				if attached rsvnlog.svn_revision.paths as l_changes and then l_changes.count > 0 then
					g.insert_new_row (g.row_count + 1)
					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					if l_changes.count = 1 then
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("1 node changed"))
					else
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (l_changes.count.out + " nodes changed"))
					end
					l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (rsvnlog.svn_revision.common_parent_path + " ..."))
					l_row.expand_actions.extend (agent do changes_expanded := True end)
					l_row.collapse_actions.extend (agent do changes_expanded := False end)

					across
						l_changes as l_paths
					loop
						g.insert_new_row_parented (g.row_count + 1, l_row)
						l_subrow := g.row (g.row_count)
						l_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (l_paths.item.action))
						l_subrow.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_paths.item.path))
					end
					if l_row.is_expandable and changes_expanded then
						l_row.expand
					end
				end


				g.insert_new_row (g.row_count + 1)
				g.insert_new_row (g.row_count + 1)
				l_row := g.row (g.row_count)
				l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Diff"))

				if rsvnlog.has_diff then
					create glab.make_with_text ("Double click to SHOW diff")
					glab.pointer_double_press_actions.force_extend (agent popup_diff (rsvnlog))
					l_row.set_item (2, glab)
				else
					create glab.make_with_text ("Double click to GET diff")
					glab.pointer_double_press_actions.force_extend (agent show_info_diff)
					l_row.set_item (2, glab)
				end

--				if rsvnlog.parent.review_enabled then
--					g.insert_new_row (g.row_count + 1)
--					l_row := g.row (g.row_count)
--					l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Review"))
--					l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text ("???"))

--					g.insert_new_row_parented (g.row_count + 1, l_row)
--					l_subrow := g.row (g.row_count)
--					l_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Accept"))
--					create gcb.make_with_text ("approve commit")
--					l_subrow.set_item (2, gcb)

--					g.insert_new_row_parented (g.row_count + 1, l_row)
--					l_subrow := g.row (g.row_count)
--					l_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Deny"))
--					create gcb.make_with_text ("disapprove commit")
--					l_subrow.set_item (2, gcb)


--					g.insert_new_row_parented (g.row_count + 1, l_row)
--					l_subrow := g.row (g.row_count)
--					l_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Note"))
--					create gtxt.make_with_text ("")
--					gtxt.enable_multiline_string
--					gtxt.enable_text_editing
--					gtxt.pointer_double_press_actions.force_extend (agent gtxt.activate)
--					l_subrow.set_item (2, gtxt)

--					g.insert_new_row_parented (g.row_count + 1, l_row)
--					l_subrow := g.row (g.row_count)
--					l_subrow.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Reset"))
--					l_subrow.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Submit"))
--				end

				g.column (1).resize_to_content
				g.column (1).set_width (g.column (1).width + 5)
				g.column (2).resize_to_content
			elseif attached {REPOSITORY_SVN_DATA} current_repository as rsvnrepo then
				if attached rsvnrepo.info as rinfo then
					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Revision"))
					l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (rinfo.revision.out))

					g.insert_new_row (g.row_count + 1)
					l_row := g.row (g.row_count)
					l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Localisation"))
					l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (rinfo.localisation))

					if attached rinfo.last_changed_rev as l_rev then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last rev"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_rev.out))
					end
					if attached rinfo.last_changed_author as l_author then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last author"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_author))
					end
					if attached rinfo.last_changed_date as l_date then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Last Date"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_date))
					end

					if attached rinfo.repository_root as l_root then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Repo Root"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_root))
					end

					if attached rinfo.repository_uuid as l_uuid then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Repo UUID"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_uuid))
					end

					if attached rinfo.url as l_url then
						g.insert_new_row (g.row_count + 1)
						l_row := g.row (g.row_count)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Url"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (l_url))
					end

					g.column (1).resize_to_content
					g.column (1).set_width (g.column (1).width + 5)
					g.column (2).resize_to_content
				end
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

	smart_log_message (a_log: REPOSITORY_LOG; a_patterns: detachable ARRAY [detachable STRING]): TUPLE [message: STRING; matches: HASH_TABLE [detachable LIST [STRING], STRING]]
		local
			mesg: STRING
			lst: detachable LIST [STRING]
			l_matches: HASH_TABLE [detachable LIST [STRING], STRING]
			t: like smart_pattern_computation
			i, n: INTEGER
		do
			if a_patterns /= Void then
				create l_matches.make (a_patterns.count)
			else
				create l_matches.make (0)
			end
			Result := [a_log.message, l_matches] --| message, matches |--
			if a_patterns /= Void and then a_patterns.count > 0 then
				from
					i := a_patterns.lower
					n := a_patterns.upper
					mesg := a_log.message
				until
					i > n
				loop
					if attached a_patterns[i] as k then
						t := smart_pattern_computation (mesg, k)
						mesg := t.mesg
						lst := t.lst
						l_matches.force (lst, k)
					end
					i := i + 1
				end
				Result.message := mesg
			end
		end

feature {NONE} -- Implementation

	smart_pattern_computation (m: STRING; k: STRING): TUPLE [mesg: STRING; lst: detachable LIST [STRING]]
		require
			m_attached: m /= Void
			k_not_empty: k /= Void and then k.count > 0
		local
			klen, n,d,e,i,p: INTEGER
			s: STRING
			mesg: STRING
			lst: detachable ARRAYED_LIST [STRING]
		do
			from
				n := m.count
				klen := k.count
				create mesg.make (n)
				create lst.make (1)
				i := 1
				p := 1
			until
				p > n
			loop
				i := m.substring_index (k, p)
				if i > 0 then
						--| skip space					
					from
						d := i + klen
					until
						d > n or else (m[d] = '#' or not m[d].is_space)
					loop
						d := d + 1
					end
					if m[d] = '#' then
						--| Found k + " #"						

						--| skip space
						from
							e := d + 1
						until
							e > n or else not m[e].is_space
						loop
							e := e + 1
						end
						--| get word
						from
							create s.make_empty
						until
							e > n or else not m[e].is_alpha_numeric
						loop
							s.extend (m[e])
							e := e + 1
						end
						if not s.is_empty then
							mesg.append_string (m.substring (p, e))
							lst.force (s)
							p := e + 1
						else
							mesg.append_string (m.substring (p, d))
							p := d + 1
						end
					else
						mesg.append_string (m.substring (p, i + klen))
						p := i + 4
					end
				else
					mesg.append_string (m.substring (p, n))
					p := n + 1
				end
			end
			if lst.count = 0 then
				lst := Void
			end
			Result := [mesg, lst]
		end

	open_url (a_url: STRING)
		local
			exec: EXECUTION_ENVIRONMENT
			s: STRING
		do
			s := a_url
			if s /= Void then
				create exec
				if attached exec.get ("COMSPEC") as l_comspec then
					s := l_comspec + " /C start " + s
					exec.launch (s)
				end
			end
		end

	open_data_folder
		local
			exec: EXECUTION_ENVIRONMENT
			s: detachable STRING
		do
			if attached current_repository as r then
				s := r.data_folder_name
			elseif attached current_log as l_log then
				s := l_log.parent.data_folder_name
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

	popup_diff (a_log: REPOSITORY_LOG)
		do
			if attached ctr_window as w then
				w.popup_diff (a_log)
			end
		end

	show_info_diff
		do
			if attached ctr_window as w then
				if attached current_log as l_log then
					w.show_log_diff (l_log)
				end
			end
		end

	changes_expanded: BOOLEAN


end
