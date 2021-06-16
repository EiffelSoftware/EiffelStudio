note
	description: "EiffelVision2 inspector window."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEBUG_INSPECTOR_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy
		end

create
	make,
	make_with_widget

feature {NONE} -- Initialization

	make (win: EV_WINDOW)
		do
			observed_window := win
			make_with_title ("EV Inspector")
			set_size (400, 300)
		end

	make_with_widget (w: EV_ANY)
		do
			make_with_title ("EV Inspector")
			drop_widget (w)
			set_size (400, 300)
		end

feature {NONE} -- Initialization		

	create_interface_objects
		do
			Precursor
			create offset.make_empty
			create info_output
			create grid
			create details_checkbox
		end

	initialize
		local
			vb: EV_VERTICAL_BOX
			txt: like info_output
			g: like grid
			nb: EV_NOTEBOOK
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
			cbut: EV_CHECK_BUTTON
		do
			Precursor
			create vb
			extend (vb)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})

			create but.make_with_text_and_action ("Open selection", agent use_selection)
			hb.extend (but)
			hb.disable_item_expand (but)
			but.drop_actions.extend (agent (obj: ANY)
					do
						if attached {EV_ANY} obj as lw then
							drop_widget (lw)
						else
							drop_widget (Void)
						end
					end
				)

			create but.make_with_text_and_action ("Clear", agent drop_widget (Void))
			hb.extend (but)
			hb.disable_item_expand (but)

			cbut := details_checkbox
			cbut.set_text ("Details?")
			cbut.select_actions.extend (agent update)
			hb.extend (cbut)
			hb.disable_item_expand (cbut)

			create nb
			vb.extend (nb)

			txt := info_output
			nb.extend (txt)
			nb.set_item_text (txt, "Info")

			g := grid
			g.set_background_color (colors.default_background_color)
			g.enable_column_separators
			g.enable_row_separators
			g.set_separator_color (colors.gray)
			nb.extend (g)
			nb.set_item_text (g, "Grid")
			nb.item_tab (g).enable_select

			g.set_column_count_to (5)
			g.column (1).set_title ("Item")
			g.column (2).set_title ("Childs")
			g.column (3).set_title ("Address")
			g.column (4).set_title ("Implementation")
			g.column (5).set_title ("Identifier?")
			if has_details then
				g.set_column_count_to (6)
				g.column (6).set_title ("Details")
			end
			g.enable_single_row_selection
			g.enable_tree
			g.key_press_actions.extend (agent (k: EV_KEY; ig: EV_GRID)
					do
						inspect k.code
						when {EV_KEY_CONSTANTS}.key_left then
							across
								ig.selected_rows as ic
							loop
								ic.item.collapse
							end
						when {EV_KEY_CONSTANTS}.key_right then
							across
								ig.selected_rows as ic
							loop
								if ic.item.is_expanded and then ic.item.subrow_count > 0 then
									ic.item.subrow (1).enable_select
								elseif ic.item.is_expandable then
									ic.item.expand
								end
							end
						else

						end
					end(?, g)
				)

			g.row_select_actions.extend (agent on_row_selected)
			g.row_deselect_actions.extend (agent on_row_deselected)

			g.item_select_actions.extend (agent (gi: EV_GRID_ITEM)
				do
					if
						not gi.is_destroyed and then
						attached gi.row as r
					then
						on_row_selected (r)
					end
				end)

			g.item_deselect_actions.extend (agent (gi: EV_GRID_ITEM)
				do
					if
						not gi.is_destroyed and then
						attached gi.row as r
					then
						on_row_deselected (r)
					end
				end)

			g.pointer_double_press_item_actions.extend (agent (ix: INTEGER; iy: INTEGER; ibut: INTEGER; i: detachable EV_GRID_ITEM)
					do
						if ibut = {EV_POINTER_CONSTANTS}.left then
							on_item_left_double_pressed (i)
						end
					end
				)

			if is_pnd_supported then
				g.set_item_pebble_function (agent (gi: EV_GRID_ITEM): detachable ANY
						do
							if attached gi.row as r then
								Result := r.data
							end
						end
					)

				g.set_item_accept_cursor_function (agent (gi: EV_GRID_ITEM): EV_POINTER_STYLE
						do
							if attached {EV_GRID_LABEL_ITEM} gi and then gi.column.index = 1 then
								Result := pixmaps.crosshair_cursor
							else
								Result := pixmaps.standard_cursor
							end
						end)
				g.set_item_deny_cursor_function (agent (gi: EV_GRID_ITEM): EV_POINTER_STYLE
						do
							Result := pixmaps.no_cursor
						end)

				g.drop_actions.extend (agent (obj: ANY)
						do
							if attached {EV_ANY} obj as lw then
								drop_widget (lw)
							else
								drop_widget (Void)
							end
						end
					)
			end

			close_request_actions.extend (agent destroy_and_exit_if_last)
		end

	on_row_selected (r: EV_GRID_ROW)
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := r.count
			until
				i > n
			loop
				if attached {EV_GRID_LABEL_ITEM} r.item (i) as glab then
					glab.set_font (selection_font)
				end
				i := i + 1
			end
		end

	on_row_deselected (r: EV_GRID_ROW)
		local
			i,n: INTEGER
		do
			from
				i := 1
				n := r.count
			until
				i > n
			loop
				if attached {EV_GRID_LABEL_ITEM} r.item (i) as glab then
					glab.set_font (normal_font)
				end
				i := i + 1
			end
		end

	on_item_left_double_pressed (a_item: detachable EV_GRID_ITEM)
		local
			bb: EV_VERTICAL_BOX
			bg: EV_COLOR
			t: EV_TIMEOUT
			done: BOOLEAN
			e: BOOLEAN
			c: CURSOR
		do
			if a_item /= Void and then attached a_item.row as l_row then
				if attached {EV_WIDGET} l_row.data as w then
					if attached {EV_BOX} w.parent as p_box then
						create bb
						bb.set_background_color (colors.magenta)
						bb.set_border_width (1)
						bb.set_padding_width (1)
						from
							c := p_box.cursor
							p_box.start
						until
							p_box.item = w
						loop
							p_box.forth
						end
						if p_box.item = w then
							e := p_box.is_item_expanded (w)
							p_box.replace (bb)
							if e then
								p_box.enable_item_expand (bb)
							else
								p_box.disable_item_expand (bb)
							end
							bb.extend (w)
							done := True
							create t.make_with_interval (500)
							t.actions.extend (agent (i_p: EV_BOX; i_b: EV_VERTICAL_BOX; i_w: EV_WIDGET; i_expand: BOOLEAN; i_t: EV_TIMEOUT)
									local
										cur: CURSOR
									do
										i_t.destroy
										cur := i_p.cursor
										from
											i_p.start
										until
											i_p.item = i_b
										loop
											i_p.forth
										end
										if i_p.item = i_b then
											i_p.replace (i_w)
											if i_expand then
												i_p.enable_item_expand (i_w)
											else
												i_p.disable_item_expand (i_w)
											end
										end
										i_p.go_to (cur)
									end (p_box, bb, w, e, t)
								)
						end
						p_box.go_to (c)
					elseif attached {EV_CELL} w.parent as p_cell then
						create bb
						bb.set_background_color (colors.magenta)
						bb.set_border_width (1)
						bb.set_padding_width (1)
						p_cell.replace (bb)
						bb.extend (w)
						done := True
						create t.make_with_interval (500)
						t.actions.extend (agent (i_p: EV_CELL; i_w: EV_WIDGET; i_t: EV_TIMEOUT)
								do
									i_t.destroy
--									i_w.rep
									i_p.replace (i_w)
								end (p_cell, w, t)
							)
					end
					if not done then
						bg := w.background_color
						w.set_background_color (colors.red)
						if bg /= Void then
							create t.make_with_interval (500)
							t.actions.extend (agent (iw: EV_COLORIZABLE; i_bg: detachable EV_COLOR; i_t: EV_TIMEOUT)
									do
										i_t.destroy
										if i_bg /= Void then
											iw.set_background_color (i_bg)
										end
									end (w, bg, t)
								)
						end
					end
				end
			end
		end

