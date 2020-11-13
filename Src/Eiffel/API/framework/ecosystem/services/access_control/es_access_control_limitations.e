note
	description: "Summary description for {ES_ACCESS_CONTROL_LIMITATIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCESS_CONTROL_LIMITATIONS

create
	make

feature {NONE} -- Initialization

	make (a_plan_name: READABLE_STRING_GENERAL)
		do
		end

feature -- Access

	add_rule (a_issuer: READABLE_STRING_GENERAL; a_operation: READABLE_STRING_GENERAL; a_rule: ACCESS_CONTROL_RULE)
		local
			tb: like rules_table
			lst: like rules
			k: like rules_key
		do
			tb := rules_table
			if tb = Void then
				create tb.make_caseless (1)
				rules_table := tb
			end
			k := rules_key (a_issuer, a_operation)
			lst := tb [k]
			if lst = Void then
				create {ARRAYED_LIST [ACCESS_CONTROL_RULE]} lst.make (1)
				tb [k] := lst
			end
			lst.force (a_rule)
		end

	rules (a_issuer: READABLE_STRING_GENERAL; a_operation: READABLE_STRING_GENERAL): detachable LIST [ACCESS_CONTROL_RULE]
		do
			if attached rules_table as tb then
				Result := tb [rules_key (a_issuer, a_operation)]
			end
		end

feature {NONE} -- Implementation

	rules_key (a_issuer, a_operation: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make (a_issuer.count + 1 + a_operation.count)
			Result.append_string_general (a_issuer.as_upper)
			Result.append_string_general ("::")
			Result.append_string_general (a_operation.as_lower)
		end

	rules_table: detachable STRING_TABLE [like rules]
			-- List of rules, indexed by `issuer+operation`.

invariant

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
