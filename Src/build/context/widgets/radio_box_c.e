
class RADIO_BOX_C 

inherit

	GROUP_COMPOSITE_C
		redefine
			widget, stored_node
		end
	
feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.set_page.radio_box_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: RADIO_BOX;

	symbol: PIXMAP is
		do
			Result := Pixmaps.radio_box_pixmap
		end;
	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("RadioBox");
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
					Context_const.Geometry_format_nbr);
		end
	
feature 

	eiffel_type: STRING is "RADIO_BOX";

	full_type_name: STRING is "Radio box"

	unarm_all_toggles_except (t: TOGGLE_B_C) is
			-- Unarm all toggles in Current except for `t'.
		local
			toggle_b_c: TOGGLE_B_C
			other_editor: CONTEXT_EDITOR
		do
			from
				child_start
			until
				child_offright
			loop
				toggle_b_c ?= child;
				if toggle_b_c /= Void and then toggle_b_c /= t then
					toggle_b_c.set_toggle_state (False);
					other_editor := context_catalog.editor 
									(toggle_b_c, Context_const.toggle_att_form_nbr)
					if other_editor /= Void then
						other_editor.reset_current_form
					end
				end;
				child_forth
			end;
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_RADIO_BOX is
		do
			!!Result.make (Current);
		end;

end
