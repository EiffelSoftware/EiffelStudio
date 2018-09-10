note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_ENTITY_DECLARATION

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_type: like type)
			-- Initialize entity declaration with name `a_name' and type `a_type'.
		require
			a_name_attached: attached a_name
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
		do
			name := a_name.twin
			type := a_type
			create entity.make (name, type)
		ensure
			name_set: name ~ a_name
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- Name of entity.

	type: IV_TYPE
			-- Type of entity.

	property: detachable IV_EXPRESSION
			-- A boolean property that holds for entity.

	entity: IV_ENTITY
			-- Entity for this declaration.

feature -- Element change

	set_property (a_property: like property)
			-- Set `property' to `a_property'.
		require
			a_property_valid: attached a_property implies a_property.type.is_boolean
		do
			property := a_property
		ensure
			property_set: property = a_property
		end

invariant
	attached_name: attached name
	valid_name: is_valid_name (name)
	attached_type: attached type
	valid_property: attached property implies property.type.is_boolean

end
