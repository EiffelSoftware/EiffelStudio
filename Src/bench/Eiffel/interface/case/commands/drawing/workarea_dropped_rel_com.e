indexing

	description: 
		"Command executed when a relation is dropped in a workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_DROPPED_REL_COM 

inherit

	ONCES;
	EC_COMMAND;
	CONSTANTS

creation

	set_relation

feature {NONE} -- Initialization

	set_relation (a_form: like graph_relation) is
			-- Set graph_relation to `a_form'.
		require
			valid_a_form: a_form /= Void
		do
			graph_relation := a_form
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Process graph_relation in relation to 
			-- `dropped_list'.
		local
			add_reverse_link: ADD_REVERSE_LINK_U;
			cli_sup_data, cli_sup_data2: CLI_SUP_DATA;
			comp_link: COMP_LINK_DATA [RELATION_DATA_KEY];
			add_to_compressed_link: ADD_TO_COMPRESSED_LINK_U;
			relation_data: RELATION_DATA;
			dropped_data: RELATION_DATA
		do
-- 			relation_data := graph_relation.data;
-- 			dropped_data := dropped_list.first;
-- 			if relation_data.is_client and then
-- 				dropped_data.is_client and then
-- 				dropped_data.f_rom = relation_data.t_o and then	
-- 				dropped_data.t_o = relation_data.f_rom 
-- 			then
-- 					-- Reverse link
-- 				if relation_data.f_rom /= relation_data.t_o then
-- 					cli_sup_data ?= relation_data;
-- 					cli_sup_data2 ?= dropped_data;
-- 					!! add_reverse_link.make_with_link (cli_sup_data,
-- 						cli_sup_data2);
-- 				end
-- 			else 
-- 				comp_link ?= relation_data;
-- 				if dropped_list.count = 1 then
-- 					if relation_data.is_able_to_compress (dropped_data) then
-- 						!! add_to_compressed_link.make (dropped_list, comp_link);
-- 					else
-- 				--		Windows.error (graph_relation.workarea.analysis_window,
-- 				--		Message_keys.compress_link_er,
-- 				--		Void)
-- 					end
-- 				elseif comp_link /= Void then
-- 					from
-- 						dropped_list.start
-- 					until
-- 						dropped_list.after
-- 					loop
-- 						if not relation_data.is_able_to_compress
-- 								(dropped_list.item)
-- 						then
-- 							dropped_list.remove
-- 						else
-- 							dropped_list.forth
-- 						end
-- 					end;
-- 					!! add_to_compressed_link.make (dropped_list, comp_link);
-- 				end;
-- 			end
		end -- execute

feature {NONE} -- Properties

	graph_relation: GRAPH_RELATION;
			-- Receipiant of dropped relation

end -- class WORKAREA_DROPPED_REL_COM
