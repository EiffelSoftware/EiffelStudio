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
			r_data: RELATION_DATA

			cluster_window: MAIN_WINDOW
			relation_window: EC_RELATION_WINDOW
		do
			r_data ?= data;
			--clus_data ?= data;
			if r_data /= Void then
				!! relation_window.make (parent)
				relation_window.set_entity (r_data)
			--elseif clus_data /= Void then
				--!! cluster_window.make_top_level
				--cluster_window.set_entity (clus_data);
			end
		end;

end -- class CREATE_EDITOR_WINDOW_COM
