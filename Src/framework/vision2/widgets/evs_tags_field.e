indexing
	description: "Test field for tags."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_TAGS_FIELD

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

convert
	to_text_field: {EV_TEXT_FIELD},
	to_widget: {EV_WIDGET}

feature {NONE} -- Initialization

	default_create is
			-- Create Current
		do
			create change_actions
			build_interface
		end

	build_interface is
			-- Build interface
		local
			hb: EV_HORIZONTAL_BOX
		do
			create hb
			create text_field
			create button
			set_pixmap (Void)

			hb.extend (text_field)
			hb.extend (button); hb.disable_item_expand (hb.last)

			button.select_actions.extend (agent open_tags_popup)
			text_field.return_actions.extend (agent update_text)

			set_category_mode (True)

			widget := hb
		end

feature -- Properties

	category_mode: BOOLEAN
			-- Display using category ?
			-- (otherwise display it flat)

	provider: TAGS_PROVIDER
			-- Tags provider.

	original_text: like text
			-- Original text kept to be able to compute `is_modified'.

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Action triggered when user press Return with modified values.

feature -- Measurement

	is_modified: BOOLEAN is
			-- Value modified ?
		local
			t,o: like text
		do
			t := text
			if t.is_empty then
				t := Void
			end
			o := original_text
			if o /= Void and then o.is_empty then
				o := Void
			end
			if o = t then --| Meaning Void, since it can not be the same reference
				check o = Void end
				Result := False
			elseif o = Void or t = Void then
				Result := True
			else
				Result := not o.is_case_insensitive_equal (t)
			end
		end

feature -- Access

	text: STRING_32 is
			-- Text
		do
			Result := text_field.text
		ensure
			Result_not_void: Result /= Void
		end

	used_tags: ARRAY [STRING_32] is
			-- Used tags as Array.
		do
			Result := string_to_array_tags (text)
		end

feature -- Change

	set_category_mode (b: BOOLEAN) is
			-- Set `category_mode' to `b'
		do
			category_mode := b
		end

	set_provider (a_prov: like provider) is
			-- Set `provider' to `a_prov'
		do
			provider := a_prov
		end

	set_text (s: STRING_GENERAL) is
			-- Set text
		require
			s_not_void: s /= Void
		do
			internal_set_text (s)
			original_text := text
		end

	set_tags (arr: ARRAY [STRING_32]) is
			-- Set tags
		do
			internal_set_tags (arr)
			original_text := text
		end

	remove_text is
			-- Remove text
		do
			internal_remove_text
			original_text := Void
		end

	set_pixmap (p: EV_PIXMAP) is
			-- Set tags's button pixmap
		do
			if p /= Void then
				button.set_pixmap (p)
				button.remove_text
			else
				button.set_text ("+")
				button.remove_pixmap
			end
		end

	set_background_color (c: EV_COLOR) is
			-- Set background_color
		do
			text_field.set_background_color (c)
		end

	set_foreground_color (c: EV_COLOR) is
			-- Set foreground_color
		do
			text_field.set_foreground_color (c)
		end

	validate_changes is
			-- Validate current change,
			-- and update original_value
		do
			original_text := text
		end

