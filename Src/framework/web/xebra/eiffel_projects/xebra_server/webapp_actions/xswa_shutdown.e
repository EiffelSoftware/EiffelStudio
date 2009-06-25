note
	description: "[
		The action which sends a shutdown message to the webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_SHUTDOWN

inherit
	XS_WEBAPP_ACTION

create
	make

feature -- Constants


feature -- Status report

	is_necessary: BOOLEAN
			-- <Precursor>
			-- Necessary if:
			--	- Always
		do
			Result := True
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>		
		do
			o.dprint ("Sending shutdown command to '" + webapp.app_config.name.out + "'...", 4)
			webapp.current_request := create {XCWC_SHUTDOWN}.make
			Result := next_action.execute
		end


end
