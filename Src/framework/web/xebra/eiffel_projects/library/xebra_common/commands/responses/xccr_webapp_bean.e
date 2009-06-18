note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XCCR_WEBAPP_BEAN

create
	make

feature {NONE} -- Initialization

	make (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
		require
			a_webapp_config_attached: a_webapp_config /= Void
		do
			app_config := a_webapp_config

		ensure
			config_attached: app_config /= Void
		end

feature -- Access

	app_config: XC_WEBAPP_CONFIG
		-- Contains info about the webapp

feature -- Access

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant
	config_attached: app_config /= Void
end

