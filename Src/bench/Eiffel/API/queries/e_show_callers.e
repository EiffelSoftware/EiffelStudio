indexing

	description: 
		"Command to display the senders of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CALLERS 

inherit

	E_FEATURE_CMD;

creation

	make, do_nothing

feature -- Status report

	to_show_all_caller: BOOLEAN;
			-- Is the format going to show all callers?

feature -- Status setting

	set_all_callers is
			-- Set `to_show_all_caller' to True;
		do
			to_show_all_caller := True
		ensure
			show_all_callers: to_show_all_caller	
		end

feature -- Execution

	execute is
			-- Execute the display of callers.
		do
			if to_show_all_caller then
				show_all_callers
			else
				show_current_callers
			end
		end;

	show_current_callers is
			-- Show the callers of `current_feature'.
		local
			clients: LINKED_LIST [E_CLASS];
			cfeat: STRING;
			client: E_CLASS;
			feat: E_FEATURE;
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_I];
			list: SORTED_LIST [STRING];
			table: EXTEND_TABLE [SORTED_LIST [STRING], CLASS_ID];
			st: like structured_text
		do
			st := structured_text;
			clients := current_class.clients;
			!! table.make (5);
			!! classes.make;
			from
				clients.start
			until
				clients.after
			loop
				client := clients.item;
				list := current_feature.callers (client)
				if list /= Void then
					table.put (list, client.id);
					classes.put_front (client.lace_class)
				end;
				clients.forth;
			end;
			classes.sort;
			tabs := tabs + 1;
			from
				classes.start
			until
				classes.after
			loop
				client := classes.item.compiled_eclass;	
					-- Print out client name once.
				add_tabs (st, tabs);
				client.append_name (st);
				st.add_new_line;
				list := table.item (client.id);
				from
					list.start
				until
					list.after
				loop
					cfeat := list.item;
					feat := client.feature_with_name (cfeat);
					add_tabs (st, tabs);
					if feat = Void then
						st.add_string ("invariant")
					else
						feat.append_name (st, client)	
					end;
					st.add_new_line;
					list.forth
				end;
				classes.forth
			end
		end;

feature {NONE} -- Implementation

	tabs: INTEGER;
			-- Number of tabs

	show_all_callers is
			-- Show all the callers of `current_feature' and its descendents.
		require
			to_show_all_caller: to_show_all_caller	
		local
			descendants: PART_SORTED_TWO_WAY_LIST [E_CLASS];
			a_feat: E_FEATURE;
			a_class: E_CLASS;
			a_list: FIXED_LIST [CELL2 [E_CLASS,E_FEATURE]];
			cell: CELL2 [E_CLASS,E_FEATURE];
			rid: ROUTINE_ID;
			st: like structured_text
		do
			rid := current_feature.rout_id_set.item (1);
			!! descendants.make; 
			record_descendants (descendants, current_class);
			from
				!! a_list.make (descendants.count);
				a_list.start;
				descendants.start
			until
				descendants.after
			loop
				a_class := descendants.item;
				a_feat := a_class.feature_with_rout_id (rid);
				!! cell.make (a_class, a_feat);
				a_list.replace (cell);
				a_list.forth;
				descendants.forth
			end;

			from
				a_list.start;
				st := structured_text;
			until
				a_list.after
			loop
				cell := a_list.item;
				current_class := cell.item1;
				current_feature := cell.item2;
				current_feature.append_name (st, current_class);
				st.add_string (" from ");
				current_class.append_name (st);
				st.add_new_line;
				tabs := 1;
				show_current_callers;
				a_list.forth
			end
		end;

end -- class E_SHOW_SENDERS
