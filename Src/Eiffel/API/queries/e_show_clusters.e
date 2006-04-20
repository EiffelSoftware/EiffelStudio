indexing

	description:
		"Command to show the universe: clusters in class lists."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTERS

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT
	CONF_REFACTORING

create

	make, do_nothing

feature -- Execution

	work is
			-- Show universe: clusters in class lists.
		local
			clusters: ARRAYED_LIST [CLUSTER_I];
			cursor: CURSOR;
			nb_of_classes: INTEGER;
			nb_of_clusters: INTEGER;
		do
--			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then

				nb_of_clusters := clusters.count;
				text_formatter.add_int (nb_of_clusters);
				if nb_of_clusters > 1 then
					text_formatter.add (" clusters containing ")
				else
					text_formatter.add (" cluster containing ")
				end;
				from clusters.start until clusters.after loop
					nb_of_classes := nb_of_classes + clusters.item.classes.count;
					clusters.forth
				end;
				text_formatter.add_int (nb_of_classes);
				if nb_of_classes > 1 then
					text_formatter.add (" classes");
				else
					text_formatter.add (" class");
				end;
				text_formatter.add_new_line;
				text_formatter.add ("root: ");
				Eiffel_system.root_class.compiled_class.append_signature (text_formatter, True);
				text_formatter.add (" (cluster: ");
				text_formatter.add_group (
					Eiffel_system.root_cluster,
					Eiffel_system.root_cluster.name);
				text_formatter.add (")");
				text_formatter.add_new_line;
				text_formatter.add_new_line;

					--| Skip precompile clusters for now
				conf_todo
--				from
--					clusters.start
--				until
--					clusters.after or else not (clusters.item.is_precompiled)
--				loop
--					clusters.forth
--				end;
				from
					--| Print user defined clusters
				until
					clusters.after
				loop
					cursor := clusters.cursor;
					display_a_cluster (clusters.item);
					clusters.go_to (cursor);
					clusters.forth
				end
				conf_todo
--				from
--					--| Print precompiled clusters.
--					clusters.start
--				until
--					clusters.after or else not (clusters.item.is_precompiled)
--				loop
--					cursor := clusters.cursor;
--					display_a_cluster (clusters.item)
--					clusters.go_to (cursor);
--					clusters.forth
--				end
			end
		end;

	display_a_cluster (cluster: CLUSTER_I) is
		local
			classes: HASH_TABLE [CLASS_I, STRING];
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			a_classi: CLASS_I;
			a_classe: CLASS_C;
			nb_of_classes: INTEGER;
		do
			create sorted_class_names.make;
			classes := cluster.classes;

			text_formatter.add ("Cluster: ");
			text_formatter.add_group (cluster, cluster.cluster_name);
			conf_todo
--			if cluster.is_precompiled then
--				text_formatter.add (" (Precompiled, ")
--			else
--				text_formatter.add (" (")
--			end;
			nb_of_classes := classes.count;
			text_formatter.add_int (nb_of_classes);
			if nb_of_classes > 1 then
				text_formatter.add (" classes)")
			else
				text_formatter.add (" class)")
			end;
			text_formatter.add_new_line;

			from
				classes.start
			until
				classes.after
			loop
				sorted_class_names.put_front (classes.key_for_iteration);
				classes.forth
			end;
			sorted_class_names.sort;
			from
				sorted_class_names.start
			until
				sorted_class_names.after
			loop
				text_formatter.add_indent;
				a_classi := classes.item (sorted_class_names.item);
				a_classe := a_classi.compiled_class;
				if a_classe /= Void then
					a_classe.append_signature (text_formatter, True);
				else
					a_classi.append_name (text_formatter);
					text_formatter.add ("  (not in system)");
				end;
				text_formatter.add_new_line;
				sorted_class_names.forth
			end;
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class E_SHOW_CLUSTERS
