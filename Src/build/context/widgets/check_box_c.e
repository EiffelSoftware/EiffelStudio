
class CHECK_BOX_C 

inherit

	PIXMAPS
		rename
			Check_box_pixmap as symbol
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
			Result := context_catalog.set_page.check_box_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: CHECK_BOX;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("CheckBox");
		end;

	
feature 

	eiffel_type: STRING is "CHECK_BOX";

-- ****************
-- Storage features
-- ****************

	stored_node: S_CHECK_BOX is
		do
			!!Result.make (Current);
		end;

end
