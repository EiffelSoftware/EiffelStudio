indexing

	description: 
		"Command to display list of the classes in the%
		%universe, in alphabetical order."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLASSES

inherit
	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

create
	make, do_nothing

feature -- Execution

	work is
			-- Show classes in universe
		local
			clusters: ARRAYED_LIST [CLUSTER_I];
			cursor: CURSOR;
			classes: HASH_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			a_classi: CLASS_I;
			a_classe: CLASS_C;
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then
				create sorted_classes.make;
				from 
					clusters.start 
				until 
					clusters.after 
				loop
					cursor := clusters.cursor;
					classes := clusters.item.classes;
					from 
						classes.start 
					until 
						classes.after 
					loop
						sorted_classes.put_front (classes.item_for_iteration);
						classes.forth
					end;
					clusters.go_to (cursor);
					clusters.forth
				end;
				sorted_classes.sort;
				from 
					sorted_classes.start 
				until 
					sorted_classes.after 
				loop
					a_classi := sorted_classes.item;
					a_classe := a_classi.compiled_class;
					if a_classe /= Void then
						a_classe.append_signature (structured_text, True)
					else
						a_classi.append_name (structured_text)
					end;
					structured_text.add_new_line;
					structured_text.add_indent;
					structured_text.add_string ("-- Cluster: ");
					structured_text.add_cluster (a_classi.cluster, a_classi.cluster.cluster_name);
					structured_text.add_new_line;
					sorted_classes.forth
				end
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

end -- class E_SHOW_CLASSES
