indexing

	description:
		"A String resource with an edit field.";
	date: "$Date$";
	revision: "$Revision$"

class FONT_PREF_RES

inherit
	PREFERENCE_RESOURCE
		rename
			make as form_make
		redefine
			associated_resource, validate
		end

creation
	make

feature {NONE} -- Initialization

	make (a_resource: FONT_RESOURCE; new_parent: COMPOSITE) is
			-- Initialize Current with `a_resource' as `associated_resource',
			-- and `new_parent' as `a_parent'.
		require
			a_resource_not_void: a_resource /= Void;
			new_parent_not_void: new_parent /= Void
		do
			associated_resource := a_resource;
			a_parent := new_parent
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			if text /= Void then
				if text.text.empty then
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

feature {PREFERENCE_CATEGORY} -- User Interface

	display is
			-- Display Current
		do
			init;
			text.enable_resize_width;
			text.set_single_line_mode;
			if associated_resource.value /= Void then
				text.set_text (associated_resource.value)
			end
		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if text = Void or else ar.value.is_equal (text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				if ar.value /= Void then
					if ar.value @ 1 /= '%"' then
						file.putchar ('%"')
					end
					file.putstring (ar.value)
					if ar.value @ ar.value.count /= '%"' then
						file.putchar ('%"')
					end
				end
			else
				if not text.text.empty then
					if text.text @ 1 /= '%"' then
						file.putchar ('%"')
					end
					file.putstring (text.text)
					if text.text @ text.text.count /= '%"' then
						file.putchar ('%"')
					end
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
				((font = Void and then not text.text.empty) or else
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
			!! new_res.make (associated_resource.name, text.text);
			!! Result.make (associated_resource, new_res)
		end

feature {NONE} -- Initialization

	init is
			-- Create and attach widgets to Current
		do
			form_make ("", a_parent);

			!! name_label.make (associated_resource.name, Current);
			!! text.make ("", Current);
			text.add_activate_action (Current, Void);

			attach_top (name_label, 1);
			attach_bottom (name_label, 1);
			attach_left (name_label, 1);

			attach_top (text, 1);
			attach_bottom (text, 1);
			attach_left_widget (name_label, text, 5);
			attach_right (text, 1)
		end

feature {NONE} -- Properties

	associated_resource: FONT_RESOURCE;
			-- Resource Current represnts

	text: TEXT
			-- Edit box to represent Current's value

end -- class STRING_PREF_RES
