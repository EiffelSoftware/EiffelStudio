

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
			create_context as old_create_context
			--, cut as pulldown_cut,
			--undo_cut as pulldown_undo_cut
		redefine
			reset_widget_callbacks, remove_widget_callbacks, 
			add_widget_callbacks, stored_node, initialize_transport,
			is_selectionnable, widget
		end;

	PULLDOWN_C
		redefine
			reset_widget_callbacks, remove_widget_callbacks, 
			add_widget_callbacks, initialize_transport, 
--			 undo_cut, cut, 
			stored_node, create_context,
			is_selectionnable, widget
		select
			create_context
--			, cut, undo_cut
		end



	
feature 

	context_type: CONTEXT_TYPE is
		do
			Result := context_catalog.submenu_type
		end;

	
feature {NONE}

	add_widget_callbacks is
		do 
			add_common_callbacks (widget.button);
			initialize_transport;
			if (parent = Void) or else not parent.is_group_composite then
				widget.button.add_enter_action (eb_selection_mgr, parent);
			end;
		end;
	
	initialize_transport is
		do
			widget.button.add_button_press_action (2, show_command, Current);
			widget.button.add_button_release_action (2, show_command, Nothing);
			widget.button.add_button_press_action (3, transport_command, Current);
		end;

	remove_widget_callbacks is 
		do 
			widget.button.remove_button_press_action (2, show_command, Current);
			widget.button.remove_button_release_action (2, show_command, Nothing);
			widget.button.remove_button_press_action (3, transport_command, Current);
		end;

	reset_widget_callbacks is 
		do 
		end;

	
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



	forbid_recompute_size is
		do
		end;


	allow_recompute_size is
		do
		end;


	widget_set_center_alignment is
		do
		end;

	widget_set_left_alignment is
		do
		end;

  -- cut features superceded
	--cut is
	--	do
	--		pulldown_cut;
	--		--shake_parent (parent.parent);
	--	end;

	--undo_cut is
	--	do
	--		pulldown_undo_cut;
	--		--shake_parent (parent.parent);
	--	end;

-- ****************
-- Storage features
-- ****************

	stored_node: S_MENU_PULL is
		do
			!!Result.make (Current);
		end;

end
