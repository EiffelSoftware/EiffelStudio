indexing
	description: "Objects that is a model for a client supplier link."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EM_CLIENT_SUPPLIER_LINK

inherit
	EG_LINK
		rename
			source as client,
			target as supplier
		redefine
			default_create,
			client, supplier
		end

create
	make_with_classes_and_name

feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_CLIENT_SUPPLIER_LINK.
		do
			Precursor {EG_LINK}
			create is_aggregated_changed
		end

	make_with_classes_and_name (a_client, a_supplier: like client; a_name: like name) is
			-- Create a EIFFEL_CLIENT_SUPPLIER_LINK with `a_name'.
		require
			a_client_not_void: a_client /= Void
			a_supplier_not_void: a_supplier /= Void
			a_name_not_void: a_name /= Void
		do
			make_directed_with_source_and_target (a_client, a_supplier)
			name := a_name
			if a_supplier.is_expanded then
				is_aggregated := True
			end
		ensure
			set: client = a_client and supplier = a_supplier
			name_set: name = a_name
		end

feature -- Access

	client: EM_CLASS
			-- Client of the link.

	supplier: EM_CLASS
			-- Supplier of the link.

feature -- Status report

	is_aggregated: BOOLEAN
			-- Is `Current' an aggregated link (`supplier' is expanded)?.

	is_aggregated_changed: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `is_aggregated' is changed.

feature -- Status settings

	set_is_aggregated (b: BOOLEAN) is
			-- Set `is_aggregated' to `b'.
		do
			if b /= is_aggregated then
				is_aggregated := b
				is_aggregated_changed.call (Void)
			end
		ensure
			set: is_aggregated = b
		end

invariant
	is_aggregated_changed_not_void: is_aggregated_changed /= Void

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

end -- class EM_CLIENT_SUPPLIER_LINK
