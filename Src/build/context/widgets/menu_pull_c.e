-- Submenu type

class MENU_PULL_C 

inherit

	PULLDOWN_C
		rename
			create_context as old_create_context,
			full_name as pulldown_full_name
		redefine
			stored_node, is_selectionable, widget,
			add_widget_callbacks, is_valid_parent,
			is_able_to_be_grouped, 
			is_movable, remove_widget_callbacks
		end;
	PULLDOWN_C
		redefine
			stored_node, create_context, full_name,
			is_selectionable, widget, add_widget_callbacks,
			is_valid_parent, is_able_to_be_grouped,
			is_movable, remove_widget_callbacks
		select
			create_context, full_name
		end;
-- samik	G_ANY

feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.submenu_type
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.menu_pull_pixmap
		end;

	add_widget_callbacks is
		local
			ms_win: STRING
			mode_backup: INTEGER
		do
			mode_backup := executing_or_editing_mode
			set_mode (editing_mode)
			ms_win := "MS_WINDOWS";
			if not ms_win.is_equal (toolkit.name) then
				add_common_callbacks (widget.button);
				initialize_transport;
				if (parent = Void) or else not parent.is_group_composite then
					widget.button.add_enter_action (eb_selection_mgr, parent);
				end
			end;
			set_mode (mode_backup)
		end;

	remove_widget_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		local
			ms_win: STRING
		do
			ms_win := "MS_WINDOWS";
			if not ms_win.is_equal (toolkit.name) then
				widget.button.remove_pointer_motion_action (Eb_selection_mgr,
					first_arg)
				widget.button.remove_enter_action (Eb_selection_mgr, parent);
			end
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.pulldown_sm_form_nbr,
						Context_const.Submenu_format_nbr);
		end;

	is_valid_parent (parent_context: COMPOSITE_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
			--| Valid if parent is not MENU_C
		local
			menu_c: MENU_C
		do
			menu_c ?= parent_context;
			Result :=  menu_c /= Void
		end;

	is_able_to_be_grouped: BOOLEAN is
		do
			Result := False
		end

	is_movable: BOOLEAN is
		do
			Result := False
		end;

feature 

	create_oui_widget (a_parent: MENU) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: MENU_PULL;

	is_selectionable: BOOLEAN is
			-- Is current context selectionnable
		do
		end;

	full_name: STRING is
		local
			mp: MENU_PULL_C;
		do
			mp ?= parent;
			if mp = Void then
				result := parent.intermediate_name;
				result.append (".");
				result.append (entity_name);
			else
				result := intermediate_name;
				result.append (".");
				result.append (entity_name);
			end;
		end;

	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Submenu");
		end;

	
feature 

	eiffel_type: STRING is "MENU_PULL";

	full_type_name: STRING is "Menu pull"

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			menu_c: MENU_C
		do
			menu_c ?= a_parent;
			if menu_c /= Void then
				Result := old_create_context (menu_c);
				Result.widget.manage;
				--shake_parent (menu_c);
			end;
		end;

	
feature {NONE}

	shake_parent (a_parent: CONTEXT) is
		do
			a_parent.set_x_y (a_parent.x, a_parent.y);
			a_parent.set_size (a_parent.width, a_parent.width);
		end

	
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
