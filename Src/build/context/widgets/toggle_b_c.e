

class TOGGLE_B_C 

inherit

	BUTTON_C
		redefine
			stored_node, widget
		end

feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.toggle_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			widget.forbid_recompute_size;
		end;

	widget: TOGGLE_B;

	symbol: PIXMAP is
		do
			Result := Pixmaps.toggle_b_pixmap
		end;
	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Toggle_b");
		end;

feature 

	eiffel_type: STRING is "TOGGLE_B";

-- ****************
-- Storage features
-- ****************

	stored_node: S_TOGGLE_B is
		do
			!!Result.make (Current);
		end;

end
