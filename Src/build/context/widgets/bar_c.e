

class BAR_C 

inherit

	PIXMAPS
		rename
			Bar_pixmap as symbol
		export
			{NONE} all
		end;

	MENU_C
		redefine
			widget, stored_node, add_to_option_list
		end

feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.bar_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			forbid_recompute_size;
			set_size (40, 40);
			allow_recompute_size;
		end;

	widget: BAR;

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Bar");
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.bar_sm_form_nbr,
						Context_const.Submenu_format_nbr);
		end;

feature 

	eiffel_type: STRING is "BAR";


	forbid_recompute_size is
		do
			widget.forbid_recompute_size;
		end;

	allow_recompute_size is
		do
			widget.allow_recompute_size;
		end;
-- ****************
-- Storage features
-- ****************

	stored_node: S_BAR is
		do
			!!Result.make (Current);
		end;

end
