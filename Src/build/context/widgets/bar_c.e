

class BAR_C 

inherit

	MENU_C
		redefine
			widget, stored_node, is_resizable
		end

feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.bar_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.bar_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!! widget.make_unmanaged (entity_name, a_parent)
				--| Resize parent window under Ms-Windows
			a_parent.set_height (a_parent.height + widget.height)
				--| The next lines are needed on Motif platforms.
--			forbid_recompute_size;
--			set_size (40, 40);
--			allow_recompute_size;
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

	full_type_name: STRING is "Bar"


	forbid_recompute_size is
		do
			widget.forbid_recompute_size;
		end;

	allow_recompute_size is
		do
			widget.allow_recompute_size;
		end;

	is_resizable: BOOLEAN is
		do
			Result := False
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_BAR is
		do
			!!Result.make (Current);
		end;

end
