indexing
	description: "Cluster adaptation clause description in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CLUST_ADAPT_SD

inherit

	AST_LACE

feature -- Properties

	cluster_name: ID_SD;
			-- Name of the cluster to adapt

feature {COMPILER_EXPORTER}

	good_cluster: BOOLEAN is
			--- Check existence of cluster named `cluster_name'.
		local
			vd03: VD03;
			vd05: VD05;
			cluster: CLUSTER_I;
		do
			cluster := Universe.cluster_of_name (cluster_name);
			Result := True;
				-- Existence of cluster
			if cluster = Void then
				create vd03;
				vd03.set_cluster_name (cluster_name);
				Error_handler.insert_error (vd03);
				Result := False;
			elseif cluster = context.current_cluster then
					-- Check if `cluster' is not the current analyzed one
				create vd05;
				vd05.set_cluster_name (cluster_name);
				Error_handler.insert_error (vd05);
				Result := False;
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

end -- class CLUST_ADAPT_SD
