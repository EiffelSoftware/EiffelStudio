note
	description: "[
				API application server.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_WEB

inherit
	ROC_CMS_LAUNCHER [ES_CLOUD_WEB_EXECUTION]
		redefine
			optional_application_name
		end

create
	make_and_launch

feature -- Access	

	optional_application_name: STRING_32 = "server"

end

