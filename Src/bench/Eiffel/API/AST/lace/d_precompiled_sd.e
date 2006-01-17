indexing

	description:
		"Precompilation options"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class D_PRECOMPILED_SD

inherit

	D_OPTION_SD
		rename
			initialize as d_initialize
		redefine
			duplicate, save, same_as, is_precompiled
		end;

	EIFFEL_ENV

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like option; v: like value; r: like renamings) is
			-- Create a new D_PRECOMPILED AST node.
		require
			o_not_void: o /= Void
		do
			option := o
			value := v
			renamings := r
		ensure
			option_set: option = o
			value_set: value = v
			renamings_set: renamings = r
		end

feature -- Access

	renamings: LACE_LIST [TWO_NAME_SD];
			-- Cluster renaming list
			-- Can be Void.

feature -- Status report

	is_precompiled: BOOLEAN is True
			-- Current is an instance of `D_PRECOMPILED_SD'.

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result.initialize (option.duplicate, duplicate_ast (value), duplicate_ast (renamings))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then option.same_as (other.option)
			 		and then same_ast (value, other.value)
					and then same_ast (renamings, other.renamings)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			Precursor {D_OPTION_SD} (st)
			if renamings /= Void then
				st.put_new_line
				st.put_string ("rename")
				st.indent
				renamings.save (st)
				st.exdent
				st.put_string ("end")
			end
		end

feature {COMPILER_EXPORTER} -- Renaming

	rename_clusters (univ: UNIVERSE_I) is
			-- Rename clusters according to `renamings' specification.
		require
			univ_not_void: univ /= Void
		local
			cluster, other_cluster: CLUSTER_I;
			old_name, new_name: STRING;
			cluster_list: ARRAYED_LIST [CLUSTER_I];
			renamed_clusters: HASH_TABLE [CLUSTER_I, STRING];
			vdcn: VDCN;
			vd48: VD48;
			vd49: VD49;
			vd50: VD50
		do
			if renamings /= Void and then not renamings.is_empty then
				create renamed_clusters.make (renamings.count);
				from renamings.start until renamings.after loop
					create old_name.make (10);
					old_name.append (renamings.item.old_name);
					old_name.to_lower;
					create new_name.make (10);
					new_name.append (renamings.item.new_name);
					new_name.to_lower;
					cluster := univ.cluster_of_name (old_name);
					if cluster = Void then
							-- `old_name': unknown cluster
						create vd48;
						vd48.set_path (value.value);
						vd48.set_cluster_name (renamings.item.old_name);
						Error_handler.insert_error (vd48);
						Error_handler.raise_error
					elseif renamed_clusters.has (new_name) then
							-- `new_name' listed twice in the rename list
						create vd49;
						vd49.set_path (value.value);
						vd49.set_new_name (renamings.item.new_name);
						Error_handler.insert_error (vd49);
						Error_handler.raise_error
					elseif renamed_clusters.has_item (cluster) then
							-- `old_name' listed twice in the rename list
						create vd50;
						vd50.set_path (value.value);
						vd50.set_old_name (renamings.item.old_name);
						Error_handler.insert_error (vd50);
						Error_handler.raise_error
					else
						renamed_clusters.put (cluster, new_name)
					end;
					renamings.forth
				end;
					-- Rename clusters.
				from renamed_clusters.start until renamed_clusters.after loop
					renamed_clusters.item_for_iteration.set_cluster_name (renamed_clusters.key_for_iteration);
					renamed_clusters.forth
				end;
					-- Check for new name clashes.
				cluster_list := univ.clusters;
				from cluster_list.start until cluster_list.after loop
					cluster := cluster_list.item;
					other_cluster := renamed_clusters.item (cluster.cluster_name);
					if
						other_cluster /= Void and then
						other_cluster /= cluster
					then
							-- Two clusters with the same name:
							-- `cluster' and `other_cluster'.
						create vdcn;
						vdcn.set_cluster (cluster);
						Error_handler.insert_error (vdcn);
						Error_handler.raise_error
					end;
					cluster_list.forth
				end
			end
		end

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

end -- class D_PRECOMPILED_SD