feature -- event

	update_text is
			-- Update text with well formatted string from `used_tags'
		do
			internal_set_tags (used_tags)
			if is_modified then
				change_actions.call (Void)
			end
		end

	add_tag	(t: STRING_32) is
			-- Add tag `t'
		local
			s: like text
		do
			s := text
			if not s.is_empty then
				s.append (", ")
			end
			s.append (t)
			internal_set_text (s)
		end

	open_tags_popup is
			-- Open tags popup
		local
			pw: EV_POPUP_WINDOW
			b: EV_VERTICAL_BOX
			g: EV_GRID
			gci: EV_GRID_CHECKABLE_LABEL_ITEM
			gpci: EV_GRID_CHECKABLE_LABEL_ITEM
			glab: EV_GRID_LABEL_ITEM
			ltags: like used_tags
			lptags: DS_LIST [STRING_32]
			s,cat, lastcat: STRING_32
			i,r: INTEGER
			w: INTEGER
			chk_chg_action: PROCEDURE [ANY, TUPLE [EV_GRID_CHECKABLE_LABEL_ITEM]]
			grp_chk_chg_action: PROCEDURE [ANY, TUPLE [EV_GRID_CHECKABLE_LABEL_ITEM]]
			tup: like category_name_tag
		do
			create pw.make_with_shadow
			pw.enable_border
			pw.enable_user_resize

			pw.hide_actions.extend (agent update_text)

			create b
			create g
			g.hide_header
			if category_mode then
				g.enable_tree
				g.row_expand_actions.force_extend (agent (ag: EV_GRID) do ag.column (1).resize_to_content end(g))
				g.row_collapse_actions.force_extend (agent (ag: EV_GRID) do ag.column (1).resize_to_content end(g))
			end

			g.set_column_count_to (1)
			b.extend (g)
			pw.extend (b)

			chk_chg_action := agent (achk: EV_GRID_CHECKABLE_LABEL_ITEM)
						local
							t: like text
						do
							if {s: !STRING_32} achk.data then
								t := text
								if achk.is_checked then
									if not t.is_empty then
										t.append_character (',')
										t.append_character (' ')
									end
									t.append_string (s)
								elseif not t.is_empty then
									remove_tag_from_tags_text (s, t)
								end
								internal_set_text (t)
							end
						end

			if category_mode then
				grp_chk_chg_action := agent (achk: EV_GRID_CHECKABLE_LABEL_ITEM)
						local
							t: like text
							row: EV_GRID_ROW
							sn: INTEGER
						do
							row := achk.row
							if row /= Void then
								from
									sn := row.subrow_count
								until
									sn = 0
								loop
									if {agci: !EV_GRID_CHECKABLE_LABEL_ITEM} row.subrow (sn).item (1) then
										agci.set_is_checked (achk.is_checked)
									end
									sn := sn - 1
								end
							end
						end
			end

			ltags := used_tags
			if ltags /= Void and then not ltags.is_empty then
				from
					i := ltags.lower
					r := 1
					g.insert_new_rows (ltags.count, r)
				until
					i > ltags.upper
				loop
					s := ltags[i]
					if s /= Void then
						create gci.make_with_text (s)
						gci.set_data (s)
						gci.set_is_checked (True)
						gci.checked_changed_actions.extend (chk_chg_action)
						g.set_item (1, r, gci)
						r := r + 1
					end
					i := i + 1
				end
			end
			if provider /= Void then
				from
					lptags := provider.tags --| Sorted list of tags				
					lptags.start
					r := g.row_count
					if ltags /= Void and then not ltags.is_empty then
						r := r + 1
						g.insert_new_row (r)
						create glab.make_with_text ("- Available tags -")
						g.set_item (1, r, glab)
					end
				until
					lptags.after
				loop
					s := lptags.item_for_iteration
					check s /= Void end --| the tags provider contains valid tags
					if category_mode then
						tup := category_name_tag (s)
						cat := tup.category
						if cat = Void then
							lastcat := Void
							gpci := Void
							create gci.make_with_text (s)
							r := r + 1
							g.insert_new_row (r)
							g.set_item (1, r, gci)
						else
							if
								lastcat = Void or else
								not lastcat.is_case_insensitive_equal (cat)
							then
								create gpci.make_with_text (cat)
								r := r + 1
								g.insert_new_row (r)
								g.set_item (1, r, gpci)
								gpci.checked_changed_actions.extend (grp_chk_chg_action)
							else
								check gpci /= Void end
							end
							lastcat := cat
							create gci.make_with_text (tup.name)
							r := r + 1
							g.insert_new_row_parented (r, gpci.row)
							g.set_item (1, r, gci)
						end
					else
						create gci.make_with_text (s)
						r := r + 1
						g.insert_new_row (r)
						g.set_item (1, r, gci)
					end
					gci.set_data (s)
					if ltags /= Void and then ltags.has (s) then
						gci.set_is_checked (True)
						gci.disable_sensitive
						gci.set_foreground_color (stock_colors.gray)
					else
						--| Default: gci.set_is_checked (False)
					end
					gci.checked_changed_actions.extend (chk_chg_action)

					lptags.forth
				end
			end

			g.key_press_actions.extend (agent (ak: EV_KEY; aw: EV_POPUP_WINDOW)
					do
						inspect ak.code
						when {EV_KEY_CONSTANTS}.key_escape then
							aw.hide
							aw.destroy
						else
						end
					end(?,pw)
				)
			g.column (1).resize_to_content
			w := g.column (1).width
			g.set_minimum_width (w)
			pw.set_position (text_field.screen_x, text_field.screen_y + text_field.height)
			pw.set_width (button.screen_x + button.width - text_field.screen_x)
			pw.set_height (g.virtual_height)
			g.focus_out_actions.extend (agent (aw: EV_WINDOW)
					do
						aw.hide
						aw.destroy
					end(pw))
			pw.resize_actions.force_extend (agent (ag: EV_GRID) do ag.column (1).resize_to_content end(g))
			pw.show
			g.set_focus
		end

	category_name_tag (a_tag: STRING_32): TUPLE [category: STRING_32; name: STRING_32] is
			-- Details from `a_tag'.
		require
			is_valid_tag: a_tag /= Void and then not a_tag.is_empty
		local
			p: INTEGER
		do
			p := a_tag.index_of (':', 1)
			if p > 0 then
				Result := [a_tag.substring (1, p - 1), a_tag.substring(p + 1, a_tag.count)]
			else
				Result := [Void, a_tag]
			end
		end

	remove_tag_from_tags_text (t: STRING_32; a_text: STRING_32) is
			-- Remove tag `t' from `a_text'
		require
			a_text /= Void
			t /= Void
		local
			i, p,l,r: INTEGER
		do
			if not a_text.is_empty then
				from
					i := 1
					p := a_text.substring_index (t, i)
				until
					p = 0
				loop
					from
						i := p - 1
					until
						i = 0 or else (
							a_text.item (i) /= ',' or
							a_text.item (i) /= ' ' or
							a_text.item (i) /= '%T'
							)
					loop
						i := i - 1
					end
					l := (i + 1).max (1)
					from
						i := p + t.count + 1
					until
						i > a_text.count or else (
							a_text.item (i) /= ',' or
							a_text.item (i) /= ' ' or
							a_text.item (i) /= '%T'
							)
					loop
						i := i + 1
					end
					r := (i - 1).min (a_text.count)
					a_text.remove_substring (l, r)
					p := a_text.substring_index (t, 1)
				end
			end
		end

