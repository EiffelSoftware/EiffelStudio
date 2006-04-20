indexing
	description: "Cluster property description for Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CLUST_PROP_SD

inherit
	AST_LACE

create
	initialize,
	default_create

feature {NONE} -- Initialization

	initialize (dep: like dependencies; us: like use_name; iop: like include_option;
		eo: like exclude_option; ao: like adapt_option;
		dop: like default_option; o: like options;
		vo: like visible_option) is
			-- Create a new CLUST_PROP AST node.
		do
			dependencies := dep
			use_name := us
			include_option := iop
			exclude_option := eo
			adapt_option := ao
			default_option := dop
			options := o
			visible_option := vo
		ensure
			dependencies_set: dependencies = dep
			use_name_set: use_name = us
			include_option_set: include_option = iop
			exclude_option_set: exclude_option = eo
			adapt_option_set: adapt_option = ao
			default_option_set: default_option = dop
			options_set: options = o
			visible_option_set: visible_option = vo
		end

feature -- Properties

	dependencies: LACE_LIST [DEPEND_SD]
			-- External dependencies.

	use_name: ID_SD;
			-- Use file

	include_option: LACE_LIST [FILE_NAME_SD];
			-- File name to include

	exclude_option: LACE_LIST [FILE_NAME_SD];
			-- File names to exclude from current cluster

	adapt_option: LACE_LIST [CLUST_ADAPT_SD];
			-- List of cluster adaptations

	default_option: LACE_LIST [D_OPTION_SD];
			-- List of default options

	options: LACE_LIST [O_OPTION_SD];
			-- List of specific options

	visible_option: LACE_LIST [CLAS_VISI_SD];
			-- Visibility

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

end -- class CLUST_PROP_SD


