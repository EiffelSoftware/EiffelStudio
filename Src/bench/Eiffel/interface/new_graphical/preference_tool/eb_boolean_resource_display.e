indexing

	description:
		"A Boolean resource with a toggle button."
	date: "$Date$"
	revision: "$Revision$"

class EB_BOOLEAN_RESOURCE_DISPLAY

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
		do
			Precursor (a_parent, a_resource)

			Create boolean_toggle.make_with_text (Current, a_resource.visual_name)
			boolean_toggle.set_state (resource.actual_value)

		end

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
			boolean_toggle.set_state (resource.actual_value)
		end

feature -- Basic Operations

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like resource
		do
			ar := resource
			if boolean_toggle = Void or else ar.actual_value = boolean_toggle.state then
					--| boolean_toggle /= Void means: toggle has been displayed
					--| and thus the user could have changed the value.
				file.putstring (ar.value)
			else
				file.putstring (boolean_toggle.state.out)
			end
		end

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if boolean_toggle /= Void and then resource.actual_value /= boolean_toggle.state then
				Result := True
			end
		end

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_with_values (resource.name, boolean_toggle.state)
			!! Result.make (resource, new_res)
		end

feature {NONE} -- Implementation

	resource: EB_BOOLEAN_RESOURCE
			-- Resource Current represnts

	boolean_toggle: EV_CHECK_BUTTON
			-- Toggle to represent Current's value

end -- class EB_BOOLEAN_RESOURCE_DISPLAY
