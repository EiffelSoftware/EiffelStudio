indexing
	description: "Reflection notifier"
	external_name: "ISE.Reflection.Notifier"

class
	NOTIFIER

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
			create agents.make
		ensure
			non_void_agents: agents /= Void
		end

feature -- Access

	agents: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Agents called when a type is added to the database or an assembly is removed from the database.
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ROUTINE [ANY, TUPLE]]
		indexing
			external_name: "Agents"
		end

feature -- Status Setting

--	add_agent (an_agent: ROUTINE [ANY, TUPLE]) is
--			-- Add `agent' to `agents'.
--		indexing
--			external_name: "AddAgent"
--		require
--			non_void_agent: an_agent /= Void
--		local
--			added: INTEGER
--		do
--			added := agents.Add (an_agent)
--		ensure
--			agent_added: agents.Contains (an_agent)
--		end

feature -- Basic Operations

--	notify_add (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
--			-- Notify that a type has been added to the database.
--		indexing
--			external_name: "NotifyAdd"
--		require
--			non_void_agent: agents /= Void
--			non_void_eiffel_class: an_eiffel_class /= Void
--		local
--			i: INTEGER
--		do	
--			from
--			until
--				i = agents.Count
--			loop
--				an_agent ?= agents.Item (i)
--				if an_agent /= Void then
--					an_agent.call ([an_eiffel_class])
--				end
--				i := i + 1
--			end
--		end

--	notify_remove (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
--			-- Notify that assembly corresponding to `an_assembly_descriptor' has been removed from the database.
--		indexing
--			external_name: "NotifyRemove"
--		require
--			non_void_agent: agents /= Void
--			non_void_assembly_descriptor: an_assembly_descriptor /= Void
--		local
--			i: INTEGER
--		do	
--			from
--			until
--				i = agents.Count
--			loop
--				an_agent ?= agents.Item (i)
--				if an_agent /= Void then
--					an_agent.call ([an_assembly_descriptor])
--				end
--				i := i + 1
--			end
--		end

invariant
	non_void_agents: agents /= Void
	
end -- class NOTIFIER