

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
			--add_widget_callbacks,
			widget, option_list, stored_node
		
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_page.bar_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
			forbid_recompute_size;
			set_size (40, 40);
			allow_recompute_size;
		end;

	widget: BAR;

--	add_widget_callbacks is
--			-- For a bar the callbacks for the selection
--			-- manager are not valid
--		do
--			initialize_transport;
--		end;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Bar");
		end;

	
feature 

	eiffel_type: STRING is "BAR";

	option_list: ARRAY [INTEGER] is
		do
			!!Result.make (1, 2);
			Result.put (geometry_form_number, 1);
			Result.put (bar_form_number, 2);
		end;

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
