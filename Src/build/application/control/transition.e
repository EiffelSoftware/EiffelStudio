indexing
	description: "Transition between two states."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class TRANSITION 

inherit
	SHARED_APPLICATION

feature -- Access

	init_element (element: GRAPH_ELEMENT) is
			-- Initialize graph element in table.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			create temp_trans.make (5)
			Shared_app_graph.put (temp_trans, element)
		end

	all_transitions (source: BUILD_STATE): TRAN_NAME_LIST is
			-- All labels name and their destination 
			-- graph element names from `source'
		require
			source_exists: Shared_app_graph.has (source)
		local
			element: GRAPH_ELEMENT
			text: TRAN_NAME
			labels: LINKED_LIST [CMD_LABEL]
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
			updated_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
			label: CMD_LABEL
			transition_name_list: TRAN_NAME_LIST
		do
			create transition_name_list.make
			create updated_trans.make (10)
			temp_trans := Shared_app_graph.item (source)
			labels := source.labels
			from
				labels.start	
			until
				labels.after
			loop
				label := labels.item
				if not transition_name_list.has_label (label) then
					create text.make (Void)
					text.set_cmd_label (label)
					if temp_trans.has (label.label) then
						element := temp_trans.item (label.label)
						if element = Void then
							text.set_destination_name ("return")
							updated_trans.put (element, label.label)
						else
							if (element.visual_name = Void) then
								text.set_destination_name (element.internal_name)
							else
								text.set_destination_name (element.visual_name)
							end
							updated_trans.put (element, label.label)
						end
					else
						text.set_destination_name ("self")
					end
					text.update
					transition_name_list.extend (text)
				end 
				labels.forth
			end
			Result := transition_name_list
			Shared_app_graph.force (updated_trans, source)
		end

	destination_element (source: GRAPH_ELEMENT; label: STRING): GRAPH_ELEMENT is
			-- The destination element of source with label.
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			if Shared_app_graph.has (source) then
				temp_trans := Shared_app_graph.item (source)
				Result := temp_trans.item (label)
			end
		end

	remove_element (element: GRAPH_ELEMENT) is
			-- Remove element from graph.
		local
			source: GRAPH_ELEMENT
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			Shared_app_graph.remove (element)
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				source := Shared_app_graph.key_for_iteration
				remove_transition (source, element)
				Shared_app_graph.forth
			end
		end

	remove_transition (source: GRAPH_ELEMENT; dest: GRAPH_ELEMENT) is
			-- Remove transition between source and dest. 
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
			element: GRAPH_ELEMENT
		do
			temp_trans := Shared_app_graph.item (source)
			if temp_trans = Void then
				from
					temp_trans.start
				until
					temp_trans.off
				loop
					element := temp_trans.item_for_iteration
					if
						element = dest
					then
						temp_trans.remove (temp_trans.key_for_iteration)
					else
						temp_trans.forth
					end
				end
			end
		end

	selected_labels (s, d: BUILD_STATE): SORTED_TWO_WAY_LIST [STRING] is 
			-- List of the transitions betwee `s' and `d'.
		local
			dest_name: STRING
			temp: TRAN_NAME_LIST
		do
			create Result.make
			if (d.visual_name = Void) then
				dest_name := d.internal_name
			else
				dest_name := d.visual_name
			end
			temp := all_transitions (s)
			from
				temp.start
			until			
				temp.after
			loop
				if temp.item.destination_name.is_equal (dest_name) then
					Result.extend (temp.item.cmd_label.label)
				end
				temp.forth
			end	
		end

	transition (source: GRAPH_ELEMENT; dest: GRAPH_ELEMENT): HASH_TABLE [GRAPH_ELEMENT, STRING] is
			-- Transition  between `source' and `dest'. If 
			-- `source' not exists then return void.
		local
			temp_tran: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			if Shared_app_graph.has (source) then
				temp_tran := Shared_app_graph.item (source)
				from
					temp_tran.start
					create Result.make (5)
				until
					temp_tran.off
				loop
					if dest= temp_tran.item_for_iteration then
						Result.put (dest, temp_tran.key_for_iteration)
					end
					temp_tran.forth
				end
			end	
		end

	update_element (old_element: GRAPH_ELEMENT; new_element: GRAPH_ELEMENT) is
			-- Replace old_element with new_element in the transition graph
			-- and then update `old_element' with `new_element' in the graph. 
		local
			element: GRAPH_ELEMENT
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				temp_trans := Shared_app_graph.item_for_iteration
				from
					temp_trans.start
				until
					temp_trans.off
				loop
					element := temp_trans.item_for_iteration
					if
						element = old_element
					then
						temp_trans.replace (new_element, temp_trans.key_for_iteration)
					end
					temp_trans.forth
				end
				Shared_app_graph.forth
			end
			Shared_app_graph.remove (old_element) -- remove all transitions
			init_element (new_element)
		end

	update_label (source: GRAPH_ELEMENT; label: STRING; dest: GRAPH_ELEMENT) is
			-- Update a label from the source to
			-- dest element. If a transition between elements do not
			-- exist then add.
		require
			element_has_transitions: Shared_app_graph.has (source)
		local
			temp_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]
		do
			temp_trans := Shared_app_graph.item (source)
			if
				source = dest
			then
				temp_trans.remove (label)
			else
				temp_trans.force (dest, label)
			end
		end

	update (new_trans: HASH_TABLE [GRAPH_ELEMENT, STRING]; element: GRAPH_ELEMENT) is
			-- Update the transitions of `element' with `new_transitions'.  
		require
			not_void_new_transitions: new_trans /= Void
			graph_has_element: Shared_app_graph.has (element)
		do
			Shared_app_graph.replace (new_trans, element)
		end

end -- class TRANSITION

