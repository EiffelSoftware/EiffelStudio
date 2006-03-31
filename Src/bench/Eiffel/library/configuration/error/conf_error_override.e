indexing
	description: "Error if an override itself is overriden."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_OVERRIDE

inherit
	CONF_ERROR_PARSE
		redefine
			text
		end

feature {NONE} -- Initialization

	text: STRING is
		do
			if file /= Void then
				Result := "Parse error in "+file+": An override was overriden"
			else
				Result := "Parse error: An override was overriden"
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
