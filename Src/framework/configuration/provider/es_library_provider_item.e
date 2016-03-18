note
	description: "Item provided by ES_LIBRARY_PROVIDER."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_PROVIDER_ITEM

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_score: REAL; a_value: ANY; a_identifier: READABLE_STRING_GENERAL)
		do
			score := a_score
			value := a_value
			identifier := a_identifier
		end

feature -- Access

	score: REAL
			-- Score in the context of associated search.

	identifier: READABLE_STRING_GENERAL
			-- String identifier of `value'.

	value: ANY

	score_is_zero: BOOLEAN
		do
			Result := score <= {REAL_32}.machine_epsilon
		end

feature -- Access: additional information

	info (a_name: READABLE_STRING_GENERAL): detachable ANY
		do
			if attached additional_information as tb then
				Result := tb.item (a_name)
			end
		end

	set_info (a_value: detachable ANY; a_name: READABLE_STRING_GENERAL)
		local
			tb: like additional_information
		do
			tb := additional_information
			if a_value /= Void then
				if tb = Void then
					create tb.make_caseless (1)
					additional_information := tb
				end
				tb.force (a_value, a_name)
			elseif tb /= Void then
				tb.remove (a_name)
			end
		end

feature {NONE} -- Access: additional information

	additional_information: detachable STRING_TABLE [ANY]
			-- Optional additional information.

feature -- Status report	

	is_less alias "<" (other: ES_LIBRARY_PROVIDER_ITEM): BOOLEAN
			-- Is current object less than `other'?
			-- Higher score first, and then sort on identifier.
		do
			if score > other.score then
				Result := True
			else
				if other.score - score <= {REAL_32}.machine_epsilon then
					check score <= other.score end
					Result := identifier.as_string_32 < other.identifier.as_string_32
				else
					Result := False
				end
			end
		ensure then
			asymmetric: Result implies not (other < Current)
		end

	debug_output: STRING_32
			-- <Precursor>.
		do
			create Result.make (5)
			Result.append_character ('[')
			Result.append (score.out)
			Result.append_character (']')
			if attached {DEBUG_OUTPUT} value as dbg then
				Result.append_string_general (dbg.debug_output)
			end
		end

invariant
	valid_score: score >= 0

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
