note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_STRUCTURE_EDITOR_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize
		end

feature {NONE} -- Initialize

	initialize
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			but, show_but, rescan_but: EV_BUTTON
			nbk: EV_NOTEBOOK
			b_grid, b_text: EV_VERTICAL_BOX
			grill_cb: EV_CHECK_BUTTON
		do
			Precursor
			create vb
			vb.set_padding_width (0)
			vb.set_border_width (0)
			extend (vb)

			create hb
			hb.set_padding_width (2)
			hb.set_border_width (2)
			vb.extend (hb); vb.disable_item_expand (hb)

			create b_grid
			create b_text

			create nbk
			vb.extend (nbk)
			nbk.set_tab_position ({EV_NOTEBOOK}.tab_bottom)
			nbk.extend (b_grid)
			nbk.extend (b_text)
			nbk.item_tab (b_grid).set_text ("Structure")
			nbk.item_tab (b_text).set_text ("Code")

			create but.make_with_text ("Show code")
			hb.extend (but); hb.disable_item_expand (but)
			show_but := but

			create but.make_with_text ("Clean code")
			hb.extend (but); hb.disable_item_expand (but)
			but.select_actions.extend (agent
					do
						clean_text
					end)

			create grill_cb.make_with_text ("grid?")
			hb.extend (grill_cb); hb.disable_item_expand (grill_cb)
			grill_cb.select_actions.extend (agent (a_cb: EV_CHECK_BUTTON)
					do
						if attached grid as g then
							if a_cb.is_selected then
								g.enable_row_separators
								g.enable_column_separators
							else
								g.disable_row_separators
								g.disable_column_separators
							end
						end
					end(grill_cb))

			hb.extend (create {EV_CELL})

			create but.make_with_text ("Reset")
			hb.extend (but); hb.disable_item_expand (but)
			rescan_but := but
			create but.make_with_text ("Save")
			but.select_actions.extend (agent
					do
						save_text
					end)
			hb.extend (but); hb.disable_item_expand (but)
			create grid
			initialize_grid
			grid.file_drop_actions.extend (agent files_dropped)
			b_grid.extend (grid)

			create text
			b_text.extend (text)

			rescan_but.select_actions.extend (agent (atab: EV_NOTEBOOK_TAB)
					do
						if attached filename as f then
							scan_file (f)
							atab.enable_select
						end
					end(nbk.item_tab (b_grid)))

			show_but.select_actions.extend (agent (atab: EV_NOTEBOOK_TAB)
					do
						show_text (class_text)
						atab.enable_select
					end(nbk.item_tab (b_text)))

			close_request_actions.extend (agent destroy_and_exit_if_last)
			grill_cb.enable_select
			set_title (default_title)
			set_icon_pixmap (pixmap_logo)
			set_size (600, 700)
		end

	initialize_grid
		local
			g: like grid
		do
			g := grid
			g.set_column_count_to (4)
			g.column (cst_name).set_title ("Name")
			g.column (cst_signature).set_title ("Signature/Export")
			g.column (cst_type).set_title ("Type")
			g.hide_column (cst_positions)

			g.enable_tree
			g.disable_row_height_fixed
			g.set_separator_color (create {EV_COLOR}.make_with_8_bit_rgb (190,190,190))
			g.hide_tree_node_connectors
			g.enable_column_separators
			g.enable_row_separators

			g.enable_single_row_selection
			g.enable_selection_key_handling

			g.resize_actions.force_extend (agent resize_columns)

			g.key_press_actions.extend (agent (a_key: EV_KEY)
					local
						l_row: like selected_row
						i: INTEGER
					do
						l_row := selected_row
						if l_row /= Void and then l_row.parent /= Void and ev_application.ctrl_pressed then
							inspect a_key.code
							when {EV_KEY_CONSTANTS}.key_c then
								copied_row := l_row
							when {EV_KEY_CONSTANTS}.key_v then
								if copied_row /= Void then
									dropped_on (l_row, copied_row)
									copied_row := Void
								end
							when {EV_KEY_CONSTANTS}.key_left then
								from
									i := 1
								until
									i > grid.row_count
								loop
									if attached {EV_GRID_ROW} grid.row (i) as r and then r.parent_row = Void and then
										r.is_expanded
									then
										r.collapse
									end
									i := i + 1
								end
							when {EV_KEY_CONSTANTS}.key_right then
								from
									i := 1
								until
									i > grid.row_count
								loop
									if attached {EV_GRID_ROW} grid.row (i) as r2 and then r2.parent_row = Void and then
										r2.is_expandable and then not r2.is_expanded
									then
										r2.expand
									end
									i := i + 1
								end
							when {EV_KEY_CONSTANTS}.key_numpad_subtract then
								if l_row.parent_row = Void then
									remove_feature_clause (l_row)
								end
							when {EV_KEY_CONSTANTS}.key_numpad_add then
								if l_row.parent_row = Void then
									insert_feature_clause (l_row)
								end
							else
							end
						end
					end)

			g.row_deselect_actions.extend (agent (a_row: EV_GRID_ROW)
					do
						selected_row := Void
					end)

			g.row_select_actions.extend (agent (a_row: EV_GRID_ROW)
					do
						if a_row /= Void and then a_row.parent /= Void then
							selected_row := a_row
							show_portion_from_row (selected_row, eiffel_class_structure, 0,0,0)
						else
							selected_row := Void
						end
					end)

			g.set_item_pebble_function (agent (gi: EV_GRID_ITEM): ANY do Result := gi.row end)
		end

