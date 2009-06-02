note
	description: "[

	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_ARGUMENT

inherit
	XU_STRING_MANIPULATION

create
	make

feature -- Initialization

	make (a_value: STRING)
			-- `a_value': The value of the argument
		require
			a_value_attached: attached a_value
		do
			internal_value := a_value
		ensure
			internal_value_attached: attached internal_value
		end

feature {NONE} -- Access

	is_dynamic: BOOLEAN
			-- Is the argument dynamic?

	internal_value: STRING
			-- The actual value


feature -- Access

	value (a_controller_id: STRING): STRING
			-- The value it represents
		do
			Result := internal_value
		end

invariant

	internal_value_attached: attached internal_value

end
