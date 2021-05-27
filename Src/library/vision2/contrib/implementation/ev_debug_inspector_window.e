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

	make_with_widget (w: EV_IDENTIFIABLE)
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
		end

	initialize
		local
			vb: EV_VERTICAL_BOX
			txt: like info_output
			g: like grid
			nb: EV_NOTEBOOK
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
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

			create but.make_with_text_and_action ("Clear", agent drop_widget (Void))
			hb.extend (but)
			hb.disable_item_expand (but)

			create nb
			vb.extend (nb)

			txt := info_output
			nb.extend (txt)
			nb.set_item_text (txt, "Info")

			g := grid
			g.set_background_color (colors.default_background_color)
			nb.extend (g)
			nb.set_item_text (g, "Grid")
			nb.item_tab (g).enable_select

			g.set_column_count_to (3)
			g.column (1).set_title ("Item")
			g.column (2).set_title ("Address")
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

			if is_pnd_supported then
				g.set_item_pebble_function (agent (gi: EV_GRID_ITEM): detachable ANY
						do
							if attached gi.row as r then
								Result := r.data
							end
						end
					)

				g.drop_actions.extend (agent (obj: ANY)
						do
							if attached {EV_IDENTIFIABLE} obj as lw then
								drop_widget (lw)
							else
								drop_widget (Void)
							end
						end
					)
			end

			close_request_actions.extend (agent destroy_and_exit_if_last)
		end

feature -- Access

	observed_window: detachable EV_WINDOW

	info_output: EV_RICH_TEXT

	grid: EV_GRID

	colors: EV_STOCK_COLORS
		once
			create Result
		end

	is_pnd_supported: BOOLEAN
		local
			env: EXECUTION_ENVIRONMENT
		once
			create env
			-- FIXME: remove when PnD is working safely with GTK34
			if not attached env.item ("vision_implementation") as v or else not v.same_string ("gtk34") then
				Result := True
			end
		end

feature -- Events		

	on_double_clicked (a_x, a_y, a_but: INTEGER; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER)
		do
			drop_widget (ev_application.focused_widget)
		end

	use_selection
		local
			win: EV_DEBUG_INSPECTOR_WINDOW
			w: EV_IDENTIFIABLE
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
					if attached {EV_IDENTIFIABLE} ic.item.data as l_id then
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

	drop_widget (w: detachable EV_IDENTIFIABLE)
		do
			info_output.set_text ("")
			show_widget (w)
			show_tree (w)
		end

	show_tree (w: detachable EV_IDENTIFIABLE)
		local
			g: like grid
			r: EV_GRID_ROW
		do
			g := grid
			g.set_row_count_to (0)
			g.insert_new_row (g.row_count + 1)
			r := g.row (g.row_count)
			attach_to_row (w, r, g, True)
			r.set_data (w)
		end

	attach_to_row (w: detachable EV_IDENTIFIABLE; r: EV_GRID_ROW; g: EV_GRID; a_include_parent: BOOLEAN)
		local
			sr,pr: EV_GRID_ROW
			n: INTEGER
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
				r.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Void"))
				r.set_item (2, create {EV_GRID_ITEM})
				r.set_background_color (colors.color_read_only)
			else
				r.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (w.generating_type.name))
				r.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (($w).out))
				r.set_foreground_color (colors.blue)
				if
					a_include_parent and
					attached w.parent as p
				then
					r.insert_subrow (r.subrow_count + 1)
					sr := r.subrow (r.subrow_count)
					pr := sr
					sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Parent ..."))
					sr.set_item (2, create {EV_GRID_ITEM})
					sr.set_background_color (colors.yellow)
					sr.ensure_expandable
					sr.expand_actions.extend_kamikaze (agent (i_r: EV_GRID_ROW; i_w: EV_IDENTIFIABLE; i_g: EV_GRID)
							local
								ssr: EV_GRID_ROW
							do
								i_r.insert_subrow (i_r.subrow_count + 1)
								ssr := i_r.subrow (i_r.subrow_count)
								ssr.set_data (i_w)
								attach_to_row (i_w, ssr, i_g, True)
								ssr.expand
							end(sr, p, g)
						)
				end
				if
					attached {EV_CONTAINER} w as l_container
				then
					r.insert_subrow (r.subrow_count + 1)
					sr := r.subrow (r.subrow_count)
					sr.set_background_color (colors.cyan)
					n := l_container.count
					if n = 0 then
						sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("No item ..."))
						sr.set_background_color (colors.grey)
					elseif n = 1 then
						sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("One item ..."))
					else
						sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (n.out + " items ..."))
					end

					sr.set_item (2, create {EV_GRID_ITEM})
					if n > 0 then
						sr.ensure_expandable
						sr.collapse_actions.extend (agent (i_r: EV_GRID_ROW; i_g: EV_GRID)
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
								end(sr, g)
							)
						sr.expand_actions.extend (agent (i_r: EV_GRID_ROW; i_w: EV_CONTAINER; i_g: EV_GRID)
								local
									fr, ssr: EV_GRID_ROW
								do
									across
										i_w as ic
									loop
										i_r.insert_subrow (i_r.subrow_count + 1)
										ssr := i_r.subrow (i_r.subrow_count)
										if fr = Void then
											fr := ssr
										end
										attach_to_row (ic.item, ssr, i_g, False)
									end
									if fr /= Void then
										fr.enable_select
									end
								end(sr, l_container, g)
							)
						if pr = Void and n = 1 then
							sr.enable_select
							sr.expand
						end
					end
				end
				if pr /= Void then
					pr.enable_select
				end
			end
			g.column (1).resize_to_content
		end

	show_text (t: READABLE_STRING_GENERAL)
		do
			info_output.append_text (offset)
			info_output.append_text (t)
			info_output.append_text ("%N")
		end

	show_widget (w: detachable EV_IDENTIFIABLE)
		do
			if w /= Void then
				info_output.append_text (offset)
				info_output.append_text (w.generating_type.name)
				info_output.append_text ("%N")
				info_output.append_text (w.out)
				info_output.append_text ("%N")

				if
					attached w.parent as p and then
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
