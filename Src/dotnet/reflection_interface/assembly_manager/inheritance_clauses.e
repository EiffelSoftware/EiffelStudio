indexing
	description: "List of inheritance clauses"
	external_name: "AssemblyManager.InheritanceClauses"

 deferred class
 	INHERITANCE_CLAUSES
 
 feature {NONE} -- Initialization
 
 	make (a_list: like inheritance_clauses) is
 			-- Set `inheritance_clauses' with `a_list'.
 		indexing
 			external_name: "Make"
 		require
 			non_void_list: a_list /= Void
 		do
 			inheritance_clauses := a_list
 		ensure
 			inheritance_clauses_set: inheritance_clauses = a_list
 		end
 
 feature -- Access
 
 	inheritance_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
 			-- Inheritance clauses
 		indexing
 			external_name: "InheritanceClauses"
 		end
 
 	--add_agent: ROUTINE [INHERITANCE_CLAUSES_VIEWER, TUPLE]
 	add_agent: INHERITANCE_CLAUSES_VIEWER
 			-- Add agent
 		indexing
 			external_name: "AddAgent"
 		end

 	--remove_agent: ROUTINE [INHERITANCE_CLAUSES_VIEWER, TUPLE]
 	remove_agent: INHERITANCE_CLAUSES_VIEWER
 			-- Remove agent
 		indexing
 			external_name: "RemoveAgent"
 		end
 
  	--remove_all_agent: ROUTINE [INHERITANCE_CLAUSES_VIEWER, TUPLE]
  	remove_all_agent: INHERITANCE_CLAUSES_VIEWER
  			-- Remove all agent
  		indexing
  			external_name: "RemoveAllAgent"
 		end
 	
 feature -- Status setting
 	
 	set_add_agent (an_agent: like add_agent) is
 			-- Set `add_agent' with `an_agent'.
		indexing
			external_name: "SetAddAgent"
 		require
 			non_void_agent: an_agent /= Void
 		do
 			add_agent := an_agent
 		ensure
 			add_agent_set: add_agent = an_agent
 		end

 	set_remove_agent (an_agent: like remove_agent) is
 			-- Set `remove_agent' with `an_agent'.
		indexing
			external_name: "SetRemoveAgent"
 		require
 			non_void_agent: an_agent /= Void
 		do
 			remove_agent := an_agent
 		ensure
 			remove_agent_set: remove_agent = an_agent
 		end
 
  	set_remove_all_agent (an_agent: like remove_all_agent) is
  			-- Set `remove_all_agent' with `an_agent'.
 		indexing
 			external_name: "SetRemoveAllAgent"
  		require
  			non_void_agent: an_agent /= Void
  		do
  			remove_all_agent := an_agent
  		ensure
  			remove_all_agent_set: remove_all_agent = an_agent
 		end
 		
 feature -- Basic Operations
 
 	notify_add (an_inheritance_clause: INHERITANCE_CLAUSE) is
 			-- Notify `agent' that `an_inheritance_clause' has been added.
 		indexing
 			external_name: "NotifyAdd"
 		require
 			non_void_agent: add_agent /= Void
 			non_void_inheritance_clause: an_inheritance_clause /= Void
 		do
 			--add_agent.call ([an_inheritance_clause])
 			add_agent.update_add (an_inheritance_clause)
 		end
  
  	notify_remove (an_inheritance_clause: INHERITANCE_CLAUSE) is
  			-- Notify `agent' that `an_inheritance_clause' has been removed.
  		indexing
  			external_name: "NotifyRemove"
  		require
  			non_void_agent: remove_agent /= Void
  			non_void_inheritance_clause: an_inheritance_clause /= Void
  		do
  			--remove_agent.call ([an_inheritance_clause])
  			remove_agent.update_remove (an_inheritance_clause)
 		end
 
   	notify_remove_all is
   			-- Notify `agent' that all inheritance clauses have been removed.
   		indexing
   			external_name: "NotifyRemoveAll"
   		require
   			non_void_agent: remove_all_agent /= Void
   		do
   			--remove_all_agent.call (create {TUPLE}.make)
   			remove_all_agent.update_remove_all
 		end
 		
 	add (a_clause: INHERITANCE_CLAUSE) is
 			-- Add `a_clause' to `inheritance_clauses'.
 		indexing
 			external_name: "Add"
 		require
 			non_void_clause: a_clause /= Void
  			non_void_add_agent: add_agent /= Void
 		local
 			added: INTEGER
 		do
 			added := inheritance_clauses.add (a_clause)
 			notify_add (a_clause)
 		ensure
 			clause_added: inheritance_clauses.contains (a_clause)
 		end

 	remove (a_clause: INHERITANCE_CLAUSE) is
 			-- Remove `a_clause' from `inheritance_clauses'.
 		indexing
 			external_name: "Remove"
 		require
 			non_void_clause: a_clause /= Void
  			non_void_remove_agent: remove_agent /= Void
 		do
 			inheritance_clauses.remove (a_clause)
 			notify_remove (a_clause)
 		ensure
 			clause_removed: not inheritance_clauses.contains (a_clause)
 		end
 
  	remove_all is
  			-- Remove all clauses of `inheritance_clauses'.
  		indexing
  			external_name: "RemoveAll"
  		require
  			non_void_remove_all_agent: remove_all_agent /= Void
  		do
  			inheritance_clauses.clear
  			notify_remove_all
  		ensure
  			clauses_removed: inheritance_clauses.count = 0
 		end
 		
 end -- class INHERITANCE_CLAUSES
 