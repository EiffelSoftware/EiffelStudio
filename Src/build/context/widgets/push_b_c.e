
class PUSH_B_C 

inherit

	PIXMAPS
		rename
			Push_b_pixmap as symbol
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
			Result := context_catalog.push_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: PUSH_B;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
        once
            !!Result.put (0)
        end;

	namer: NAMER is
		once
			!!Result.make ("Push_b");
		end;

feature 

	eiffel_type: STRING is "PUSH_B";

-- ****************
-- Storage features
-- ****************

	stored_node: S_PUSH_B is
		do
			!!Result.make (Current);
		end;


end
