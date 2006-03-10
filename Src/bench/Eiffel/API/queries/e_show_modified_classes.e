indexing

	description:
		"Command to display modified classes since last compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_MODIFIED_CLASSES

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

create

	make, do_nothing

feature -- Execution

	work is
			-- Show universe: clusters in class lists.
		local
			clusters: ARRAYED_LIST [CLUSTER_I];
			cursor: CURSOR;
		do
			text_formatter.add ("Classes modified since last compilation");
			text_formatter.add_new_line;
			text_formatter.add_new_line;
			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then
					--| Skip precompile clusters for now
				from
					clusters.start
				until
					clusters.after or else not (clusters.item.is_precompiled)
				loop
					clusters.forth
				end;
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
			end
		end;

feature {NONE} -- Implementation

	display_a_cluster (cluster: CLUSTER_I) is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: HASH_TABLE [CLASS_I, STRING];
			a_classi: CLASS_I;
			a_classe: CLASS_C
		do
			create sorted_class_names.make;
			classes := cluster.classes;
			from
				classes.start
			until
				classes.after
			loop
				if classes.item_for_iteration.date_has_changed then
					sorted_class_names.put_front (classes.key_for_iteration)
				end;
				classes.forth
			end;
			if not sorted_class_names.is_empty then
				sorted_class_names.sort;
				text_formatter.add ("Cluster: ");
				text_formatter.add (cluster.cluster_name);
				if cluster.is_precompiled then
					text_formatter.add (" (Precompiled)")
				end;
				text_formatter.add_new_line;
				from
					sorted_class_names.start
				until
					sorted_class_names.after
				loop
					text_formatter.add_indent;
					a_classi := classes.item (sorted_class_names.item);
					a_classe := a_classi.compiled_class;
					if a_classe /= Void then
						a_classe.append_signature (text_formatter, True)
					else
						a_classi.append_name (text_formatter);
						text_formatter.add ("  (not in system)")
					end;
					text_formatter.add_new_line;
					sorted_class_names.forth
				end
			end;
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

end -- class E_SHOW_MODIFIED_CLASSES
