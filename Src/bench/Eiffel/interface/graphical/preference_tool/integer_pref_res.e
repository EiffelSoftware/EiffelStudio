indexing

	description:
		"An Integer resource with an edit field.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_PREF_RES

inherit
	PREFERENCE_RESOURCE
		rename
			make as form_make
		redefine
			associated_resource
		end;
	COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_resource: INTEGER_RESOURCE; new_parent: COMPOSITE) is
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
		local
			str: STRING;
			warning_d: WARNING_D;
			msg: STRING
		do
			if text /= Void then
				str := text.text;
				if not str.is_equal (associated_resource.value) then
					if not str.is_integer then
						is_resource_valid := False;
						!! warning_d.make ("Warning", Current);
						!! msg.make (0);
						msg.append ("Resource `");
						msg.append (associated_resource.name);
						msg.append ("' must be an integer.");
						warning_d.set_message (msg);
						warning_d.hide_help_button;
						warning_d.hide_cancel_button;
						warning_d.add_ok_action (Current, warning_d);
						warning_d.popup;
						warning_d.raise
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

feature {PREFERENCE_CATEGORY} -- User Interface

	display is
			-- Display Current
		--local
			--int: INTEGER
		do
			init;
			text.enable_resize_width;
			text.set_text (associated_resource.value);
			text.set_single_line_mode
		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current to `file'.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if text = Void or else ar.value.is_equal (text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				file.putstring (ar.value)
			else
				file.putstring (text.text)
			end;
		end

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not associated_resource.value.is_equal (text.text) then
				Result := True
			end
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			!! new_res.make (associated_resource.name, text.text.to_integer);
			!! Result.make (associated_resource, new_res)
		end

feature {NONE} -- Initialization

	init is
			-- Create and attach widgets to Current
		do
			form_make ("", a_parent);

			!! name_label.make (associated_resource.name, Current);
			!! text.make ("", Current);

			attach_top (name_label, 1);
			attach_bottom (name_label, 1);
			attach_left (name_label, 1);

			attach_top (text, 1);
			attach_bottom (text, 1);
			attach_left_widget (name_label, text, 5);
			attach_right (text, 1)
		end

feature {NONE} -- Properties

	associated_resource: INTEGER_RESOURCE;
			-- Resource Current represnts

	text: TEXT
			-- Text field to represent Current's value

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute Current
		local
			wd: WARNING_D
		do
			wd ?= arg;
			if wd /= Void then
				wd.popdown;
				wd.destroy
			end
		end

end -- class STRING_PREF_RES
