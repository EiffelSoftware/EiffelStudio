note
	description: "[
		A basic implementation of {ES_CONTRACT_SOURCE_I} for editor source nodes that represents contracts but are not actually
		a contract themselves.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_SOURCE

inherit
	ES_CONTRACT_SOURCE_I

create
	make

feature {NONE} -- Initialization

	make (a_context: like context; a_editable: like is_editable)
			-- Initializes a contract source.
		require
			a_context_is_interface_usable: a_context.is_interface_usable
		do
			context := a_context
			is_editable := a_editable
		ensure
			context_set: context = a_context
			is_editable_set: is_editable = a_editable
		end

feature -- Access

	context: attached ES_CONTRACT_EDITOR_CONTEXT [CLASSI_STONE]
			-- <Precursor>

	source: attached ES_CONTRACT_SOURCE_I
			-- <Precursor>
		do
			Result := Current
		end

feature -- Status report

	is_editable: BOOLEAN
			-- <Precursor>

;note
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
