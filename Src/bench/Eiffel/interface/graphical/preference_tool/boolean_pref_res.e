indexing

	description:
		"A Boolean resource with a toggle button.";
	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_PREF_RES

inherit
	PREFERENCE_RESOURCE
		redefine
			associated_resource
		end

create
	make

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			is_resource_valid := True
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
			if associated_resource.actual_value then
				boolean_toggle.set_toggle_on
			else
				boolean_toggle.set_toggle_off
			end;
		end;

feature {PREFERENCE_CATEGORY} -- User Interface

	init (a_parent: COMPOSITE) is
			-- Display Current
		do
			form_make ("", a_parent);

			create boolean_toggle.make (associated_resource.visual_name, Current);

			attach_top (boolean_toggle, 1);
			attach_bottom (boolean_toggle, 1);
			attach_left (boolean_toggle, 5)

		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if boolean_toggle = Void or else ar.actual_value = boolean_toggle.state then
					--| boolean_toggle /= Void means: toggle has been displayed
					--| and thus the user could have changed the value.
				file.putstring (ar.value)
			else
				file.putstring (boolean_toggle.state.out)
			end
		end;

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if boolean_toggle /= Void and then associated_resource.actual_value /= boolean_toggle.state then
				Result := True
			end
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			create new_res.make_with_values (associated_resource.name, boolean_toggle.state);
			create Result.make (associated_resource, new_res)
		end

feature {NONE} -- Properties

	associated_resource: BOOLEAN_RESOURCE;
			-- Resource Current represnts

	boolean_toggle: TOGGLE_B
			-- Toggle to represent Current's value

end -- class BOOLEAN_PREF_RES
