

class ARROW_B_C 

inherit

	BUTTON_C
		rename
			copy_attributes as button_copy_attributes,
			context_initialization as old_context_initialization,
			reset_modified_flags as button_reset_modified_flags,
			create_context as button_create_context
		redefine
			stored_node, is_fontable, widget,
			add_to_option_list, retrieve_set_visual_name
		end;
	BUTTON_C
		redefine
			create_context, stored_node, reset_modified_flags, 
			copy_attributes, is_fontable, context_initialization,
			add_to_option_list, widget, retrieve_set_visual_name
		select
			copy_attributes, context_initialization, reset_modified_flags,
			create_context
		end;
	
feature 

	symbol: PIXMAP is
		do
			Result := Pixmaps.arrow_b_pixmap
		end;

	type: CONTEXT_TYPE is
		do
			Result := context_catalog.primitive_page.arrow_b_type
		end

	create_oui_widget (a_parent: COMPOSITE) is
		do
			!!widget.make_unmanaged (entity_name, a_parent);
		end;

	widget: ARROW_B;

feature -- Default event

	default_event: BUT_ACT_EV is
		do
			Result := but_act_ev
		end
	
feature {NONE}

	namer: NAMER is
		once
			!!Result.make ("Arrow_b");
		end;
	
	add_to_option_list (opt_list: ARRAY [INTEGER]) is
		do
			opt_list.put (Context_const.geometry_form_nbr,
							Context_const.Geometry_format_nbr);
			opt_list.put (Context_const.arrow_b_att_form_nbr,
							Context_const.Attribute_format_nbr);
		end;

	retrieve_set_visual_name (s: STRING) is
		do
			visual_name := clone (s);
		end;

feature 

	eiffel_type: STRING is "ARROW_B";

	full_type_name: STRING is "Arrow button"

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Create a context of the same type
		do
			Result := button_create_context (a_parent);
			if (widget = Void) and Result /= Void then
				Result.set_direction (direction)
			end;
		end;

feature -- Context attributes

	is_fontable: BOOLEAN is
			-- Is current context fontable
		do
			Result := false
		end;

	direction: INTEGER;

	direction_modified: BOOLEAN;

	set_direction (new_direction: INTEGER) is
			-- Set the direction of the arrow
		do
			direction_modified := True;
			direction := new_direction;
			if not (widget = Void) then
				if new_direction = Context_const.up_arrow_direction then
					widget.set_up
				elseif new_direction = Context_const.down_arrow_direction then
					widget.set_down
				elseif new_direction = Context_const.right_arrow_direction then
					widget.set_right
				else
					widget.set_left
				end;
			end;
		end;

	reset_modified_flags is
		do
			button_reset_modified_flags;
			direction_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if direction_modified then
				other_context.set_direction (direction);
			end;
			button_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		local
			func_name: STRING;
		do
			Result := old_context_initialization (context_name);
			if direction_modified then
				if direction = Context_const.down_arrow_direction then
					func_name := "set_down"
				elseif direction = Context_const.left_arrow_direction then
					func_name := "set_left"
				elseif direction = Context_const.right_arrow_direction then
					func_name := "set_right"
				else
					func_name := "set_up"
				end;
				function_to_string (Result, context_name, func_name);
			end;
		end;

-- ****************
-- Storage features
-- ****************

	
feature 

	stored_node: S_ARROW_B is
		do
			!!Result.make (Current);
		end;

end
