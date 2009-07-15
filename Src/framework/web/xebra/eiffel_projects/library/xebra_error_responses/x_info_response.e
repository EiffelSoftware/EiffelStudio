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
			-- <Precursor>
		do
			Result := "Information"
		end

	deco_color: STRING
			-- <Precursor>
		do
			Result := "#6CC5C3"
		end

	img: STRING
			-- <Precursor>
		do
			Result := ""
		end

end


