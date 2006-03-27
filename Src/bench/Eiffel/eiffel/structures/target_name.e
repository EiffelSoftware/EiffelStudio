indexing
	description: "Transitional structure to move to new EIFGEN directory structures with targets."
	date: "$Date$"
	revision: "$Revision$"

class
	TARGET_NAME

feature -- Access

	name: STRING
			-- Name of the target.

feature -- Update

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end


end
