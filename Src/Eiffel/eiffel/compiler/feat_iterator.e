note
	description: "Iterator on features."
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class FEAT_ITERATOR

inherit

	SHARED_SERVER

feature {NONE} -- Creation

	make
			-- Setup the analyzer.
		do
				-- Take into account that indexes in `{SPECIAL}` do not start at `1`.
			create reachable_code.make_filled (False, System.body_index_counter.count + (1 - {like reachable_code}.lower))
		end

feature -- Status report

	is_code_reachable (body_index: INTEGER): BOOLEAN
			-- Is feature of `body_index` potentially reachable during execution?
		do
			Result := reachable_code.item (body_index)
		end

feature -- Modification

	mark_code_reachable (body_index: INTEGER)
			-- Mark feature body index `body_index` as potentially reachable during execution.
		do
			reachable_code.put (True, body_index)
		end

feature {NONE} -- State

	reachable_code: SPECIAL [BOOLEAN]
				-- Flags indexed by body indexes indicating if code is reachable.

;note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
