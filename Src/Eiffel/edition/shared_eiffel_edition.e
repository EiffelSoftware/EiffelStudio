note
	description: "Summary description for {SHARED_EIFFEL_EDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EIFFEL_EDITION

feature -- Status

	is_eiffel_edition_defined: BOOLEAN
			-- Has the edition been defined?
		do
			Result := eiffel_edition_cell.item /= Void
		ensure
			instance_free: class
		end

feature -- Update

	set_eiffel_edition (a_edition: like eiffel_edition)
			-- Set `eiffel_edition' to `a_edition'.
		require
			a_edition_ok: a_edition /= Void
		do
			eiffel_edition_cell.put (a_edition)
		ensure
			instance_free: class
			is_eiffel_edition_defined: is_eiffel_edition_defined
		end

feature -- Access

	eiffel_edition: detachable EIFFEL_EDITION
			-- Edition of Eiffel.
		do
			if attached eiffel_edition_cell.item as l_result then
				Result := l_result
			end
		ensure
			instance_free: class
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	eiffel_edition_cell: CELL [detachable EIFFEL_EDITION]
			-- Cell to hold the edition.
		once
			create Result.put (Void)
		ensure
			instance_free: class
			result_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
