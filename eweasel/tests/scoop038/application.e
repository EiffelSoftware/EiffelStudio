note
	description: "Test agent creation rule on an uncontrolled object."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			sep: separate APPLICATION
			ag: separate PROCEDURE [ANY, TUPLE]
			my_id: INTEGER
			separate_id: INTEGER
			agent_id: INTEGER
		do
			my_id := processor_id_from_object (Current)

			create sep

				-- This is the statement being tested here.
			ag := agent sep.compare (my_id)

			separate_id := processor_id_from_object (sep)
			agent_id := processor_id_from_object (ag)

				-- Check that the processor IDs are correct.
			if separate_id = agent_id and separate_id /= my_id then
				print ("ok%N")
			else
				print ("error%N")
			end

				-- Call the agent.
			call_agent (ag)
		end

feature -- Basic operations

	call_agent (proc: separate PROCEDURE [ANY, TUPLE])
			-- Invoke a separate agent.
		do
			proc.call (Void)
		end

	compare (pid: INTEGER)
			-- Compare the processor ID `pid' with our own ID.
		local
			my_id: INTEGER
		do
			my_id := processor_id_from_object (Current)
			if pid /= my_id then
				print ("not_equal%N")
			else
				print ("equal%N")
			end
		end

feature {NONE} -- C externals.

	frozen processor_id_from_object (a_object: separate ANY): INTEGER
		external
			"C inline use %"eif_scoop.h%""
		alias
			"RTS_PID(eif_access($a_object))"
		end

end
