

class MENU_PULL_C 

inherit

	PIXMAPS
		rename
			Menu_pull_pixmap as symbol
		export
			{NONE} all
		end;

	PULLDOWN_C
		rename
			create_context as old_create_context,
			cut as pulldown_cut,
			undo_cut as pulldown_undo_cut
		redefine
			reset_widget_callbacks, remove_widget_callbacks, 
			add_widget_callbacks, stored_node,
			is_selectionnable, widget
		end;

	PULLDOWN_C
		redefine
			reset_widget_callbacks, remove_widget_callbacks, 
			add_widget_callbacks, undo_cut, cut, stored_node, create_context, 
			is_selectionnable, widget
		select
			create_context, cut, undo_cut
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.submenu_type
		end;

	
feature {NONE}

	add_widget_callbacks is do end;
	
	remove_widget_callbacks is do end;

	reset_widget_callbacks is do end;

	
feature 

	create_oui_widget (a_parent: MENU) is
		do
			!!widget.make (entity_name, a_parent);
		end;

	widget: MENU_PULL;

	is_selectionnable: BOOLEAN is
			-- Is current context selectionnable
		do
		end;

	
feature {NONE}

	editor_form_cell: CELL [INTEGER] is
		once
			!!Result.put (0)
		end;

	namer: NAMER is
		once
			!!Result.make ("Submenu");
		end;

	
feature 

	eiffel_type: STRING is "MENU_PULL";

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			menu_c: MENU_C
		do
			menu_c ?= a_parent;
			if not (menu_c = Void) then
				Result := old_create_context (menu_c);
				shake_parent (menu_c);
			end;
		end;

	
feature {NONE}

	shake_parent (a_parent: CONTEXT) is
		do
			a_parent.set_x_y (a_parent.x, a_parent.y);
		end;

	
feature 

	cut is
		do
			pulldown_cut;
			shake_parent (parent);
		end;

	undo_cut is
		do
			pulldown_undo_cut;
			shake_parent (parent);
		end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_MENU_PULL is
		do
			!!Result.make (Current);
		end;

end
