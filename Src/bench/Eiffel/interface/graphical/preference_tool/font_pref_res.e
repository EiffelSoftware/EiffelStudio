indexing

	description:
		"A String resource with an edit field.";
	date: "$Date$";
	revision: "$Revision$"

class FONT_PREF_RES

inherit
	PREFERENCE_RESOURCE
		redefine
			associated_resource, validate, execute
		end

creation
	make

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			if text /= Void then
				if text.text.is_empty then
					is_resource_valid := True
				else
					is_resource_valid := associated_resource.is_valid (text.text)
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
			if associated_resource.value = Void then
				text.set_text ("")
			else
				text.set_text (associated_resource.value)
			end
		end;

feature {PREFERENCE_CATEGORY} -- User Interface

	init (a_parent: COMPOSITE) is
			-- Display Current
		do
			form_make ("", a_parent);

			!! name_label.make (associated_resource.visual_name, Current);
			!! text.make ("", Current);
			text.add_activate_action (Current, Void);
			text.add_button_press_action (3, Current, font_action);

			attach_top (name_label, 1);
			attach_bottom (name_label, 1);
			attach_left (name_label, 1);

			attach_top (text, 1);
			attach_bottom (text, 1);
			attach_left_widget (name_label, text, 5);
			attach_right (text, 1)

			text.add_activate_action (Current, Void);
		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if text = Void or else equal (ar.value, text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				if ar.value = Void or else ar.value.is_empty then
					file.putstring ("%"%"")
				else
					file.putchar ('%"')
					file.putstring (ar.value)
					file.putchar ('%"')
				end
			else
				if text.text.is_empty then
					file.putstring ("%"%"")
				else
					file.putchar ('%"')
					file.putstring (text.text)
					file.putchar ('%"')
				end
			end
		end;

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		local
			font: FONT
		do
			font := associated_resource.actual_value;
			if 	
				text /= Void and then 
				((font = Void and then not text.text.is_empty) or else
				(font /= Void and then not font.name.is_equal (text.text)))
			then
				Result := True
			end
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			!! new_res.make_with_values (associated_resource.name, text.text);
			!! Result.make (associated_resource, new_res)
		end

feature -- Execution

	execute (arg: ANY) is
			-- Execute command.
		local
			font_name: STRING
		do
			if arg = font_action then
				get_font_box
				popup_font_box
			elseif arg = fb_ok_action then
				font_name := font_box.font.name;
				if font_name /= Void then	
					text.set_text (font_name)
				end;
				font_box.popdown;
				font_box.remove_ok_action (Current, fb_ok_action)
				font_box := Void
			elseif arg = fb_cancel_action then
				font_box.popdown;
				font_box.remove_ok_action (Current, fb_ok_action)
				font_box := Void
			else
				{PREFERENCE_RESOURCE} Precursor (arg)
			end
		end;

feature {NONE} -- Implementation

	associated_resource: FONT_RESOURCE;
			-- Resource Current represnts

	text: TEXT_FIELD
			-- Edit box to represent Current's value

	font_action, fb_ok_action, fb_cancel_action: ANY is
		once
			!! Result
		end

	font_box: FONT_BOX_D
			-- Current opened FONT_BOX_D.

	get_font_box is
			-- Font box dialog
		local
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor;
			!! font_box.make ("Font Box", text.top);
			font_box.set_font (associated_resource.actual_value)
			font_box.hide_apply_button;
			font_box.add_cancel_action (Current, fb_cancel_action);
			font_box.set_default_position (False);
			font_box.set_exclusive_grab;
			mp.restore
		end;

	popup_font_box is
			-- Popup the font box.
		local
			new_x, new_y: INTEGER;
			p: COMPOSITE
		do	
			p := font_box.parent;
			new_x := p.x + (p.width - font_box.width) // 2;
			new_y := p.y + (p.height - font_box.height) // 2;
			if new_x + font_box.width > font_box.screen.width then
				new_x := font_box.screen.width - width
			elseif new_x < 0 then
				new_x := 0
			end;
			if new_y + font_box.height > font_box.screen.height then
				new_y := font_box.screen.height - font_box.height
			elseif new_y < 0 then
				new_y := 0
			end;
			font_box.set_x_y (new_x, new_y);
			font_box.add_ok_action (Current, fb_ok_action);
			font_box.popup;
		end

end -- class FONT_PREF_RES
