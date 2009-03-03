indexing
	description : "xebra_web_app application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_STARTER

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			webapp: WEB_APPLICATION
		do
			create webapp.make

		end

end
