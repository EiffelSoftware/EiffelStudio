indexing
	description: "Accessor to tracer"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EIFNET_DEBUGGER_TRACER_ACCESS

feature

	eifnet_debugger_tracer: CELL[EIFNET_DEBUGGER_TRACER] is
		once
			create Result.put (Void)
		end

	set_eifnet_debugger_tracer (val: EIFNET_DEBUGGER_TRACER) is
			-- Change value
		do
			eifnet_debugger_tracer.replace (val)
		end

	eif_debug_display (msg: STRING) is
		do
			if eifnet_debugger_tracer.item /= Void then
				eifnet_debugger_tracer.item.trace_debugger (msg)
			end
		end

end -- class EIFNET_DEBUGGER_TRACER_ACCESS
