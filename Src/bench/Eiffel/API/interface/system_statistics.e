indexing

	description: 
		"General information about the Eiffel system.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_STATISTICS

inherit

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end;
	SHARED_WORKBENCH
		export
			{NONE} all
		end

creation
	make,
	make_compilation_stat

feature {NONE} -- Initialization

	make is
			-- Initialize statistical information.
		require
			project_inititalized: Eiffel_project.initialized
		do
			number_of_classes := Eiffel_system.number_of_classes;
			number_of_melted_classes := System.degree_minus_1.count;
			number_of_compilations := Workbench.compilation_counter - 1;
			number_of_clusters := Eiffel_universe.clusters.count;
		end;

	make_compilation_stat is
			-- Initailize `number_of_compilations'
		do	
			number_of_compilations := Workbench.compilation_counter
		end

feature -- Access

	number_of_classes: INTEGER
			-- Total number of compiled classes in the system

	number_of_clusters: INTEGER
			-- Total number of clusters in the system

	number_of_melted_classes: INTEGER
			-- Number of melted classes in the system

	number_of_compilations: INTEGER
			-- Number of melted classes in the system

end -- class SYSTEM_STATISTICS
