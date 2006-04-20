indexing
	description: "Representation of a root class specification"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROOT_SD

inherit
	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (rn: like root_name; cm: like cluster_mark;
		cp: like creation_procedure_name) is
			-- Create a new ROOT AST node.
		require
			rn_not_void: rn /= Void
		do
				-- Class names are stored in upper, thus the conversion to upper cases.
			root_name := rn
			root_name.to_upper
			cluster_mark := cm
			if cluster_mark /= Void then
				cluster_mark.to_lower
			end
			creation_procedure_name := cp
			if creation_procedure_name /= Void then
				creation_procedure_name.to_lower
			end
		ensure
			root_name_set: root_name.is_equal (rn.as_upper)
			cluster_mark_set: cluster_mark = cm
			creation_procedure_name_set: creation_procedure_name = cp
		end

feature -- Properties

	root_name: ID_SD;
			-- Root class name

	cluster_mark: ID_SD;
			-- Cluster where the root class is
			-- Can be Void

	creation_procedure_name: ID_SD;
			-- Creation procedure

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

end -- class ROOT_SD
