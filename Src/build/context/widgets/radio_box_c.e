
class RADIO_BOX_C 

inherit

	PIXMAPS
		rename
			Radio_box_pixmap as symbol
		export
			{NONE} all
		end;

	GROUP_COMPOSITE_C
		redefine
			widget, stored_node
		
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.set_page.radio_box_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: RADIO_BOX;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("RadioBox");
		end;

	
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
