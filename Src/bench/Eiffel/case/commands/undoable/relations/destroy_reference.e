indexing

	description: 
		"Undoable command that removes a client-supp relation."
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_REFERENCE

inherit

	DESTROY
		redefine
			data
		end

	ONCES

	WARNING_CALLER

creation

	make

feature -- Initialization

	make (a_link: like data) is
			-- Create a new class
		require
			has_link: a_link /= void;
			is_a_reference_link: not a_link.is_aggregation
		do
			data := a_link;
			if data.is_in_compressed_link then
				compressed_link := data.find_compressed_link
			end;
		ensure
			correctly_set: data = a_link;
			is_compressed_set: data.is_in_compressed_link implies 
								compressed_link /= Void
		end

feature -- Property

	name: STRING is "Destroy client supplier";

feature {DESTROY_ENTITIES_U} -- Update

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
			if compressed_link = Void then
				workareas.refresh
			else
				compressed_link.update_editor
			end
		end

	redo is
		local
			cli_sup: CLI_SUP_DATA
		do
			cli_sup ?= data
			if cli_sup /= Void and then implied_features(cli_sup) then 
			--	Windows.warning(Windows.main_graph_window, "Wba",Void, Current)
			else
				proceed_redo
			end
		end

	implied_features(cli_sup: CLI_SUP_DATA): BOOLEAN is
			-- Has to be re-written.
		require
			cli_sup_exists: cli_sup /= Void
		local
			client_class: CLASS_DATA
			feat_list: FEATURE_LIST
		do
			--client_class ?= cli_sup.client
			--if client_class /= Void and then client_class.features /= Void then
			--	from
			--		feat_list := client_class.features
			--		feat_list.start
			--		!! list_features_to_remove.make
			--	until
			--		feat_list.after
			--	loop
			--		if feat_list.item.result_type/= Void and then
			--			feat_list.item.result_type.clickable_string /= Void and then
			--			feat_list.item.result_type.clickable_string.is_equal(cli_sup.supplier.name) then
			--				list_features_to_remove.extend(feat_list.item)
			--		end
			--		feat_list.forth
			--	end
			--	Result := (list_features_to_remove.count>0)
			--end
		end	

	proceed_redo is
			-- Re-execute command (after it was undone).
		do
			if data.is_in_system then
				data.remove_from_system;
				if data.is_reverse_link then
					data.reverse_link.remove_from_system
				end;
				if compressed_link = Void then
					workareas.destroy_reference (data);
				else
					compressed_link.remove_relation (data)
				end;
				update
			end
		end
	

	undo is
			-- Cancel effect of executing the command.
		do
			if not data.is_in_system then
				data.put_in_system;
				if data.is_reverse_link then
					data.reverse_link.put_in_system
				end;
				if compressed_link = Void then
					workareas.new_reference (data)
				else
					compressed_link.add_relation (data.key)
				end
				update
			end
		end

feature {WARNING_WINDOW} -- Implementation

	ok_action is
			-- remove the features associated to the link ...
		require else
			list_features_to_remove /= Void 
		local
			link_d: CLI_SUP_DATA
			cdata: CLASS_DATA
		do
			link_d ?= data
			if link_d /= Void then
				cdata ?= link_d.client
			end
			if cdata /= Void then
			--	from
			--		list_features_to_remove.start
			--	until
			--		list_features_to_remove.after
			--	loop
					--cdata.remove_feature(list_features_to_remove.item)		
					--list_features_to_remove.forth
			--	end
			end	
			proceed_redo
		end

	cancel_action is
			-- Action executed when control isn't satisfying
		do
			proceed_redo
		end -- cancel_action


feature -- Internal use

	list_features_to_remove: LINKED_LIST [ FEATURE_DATA ]

feature {NONE} -- Implementation properties


	data: CLI_SUP_DATA
			-- Reference link destroyed

	compressed_link: COMP_LINK_DATA [RELATION_DATA_KEY]

invariant

	is_a_reference_link: not data.is_aggregation

end -- class DESTROY_REFERENCE
