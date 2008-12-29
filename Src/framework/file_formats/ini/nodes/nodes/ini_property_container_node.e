note
	description: "Base implementation for all AS nodes that can contain property AS nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_PROPERTY_CONTAINER_NODE

feature {NONE} -- Initialization

	make
			-- Initialize container
		do
			create mutable_properties.make (1)
			create mutable_literals.make (1)
		end

feature -- Access

	properties: LIST [INI_PROPERTY_NODE]
			-- List of properties contained within current container
		do
			Result := mutable_properties
		ensure
			result_attached: Result /= Void
		end

	literals: LIST [INI_LITERAL_NODE]
			-- List of literals
		do
			Result := mutable_literals
		ensure
			result_attached: Result /= Void
		end

feature -- Extension

	extend_property (a_property: INI_PROPERTY_NODE)
			-- Extends container with property `a_property'.
		require
			a_property_attached: a_property /= Void
			already_added: not properties.has (a_property)
		do
			mutable_properties.extend (a_property)
		ensure
			a_property_added: properties.has (a_property)
		end

	extend_literal (a_id: INI_LITERAL_NODE)
			-- Extends container with literal `a_id'.
		require
			a_id_attached: a_id /= Void
			already_added: not literals.has (a_id)
		do
			mutable_literals.extend (a_id)
		ensure
			a_id_added: literals.has (a_id)
		end

feature {NONE} -- Implementation

	mutable_properties: ARRAYED_LIST [INI_PROPERTY_NODE]
			-- Mutable version of `properties'

	mutable_literals: ARRAYED_LIST [INI_LITERAL_NODE]
			-- Mutable version of `literals'			

invariant
	mutable_properties_attached: mutable_properties /= Void

note
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

end -- class {INI_PROPERTY_CONTAINER_NODE}
