

class TOGGLE_B_C 

inherit

	BUTTON_C
		rename
			context_initialization as old_context_initialization,
			set_size as old_set_size
		redefine
			stored_node, widget, is_able_to_be_grouped, 
			add_to_option_list, is_valid_parent,
			update_visual_name_in_editor
		end
	BUTTON_C
		redefine
			stored_node, widget, is_able_to_be_grouped, 
			add_to_option_list, context_initialization,
			is_valid_parent, set_size, update_visual_name_in_editor
		select
			context_initialization, set_size
		end

feature 

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.toggle_b_type
		end;

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
			disable_resize_policy (True);
			set_left_alignment (False);
		end;

	widget: TOGGLE_B;

	symbol: PIXMAP is
		do
			Result := Pixmaps.toggle_b_pixmap
		end;

	is_able_to_be_grouped: BOOLEAN is
			-- Is Current toggle able to be grouped?
		do
			Result := not parent.is_group_composite and
						then not is_in_a_group
		end;

	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
						Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.toggle_att_form_nbr,
						Context_const.Attribute_format_nbr);
		end;

	update_visual_name_in_editor is
		local
			editor: CONTEXT_EDITOR
		do
			editor := context_catalog.editor (Current,
					Context_const.toggle_att_form_nbr);
			if editor /= Void then
				editor.reset_current_form
			end;
		end;

	is_valid_parent (parent_context: COMPOSITE_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
			--| Valid if parent is not MENU_C
		local
			menu_c: MENU_C
		do
			menu_c ?= parent_context;
			Result := menu_c = Void
		end

feature -- Default event

	default_event: VALUE_CHANGED_EV is
		do
			Result := value_changed_ev
		end

feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			Result := old_context_initialization (context_name);
			if is_armed_modified then
				cond_f_to_string (Result, is_armed, context_name,
					"set_toggle_on",
					"set_toggle_off");
			end
		end;

feature

	is_armed: BOOLEAN;

	is_armed_modified: BOOLEAN;

	set_is_armed (flag: BOOLEAN) is
		local
			rb: RADIO_BOX_C
		do
			rb ?= parent;
			if rb /= Void then
				rb.unarm_all_toggles_except (Current)
			end;
			set_toggle_state (flag);
		end;

	set_size (new_w, new_h: INTEGER) is
			-- Set new size of Current and update
			-- all children of parent if necessary.
		local
			group_comp: GROUP_COMPOSITE_C
		do
			old_set_size (new_w, new_h)
				-- Not while retrieving
			if retrieved_node = Void then
				group_comp ?= parent
				if group_comp /= Void then
					group_comp.update_form_for_all_children (Context_const.geometry_form_nbr)
				end
			end
		end;

feature {RADIO_BOX_C, S_TOGGLE_B_R333}

	set_toggle_state (flag: BOOLEAN) is
		do
			is_armed_modified := True;
			is_armed := flag;
			if flag then
				widget.set_toggle_on
			else
				widget.set_toggle_off
			end
		end

feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Toggle_b");
		end;

feature 

	eiffel_type: STRING is "TOGGLE_B";

	full_type_name: STRING is "Toggle button"

-- ****************
-- Storage features
-- ****************

	stored_node: S_TOGGLE_B_R333 is
		local
			foobar: S_TOGGLE_B
		do
			!!Result.make (Current);
			if foobar = Void then end;
				-- So it won't be dead code removed
		end;

end
