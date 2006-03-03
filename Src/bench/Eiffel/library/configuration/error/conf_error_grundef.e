indexing
	description: "Undefined group error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_GRUNDEF

inherit
	CONF_ERROR

feature -- Access

	text: STRING is
		do
			Result := "Undefined group"
			if group /= Void then
				Result.append (": "+group)
			end
		end

feature -- Update

	set_group (a_group: STRING) is
			-- Set the undefined group to `a_group'.
		do
			group := a_group
		end

feature {NONE} -- Implementation

	group: STRING

end
