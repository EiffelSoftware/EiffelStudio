indexing
	description: "List of rename clauses"
	external_name: "ISE.AssemblyManager.RenameClauses"

 class
 	RENAME_CLAUSES
 
 create
 	make
 	
 feature {NONE} -- Initialization
 
 	make (a_list: like rename_clauses) is
 			-- Set `inheritance_clauses' with `a_list'.
 		indexing
 			external_name: "Make"
 		require
 			non_void_list: a_list /= Void
 		do
 			rename_clauses := a_list
 		ensure
 			rename_clauses_set: rename_clauses = a_list
 		end
 
 feature -- Access
 
 	rename_clauses: SYSTEM_COLLECTIONS_ARRAYLIST
 			-- Rename clauses
 		indexing
 			external_name: "RenameClauses"
 		end
 
 	--add_agent: ROUTINE [RENAME_CLAUSES_VIEWER, TUPLE]
 	add_agent: RENAME_CLAUSES_VIEWER
 			-- Add agent
 		indexing
 			external_name: "AddAgent"
 		end

 	--replace_agent: ROUTINE [RENAME_CLAUSES_VIEWER, TUPLE]
 	replace_agent: RENAME_CLAUSES_VIEWER
 			-- Replace agent
 		indexing
 			external_name: "ReplaceAgent"
 		end
 	
 	console: SYSTEM_CONSOLE
 	
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

 	set_replace_agent (an_agent: like replace_agent) is
 			-- Set `replace_agent' with `an_agent'.
		indexing
			external_name: "SetReplaceAgent"
 		require
 			non_void_agent: an_agent /= Void
 		do
 			replace_agent := an_agent
 		ensure
 			replace_agent_set: replace_agent = an_agent
 		end
 
 feature -- Basic Operations
 
 	notify_add (a_rename_clause: ISE_REFLECTION_RENAMECLAUSE) is
 			-- Notify `agent' that `a_rename_clause' has been added.
 		indexing
 			external_name: "NotifyAdd"
 		require
 			non_void_agent: add_agent /= Void
 			non_void_rename_clause: a_rename_clause /= Void
 		do
 			--add_agent.call ([a_rename_clause])
 			add_agent.update_add (a_rename_clause)
 		end
  
  	notify_replace (an_old_clause, a_new_clause: ISE_REFLECTION_RENAMECLAUSE) is
  			-- Notify `agent' that `an_old_clause' has been replaced by `a_new_clause'.
  		indexing
  			external_name: "NotifyRename"
  		require
  			non_void_agent: replace_agent /= Void
  			non_void_old_clause: an_old_clause /= Void
  			non_void_new_clause: a_new_clause /= Void
  		do
  			--replace_agent.call ([an_old_clause, a_new_clause])
  			replace_agent.update_replace (an_old_clause, a_new_clause)
 		end
 		
 	add (a_clause: ISE_REFLECTION_RENAMECLAUSE) is
 			-- Add `a_clause' to `rename_clauses'.
 		indexing
 			external_name: "Add"
 		require
 			non_void_clause: a_clause /= Void
  			non_void_add_agent: add_agent /= Void
 		local
 			added: INTEGER
 		do
 			added := rename_clauses.add (a_clause)
 			notify_add (a_clause)
 		ensure
 			clause_added: rename_clauses.contains (a_clause)
 		end

 	replace (an_old_clause, a_new_clause: ISE_REFLECTION_RENAMECLAUSE) is
 			-- Replace `an_old_clause' from `rename_clauses' bu `a_new_clause'.
 		indexing
 			external_name: "Replace"
 		require
 			non_void_old_clause: an_old_clause /= Void
 			non_void_new_clause: a_new_clause /= Void
  			non_void_replace_agent: replace_agent /= Void
  		local
  			added: INTEGER
 		do
 			rename_clauses.remove (an_old_clause)
 			added := rename_clauses.add (a_new_clause)
 			notify_replace (an_old_clause, a_new_clause)
 		ensure
 			old_clause_removed: not rename_clauses.contains (an_old_clause)
 			new_clause_added: rename_clauses.contains (a_new_clause)
 		end
 
 end -- class RENAME_CLAUSES
 