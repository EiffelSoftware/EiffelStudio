indexing

	description: 
		"Abstact linkable view information.";
	date: "$Date$";
	revision: "$Revision $"

class LINKABLE_VIEW

inherit

	COORD_XY_VIEW
		rename
			update_from as coord_update_from,
			update_data as coord_update_data
		end
	COORD_XY_VIEW
		redefine
			update_from, update_data
		select
			update_from, update_data
		end;
	ONCES

feature -- Properties

	color_name: STRING
			-- Color of Current, to be removed. 

	view_id: INTEGER
			-- Linkable view identifier, to be removed.

	is_hidden: BOOLEAN
			-- Is Current hidden?

	client_links: ARRAYED_LIST [CLI_SUP_VIEW];
			-- List of client/supplier view for which current
			-- is the client

	heir_links: ARRAYED_LIST [INHERIT_VIEW];
			-- List of inheritance view for which current is the heir

	compressed_heir_links: ARRAYED_LIST [COMP_INHERIT_VIEW]
			-- List of compressed heir links

	compressed_client_links: ARRAYED_LIST [COMP_CLI_SUP_VIEW]
			-- List of compressed client links


feature {NONE} -- Setting

	update_from (a_linkable: LINKABLE_DATA) is
			-- Update Current from `a_linkable'.
		local
			c_list: LINKED_LIST [CLI_SUP_DATA];
			i_list: LINKED_LIST [INHERIT_DATA];
			client_view: CLI_SUP_VIEW_R336;
			inherit_view: INHERIT_VIEW;
			cli_sup_data: CLI_SUP_DATA;
			inherit_data: INHERIT_DATA;
			comp_client_view: COMP_CLI_SUP_VIEW_R336;
			comp_inherit_view: COMP_INHERIT_VIEW;
			comp_inherit_data: COMP_INHERIT_DATA;
			comp_cli_sup_data: COMP_CLI_SUP_DATA
		do
			coord_update_from (a_linkable);
			color_name := a_linkable.color_name
			is_hidden := a_linkable.is_hidden;
			view_id := a_linkable.view_id;
			c_list := a_linkable.client_links;
			if c_list /= Void and then not c_list.empty then
				from
					!! client_links.make (c_list.count);
					!! compressed_client_links.make (0);
					client_links.start;
					c_list.start
				until
					c_list.after
				loop
					cli_sup_data := c_list.item;
					if cli_sup_data.is_compressed then
						comp_cli_sup_data ?= cli_sup_data;
						!! comp_client_view.make (comp_cli_sup_data);
						compressed_client_links.extend (comp_client_view);
					else
						!! client_view.make (c_list.item);
						client_links.extend (client_view);
					end;
					c_list.forth
				end
			end;
			i_list := a_linkable.heir_links;
			if i_list /= Void and then not i_list.empty then
				from
					!! heir_links.make (i_list.count);
					!! compressed_heir_links.make (0);
					heir_links.start;
					i_list.start
				until
					i_list.after
				loop
					inherit_data := i_list.item
					if inherit_data.heir/=Void and inherit_data.parent/=Void then
						if inherit_data.is_compressed then
							comp_inherit_data ?= inherit_data;
							!! comp_inherit_view.make (comp_inherit_data);
							compressed_heir_links.extend (comp_inherit_view);
						else
							!! inherit_view.make (i_list.item);
							heir_links.extend (inherit_view);
						end
					end
					i_list.forth
				end
			end;
		ensure then
			updated: is_hidden = a_linkable.is_hidden and then
				view_id = a_linkable.view_id and then
				color_name = a_linkable.color_name		
		end;

feature {CLUSTER_CONTENT,ALGO_WINDOW} -- Setting

	update_data (linkable_data: LINKABLE_DATA) is
			-- Update `linkable_data' from Current.
		local
			h_list: LINKED_LIST [INHERIT_DATA];
			c_list: LINKED_LIST [CLI_SUP_DATA];
			client_view: CLI_SUP_VIEW;
			inherit_view: INHERIT_VIEW;
			cli_sup_data: CLI_SUP_DATA;
			inherit_data: INHERIT_DATA;
			finished: BOOLEAN
		do
			coord_update_data (linkable_data);
			linkable_data.set_color_name (color_name);
			linkable_data.set_hidden (is_hidden);
			c_list := linkable_data.client_links;
			if c_list /= Void and then client_links /= Void then 
				from
					client_links.start;
					c_list.start;
				until
					c_list.after
				loop
					cli_sup_data := c_list.item;
					if not client_links.after then
						client_view := client_links.item;
						if client_view.view_id = cli_sup_data.view_id then
							client_view.update_data (cli_sup_data)
							client_links.forth;
						else
							finished := False;
							View_information.set_are_new_relations;
							from
							until
								client_links.after or else finished
							loop
								client_view	:= client_links.item;
								if client_view.view_id = cli_sup_data.view_id then
									finished := True;
									client_view.update_data (cli_sup_data);
									client_links.forth
								elseif client_view.view_id > cli_sup_data.view_id then
									finished := True
								else
									client_links.forth
								end
							end
						end;
					else
						View_information.set_are_new_relations;
					end;
					c_list.forth
				end
			elseif c_list /= Void and then not c_list.empty then
				View_information.set_are_new_relations;
			end;
			h_list := linkable_data.heir_links;
			if h_list /= Void and then heir_links /= Void then 
				from
					h_list.start;
					heir_links.start
				until
					h_list.after
				loop
					inherit_data := h_list.item;
					if not heir_links.after then
						inherit_view := heir_links.item
						if inherit_data.parent/= Void then
						if inherit_view.view_id = inherit_data.view_id then
							inherit_view.update_data (inherit_data);
							heir_links.forth
						else
							View_information.set_are_new_relations;
							from
								finished := False
							until
								heir_links.after or else finished
							loop
								inherit_view := heir_links.item
								if inherit_view.view_id = inherit_data.view_id then
									finished := True;
									inherit_view.update_data (inherit_data);
									heir_links.forth
								elseif inherit_view.view_id > inherit_data.view_id then
									finished := True
								else
									heir_links.forth
								end
							end;
						end
						end
					else
						View_information.set_are_new_relations;
					end;
					h_list.forth
				end
			elseif h_list /= Void and then not h_list.empty then
				View_information.set_are_new_relations;
			end;
			update_compressed_data (linkable_data)
		end;

	update_compressed_data (linkable_data: LINKABLE_DATA) is
			-- Update `linkable_data' from Current.
		local
			comp_cli_sup_view: COMP_CLI_SUP_VIEW;
			comp_inherit_view: COMP_INHERIT_VIEW;
			comp_sup_data: COMP_CLI_SUP_DATA;
			comp_inh: COMP_INHERIT_DATA
		do
			if compressed_client_links /= Void then
				from
					compressed_client_links.start
				until
					compressed_client_links.after
				loop
					comp_cli_sup_view := compressed_client_links.item;
					comp_sup_data := comp_cli_sup_view.data 
							(linkable_data);
					if comp_sup_data /= Void then
						comp_sup_data.add_link;
					end;
					compressed_client_links.forth
				end
			end
			if compressed_heir_links /= Void then
				from
					compressed_heir_links.start
				until
					compressed_heir_links.after
				loop
					comp_inherit_view := compressed_heir_links.item;
					comp_inh := comp_inherit_view.data (linkable_data);
					if comp_inh /= Void then
						comp_inh.add_link;
					end;
					compressed_heir_links.forth
				end
			end
		end;

end -- class LINKABLE_VIEW
