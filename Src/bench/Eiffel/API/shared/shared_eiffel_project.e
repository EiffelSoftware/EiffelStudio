indexing

	description: 
		"Shared instance of an eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_EIFFEL_PROJECT

feature -- Access

	Eiffel_project: E_PROJECT is
		once
			create Result
		end	

	Eiffel_ace: E_ACE is
			-- Eiffel system
		require
			initialized: Eiffel_project.initialized
		once
			Result := Eiffel_project.ace
		ensure
			result_is_set: Result = Eiffel_project.ace;
			result_is_not_void: Result /= Void
		end;
	
	Eiffel_dynamic_lib: E_DYNAMIC_LIB is
		require
			initialized: Eiffel_project.initialized
		do
			Result := Eiffel_project.dynamic_lib
		ensure
			result_is_set: Result = Eiffel_project.dynamic_lib
		end;

	Eiffel_system: E_SYSTEM is
			-- Eiffel system
		require
			initialized: Eiffel_project.initialized
			defined: Eiffel_project.system_defined
		once
			Result := Eiffel_project.system
		ensure
			result_is_set: Result = Eiffel_project.system;
			result_is_not_void: Result /= Void
		end;

	Eiffel_universe: UNIVERSE_I is
			-- Eiffel project universe
		require
			initialized: Eiffel_project.initialized
		once
			Result := Eiffel_project.universe
		ensure
			result_is_set: Result = Eiffel_project.universe;
			result_is_not_void: Result /= Void
		end;

feature {NONE} -- Implementation

	Degree_output: DEGREE_OUTPUT is
			-- Degree output for Eiffel project
		do
			Result := Eiffel_project.degree_output
		end;

end -- class SHARED_EIFFEL_PROJECT
