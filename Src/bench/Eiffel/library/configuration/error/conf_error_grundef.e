indexing
	description: "Undefined group error."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_GRUNDEF

inherit
	CONF_ERROR_PARSE
		redefine
			text
		end

feature {NONE} -- Initialization

	text: STRING is
		do
			if file /= Void then
				Result := "Parse error in "+file+": Undefined group"
			else
				Result := "Parse error: Undefined group"
			end
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
