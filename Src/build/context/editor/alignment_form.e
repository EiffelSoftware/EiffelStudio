indexing
	description: "Page representing the alignment properties."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class ALIGNMENT_FORM 

inherit

	WINDOWS
		select
			init_toolkit
		end
	COMMAND
	EDITOR_OK_FORM

creation

	make
	
feature -- Interface
	
	vertical: TOGGLE_B

	make_visible (a_parent: COMPOSITE) is
		local	
			radio_box_direction: RADIO_BOX
			radio_box_point: RADIO_BOX
			a_separator: SEPARATOR
		do	
			initialize (Widget_names.alignment_form_name, a_parent)
			create_ok_button

--			set_size (200, 350)

			detach_top (separator)
			!! context_list.make (Widget_names.widget_list_name, Current)
			!! reference.make (Widget_names.reference_name, Current)
			!! align_hole.make (Widget_names.context_name, Current)
			!! radio_box_direction.make (Widget_names.radio_box, Current)
			!! radio_box_point.make (Widget_names.radio_box1, Current)
			!! a_separator.make (Widget_names.separator, Current)

			!! vertical.make (Widget_names.vertically_name, 
					radio_box_direction)
			!! horizontal.make (Widget_names.horizontally_name, 
					radio_box_direction)
			horizontal.arm

			!! top_left.make (Widget_names.top_left_name, radio_box_point)
			!! center.make (Widget_names.center_name, radio_box_point)
			!! bottom_right.make (Widget_names.bottom_right_name, radio_box_point)
			top_left.arm

			!! offset.make (Widget_names.offset_name, Current)
			!! offset_value.make (Widget_names.scale, Current)
			offset_value.set_horizontal (True)
			offset_value.set_maximum_right_bottom (true)
			offset_value.show_value (True)
			offset_value.set_size (110, 50)
			offset_value.add_value_changed_action (Current, offset_value)
			offset_value.set_minimum (0)
			offset_value.set_maximum (100)

			attach_left (reference, 10)
			--attach_right_position (reference, 5)
			attach_left_position (align_hole, 70)
			attach_right (align_hole, 10)

			attach_left (a_separator, 0)
			attach_right (a_separator, 0)

			attach_left (radio_box_direction, 10)
			attach_left (radio_box_point, 10)
			attach_left_widget (radio_box_direction,context_list, 20)
			attach_right (context_list, 10)

			attach_left (offset, 10)
			attach_left (offset_value, 10)

			attach_top (reference, 10)
			attach_top (align_hole, 10)
			attach_top_widget (reference, a_separator, 10)
			attach_top_widget (a_separator, radio_box_direction, 10)
			attach_top_widget (a_separator, context_list, 10)
			attach_top_widget (radio_box_direction, radio_box_point, 10)
			attach_top_widget (radio_box_point, offset, 10)
			attach_top_widget (offset, offset_value, 10)
			attach_top_widget (context_list, separator, 5)
			attach_top_widget (offset_value, separator, 5)
--			attach_bottom_widget (separator, context_list, 5)
--			attach_bottom_widget (separator, offset_value, 5)
			radio_box_direction.set_always_one (True)
			radio_box_point.set_always_one (True)
			show_current
		end

	reset_list is
			-- Reset the context list
		do
			context_list.wipe_out
		end

	unregister_holes is
		do
			if is_initialized then
				reference.unregister
				align_hole.unregister
				context_list.unregister_holes
			end
		end

feature {ALIGNMENT_HOLE}

	reference_context: CONTEXT is
		do
			Result := reference.context
		end

	clear_alignment_box is
		do
			context_list.wipe_out
		end

	add_item (item: CONTEXT) is
			-- Add an `item' in the list of context.
		local
			found: BOOLEAN
		do
			from
				context_list.start
			until
				found or else context_list.after
			loop
				if context_list.item.data = item then
					found := true
				else
					context_list.forth
				end
			end
			if not found then
				context_list.extend (item)
			end
		end

feature {ALIGNMENT_CMD}

	context_list: ALIGNMENT_BOX
			-- Contexts to align with reference
	
feature {NONE}

	apply is
		local
			a_context: CONTEXT
			ref_context: CONTEXT
			new_x, new_y: INTEGER
			list_width, list_height: INTEGER
			i: INTEGER
		do
			if reference.context /= Void then
				ref_context := reference.context
				list_width := ref_context.width
				list_height := ref_context.height
				from
					context_list.start
				until	
					context_list.after
				loop
					a_context := context_list.item.data
					if not a_context.deleted then
						i := i + 1
						if vertical.state then
							if offset.state then
								new_y := ref_context.y + 
											i * offset_value.value 
											+ list_height	
							else
								new_y := ref_context.y
							end
							if top_left.state then
								new_x := ref_context.x
							elseif center.state then
								new_x := ref_context.x + 
											ref_context.width // 2 
											- a_context.width // 2
							else
								new_x := ref_context.x + 
											ref_context.width 
											- a_context.width
							end
						else
							if offset.state then
								new_x := ref_context.x + 
											i * offset_value.value 
											+ list_width
							else
								new_x := ref_context.x
							end
							if top_left.state then
								new_y := ref_context.y
							elseif center.state then
								new_y := ref_context.y + 
											ref_context.height // 2 
											- a_context.height // 2
							else
								new_y := ref_context.y + 
											ref_context.height 
											- a_context.height
							end
						end
						a_context.set_x_y (new_x, new_y)
						context_catalog.update_editors (a_context, 
											Context_const.geometry_form_nbr)
						list_width := list_width + a_context.width
						list_height := list_height + a_context.height
					end
					context_list.forth
				end
			end
		end

feature {NONE} 

	reference: REFERENCE_HOLE
			-- Reference for the alignment

	align_hole: ALIGNMENT_HOLE
			-- Hole for adding new contexts

	horizontal: TOGGLE_B

	top_left, center, bottom_right: TOGGLE_B

	offset: TOGGLE_B

	offset_value: SCALE

	form_number: INTEGER is
		do
			Result := Context_const.alignment_form_nbr
		end

	format_number: INTEGER is
		do
			Result := Context_const.align_format_nbr
		end

	command: ALIGNMENT_CMD is
		once
			!!  Result
		end

	reset is
		do
			reference.reset
				--| Next line: To be able to see the label of `align_hole' on
				--| Windows 95.
			align_hole.set_managed (True)
			horizontal.arm
			top_left.arm
			offset.arm
			reset_list
		end

	execute (argument: ANY) is
		do
			offset.arm
		end

end
