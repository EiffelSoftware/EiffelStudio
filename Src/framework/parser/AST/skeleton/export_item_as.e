note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EXPORT_ITEM_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like clients; f: like features)
			-- Create a new EXPORT_ITEM AST node.
		require
			c_not_void: c /= Void
		do
			clients := c
			features := f
		ensure
			clients_set: clients = c
			features_set: features = f
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_export_item_as (Current)
		end

feature -- Attributes

	clients: CLIENT_AS
			-- Client list.

	features: detachable FEATURE_SET_AS
			-- Feature set.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := clients.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
					-- Non-roundtrip mode
				if attached features as l_features then
					Result := l_features.last_token (a_list)
				end
			else
					-- Roundtrip mode
				if attached features as l_features then
					Result := l_features.last_token (a_list)
				else
					Result := clients.last_token (a_list)
				end
			end
		end

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			if attached clients as c then
				Result := c.index
			elseif attached features as f then
				Result := f.index
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (clients, other.clients) and
				equivalent (features, other.features)
		end

invariant
	clients_not_void: clients /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
