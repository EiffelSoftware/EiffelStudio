indexing

	description:
		"A Font resource with an edit field."
	date: "$Date$"
	revision: "$Revision$"

class EB_FONT_RESOURCE_DISPLAY

inherit
	EB_LINE_RESOURCE_DISPLAY
		redefine
			resource, validate
		end

creation
	make_with_resource

feature -- Access

	resource: EB_FONT_RESOURCE
			-- Resource Current represnts

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		local
			font: EV_FONT
		do
			font := resource.actual_value
			if 	
				text /= Void and then 
				((font = Void and then not text.text.empty) or else
				(font /= Void and then not font.name.is_equal (text.text)))
			then
				Result := True
			end
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			if text /= Void then
				if text.text.empty then
					is_resource_valid := True
				else
					is_resource_valid := resource.is_valid (text.text)
				end
			else
				is_resource_valid := True
			end
			if not is_resource_valid then
				raise_warner ("a valid system font")
			end
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
--			if resource.value = Void then
--				text.set_text ("")
--			else
--				text.set_text (resource.value)
--			end
		end

feature {EB_ENTRY_PANEL} -- User Interface

	init (a_parent: EV_CONTAINER) is
			-- Display Current
		do
			make (a_parent)

			Create name_label.make_with_text (Current, resource.visual_name)
			Create text.make (Current)
--			text.add_activate_action (Current, Void)
--			text.add_button_press_action (3, Current, font_action)

--			text.add_activate_action (Current, Void)
		end

feature -- Basic operations

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like resource
		do
			ar := resource
			if text = Void or else equal (ar.value, text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				if ar.value = Void or else ar.value.empty then
					file.putstring ("%"%"")
				else
					if ar.value @ 1 /= '%"' then
						file.putchar ('%"')
					end
					file.putstring (ar.value)
					if ar.value @ ar.value.count /= '%"' then
						file.putchar ('%"')
					end
				end
			else
				if text.text.empty then
					file.putstring ("%"%"")
				else
					if text.text @ 1 /= '%"' then
						file.putchar ('%"')
					end
					file.putstring (text.text)
					if text.text @ text.text.count /= '%"' then
						file.putchar ('%"')
					end
				end
			end
		end

feature {EB_ENTRY_PANEL} -- Access

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_from_string (resource.name, text.text)
			!! Result.make (resource, new_res)
		end

feature -- Execution

--	execute (arg: ANY) is
--			-- Execute command.
--		local
--			font_name: STRING
--		do
--			if arg = font_action then
--				popup_font_box
--			elseif arg = fb_ok_action then
--				font_name := font_box.font.name
--				if font_name /= Void then	
--					text.set_text (font_name)
--				end
--				font_box.popdown
--				font_box.remove_ok_action (Current, fb_ok_action)
--			elseif arg = fb_cancel_action then
--				font_box.popdown
--				font_box.remove_ok_action (Current, fb_ok_action)
--			else
--				{EB_RESOURCE_DISPLAY} Precursor (arg)
--			end
--		end

feature {NONE} -- Implementation

	text: EV_TEXT_FIELD
			-- Edit box to represent Current's value

--	font_action, fb_ok_action, fb_cancel_action: ANY is
--		once
--			!! Result
--		end
--
--	font_box: FONT_BOX_D is
--			-- Font box dialog
--		local
--			mp: MOUSE_PTR
--		once
--			!! mp.set_watch_cursor
--			!! Result.make ("Font Box", text.top)
--			Result.hide_apply_button
--			Result.add_cancel_action (Current, fb_cancel_action)
--			Result.set_default_position (False)
--			Result.set_exclusive_grab
--			mp.restore
--		end
--
--	popup_font_box is
--			-- Popup the font box.
--		local
--			new_x, new_y: INTEGER
--			p: COMPOSITE
--		do	
--			p := font_box.parent
--			new_x := p.x + (p.width - font_box.width) // 2
--			new_y := p.y + (p.height - font_box.height) // 2
--			if new_x + font_box.width > font_box.screen.width then
--				new_x := font_box.screen.width - width
--			elseif new_x < 0 then
--				new_x := 0
--			end
--			if new_y + font_box.height > font_box.screen.height then
--				new_y := font_box.screen.height - font_box.height
--			elseif new_y < 0 then
--				new_y := 0
--			end
--			font_box.set_x_y (new_x, new_y)
--			font_box.add_ok_action (Current, fb_ok_action)
--			font_box.popup
--		end

end -- class EB_FONT_RESOURCE_DISPLAY
