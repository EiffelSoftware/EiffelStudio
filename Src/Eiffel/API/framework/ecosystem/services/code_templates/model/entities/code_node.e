indexing
	description: "[
		Core base node for code templates, which all nodes inherit.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_NODE

inherit
	USABLE_I

feature {NONE} -- Initialization

	make
			-- Initializes a code node.
		do
		end

	frozen build_nodes (a_factory: like code_factory)
			-- Builds the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		require
			not_is_initialized: not is_initialized
		do
			initialize_nodes (a_factory)
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

	initialize_nodes (a_factory: like code_factory)
			-- Initializes the default nodes for Current.
			--
			-- `a_factory': Factory used for creating nodes.
		require
			not_is_initialized: not is_initialized
		deferred
		end

feature -- Access

	definition: !CODE_TEMPLATE_DEFINITION
			-- Top level code file.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {CODE_NODE} -- Access

	code_factory: !CODE_FACTORY
			-- Factory used for creating code nodes
		deferred
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		do
			Result := is_initialized
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Is the node initialized?

feature -- Visitor

	process (a_visitor: !CODE_TEMPLATE_VISITOR_I)
			-- Visit's the current node and processes it.
		require
			is_interface_usable: is_interface_usable
			a_visitor_is_interface_usable: a_visitor.is_interface_usable
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