feature -- Widgets

	text_field: EV_TEXT_FIELD
			-- Text field representation.

	button: EV_BUTTON
			-- Button to open the tags popup.

feature -- Convertion

	widget: EV_WIDGET
			-- Related widget (represents Current)

	to_widget: EV_WIDGET is
			-- Current as widget.
		do
			Result := widget
		ensure
			Result /= Void
		end

	to_text_field: EV_TEXT_FIELD is
			-- Current as text field.
		do
			Result := text_field
		ensure
			Result /= Void
		end

	parent_window (w: EV_WIDGET): EV_WINDOW is
			-- Parent window of `w'.
		require
			w /= Void
		do
			Result ?= w
			if Result = Void and then w.parent /= Void then
				Result := parent_window (w.parent)
			end
		end

feature {NONE} -- Implementation

	stock_colors: EV_STOCK_COLORS is
		once
			create Result
		end

	internal_remove_text is
			-- Remove text
		do
			text_field.remove_text
		end

	internal_set_text (s: STRING_GENERAL) is
			-- Set text
		require
			s_not_void: s /= Void
		local
			s32: STRING_32
			t: STRING_32
			i: INTEGER
			c: CHARACTER_32
		do
			s32 := s.as_string_32
			s32.left_adjust
			s32.right_adjust
			from
				create t.make (s32.count)
				i := 1
			until
				i > s32.count
			loop
				c := s32.item (i)
				if c = ',' then
					if i /= s32.count then
							--| Go to next valid entry
						from
							i := i + 1
						until
							c /= ' ' or c /= '%T' or c /= ','
						loop
							i := i + 1
						end

						t.append_character (c)
						t.append_character (' ')
					end
				else
					t.append_character (c)
				end
				i := i + 1
			end
			text_field.set_text (t)
		end

	internal_set_tags (arr: ARRAY [STRING_32]) is
			-- Set internal storage of tags from `arr'
		local
			t: like text
			ltgs: ARRAYED_LIST [STRING_32]
		do
			if arr /= Void and then not arr.is_empty then
				create ltgs.make_from_array (arr)
				ltgs.prune_all (Void)
			end
			if ltgs /= Void and then not ltgs.is_empty then
				from
					ltgs.start
					create t.make_from_string (ltgs.item_for_iteration)
					ltgs.forth
				until
					ltgs.after
				loop
					t.append_string (", ")
					t.append (ltgs.item_for_iteration)
					ltgs.forth
				end
				internal_set_text (t)
			else
				internal_remove_text
			end
		end

	string_to_array_tags (a_text: STRING_32): ARRAY [STRING_32] is
			-- Used tags as Array from `s'.
		require
			a_text_not_void: a_text /= Void
		local
			s,t: STRING_32
			n,p,pp: INTEGER
			sres: SORTABLE_ARRAY [STRING_32]
			lst: ARRAYED_LIST [STRING_32]
		do
			s := a_text
			s.left_adjust
			s.right_adjust
			if not s.is_empty then
				n := s.occurrences (',') + 1
				if n = 1 then
					Result := << s >>
				else
					create lst.make (n)
					lst.compare_objects
					from
						pp := 1
					until
						pp > s.count or n = 0
					loop
						p := s.index_of (',', pp)
						if p > 0 then

						else
							p := s.count + 1
						end
						t := s.substring (pp, p - 1)
						pp := p + 1
						t.left_adjust
						t.right_adjust
						if not t.is_empty and then not lst.has (t) then
							lst.extend (t)
							n := n - 1
						end
					end
					lst.prune_all (Void)
					from
						n := lst.count
						create sres.make (1, n)
						lst.finish
					until
						lst.before or n = 0
					loop
						sres.put (lst.item_for_iteration, n)
						check lst.item_for_iteration /= Void end
						n := n - 1
						lst.back
					end
					sres.sort
					Result := sres
				end
				Result.compare_objects
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
