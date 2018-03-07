note
	description: "Tester for an associated configuration namespace."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_NAMESPACE_TESTER

inherit
	CONF_FILE_CONSTANTS

feature {NONE} -- Access

	namespace: detachable like latest_namespace
			-- Associated namespace.
			-- Used by `includes_this_or_before' and `includes_this_or_after'.

feature {NONE} -- Namespace checks

	includes_this_or_before (n: like latest_namespace): BOOLEAN
			-- Is current `namespace' less or equal to `n'?
			-- (Includes unknown namespaces.)
		require
			n_attached: attached n
			n_known: is_namespace_known (n)
		do
			Result := is_before_or_equal (namespace, n)
		ensure
			definition: Result = is_before_or_equal (namespace, n)
		end

	includes_this_or_after (n: like latest_namespace): BOOLEAN
			-- Is current `namespace' greater or equal to `n'?
			-- (Includes unknown namespaces.)
		require
			n_attached: attached n
			n_known: is_namespace_known (n)
		do
			Result := is_after_or_equal (namespace, n)
		ensure
			definition: Result = is_after_or_equal (namespace, n)
		end

	includes_this_or_between (n1, n2: like latest_namespace): BOOLEAN
			-- Is current `namespace' less or equal to `n1` and greater or equal to `n2`?
			-- (Excludes unknown namespaces.)
		require
			n1_attached: attached n1
			n1_known: is_namespace_known (n1)
			n2_attached: attached n2
			n2_known: is_namespace_known (n2)
		do
			Result := is_between_or_equal (namespace, n1, n2)
		ensure
			definition: Result = is_between_or_equal (namespace, n1, n2)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
