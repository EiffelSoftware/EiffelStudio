indexing

	description:
		"A String resource with an edit field."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STRING_RESOURCE_DISPLAY

inherit
	EB_LINE_RESOURCE_DISPLAY
		redefine
			resource, validate,
			make_with_resource
		end

creation
	make_with_resource

feature {NONE} -- Initialization

	make_with_resource (a_parent: EV_CONTAINER; a_resource: like resource) is
			-- Create display
		local
			s: STRING
				-- used for appending `" : "'
		do
			Precursor (a_parent, a_resource)

			s := clone (a_resource.visual_name)
			s.append (" : ")
			Create name_label.make_with_text (Current, s)
			name_label.set_right_alignment
			name_label.set_minimum_width (100)

			Create text.make_with_text (Current, a_resource.value)
			text.set_minimum_width (200)
			text.set_expand (True)

--			text.add_activate_command (Current, Void)

		end

feature -- Status report

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not equal (resource.value, text.text) then
				Result := True
			end
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			if text /= Void then
				if not text.text.empty then
					is_resource_valid := resource.is_valid (text.text)
				else
					is_resource_valid := True
				end
			else
				is_resource_valid := True
			end
			if not is_resource_valid then
				raise_warner ("a string")
			end
		end

feature -- Element change

	reset is
			-- Reset the text field.
		local
			txt: STRING
		do
			txt := resource.value
			if txt /= Void then
				text.set_text (txt)
			end
		end


feature {EB_ENTRY_PANEL} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like resource
			quotation_added: BOOLEAN
		do
			ar := resource
			if text = Void or else equal (ar.value, (text.text)) then
					--| text /= Void means text has been displayed
					--| and thus the user could have changed the value.
				if ar.value = Void or else ar.value.empty then
					file.putstring ("%"%"")
				else
					if ar.value @ 1 /= '%"' then
						file.putchar ('%"')
						quotation_added := true
					end
					file_putstring (file, ar.value)
					if quotation_added then
						file.putchar ('%"')
					end
				end
			elseif text.text.empty then
				file.putstring ("%"%"")
			else
				if text.text @ 1 /= '%"' then
					file.putchar ('%"')
					quotation_added := true
				end
				file_putstring (file, text.text)
				if quotation_added then
					file.putchar ('%"')
				end
			end
		end

	file_putstring (file: PLAIN_TEXT_FILE; s: STRING) is
		local
			index: INTEGER
			temp: STRING
			finished: BOOLEAN
		do
			if s.has ('%"') then
				from
					temp := clone (s)
					index := temp.index_of ('%"', 1)
				until
					index = 0 or finished
				loop
					temp.insert ("%%", index)
					index := index + 2
					if index < temp.count then
						index := temp.index_of ('%"', index)
					else
						finished := true
					end
				end

				file.putstring (temp)
			else
				file.putstring (s)
			end
		end

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_with_values (resource.name, text.text)
			!! Result.make (resource, new_res)
		end

feature {NONE} -- Implementation

	resource: EB_STRING_RESOURCE
			-- Resource Current represnts

	text: EV_TEXT_FIELD
			-- Edit box to represent Current's value

end -- class EB_STRING_RESOURCE_DISPLAY
