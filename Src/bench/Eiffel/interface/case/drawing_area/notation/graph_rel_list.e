indexing

	description: 
		"Graphic management for list of BON%
		%relations (inheritance, client/supplier)";
	date: "$Date$";
	revision: "$Revision $"

class GRAPH_REL_LIST [T->GRAPH_RELATION] 

inherit

	GRAPH_LIST [T]
		redefine
			data_type
		end

creation

	make

feature -- Properties

	data_type: RELATION_DATA is do end
			-- Just to have the item.data's type

feature -- Access

	links_who_has (handle: HANDLE_DATA): GRAPH_REL_LIST [T] is
			-- Call update_form on items who has handle.
		require
			handle /= void
		do
			!!Result.make;
			from
				start
			until
				after
			loop
				if item.data.break_points.has (handle) then
					Result.put_front (item)
				end;
				forth
			end
		ensure
			Result /= void;
			Result.count <= count
		end; 

	links_who_has_link (linkable: GRAPH_LINKABLE): GRAPH_REL_LIST [T] is
			-- Call update_form on items who has handle.
		require
			valid_linkable: linkable /= void
		local
			cli_sup: CLI_SUP_DATA
		do
			!! Result.make;
			from
				start
			until
				after
			loop
				if (item.to_form = linkable or else
					item.from_form = linkable) 
				then
					if item.data.is_client then
						cli_sup ?= item.data;
						if not cli_sup.is_reflexive then
							Result.put_front (item)
						end
					else
						Result.put_front (item)
					end
				end;
				forth
			end
		ensure
			valid_result: Result /= void;
			Result.count <= count
		end; 

feature -- Update

	update_form_if_associated_with (graph_linkable: GRAPH_LINKABLE;
					is_hidden: BOOLEAN) is
			-- Call update_form on items associated with graph_linkable
		require
			graph_linkable /= void
		local
			workarea: WORKAREA
		do
			workarea := graph_linkable.workarea;
			from
				start
			until
				after
			loop
				if item.associated_with (graph_linkable) then
					if is_hidden then
						item.update_without_erase;
					else
						item.update;
					end
				end;
				forth
			end
		end; -- update_form_if_associated_with

feature -- Output

	erase_form_if_associated_with (graph_linkable: GRAPH_LINKABLE; 
					is_hidden: BOOLEAN) is
			-- erase items associated with graph_linkable
		require
			graph_linkable /= void
		do
			from
				start
			until
				after
			loop
				if item.associated_with (graph_linkable) then
					if not is_hidden then
						item.erase;
					end;
					remove;
				else
					forth
				end;
			end;
		end 

feature -- Implementation

	display_associated_links (graph_linkable : GRAPH_LINKABLE; mode : INTEGER) is
			-- Display the associated links of 'graph_linkable' 
			-- according to the display 'mode'
		require
			has_linkable : graph_linkable /= Void
		local
			a_workarea : WORKAREA
		do
			a_workarea := graph_linkable.workarea;
			from
				start
			until
				after
			loop
				if item.associated_with (graph_linkable) then
					item.update;
				end;
				if not after then forth end
			end
		end;

	draw_in_and_update_list (clip_closure: EC_CLOSURE; 
					list: LINKED_LIST [EC_DOUBLE_LINE]) is
			-- Draw figures if in clip area `clip'.
			-- (in reverse order).
		do
			from
				start
			until
				after
			loop
				item.draw_in_and_update_list (clip_closure, list);
				forth
			end
		end; 

end -- class GRAPH_REL_LIST