feature -- Access

	dropped_widget: detachable EV_ANY

	has_details: BOOLEAN
		do
			Result := details_checkbox.is_selected
		end

	observed_window: detachable EV_WINDOW

	info_output: EV_RICH_TEXT

	grid: EV_GRID

	details_checkbox: EV_CHECK_BUTTON

	colors: EV_STOCK_COLORS
		once
			create Result
		end

	normal_font: EV_FONT
		once
			create Result
--			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		end

	selection_font: EV_FONT
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	pixmaps: EV_STOCK_PIXMAPS
		once
			create Result
		end

	is_pnd_supported: BOOLEAN
		local
			env: EXECUTION_ENVIRONMENT
		once
			create env
			Result := True
		end

feature -- Events		

	on_double_clicked (a_x, a_y, a_but: INTEGER; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER)
		do
			drop_widget (ev_application.focused_widget)
		end

	update
		do
			drop_widget (dropped_widget)
		end

	use_selection
		local
			win: EV_DEBUG_INSPECTOR_WINDOW
			w: EV_ANY
		do
			if
				attached grid as g and then
				attached g.selected_rows as l_rows
			then
				across
					l_rows as ic
				until
					w /= Void
				loop
					if attached {EV_ANY} ic.item.data as l_id then
						w := l_id
					end
				end
				if w /= Void then
					create win.make_with_widget (w)
					if attached observed_window as obswin then
						win.show_relative_to_window (obswin)
					else
						win.show_relative_to_window (Current)
					end
				end
			end
		end

	drop_widget (w: detachable EV_ANY)
		do
			dropped_widget := w
			info_output.set_text ("")
			show_widget (w)
			show_tree (w)
		end

	fill_parents_chain (a_id: EV_ANY; a_chain: ARRAYED_STACK [EV_WIDGET])
		do
			if
				attached {EV_WIDGET} a_id as w and then
				attached w.parent as l_parent
			then
				a_chain.extend (l_parent)
				fill_parents_chain (l_parent, a_chain)
			end
		end

	show_tree (w: detachable EV_ANY)
		local
			g: like grid
			r: EV_GRID_ROW
			l_parents: ARRAYED_STACK [EV_WIDGET]
		do
			g := grid
			g.set_row_count_to (0)
			g.insert_new_row (g.row_count + 1)
			r := g.row (g.row_count)
			if w /= Void then
				create l_parents.make (5)
				fill_parents_chain (w, l_parents)
				if l_parents.is_empty then
					attach_to_row (w, r, g, True)
					r.set_data (w)
				elseif attached l_parents.item as wi then
					attach_to_row (wi, r, g, False)
					r.set_data (wi)
					l_parents.remove
					expand_parents_until (r, l_parents, w, g)
				end
			else
				attach_to_row (w, r, g, True)
				r.set_data (w)
			end
		end

	expand_parents_until (a_row: EV_GRID_ROW; a_parents: ARRAYED_STACK [EV_WIDGET]; a_widget: EV_ANY; a_grid: EV_GRID)
		require
			not a_parents.is_empty
		local
			l_items_row, sr: EV_GRID_ROW
			nxt: EV_WIDGET
			i,n: INTEGER
		do
			if attached a_row.data as l_data then
				print ("expand_parents_until (" + l_data.generator + ", a_parent.count=" + a_parents.count.out + " ...%N")
			else
				print ("expand_parents_until (No row data !!!, a_parent.count=" + a_parents.count.out + " ...%N")
			end
			if a_row.is_expandable then
				if not a_row.is_expanded then
					a_row.expand
				end
				if attached {ITERABLE [EV_WIDGET]} a_row.data as l_iterable then
					l_items_row := a_row
					if l_items_row /= Void then
						if l_items_row.is_expandable and then not l_items_row.is_expanded then
							expand_items_row (l_items_row, l_iterable, a_grid, False)
							if l_items_row.is_expandable then
								l_items_row.expand
							end
						end
						l_items_row.enable_select
						sr := Void
						nxt := Void
						if not a_parents.is_empty then
							nxt := a_parents.item
							a_parents.remove
						end
						from
							i := 1
							n := l_items_row.subrow_count
						until
							sr /= Void or i > n
						loop
							sr := l_items_row.subrow (i)
							if sr.data = a_widget then
									-- Found final widget
							elseif nxt /= Void then
								if sr.data = nxt then
										-- Found next widget in parents chain
								else
									sr := Void
								end
							else
									-- Skip
								sr := Void
							end
							i := i + 1
						end
						if sr /= Void then
							if sr.data /= a_widget then
								check a_parents.is_empty end
