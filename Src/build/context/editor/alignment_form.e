
class ALIGNMENT_FORM 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	COMMAND
		export
			{NONE} all
		end;
	CONTEXT_CMDS
		rename
			alignment_cmd as command
		export
			{NONE} all
		end;
	EDITOR_OK_FORM
		export
			{ANY} all
		undefine
			init_toolkit
		redefine
			form_name
		end


creation

	make

	
feature 

	form_name: STRING is
			-- Name of the form in the menu
		do
			Result := A_lignment_form_name
		end;

	
feature {ALIGNMENT_CMD}

	context_list: ALIGNMENT_BOX;
			-- Contexts to align with reference

	
feature {NONE}

	reference: REFERENCE_HOLE;
			-- Reference for the alignment

	
feature 

	reference_context: CONTEXT is
		do
			Result := reference.context
		end;

	
feature {NONE}

	align_hole: ALIGNMENT_HOLE;
			-- Hole for adding new contexts

	vertical, horizontal: TOGGLE_B;

	top_left, center, bottom_right: TOGGLE_B;

	offset: TOGGLE_B;

	offset_value: SCALE;

	
feature 

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, alignment_form_number);
		end;

	make_visible (a_parent: CONTEXT_EDITOR) is
		local	
			radio_box_direction: RADIO_BOX;
			radio_box_point: RADIO_BOX;
			a_separator: SEPARATOR_G;
		do	
			initialize (A_lignment_form_name, a_parent);
			create_ok_button;
			detach_top (separator);
			!!context_list.make (W_idget_list, Current);
			!!reference.make (R_eference, Current);
			!!align_hole.make (C_ontext, Current);
			!!radio_box_direction.make (R_adio_box, Current);
			!!radio_box_point.make (R_adio_box, Current);
			!!a_separator.make (S_eparator, Current);

			!!vertical.make (V_ertically, radio_box_direction);
			!!horizontal.make (H_orizontally, radio_box_direction);
			horizontal.arm;

			!!top_left.make (T_op_left, radio_box_point);
			!!center.make (C_enter, radio_box_point);
			!!bottom_right.make (B_ottom_right, radio_box_point);
			top_left.arm;

			!!offset.make (O_ffset, Current);
			!!offset_value.make (S_cale, Current);
			offset_value.set_maximum_right_bottom (true);
			offset_value.set_horizontal (true);
			offset_value.show_value (true);
			offset_value.set_size (110, 15);
			offset_value.add_value_changed_action (Current, offset_value);

			attach_left (reference, 10);
			attach_right_position (reference, 5);
			attach_left_position (align_hole, 11);
			attach_right (align_hole, 10);

			attach_left (a_separator, 10);
			attach_right (a_separator, 10);

			attach_left (radio_box_direction, 10);
			attach_left (radio_box_point, 10);
			attach_left_widget (radio_box_direction,context_list, 20);
			attach_right (context_list, 10);

			attach_left (offset, 10);
			attach_left (offset_value, 10);

			attach_top (reference, 10);
			attach_top (align_hole, 10);
			attach_top_widget (reference, a_separator, 10);
			attach_top_widget (a_separator, radio_box_direction, 10);
			attach_top_widget (a_separator, context_list, 10);
			attach_top_widget (radio_box_direction, radio_box_point, 10);
			attach_top_widget (radio_box_point, offset, 10);
			attach_top_widget (offset, offset_value, 10);
			attach_bottom_widget (separator, context_list, 5);
			attach_bottom_widget (separator, offset_value, 5);
			radio_box_direction.set_always_one (True);
			radio_box_point.set_always_one (True);
		end;

	
feature {NONE}

	reset is
		do
			reference.reset;
			horizontal.arm;
			top_left.arm;
			offset.disarm;
			reset_list
		end;

	
feature 

	reset_list is
			-- reset the context list
		do
			context_list.wipe_out
		end;

	apply is
		local
			a_context: CONTEXT;
			ref_context: CONTEXT;
			new_x, new_y: INTEGER;
			list_width, list_height: INTEGER;
			i: INTEGER;
		do
			if not (reference.stone = Void) then
				ref_context := reference.context;
				list_width := ref_context.width;
				list_height := ref_context.height;
				from
					context_list.start
				until	
					context_list.after
				loop
					a_context := context_list.item.original_stone;
					i := i + 1;
					if vertical.state then
						if offset.state then
							new_y := ref_context.y + i * offset_value.value + list_height	
						else
							new_y := a_context.y
						end;
						if top_left.state then
							new_x := ref_context.x
						elseif center.state then
							new_x := ref_context.x + ref_context.width // 2 - a_context.width // 2
						else
							new_x := ref_context.x + ref_context.width - a_context.width
						end
					else
						if offset.state then
							new_x := ref_context.x + i * offset_value.value + list_width
						else
							new_x := a_context.x
						end;
						if top_left.state then
							new_y := ref_context.y
						elseif center.state then
							new_y := ref_context.y + ref_context.height // 2 - a_context.height // 2
						else
							new_y := ref_context.y + ref_context.height - a_context.height
						end
					end;
					a_context.set_x_y (new_x, new_y);
					--context_catalog.update_editors (a_context, geometry_form_number);
					list_width := list_width + a_context.width;
					list_height := list_height + a_context.height;
					context_list.forth;
				end;
			end;
		end;

	add_item (item: CONTEXT) is
			-- add an item in the list of context
		local
			found: BOOLEAN;
		do
			from
				context_list.start
			until
				found or else context_list.after
			loop
				if context_list.item.original_stone = item then
					found := true
				else
					context_list.forth
				end;
			end;
			if not found then
				context_list.extend (item);
			end;
		end;

	
feature {NONE}

	execute (argument: ANY) is
		do
			offset.arm
		end;

end
