indexing

	description:
		"An Integer resource with an edit field."
	date: "$Date$"
	revision: "$Revision$"

class EB_INTEGER_RESOURCE_DISPLAY

inherit
	EB_LINE_RESOURCE_DISPLAY
		redefine
			resource,
			make_with_resource
		end

creation
	make_with_resource

feature {NONE} -- Initialization

	make_with_resource (a_parent: EV_CONTAINER; a_resource: like resource) is
			-- Display Current
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1[EV_WARNING_DIALOG]

			s: STRING
				-- used for appending `" : "'
		do
			Precursor (a_parent, a_resource)

			s := clone (a_resource.visual_name)
			s.append (" : ")
			Create name_label.make_with_text (Current, s)
			name_label.set_right_alignment
			name_label.set_minimum_width (100)

			Create text.make_with_text (Current, resource.value)
			text.set_minimum_width (100)

			Create cmd.make (~execute)
			Create arg.make (void)
			text.add_activate_command (cmd, arg)
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		local
			str: STRING
		do
			if text /= Void then
				str := text.text
				if not str.is_equal (resource.value) then
					if not str.is_integer then
						is_resource_valid := False
						raise_warner ("an integer")
						reset
					else
						is_resource_valid := True
					end
				else
					is_resource_valid := True
				end
			else
				is_resource_valid := True
			end
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
			text.set_text (resource.value)
		end

feature {EB_ENTRY_PANEL} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current to `file'.
		local
			ar: like resource
		do
			ar := resource
			if text = Void or else ar.value.is_equal (text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				file.putstring (ar.value)
			else
				file.putstring (text.text)
			end
		end

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not resource.value.is_equal (text.text) then
				Result := True
			end
		end

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_with_values (resource.name, text.text.to_integer)
			!! Result.make (resource, new_res)
		end

feature {NONE} -- Properties

	resource: EB_INTEGER_RESOURCE
			-- Resource Current represnts

	text: EV_TEXT_FIELD
			-- Text field to represent Current's value

end -- class EB_INTEGER_RESOURCE_DISPLAY
