note
	description: "Compiler's Extension for Estudio debug menu ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ESTUDIO_DEBUG_EXTENSION_COMPILER

inherit
	ESTUDIO_DEBUG_EXTENSION

create
	make

feature {NONE} -- Initialization


feature -- Execution

	execute
		do
			open_debug_class_feature_info (Void, Void)
		end

	open_debug_class_feature_info (a_cl, a_ft: detachable STRING)
		local
			l_dlg: EV_DIALOG
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			tf_c, tf_f: EV_TEXT_FIELD
			cl: EV_CELL
			but, cbut: EV_BUTTON
			but_action: PROCEDURE [ANY, TUPLE]
		do
			create l_dlg.make_with_title ("Class/Feature info")
			keep_dialog (l_dlg)
			create hb
			create tf_c.make_with_text ("")
			create tf_f.make_with_text ("")
			hb.extend (tf_c)
			hb.extend (tf_f)
			hb.set_padding_width (5)

			create vb
			vb.extend (hb)
			create cl
			but_action := agent (ai_tf_c, ai_tf_f: EV_TEXT_FIELD; ai_cell: EV_CELL)
					local
						sh_sys: SHARED_WORKBENCH
						c,f: STRING
						cli: CLASS_I
						g: ES_GRID
						l_row,r: EV_GRID_ROW
						gei: EV_GRID_EDITABLE_ITEM
						bgcol: EV_COLOR
					do
						create bgcol.make_with_8_bit_rgb (210, 210, 255)
						create g
						g.enable_tree
						g.set_column_count_to (2)
						g.enable_vertical_scrolling_per_item
						g.set_auto_resizing_column (1, True)
						g.set_auto_resizing_column (2, True)
						g.enable_border
						g.enable_column_separators
						g.enable_row_separators
						ai_cell.wipe_out
						ai_cell.extend (g)

						c := ai_tf_c.text.as_upper
						f := ai_tf_f.text.as_lower
						ai_tf_c.set_text (c)
						ai_tf_f.set_text (f)
						create sh_sys
						l_row := g.grid_extended_new_row (g)
						l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Class"))
						l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (c))
						if not f.is_empty then
							l_row := g.grid_extended_new_row (g)
							l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Feature"))
							l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (f))
						end

						if not c.is_empty and then attached sh_sys.universe.classes_with_name (c) as cl_i_lst then
							g.wipe_out
							from
								cl_i_lst.start
							until
								cl_i_lst.after
							loop
								cli := cl_i_lst.item
								l_row := g.grid_extended_new_row (g)
								l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (cli.name))
								l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (cli.file_name))
								if attached {CLASS_C} cli.compiled_representation as cl then
									r := l_row
									l_row := g.grid_extended_new_subrow (r)
									l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("is compiled"))
									l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text ("yes"))

									l_row := g.grid_extended_new_subrow (r)
									l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("class_id"))
									gei := create {EV_GRID_EDITABLE_ITEM}.make_with_text (cl.class_id.out)
									gei.set_background_color (bgcol)
									gei.pointer_double_press_actions.force_extend (agent gei.activate)
									gei.deactivate_actions.extend (agent (ai_gei: EV_GRID_EDITABLE_ITEM)
											local
												l_id: STRING
												i_sh_sys: SHARED_WORKBENCH
											do
												if attached ai_gei.text_field as tf then
													l_id := tf.text
													if l_id.is_integer then
														create i_sh_sys
														if attached {CLASS_C} i_sh_sys.system.class_of_id (l_id.to_integer) as i_cl then
															open_debug_class_feature_info (i_cl.name, Void)
														end
													end
												end
											end(gei))
									l_row.set_item (2, gei)

									l_row := g.grid_extended_new_subrow (r)
									l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("topological_id"))
									l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (cl.topological_id.out))

									if attached cl.types as l_class_types then
										l_row := g.grid_extended_new_subrow (r)
										l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Class types"))
										from
											l_class_types.start
										until
											l_class_types.after
										loop
											if attached l_class_types.item as ct then
												debug_class_feature_info_add_class_type (ct, l_row, bgcol)
											end
											l_class_types.forth
										end
									end

									if not f.is_empty and then attached {FEATURE_I} cl.feature_named (f) as fi then
										debug_class_feature_info_add_feature_i (cl, fi, r, bgcol, False)
									elseif attached cl.feature_table as ftable then
										l_row := g.grid_extended_new_subrow (r)
										l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Inherited features"))
										from
											ftable.start
										until
											ftable.after
										loop
											if attached ftable.item_for_iteration as fi then
												if fi.written_class /= cl then
													debug_class_feature_info_add_feature_i (cl, fi, l_row, bgcol, True)
												end
											end
											ftable.forth
										end
										l_row := g.grid_extended_new_subrow (r)
										l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Immediate features"))
										from
											ftable.start
										until
											ftable.after
										loop
											if attached ftable.item_for_iteration as fi then
												if fi.written_class = cl then
													debug_class_feature_info_add_feature_i (cl, fi, l_row, bgcol, True)
												end
											end
											ftable.forth
										end

									end
									if r.is_expandable then
										r.expand
									end
								end
								cl_i_lst.forth
							end
						end

					end(tf_c, tf_f, cl)

			create but.make_with_text_and_action ("Info", but_action)
			create cbut.make_with_text_and_action ("Close", agent release_dialog (l_dlg))

			vb.extend (but)
			vb.extend (cbut)

			vb.extend (cl)
			vb.disable_item_expand (hb)
			vb.disable_item_expand (but)
			vb.disable_item_expand (cbut)
			l_dlg.extend (vb)
			l_dlg.set_default_cancel_button (cbut)
			cbut.hide
			l_dlg.set_size (500, 500)

			tf_c.return_actions.extend (agent tf_f.set_focus)
			tf_f.return_actions.extend (agent but.set_focus)


			if a_cl /= Void then
				tf_c.set_text (a_cl)
				if a_ft /= Void then
					tf_f.set_text (a_ft)
				end
				but_action.call (Void)
			end
			if attached estudio_debug_menu.window as w then
				l_dlg.show_relative_to_window (w)
			else
				l_dlg.show
			end
		end

	debug_class_feature_info_add_class_type (ct: CLASS_TYPE; r: EV_GRID_ROW; bgcol: EV_COLOR)
		local
			l_row: EV_GRID_ROW
			g: ES_GRID
			gi: EV_GRID_LABEL_ITEM
		do
			g ?= r.parent
			l_row := g.grid_extended_new_subrow (r)
			create {EV_GRID_LABEL_ITEM} gi.make_with_text (ct.type.name)
			l_row.set_item (1, gi)
			l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text ("static_type_id=" + ct.static_type_id.out + " type_id=" + ct.type_id.out))

