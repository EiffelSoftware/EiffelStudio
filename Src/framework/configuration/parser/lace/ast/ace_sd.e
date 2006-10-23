indexing
	description: "Representation of a Lace AST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ACE_SD

inherit
	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (sn: like system_name; r: like root;
		d: like defaults; c: like clusters; a: like assemblies;
		e: like externals) is
			-- Create a new ACE AST node.
		require
			sn_not_void: sn /= Void
			r_not_void: r /= Void
		do
			system_name := sn
			root := r
			defaults := d
			clusters := c
			assemblies := a
			externals := e
		ensure
			system_name_set: system_name = sn
			root_set: root = r
			defaults_set: defaults = d
			clusters_set: clusters = c
			assemblies_set: assemblies = a
			externals_set: externals = e
		end

feature -- Properties

	system_name: ID_SD
			-- System name

	root: ROOT_SD;
			-- Decription to the root clause

	defaults: LACE_LIST [D_OPTION_SD];
			-- Description of the default clause

	clusters: LACE_LIST [CLUSTER_SD];
			-- Description of cluster clauses

	assemblies: LACE_LIST [ASSEMBLY_SD]
			-- Description of assemblies

	externals: LACE_LIST [LANG_TRIB_SD];
			-- Description of extenal clauses

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

end -- class ACE_SD

