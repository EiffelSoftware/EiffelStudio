

class TOGGLE_B_C 

inherit

	PIXMAPS
		rename
			Toggle_b_pixmap as symbol
		export
			{NONE} all
		end;

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
			!!widget.make (entity_name, a_parent);
		end;

	widget: TOGGLE_B;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Toggle_b");
		end;

	editor_form_cell: CELL [INTEGER] is
        once
            !!Result.put (0)
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
