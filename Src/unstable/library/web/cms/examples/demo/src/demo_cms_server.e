note
	description: "DEMO application server."
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO_CMS_SERVER

inherit
	ROC_CMS_LAUNCHER [DEMO_CMS_EXECUTION]
		redefine
			optional_application_name
		end

create
	make_and_launch

feature -- Access	

	optional_application_name: STRING_32 = "server"

end