--			sr := g.grid_extended_new_subrow (l_row)
--			l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("static_type_id"))
--			l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (ct.static_type_id.out))

--			sr := g.grid_extended_new_subrow (l_row)
--			l_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("type_id"))
--			l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (ct.type_id.out))

		end

	debug_class_feature_info_add_feature_i (cl: CLASS_C; fi: FEATURE_I; r: EV_GRID_ROW; bgcol: EV_COLOR; a_list: BOOLEAN)
		local
			l_row,sr: EV_GRID_ROW
			g: ES_GRID
			gi: EV_GRID_LABEL_ITEM
			gei: EV_GRID_EDITABLE_ITEM
			f,s: STRING
		do
			g ?= r.parent
			l_row := g.grid_extended_new_subrow (r)
			create {EV_GRID_LABEL_ITEM} gi.make_with_text (fi.feature_name)
			if a_list then
				gi.set_background_color (bgcol)
				gi.pointer_double_press_actions.force_extend (agent open_debug_class_feature_info (cl.name, fi.feature_name))
			end
			l_row.set_item (1, gi)
			l_row.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (attached_string(fi.alias_name)))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("feature_id"))
			if a_list then
				create gi.make_with_text (fi.feature_id.out)
				sr.set_item (2, gi)
			else
				gei := create {EV_GRID_EDITABLE_ITEM}.make_with_text (fi.feature_id.out)
				gei.set_background_color (bgcol)
				gei.pointer_double_press_actions.force_extend (agent gei.activate)
				gei.deactivate_actions.extend (agent (ai_gei: EV_GRID_EDITABLE_ITEM; ai_cl: CLASS_C)
						local
							l_id: STRING
						do
							if attached ai_gei.text_field as tf then
								l_id := tf.text
								if l_id.is_integer then
									if attached {FEATURE_I} ai_cl.feature_of_feature_id (l_id.to_integer) as i_ft then
										open_debug_class_feature_info (ai_cl.name, i_ft.feature_name)
									end
								end
							end
						end(gei, cl))
				sr.set_item (2, gei)
			end

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("feature_name_id"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.feature_name_id.out))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("id"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.id.out))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("body_index"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.body_index.out))
			if
				attached {ROUT_ID_SET} fi.rout_id_set as ridset and then
				attached ridset.linear_representation as ridset_list
			then
				create s.make_empty
				from
					ridset_list.start
				until
					ridset_list.after
				loop
					s.append_integer (ridset_list.item)
					s.append_character (' ')
					ridset_list.forth
				end
				sr := g.grid_extended_new_subrow (l_row)
				sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("rout_id_set"))
				sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (s))
			end
			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("origin_class_id"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.origin_class_id.out))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("origin_feature_id"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.origin_feature_id.out))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("written_feature_id"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.written_feature_id.out))

			sr := g.grid_extended_new_subrow (l_row)
			sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("written_in"))
			sr.set_item (2, create {EV_GRID_LABEL_ITEM}.make_with_text (fi.written_in.out))

			if attached {CLASS_C} fi.written_class as wcl and then wcl /= cl then
				sr := g.grid_extended_new_subrow (l_row)
				sr.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text ("written_class"))
				create gi.make_with_text (wcl.name)
				gi.pointer_double_press_actions.force_extend (agent open_debug_class_feature_info (wcl.name, f))
				gi.set_background_color (bgcol)
				sr.set_item (2, gi)
			end
			if not a_list and then l_row.is_expandable then
				l_row.expand
			end
		end


feature -- Access

	menu_path: ARRAY [STRING]
		do
			Result := <<"Compiler", "Show class/feature info">>
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
