indexing
	description: "Representation of a rename clause"
	external_name: "ISE.AssemblyManager.RenameClause"

class
	RENAME_CLAUSE
 
 create
 	make
 
 feature {NONE} -- Initialization
 
 	make (a_source: like source; a_target: like target) is 
 			-- Set `source' with `a_source'.
 			-- Set `target' with `a_target'.
 		indexing
 			external_name: "Make"
 		require
 			non_void_source: a_source /= Void
 			not_empty_source: a_source.length > 0
 			non_void_target: a_target /= Void
 			not_empty_target: a_target.length > 0 			
 		do
 			source := a_source
 			target := a_target
 		ensure
 			source_set: source.equals_string (a_source)
 			target_set: target.equals_string (a_target)
 		end
 
 feature -- Access
 
 	source: STRING
 			-- Source feature name
 		indexing
 			external_name: "Source"
 		end
 	
 	target: STRING
 			-- Target feature name
 		indexing
 			external_name: "Target"
 		end
	
 end -- class RENAME_CLAUSE
