indexing
	description: "Implemented `IPropertyNotifySink' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IPROPERTY_NOTIFY_SINK_IMPL

inherit
	IPROPERTY_NOTIFY_SINK_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	on_changed (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- No Implementation.
		end

	on_request_edit (disp_id: INTEGER) is
			-- No description available.
			-- `disp_id' [in].  
		do
			-- No Implementation.
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IPROPERTY_NOTIFY_SINK_IMPL

