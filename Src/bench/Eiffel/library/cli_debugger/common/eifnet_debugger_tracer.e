indexing
	description: "Manage debug traces"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_TRACER

create
	make

feature {NONE} -- Initialization

	make (a_agent: PROCEDURE [ANY, TUPLE [STRING]] ) is
			-- Initialize `Current'.
		do
			tracer_procedure := a_agent
		end

	tracer_procedure: PROCEDURE [ANY, TUPLE[STRING]]

feature 

	set_tracer_procedure (val: like tracer_procedure) is
			-- Change value
		do
			tracer_procedure := val
		end

	trace_debugger (msg: STRING) is
		do
			tracer_procedure.call ([msg])
		end

end -- class EIFNET_DEBUGGER_TRACER
