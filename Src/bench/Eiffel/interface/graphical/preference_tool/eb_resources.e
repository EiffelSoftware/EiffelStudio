indexing

	description:
		"All resouorces for the application.";
	date: "$Date$";
	revision: "$Revision$"

class EB_RESOURCES

inherit
	EB_CONSTANTS;
	SHARED_EIFFEL_PROJECT;
	TTY_RESOURCES
		rename
			initialize_resources as tty_initialize_resources
		end;
	TTY_RESOURCES
		redefine
			initialize_resources
		select
			initialize_resources
		end

creation 
	initialize

feature {NONE} -- Initialization

	initialize_resources (a_table: RESOURCE_TABLE) is
			-- Initialize all resources for bench
		do
			tty_initialize_resources (a_table);
			if not Eiffel_project.batch_mode then
				Graphical_resources.initialize (a_table)
				Project_resources.initialize (a_table)
				System_resources.initialize (a_table)
				Object_resources.initialize (a_table)
				Explain_resources.initialize (a_table)
				Profiler_resources.initialize (a_table)
			end
		end

feature -- Access

	is_graphical_output_disabled: BOOLEAN is
			-- Is the graphical output disabled?
		do
			Result := Project_resources.graphical_output_disabled.actual_value
		end;

end -- class EB_RESOURCES
