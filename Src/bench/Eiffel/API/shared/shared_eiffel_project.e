indexing

	description: 
		"Shared instance of an eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_EIFFEL_PROJECT

feature -- Access

	Eiffel_project: E_PROJECT is
		once
			!! Result
		end;	

	Eiffel_ace: E_ACE is
			-- Eiffel system
		require
			initialized: project_initialized
		once
			Result := Eiffel_project.ace
		ensure
			result_is_sys: Result = Eiffel_project.ace;
			result_is_not_void: Result /= Void
		end;

	Eiffel_system: E_SYSTEM is
			-- Eiffel system
		require
			initialized: project_initialized
			defined: system_defined
		once
			Result := Eiffel_project.system
		ensure
			result_is_sys: Result = Eiffel_project.system;
			result_is_not_void: Result /= Void
		end;

	Eiffel_universe: UNIVERSE_I is
			-- Eiffel project universe
		require
			initialized: project_initialized
		once
			Result := Eiffel_project.universe
		ensure
			result_is_universe: Result = Eiffel_project.universe;
			result_is_not_void: Result /= Void
		end;

	project_initialized: BOOLEAN is
			-- Is the Eiffel project initialized?
		do
			Result := Eiffel_project.initialized
		ensure
			initialized_means: Result implies Eiffel_project.initialized
		end

	system_defined: BOOLEAN is
			-- Is the Ace file parsed?
		do
			Result := Eiffel_project.system_defined
		end;

end -- class SHARED_EIFFEL_PROJECT
