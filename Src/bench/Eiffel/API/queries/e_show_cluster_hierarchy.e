indexing

	description: 
		"Command to display hierarchical structure of the system.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTER_HIERARCHY

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show classes in universe
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			a_classi: CLASS_I;
			a_classe: E_CLASS;
		do
print ("to be implemented%N");
			clusters := Eiffel_universe.clusters;
			if not clusters.empty then
				from 
					clusters.start 
				until 
					clusters.after 
				loop
					clusters.forth
				end;
			end
		end;

end -- class E_SHOW_CLUSTER_HIERARCHY
