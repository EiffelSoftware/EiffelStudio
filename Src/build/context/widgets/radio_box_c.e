
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

-- ****************
-- Storage features
-- ****************

	stored_node: S_RADIO_BOX is
		do
			!!Result.make (Current);
		end;

end
