indexing

	description: 
		"Graphical representation for an aggregation relationship";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_AGGREG

inherit

	GRAPH_CLIENTELE
		redefine
			link_head
		end

creation

	make

feature {NONE} -- Initialization

	make (a_cli_sup: CLI_SUP_DATA; a_workarea: WORKAREA) is
			-- create GRAPH_AGGREG object with `a_cli_sup' as link 
		require
			entity_exists: a_cli_sup /= Void;
			entity_is_an_aggregation_link: a_cli_sup.is_aggregation;
			has_workarea: a_workarea /= Void
		do
			workarea := a_workarea;
			data := a_cli_sup;
			-- pascalf 
		--	if data.color_name = Void then
		--		if resources.link_color/= Void then
		--			data.set_color_name (resources.get_color("link_color"))
		--		else
		--			data.set_color_name (resources.get_color("link_aggreg"))
		--		end
		--	end
			--
			client := a_workarea.find_linkable (data.client);
			supplier := a_workarea.find_linkable (data.supplier);
			if client /= Void and then supplier /= Void then
				a_workarea.aggreg_list.add_form (Current);
				!! link_body.make;
				make_relation (a_workarea);
				update_clip_area;
			end;
		ensure
			data_correctly_set: data = a_cli_sup;
		end; 

feature -- Properties

	link_head: EC_BRACKET_HEAD

feature -- Removal

	destroy_without_clip_update is
			-- Destroy 'Current' from 'workarea'
		do
			workarea.aggreg_list.remove_form (Current)
		end 

feature {NONE} -- Implementation

	make_link_head is
			-- Create the link head for an aggregation link.
		do
			!! link_head.make (to_point,3)
			-- 3 is to specify that it is an aggregation link
		end; -- make_link_head

end -- class GRAPH_AGGREG