feature -- Basic operations

	populate_grid
		require
			 has_valid_eiffel_class_structure: has_valid_eiffel_class_structure
		local
			ecs: like eiffel_class_structure
			feat_clauses: LIST [FEATURE_CLAUSE_AS]
			glab: EV_GRID_LABEL_ITEM
			gelab: EV_GRID_EDITABLE_ITEM
			l_row, l_subrow: EV_GRID_ROW
			t: STRING_32
			r,sr: INTEGER
			g: like grid

			l_as: FEATURE_CLAUSE_AS
			feats: EIFFEL_LIST [FEATURE_AS]
			f: FEATURE_AS
			feature_clause_bg: EV_COLOR
		do
			ecs := eiffel_class_structure
			g := grid
			g.set_row_count_to (0)

			if ecs.has_structure then
				create feature_clause_bg.make_with_8_bit_rgb (235,235,250)

				from
					feat_clauses := ecs.structure
					feat_clauses.start
				until
					feat_clauses.after
				loop
					r := g.row_count + 1
					g.insert_new_row (r)
					l_row := g.row (r)
					l_row.set_background_color (feature_clause_bg)
					l_as := feat_clauses.item

						--| Name
					t := "-- "
					t.append ("%"")
					t.append (ecs.feature_clause_comment (l_as))
					t.append ("%"")

					create gelab.make_with_text (t)
					gelab.set_font (feature_clause_font)
					l_row.set_item (cst_name, gelab)
					gelab.drop_actions.extend (agent dropped_on (l_row,?))
					gelab.pointer_double_press_actions.force_extend (agent gelab.activate)
					gelab.activate_actions.extend (agent (a_fcas: FEATURE_CLAUSE_AS; ag: EV_GRID_EDITABLE_ITEM; w: EV_POPUP_WINDOW)
							do
								ag.text_field.set_text (eiffel_class_structure.feature_clause_comment (a_fcas))
							end(l_as, gelab, ?))
					gelab.deactivate_actions.extend (agent (a_fcas: FEATURE_CLAUSE_AS; ag: EV_GRID_EDITABLE_ITEM)
							local
								nt: STRING
							do
								nt := ag.text_field.text
								eiffel_class_structure.update_feature_clause_comment (a_fcas, nt)
								ag.set_text ("-- %"" + nt + "%"")
								refresh
							end(l_as, gelab))

						--| Export
					create glab.make_with_text (feature_clause_exports_text (l_as))
					l_row.set_item (cst_export, glab)

						--| Position
					t := ""
					t.append (" (")
					t.append_integer (l_as.feature_keyword.start_position)
					t.append (",")
					t.append_integer (l_as.feature_clause_end_position)
					t.append (")")
					l_row.set_data ([l_as, [l_as.feature_keyword.start_position, l_as.feature_clause_end_position]])
					create glab.make_with_text (t)
					l_row.set_item (cst_positions, glab)

					feats := l_as.features
					if feats /= Void and then not feats.is_empty then
						from
							feats.start
						until
							feats.after
						loop
							sr := l_row.subrow_count + 1
							l_row.insert_subrow (sr)
							l_subrow := l_row.subrow (sr)

							f := feats.item
							add_feature_to_row (f, l_subrow)

							feats.forth
						end
					end
					feat_clauses.forth
					if l_row.is_expandable then
						l_row.expand
					end
				end
			else
				create glab.make_with_text ("No structure")
				g.set_item (1, 1, glab)
			end
			resize_columns
		end

	add_feature_to_row (f: FEATURE_AS; a_row: EV_GRID_ROW)
		local
			ecs: like eiffel_class_structure
			t: STRING
			glab: EV_GRID_LABEL_ITEM
			l_subrow: EV_GRID_ROW
			l_name,l_sign,l_type: STRING
			p: EV_PIXMAP
			err: STRING
		do
			ecs := eiffel_class_structure

			err := ""
			if f.body.content /= Void and then f.is_deferred then
				err.append ("+Deferred ")
			end

			l_name := ""
			if attached {LIST [STRING]} ecs.feature_names (f) as fns and then not fns.is_empty then
				from
					fns.start
				until
					fns.after
				loop
					l_name.append_string (fns.item)
					if not fns.islast then
						l_name.append_string (", ")
					end
					fns.forth
				end
			end

			l_sign := ""
			l_type := ""

			t := ""
			if f.is_attribute then
--				t := once "attribute"
				p := pixmap_attribute
			elseif f.is_constant then
--				t := once "constant"
				p := pixmap_constant
			else
				if f.body.arguments /= Void then
					l_sign := eiffel_class_structure.ast_text (f.body.arguments)
				end
				if f.is_function then
					p := pixmap_function
--					t := once "function"
					check f.body.type /= Void end
				else
					p := pixmap_method
--					t := once "method"
				end
			end

			if f.body.type /= Void then
				l_type := eiffel_class_structure.ast_text (f.body.type)
			end

--				--| Name
--			create glab.make_with_text (l_name)
--			glab.set_background_color (name_bg)
--			a_row.set_item (cst_name, glab)
--			glab.drop_actions.extend (agent dropped_on (a_row,?))
--			if p /= Void then
--				glab.set_pixmap (p)
--			end
--
--				--| Sign+type
--			t := ""
----			t.append_string (l_name)
--			if l_sign /= Void and then not l_sign.is_empty then
--				t.append_string ("(")
--				t.append_string (l_sign)
--				t.append_string (")")
--			end
--			if l_type /= Void and then not l_type.is_empty then
--				if not t.is_empty then
--					t.append_string (": ")
--				end
--				t.append_string (l_type)
--			end
--				--| Sign+type		
--			create glab.make_with_text (t)
--			a_row.set_item (cst_signature, glab)

				--| Name
			create glab.make_with_text (l_name)
			glab.set_background_color (name_bg)
			a_row.set_item (cst_name, glab)
			glab.drop_actions.extend (agent dropped_on (a_row,?))
			if p /= Void then
				glab.set_pixmap (p)
			end
				--| Sign
			create glab.make_with_text (l_sign)
			a_row.set_item (cst_signature, glab)

				--| Type
			create glab.make_with_text (l_type)
			a_row.set_item (cst_type, glab)

				--| Position
			t := ""
			t.append (" (")
			t.append_integer (f.start_position)
			t.append (",")
			t.append_integer (f.end_position)
			t.append (")")
			a_row.set_data ([f, [f.start_position, f.end_position]])
			create glab.make_with_text (t)
			a_row.set_item (cst_positions, glab)

			t := ecs.feature_comments_to_string (f)
			if t /= Void and then t.count > 0 then
				a_row.insert_subrow (1)
				l_subrow := a_row.subrow (1)

				create glab.make_with_text (t)
				glab.set_foreground_color (comments_fg)
				l_subrow.set_item (cst_comments, glab)
				l_subrow.set_height (glab.text_height + 4)
			else
				err.append_string ("+NoComment ")
			end
			create glab.make_with_text (err)
			glab.set_foreground_color (stock_colors.red)
			a_row.set_item (cst_error, glab)
		end

	show_text (t: STRING)
		local
			tt: STRING
		do
			if t = Void then
				text.remove_text
			else
				tt := t.twin
				tt.prune_all ('%R')
				text.set_text (tt)
			end
		end

	show_portion (t: TUPLE [s,e: INTEGER]; a_ecs: EIFFEL_CLASS_STRUCTURE)
		local
			ut: TUPLE [s,e: INTEGER; s_offset, e_offset: INTEGER; t: STRING_32]
		do
			ut ?= t
			if ut = Void and t /= Void then
				create ut
				ut.s := t.s
				ut.e := t.e
			end
			if ut /= Void then
				a_ecs.update_text_information (ut)
				show_text (ut.t)
				ut.t := Void
			end
		end

feature -- Element change

	insert_feature_clause (a_row: EV_GRID_ROW)
		local
			fc: FEATURE_CLAUSE_AS
		do
			fc ?= ast_for_row (a_row)
			if fc /= Void then
				eiffel_class_structure.insert_feature_clause ("New Feature Clause", Void,fc)
				refresh
			end
		end

	remove_feature_clause (a_row: EV_GRID_ROW)
		local
			fc: FEATURE_CLAUSE_AS
		do
			fc ?= ast_for_row (a_row)
			if fc /= Void then
				eiffel_class_structure.remove_feature_clause (fc)
				refresh
			end
		end

	resize_columns
		local
			g: like grid
			w, n, i: INTEGER
		do
			g := grid
			if g.row_count > 0 then
				n := g.column_count
				from i := 1 until i = n loop
					if g.column_displayed (i) then
						w := g.column (i).required_width_of_item_span (1, g.row_count)
						g.column (i).set_width (w + 5)
					end
					i := i + 1
				end
			end
		end

feature -- Callback

	files_dropped (lst: LIST [STRING_32])
		do
			if lst.count = 1 then
				if attached lst.first as s then
					set_filename (s)
				end
			end
		end

	dropped_on (a_row: EV_GRID_ROW; a_pebble: EV_GRID_ROW)
		local
			l_target: EV_GRID_ROW
			g: EV_GRID
			i,j,n: INTEGER
			pebble_is_feature: BOOLEAN
			src_as: AST_EIFFEL
		do
			if a_row /= a_pebble then
				src_as := ast_for_row (a_pebble)
				if src_as /= Void then
					pebble_is_feature := a_pebble.parent_row /= Void
					i := a_pebble.index
					n := 1 + a_pebble.subrow_count_recursive

					if a_row.parent_row = Void then
						-- Features clause
						if pebble_is_feature then
							l_target := a_row
							j := l_target.index + l_target.subrow_count_recursive + 1
							eiffel_class_structure.move_feature (src_as, ast_for_row (a_row), Void)
						else
							j := a_row.index
							eiffel_class_structure.move_feature_clause (src_as, ast_for_row (a_row))
						end
					else
						-- Feature item
						if pebble_is_feature then
							l_target := a_row.parent_row
							j := a_row.index
							eiffel_class_structure.move_feature (src_as, ast_for_row (l_target), ast_for_row(a_row))
						else
							j := a_row.parent_row.index
							eiffel_class_structure.move_feature_clause (src_as, ast_for_row (a_row.parent_row))
						end
					end

					g := a_row.parent
					if l_target /= Void then
						g.move_rows_to_parent (i,j, n, l_target)
					else
						g.move_rows (i,j, n)
					end

					refresh
				end
			end
		end

feature -- Implementation

	ast_for_row (a_row: EV_GRID_ROW): AST_EIFFEL
		local
			t: TUPLE [ast: AST_EIFFEL]
		do
			t ?= a_row.data
			if t /= Void then
				Result ?= t.ast
			end
		end

	text_position_for_row (a_row: EV_GRID_ROW): TUPLE [s,e: INTEGER]
		local
			t: TUPLE [ast: AST_EIFFEL; pos: TUPLE [s,e: INTEGER]]
		do
			t ?= a_row.data
			if t /= Void then
				Result := t.pos
			end
		end

	show_portion_from_row (a_row: EV_GRID_ROW; a_ecs: EIFFEL_CLASS_STRUCTURE; ax,ay,ab: INTEGER)
		do
			show_portion (text_position_for_row (a_row), a_ecs)
		end

	feature_clause_exports_text (l_as: FEATURE_CLAUSE_AS): STRING
		require
			has_valid_eiffel_class_structure: has_valid_eiffel_class_structure
		local
			s: STRING
		do
			Result := ""
			if attached {LIST [STRING]} eiffel_class_structure.feature_class_exports (l_as) as cls and then not cls.is_empty then
				from
					cls.start
				until
					cls.after
				loop
					s := cls.item
					if s /= Void then
						Result.append (s)
					end
					if not cls.islast then
						Result.append (", ")
					end
					cls.forth
				end
			end
		end

feature -- Access

	is_modified: BOOLEAN

	text: EV_TEXT

	grid: EV_GRID

	selected_row: EV_GRID_ROW

	copied_row: EV_GRID_ROW

	filename: detachable STRING_8
		note
			option: stable
		attribute
		end

	has_valid_eiffel_class_structure: BOOLEAN
		do
			Result := attached eiffel_class_structure as s and then s.has_structure
		end

	eiffel_class_structure: detachable EIFFEL_CLASS_STRUCTURE

	class_text: detachable STRING
		do
			if
				attached eiffel_class_structure as s and then
				s.has_structure
			then
				Result := s.class_text
			end
		end

feature -- Basic operation

	set_modified (b: BOOLEAN)
		local
			t,m: STRING_32
		do
			if b then
				t := title
				m := "-- Modified --"
				if t.substring_index (m, 1) = 0 then
					set_title (m + title)
				end
			else
				if filename /= Void then
					set_title (default_title + " (" + filename + ")" )
				else
					set_title (default_title)
				end
			end
			is_modified := b
		end

	set_filename (fn: STRING_8)
		require
			fn_attached: fn /= Void
		do
			filename := fn
			scan_file (fn)
		end

	clean_text
			-- Pretty/clean code
		local
			t: STRING
			s: STRING
		do
			if has_valid_eiffel_class_structure then
				t := class_text
				s := t.string
				s.prune_all ('%R')
				s := clean_class_code (s)
				scan_string (s)
				set_modified (True)
			end
		end

	save_text
		local
			t: detachable STRING
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			t := class_text
			if t /= Void then
				s := t.string
				s.prune_all ('%R')
	--			s := clean_class_code (s)

				create f.make_create_read_write (filename)
				f.open_write
				f.put_string (s)
				f.flush
				f.close

				set_modified (False)
			end
		end

	clean_class_code (t: STRING): STRING
		local
			a_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			--| regexp (vim)   :%s/\(\n\)\s*\n[\s\n]*\s*(\n)/\1\2/gc			
			create a_regexp.make
			a_regexp.compile ("(\n)\s*\n[\s\n]*\s*(\n)")
			a_regexp.optimize
			a_regexp.match (t)
			Result := a_regexp.replace_all ("%N%N")
		end

	refresh
		local
			i: INTEGER
		do
			if has_valid_eiffel_class_structure then
				if attached {EV_GRID_ROW} selected_row as r then
					i := r.index
				end
				scan_string (eiffel_class_structure.class_text)
				if i > 0 then
					grid.select_row (i)
					grid.row (i).ensure_visible
				end
				set_modified (True)
			end
		end

	scan_file (fn: STRING_8)
		require
			fn_attached: fn /= Void
		local
			ecs: EIFFEL_CLASS_STRUCTURE
		do
			set_modified (False)

			copied_row := Void
			selected_row := Void
			eiffel_class_structure := Void
			show_text ("Scanning %"" + fn + "%" ...")
			create ecs.make_with_filename (fn)
			if
				ecs.has_structure and then
				attached {STRING} ecs.structure_to_string as t
			then
				show_text (t)
			end
			eiffel_class_structure := ecs
			if has_valid_eiffel_class_structure then
				populate_grid
			end
		end

	scan_string (txt: STRING)
		local
			ecs: EIFFEL_CLASS_STRUCTURE
		do
			copied_row := Void
			selected_row := Void
			eiffel_class_structure := Void
			show_text ("Scanning string ...")
			create ecs.make_with_string (txt)
			show_text (ecs.structure_to_string)
			eiffel_class_structure := ecs

			if has_valid_eiffel_class_structure then
				populate_grid
			end
		end

feature -- Pixmaps

	comments_fg: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255,90,90)
		end

	name_bg: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255,255,230)
		end

	stock_colors: EV_STOCK_COLORS
		once
			create Result
		end

	feature_clause_font: EV_FONT
		once
			create Result
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		end

	pixmap_font: EV_FONT
		once
			create Result
			Result.set_height_in_points (7)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
		end

	pixmap_logo: EV_PIXMAP
		local
			c1: EV_COLOR
		once
			create Result.make_with_size (18, 18)
			Result.set_background_color (stock_colors.white)
			create c1.make_with_8_bit_rgb (110,110,210)
			Result.set_foreground_color (c1)
			Result.clear
			Result.draw_rectangle (0,0, 18,18)
			Result.draw_rectangle (2,2, 14,14)
			Result.fill_rectangle (5,5, 8,8)
			Result.set_foreground_color (stock_colors.white)
			Result.draw_segment (5, 8, 12,8)
		end

	pixmap_for (t: STRING; c: EV_COLOR): EV_PIXMAP
		do
			create Result.make_with_size (12, 12)
			Result.set_foreground_color (stock_colors.white)
			Result.set_background_color (c)
			Result.clear
			Result.set_font (pixmap_font)
			Result.draw_text_top_left (1, 0, t)
		end

	pixmap_method: EV_PIXMAP
		once
			Result := pixmap_for("M", stock_colors.blue)
		end
	pixmap_function: EV_PIXMAP
		once
			Result := pixmap_for("F", stock_colors.dark_red)
		end
	pixmap_attribute: EV_PIXMAP
		once
			Result := pixmap_for("A", stock_colors.red)
		end
	pixmap_constant: EV_PIXMAP
		once
			Result := pixmap_for("C", stock_colors.magenta)
		end

feature -- Constants

	cst_name: INTEGER = 1
	cst_export: INTEGER = 2
	cst_comments: INTEGER = 2
	cst_signature: INTEGER = 2
	cst_type: INTEGER = 3
	cst_positions: INTEGER = 4
	cst_error: INTEGER = 5

	default_title: STRING = "Eiffel Class Structure Editor"

end
