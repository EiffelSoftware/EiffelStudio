indexing

	description: 
		"Abstract class for hiding/showing a linkable.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LINKABLE_ABSTRACTION

inherit

	ONCES;
	UNDOABLE_EFC

feature {NONE} -- Implementation

	linkable_data: LINKABLE_DATA
			-- Class data 

	hide_linkable is
		local
			cluster_data: CLUSTER_DATA
			class_data: CLASS_DATA
		do
			linkable_data.set_hidden (True);
			if linkable_data.is_class then
				class_data ?= linkable_data
				workareas.destroy_class (class_data)
			else
				cluster_data ?= linkable_data
				workareas.destroy_cluster (cluster_data)
			end;
			graphicals_update
		end;

	show_linkable is
		do
			linkable_data.set_hidden (False);
			workareas.change_data (linkable_data);
			graphicals_update
		end

	graphicals_update is
		do
--			workareas.refresh;
--			Windows.update_hidden_entity_window;
--			System.set_is_modified
		end 

end -- class LINKABLE_ABSTRACTION
