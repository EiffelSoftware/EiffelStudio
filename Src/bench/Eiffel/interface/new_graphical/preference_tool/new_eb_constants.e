indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_EB_CONSTANTS

feature {NONE} -- Resources

	General_resources: EB_GENERAL_PARAMETERS is
			-- General resources
		once
			Create Result.make
			
		end

	Tool_resources: EB_TOOL_PARAMETERS is
			-- General resources
		once
			Create Result.make
			
		end

	Feature_Resources: EB_FEATURE_PARAMETERS is
			-- Senator Palpatine
		once
			Create Result.make
		end

	Class_Resources: EB_CLASS_PARAMETERS is
			-- Prince Corwin of Amber
		once
			Create Result.make
		end

	Graphical_resources: EB_GRAPHICAL_PARAMETERS is
			-- Graphical resources
		once
			Create Result.make
			
		end

	Project_resources: EB_PROJECT_PARAMETERS is
			-- Project resources
		once
			Create Result.make
			
		end

	Debugger_resources: EB_DEBUGGER_PARAMETERS is
			-- Project resources
		once
			Create Result.make
			
		end

	Explain_Resources: EB_EXPLAIN_PARAMETERS is
			-- Homer Simpson
		once
			Create Result.make
		end

	System_Resources: EB_SYSTEM_PARAMETERS is
			-- Duke Nuken
		once
			Create Result.make
		end


	Object_Resources: EB_OBJECT_PARAMETERS is
			-- Henri the IV
		once
			Create Result.make
		end

	Profile_Resources: EB_PROFILE_PARAMETERS is
			-- Corny gag, isn't it?
		once
			Create Result.make
		end

	Pixmaps: SHARED_PIXMAPS is
	
		once
			Create Result
		end

end -- class NEW_EB_CONSTANTS
