indexing
	description: "This is a common heir for accessing the global class repository. Use this class instead of JVM_CLASS_REPOSITORY"
			
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_JVM_CLASS_REPOSITORY

feature {ANY}
			
	repository: JVM_CLASS_REPOSITORY is
			-- access to the global class factory
		once
			create Result.make
		end
			
invariant
	repository_not_void: repository /= Void

end -- class SHARED_JVM_CLASS_REPOSITORY



