

class MENU_ENTRY_C 

inherit

	PIXMAPS
		rename
			Menu_entry_pixmap as symbol
		export
			{NONE} all
		end;

	BUTTON_C
		rename
			create_context as button_create_context
		redefine
			add_widget_callbacks,
			stored_node, option_list, is_selectionnable, widget
		end;

	BUTTON_C
		redefine
			add_widget_callbacks,
			stored_node, option_list, is_selectionnable, create_context, widget
		select
			create_context
		end
	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.menu_entry_type
		end;

	
feature {NONE}

	add_widget_callbacks is do end;

	editor_form_cell: CELL [INTEGER] is
        once
            !!Result.put (0)
        end;

	
feature 

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: PUSH_B;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Menu_entry");
		end;
	
feature 

	eiffel_type: STRING is "PUSH_B";

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			menu: MENU_C;
		do
			menu ?= a_parent;
			if not (menu = Void) then
				Result := button_create_context (a_parent);
			end;
		end;

	is_selectionnable: BOOLEAN is
			-- Is current context selectionnable
		do
			Result := False
		end;

	option_list: ARRAY [INTEGER] is
		do
			!!Result.make (1, 1);
			Result.put (label_text_form_number, 1);
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_MENU_ENTRY is
		do
			!!Result.make (Current);
		end;

end
