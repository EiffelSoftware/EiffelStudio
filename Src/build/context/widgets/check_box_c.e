
class CHECK_BOX_C 

inherit

	GROUP_COMPOSITE_C
		redefine
			widget, stored_node
		
		end
	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.check_box_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.set_page.check_box_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: CHECK_BOX;

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("CheckBox");
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
							Context_const.Geometry_format_nbr);
		end
	
feature 

	eiffel_type: STRING is "CHECK_BOX";

	full_type_name: STRING is "Check box"

-- ****************
-- Storage features
-- ****************

	stored_node: S_CHECK_BOX is
		do
			!!Result.make (Current);
		end;

end
