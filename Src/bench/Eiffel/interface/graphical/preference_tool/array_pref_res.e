indexing

	description:
		"Array resource with a text field.";
	date: "$Date$";
	revision: "$Revision$"

class ARRAY_PREF_RES

inherit
	STRING_PREF_RES
		redefine
			make, associated_resource, validate
		end

creation
	make

feature {NONE} -- Initialization

	make (a_resource: ARRAY_RESOURCE; new_parent: COMPOSITE) is
			-- Initialize Current with `a_resource' as `associated_resource'
			-- and `new_parent' as `a_parent'.
		do
			associated_resource := a_resource;
			a_parent := new_parent
		end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			is_resource_valid := (text /= Void and then
				associated_resource.is_valid (text.text)) or else
				text = Void
			if not is_resource_valid then
				raise_warner ("an array")
			end
		end

feature {NONE} -- Properties

	associated_resource: ARRAY_RESOURCE
			-- Resource Current represents

end -- class ARRAY_PREF_RES
