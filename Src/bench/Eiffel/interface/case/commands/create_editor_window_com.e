indexing

	description: 
		"Command to create a window editor.";
	date: "$Date$";
	revision: "$Revision $"

class CREATE_EDITOR_WINDOW_COM

inherit
	
	ONCES

creation
	make

feature -- Creation

	make (p: like parent) is
		do
			parent := p
		end

feature -- Properties

	parent: EV_WINDOW

feature -- Execution

	execute (data: DATA) is
		local
			f_data: FEATURE_DATA;
			fc_data: FEATURE_CLAUSE_DATA
			clas_data: CLASS_DATA;
			r_data: RELATION_DATA;
			--clus_data: CLUSTER_DATA;

			class_window: EC_CLASS_WINDOW
			cluster_window: MAIN_WINDOW
			relation_window: EC_RELATION_WINDOW
			feature_window: EC_FEATURE_WINDOW
		do
			f_data ?= data;
			fc_data ?= data;
			clas_data ?= data;
			r_data ?= data;
			--clus_data ?= data;
			if r_data /= Void then
				!! relation_window.make (parent)
				relation_window.set_entity (r_data)
			elseif f_data /= Void then
				!! feature_window.make (parent)
				feature_window.set_entity (f_data)
			elseif fc_data /= Void then
				--Windows.create_feature_clause_window (fc_data);
			elseif clas_data /= Void then
				!! class_window.make (parent)
				class_window.set_entity (clas_data)
			--elseif clus_data /= Void then
				--!! cluster_window.make_top_level
				--cluster_window.set_entity (clus_data);
			end
		end;

end -- class CREATE_EDITOR_WINDOW_COM
