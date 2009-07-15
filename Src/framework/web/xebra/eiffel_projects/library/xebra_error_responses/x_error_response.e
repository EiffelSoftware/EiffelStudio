note
	description: "[
		Represents an error response page
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	X_ERROR_RESPONSE

inherit
	X_RESPONSE

feature -- Access

	title: STRING
			-- <Precursor>
		do
			Result := "Error Report"
		end

	deco_color: STRING
			-- <Precursor>
		do
			Result := "#F15922"
		end

	img: STRING
			-- <Precursor>
		do
			Result := "[
					   <img src="http://fusun.ch/download/temp/xebTot.jpg" alt="fail xebra image" width="520" height="256" />
					   ]"
		end
end
