note
	description: "[
		Represents a infromation response page
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	X_INFO_RESPONSE

inherit
	X_RESPONSE

feature -- Access

	title: STRING
			-- The type (title) of the Response
		do
			Result := "Information"
		end

	deco_color: STRING
			-- The color of the decoration
		do
			Result := "#6CC5C3"
		end

end