--								ev_application.add_idle_action_kamikaze (agent expand_parents_until (sr, a_parents, a_widget, a_grid))
								expand_parents_until (sr, a_parents, a_widget, a_grid)
							else
--								if sr.is_expandable and then not sr.is_expanded then
--									sr.expand
--								end
								sr.ensure_visible
								sr.enable_select
--								ev_application.add_idle_action_kamikaze (agent sr.ensure_visible)
--								ev_application.add_idle_action_kamikaze (agent sr.enable_select)
							end
						end
					end
				end
			end
		end

	attach_to_row (w: detachable EV_ANY; r: EV_GRID_ROW; g: EV_GRID; a_auto_expand: BOOLEAN)
		local
--			pr,
--			sr: EV_GRID_ROW
			n: INTEGER
			lab: EV_GRID_LABEL_ITEM
			s: STRING_32
		do
			r.set_data (w)
			r.set_background_color (colors.default_background_color)
			from
			until
				r.subrow_count_recursive = 0
			loop
				n := r.subrow_count_recursive
				g.remove_row (r.index + n)
			end
			if w = Void then
				r.set_item (1, new_label ("Void"))
				r.set_item (2, create {EV_GRID_ITEM})
				r.set_item (3, create {EV_GRID_ITEM})
				r.set_background_color (colors.color_read_only)
			else
				lab := new_label (w.generating_type.name_32)
				r.set_item (1, lab)
				r.set_item (2, new_label  ("..."))
				r.set_item (3, new_label  (($w).out))
				if attached w.implementation as l_imp then
					r.set_item (4, new_label  (l_imp.generating_type.name_32))
				else
					r.set_item (4, create {EV_GRID_ITEM})
				end
				if attached {EV_IDENTIFIABLE} w as l_id and then l_id.has_identifier_name_set then
					r.set_item (5, new_label  (l_id.identifier_name))
				else
					r.set_item (5, create {EV_GRID_ITEM})
				end
				if has_details then
					r.set_item (6, create {EV_GRID_ITEM})
					if attached {EV_POSITIONED} w as l_pos then
						create s.make_empty
						s.append ("(" + l_pos.x_position.out)
						s.append ("," + l_pos.y_position.out)
						s.append (")")

						s.append (" @(" + l_pos.screen_x.out)
						s.append ("," + l_pos.screen_y.out)
						s.append (")")
						
						s.append (" " + l_pos.width.out)
						s.append (" x " + l_pos.height.out)
						s.append (" (min: ")
						s.append (l_pos.minimum_width.out)
						s.append (" x " + l_pos.minimum_height.out)
						s.append (")")
						r.set_item (6, new_label (s))
					end
				end
				lab.set_foreground_color (colors.blue)
				if
					attached {ITERABLE [EV_WIDGET]} w as l_iterable
				then
					n := 0
					across
						l_iterable as ic
					loop
						n := n + 1
					end
					if n = 0 then
						lab := new_label (n.out)
						r.set_item (2, lab)
						lab.set_foreground_color (colors.grey)
					else
						r.set_item (2, new_label  (n.out))
					end
					if n > 0 then
						r.ensure_expandable
						r.collapse_actions.extend (agent (i_r: EV_GRID_ROW; i_g: EV_GRID)
								local
									nb: INTEGER
								do
									from
										nb := i_r.subrow_count_recursive
									until
										nb = 0
									loop
										i_g.remove_row (i_r.index + nb)
										nb := i_r.subrow_count_recursive
									end
									i_g.column (1).resize_to_content
									i_r.enable_select
									i_r.ensure_expandable
								end(r, g)
							)
						r.expand_actions.extend (agent expand_items_row (r, l_iterable, g, a_auto_expand))
					end
				else
					r.set_item (2, create {EV_GRID_ITEM})
				end
			end
			g.column (1).resize_to_content
			g.column (2).resize_to_content
			g.column (4).resize_to_content
			g.column (5).resize_to_content
			if has_details then
				g.column (6).resize_to_content
			end
		end

	expand_items_row (a_row: EV_GRID_ROW; a_iterable: ITERABLE [EV_WIDGET]; a_grid: EV_GRID; l_auto_select: BOOLEAN)
		local
			fr,
			ssr: EV_GRID_ROW
		do
			a_row.expand_actions.block
			if a_row.subrow_count = 0 then
				across
					a_iterable as ic
				loop
					a_row.insert_subrow (a_row.subrow_count + 1)
					ssr := a_row.subrow (a_row.subrow_count)
					if fr = Void then
						fr := ssr
					end
					attach_to_row (ic.item, ssr, a_grid, l_auto_select)
				end
			end
			if l_auto_select and fr /= Void then
				fr.enable_select
			end
			a_row.expand_actions.resume
		end

	show_text (t: READABLE_STRING_GENERAL)
		do
			info_output.append_text (offset)
			info_output.append_text (t)
			info_output.append_text ("%N")
		end

	show_widget (w: detachable EV_ANY)
		do
			if w /= Void then
				info_output.append_text (offset)
				info_output.append_text (w.generating_type.name)
				info_output.append_text ("%N")
				info_output.append_text (w.out)
				info_output.append_text ("%N")

				if
					attached parent_of (w) as p and then
					p /= w
				then
					info_output.append_text ("Parents...%N")
					indent
					show_widget (p)
					exdent
				end
			else
				info_output.append_text (offset)
				info_output.append_text ("None")
				info_output.append_text ("%N")
			end
		end

	parent_of (a_any: detachable EV_ANY): detachable EV_ANY
		do
			if a_any = Void then
			elseif attached {EV_IDENTIFIABLE} a_any as l_id then
				Result := l_id.parent
			elseif attached {EV_WIDGET} a_any as w then
				Result := w.parent
			elseif attached {EV_CONTAINABLE} a_any as l_c then
				Result := l_c.parent
			end
		end

	reset_indent
		do
			offset.wipe_out
		end

	indent
		do
			offset.append (offset_step)
		end

	exdent
		do
			offset.remove_tail (offset_step.count)
		end

	offset: STRING_32

	offset_step: STRING_32 = "  "

feature -- Factory

	new_label (s: READABLE_STRING_GENERAL): EV_GRID_LABEL_ITEM
		do
			create Result.make_with_text (s)
			Result.set_font (normal_font)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
