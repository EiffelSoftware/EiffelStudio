indexing
	description: "Implemented `IPropertyNotifySink' Interface."
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


end -- IPROPERTY_NOTIFY_SINK_IMPL

