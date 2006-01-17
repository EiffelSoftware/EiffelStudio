indexing
	description: "Ignore cluster adapt."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CLUST_IGN_SD

inherit
	CLUST_ADAPT_SD
		redefine
			adapt
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (cn: like cluster_name) is
			-- Create a new CLUST_IGN AST node.
		require
			cn_not_void: cn /= Void
		do
			cluster_name := cn
			cluster_name.to_lower
		ensure
			cluster_name_set: cluster_name = cn
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result.initialize (cluster_name.duplicate)
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then cluster_name.same_as (other.cluster_name)
		end

feature -- Save 

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			cluster_name.save (st)
			st.put_string (": ignore")
			st.put_new_line
		end

feature {COMPILER_EXPORTER}

	adapt is
			-- Cluster adaptation
		local
			cluster: CLUSTER_I;
			ok: BOOLEAN;
		do
				-- First check cluster existence
			ok := good_cluster;
			if ok then
				cluster := Universe.cluster_of_name (cluster_name);
				context.current_cluster.insert_cluster_to_ignore (cluster);
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

end -- class CLUST_IGN_SD
