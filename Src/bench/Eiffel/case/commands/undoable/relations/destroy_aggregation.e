indexing

	description: 
		"Undoable command that destroys an aggregation.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_AGGREGATION

inherit

	DESTROY
		redefine
			data
		end;

	ONCES

creation

	make

feature -- Initialization

	make (a_link: like data) is
			-- Create a new class
		require
			has_link: a_link /= void;
			is_a_aggregation_link: a_link.is_aggregation
		do
			data := a_link;
			if data.is_in_compressed_link then
				compressed_link := data.find_compressed_link
			end;
		ensure
			correctly_set: data = a_link
		end

feature -- Property

	name: STRING is "Destroy aggregation";

feature {DESTROY_ENTITIES_U,CANCEL_COM} -- Implementation

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= data.client
			if class_d /= Void then
				class_d.update_display (data.supplier)
			end;
			class_d ?= data.supplier
			if class_d /= Void then
				class_d.update_display (data.client)
			end;
			workareas.refresh
		end

	redo is
			-- Re-execute command (after it was undone).
		do
			if data.is_in_system then
				data.remove_from_system;
				if data.is_reverse_link then
					data.reverse_link.remove_from_system
				end;
				if compressed_link = Void then
					workareas.destroy_aggregation (data);
				else
					compressed_link.remove_relation (data)
				end;
				update
			end
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			if not data.is_in_system then
				data.put_in_system;
				if compressed_link = Void then
					workareas.new_aggregation (data)
				else
					compressed_link.add_relation (data.key)
				end
				update
			end
		end

feature {NONE} -- Implementation data

	data: CLI_SUP_DATA
			-- Aggregation link destroyed

	compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]

invariant

	is_a_aggregation_link: data.is_aggregation

end -- class DESTROY_AGGREGATION
