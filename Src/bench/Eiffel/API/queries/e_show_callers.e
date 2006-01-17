indexing

	description: 
		"Command to display the senders of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CALLERS 

inherit

	E_FEATURE_CMD;

create
	make, default_create

feature -- Status report

	to_show_all_callers: BOOLEAN;
			-- Is the format going to show all callers?

	flag: INTEGER_8
			-- Type of callers we are looking for.

feature -- Status setting

	set_all_callers is
			-- Set `to_show_all_callers' with True;
		do
			to_show_all_callers := True
		ensure
			show_all_callers: to_show_all_callers	
		end

	set_flag (a_flag: INTEGER_8) is
			-- Set `flag' with `a_flag'.
		do
			flag := a_flag
		ensure
			flag_set: flag = a_flag
		end

feature -- Execution

	work is
			-- Execute the display of callers.
		do
			if to_show_all_callers then
				show_all_callers (flag)
			else
				tabs := -1;
				show_current_callers (current_class, current_feature, flag)
			end
		end;

	show_current_callers (l_class: like current_class; l_feat: like current_feature; a_flag: INTEGER_8) is
			-- Show the callers of `l_feat' in `l_class'.
		require
			l_class_not_void: l_class /= Void
			l_feat_not_void: l_feat /= Void
		local
			clients: ARRAYED_LIST [CLASS_C];
			cfeat: STRING;
			client: CLASS_C;
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_I];
			list: SORTED_LIST [STRING];
			table: HASH_TABLE [SORTED_LIST [STRING], INTEGER];
			st: like structured_text;
			invariant_name: STRING
		do
			invariant_name := "_invariant";
			st := structured_text;
			clients := l_class.clients;
			create table.make (20);
			create classes.make;
			from
				clients.start
			until
				clients.after
			loop
				client := clients.item;
				list := l_feat.callers (client, a_flag)
				if list /= Void then
					table.put (list, client.class_id);
					classes.put_front (client.lace_class)
				end;
				clients.forth;
			end;

			if not classes.is_empty then
				l_feat.append_name (st);
				st.add_string (" from ");
				l_class.append_name (st);
				st.add_new_line;
				tabs := 0;
			end

			from
				classes.sort;
				tabs := tabs + 1;
				classes.start
			until
				classes.after
			loop
				client := classes.item.compiled_class;	
					-- Print out client name once.
				add_tabs (st, tabs);
				client.append_name (st);
				st.add_new_line;
				from
					list := table.item (client.class_id);
					list.start
				until
					list.after
				loop
					cfeat := list.item;
					add_tabs (st, tabs + 1);
					if cfeat.is_equal (invariant_name) then
						st.add_string ("invariant")
					else
						st.add_feature_name (cfeat, client)
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

	show_all_callers (a_flag: INTEGER_8) is
			-- Show all the callers of `current_feature' and its descendants.
		require
			to_show_all_callers: to_show_all_callers
		local
			descendants: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			a_feat: E_FEATURE;
			a_class: CLASS_C;
			a_list: ARRAYED_LIST [CELL2 [CLASS_C,E_FEATURE]];
			cell: CELL2 [CLASS_C,E_FEATURE];
			rid: INTEGER;
			st: like structured_text
		do
			rid := current_feature.rout_id_set.item (1);
			create descendants.make; 
			record_descendants (descendants, current_class);
			from
				create a_list.make (descendants.count)
				a_list.start
				descendants.start
			until
				descendants.after
			loop
				a_class := descendants.item;
				if a_class.has_feature_table then
					a_feat := a_class.feature_with_rout_id (rid)
						-- FIXME: Manu: 03/25/2004:
						-- Temporary fix for .NET as .NET classes don't have yet
						-- the routine of ANY
					debug ("FIXME") check fixme: False end end
					if a_feat /= Void then
						create cell.make (a_class, a_feat)
						a_list.extend (cell)
					end
				end
				descendants.forth
			end;

			from
				a_list.start
				st := structured_text
			until
				a_list.after
			loop
				cell := a_list.item
				show_current_callers (cell.item1, cell.item2, a_flag)
				a_list.forth
			end
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
