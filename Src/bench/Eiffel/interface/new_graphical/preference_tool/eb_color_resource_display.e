indexing
 
	description:
		"A Color resource with an edit field. Only used in the preference tool"
	date: "$Date$"
	revision: "$Revision$"
 
class EB_COLOR_RESOURCE_DISPLAY
 
inherit
	EB_LINE_RESOURCE_DISPLAY
		redefine
			resource,
			make_with_resource
		end

creation
	make_with_resource

feature {NONE} -- Initialization

	make_with_resource (par: EV_CONTAINER; a_resource: like resource) is
			-- Display Current
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1[EV_WARNING_DIALOG]
		do
			Precursor (par, a_resource)

			Create name_label.make_with_text (Current, a_resource.visual_name)
--			name_label.set_right_alignment
			name_label.set_minimum_width (100)
			Create color_button.make_with_color (Current, resource.actual_value)			
			color_button.set_horizontal_resize (False)
			color_button.set_minimum_width (50)
			color_button.set_color (resource.actual_value)

				-- Opening color dialog command creation
			Create cmd.make (~execute)
			Create arg.make (void)
			color_button.add_click_command (cmd, arg)
		end

feature -- Access

	resource: EB_COLOR_RESOURCE
			-- Resource Current represnts

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if color_button /= Void and then not resource.actual_value.is_equal (color_button.color) then
				Result := True
			end
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			is_resource_valid := true
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
			color_button.set_color (resource.actual_value)
		end

feature -- Basic operations

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current to `file'.
		local
			ar: like resource
		do
			ar := resource
			if not (color_button.destroyed) or else ar.actual_value.is_equal (color_button.color) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				file.putstring (ar.value)
			else
				file.putstring (color_button.color.name)
			end
		end

feature {EB_ENTRY_PANEL} -- Access

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_with_values (resource.name, color_button.color)
			!! Result.make (resource, new_res)
		end

feature -- Execution
 
--	execute (arg: EV_ARGUMENT, data: EV_EVENT_DATA) is
--			-- Execute command.
--		do
--			if arg = color_action then
--				popup_color_box
--			elseif arg = color_box then
--				if color_box.position /= 0 then
--					text.set_text (color_box.selected_item)
--				end
--				color_box.popdown
--			else
--				string_execute (arg)
--			end
--		end
 
feature {NONE} -- Properties
 
	color_button: EB_COLOR_BUTTON

--	color_action: ANY is
--		once
--			!! Result
--		end
--
--	color_box: CHOICE_W is
--			-- Color box dialog
--		once
--			!! Result.make (text.top)
--		end
--
--	raise_color_box is
--			-- Popup the font box.
--		local
--			new_x, new_y: INTEGER
--			p: CONTAINER
--			list: LINKED_LIST [STRING]
--			i: INTEGER
--		do	
--			p := color_box.parent
--			new_x := p.x + (p.width - color_box.width) // 2
--			new_y := p.y + (p.height - color_box.height) // 2
--			if new_x + color_box.width > color_box.screen.width then
--				new_x := color_box.screen.width - width
--			elseif new_x < 0 then
--				new_x := 0
--			end
--			if new_y + color_box.height > color_box.screen.height then
--				new_y := color_box.screen.height - color_box.height
--			elseif new_y < 0 then
--				new_y := 0
--			end
--			color_box.set_x_y (new_x, new_y)
--			color_box.popup (Current, list, Interface_names.t_Select_color)
--		end

end -- class EB_COLOR_RESOURCE_DISPLAY
