note
	description: "Name of unicode symbol to be inserted by autocomplete after N=2 character(s) are typed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYMBOLS_FOR_DELAYED_COMPLETION

inherit
	EB_SYMBOLS_FOR_COMPLETION
		redefine
			name_matcher
		end

create
	make,
	make_parent

create {NAME_FOR_COMPLETION}
	make_with_name

feature {EB_SYMBOLS_FOR_DELAYED_COMPLETION} -- Implementation

	name_matcher: COMPLETION_NAME_MATCHER
			-- Name matcher
		local
			n: INTEGER
		once
			if attached preferences.editor_data.minimum_count_for_unicode_symbols_completion_preference as p then
					-- Due to annoying design based on onces!
					-- this dirty code is to update the min_count value when associated preference is changed.
				p.change_actions.extend (agent (ip: INTEGER_PREFERENCE)
					local
						c: EB_SYMBOLS_FOR_DELAYED_COMPLETION
					do
						create c.make_with_name ("_dummy_")
						if
							attached {UNICODE_SYMBOL_COMPLETION_NAME_MATCHER} c.name_matcher as nm and then
							ip.value >= 0
						then
							nm.set_minimum_count (ip.value)
						end
					end(p))
				n := p.value
			else
				n := 3
			end
			create {UNICODE_SYMBOL_COMPLETION_NAME_MATCHER} Result.make_with_minimum_count (n)

		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
