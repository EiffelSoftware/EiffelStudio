indexing
	description: "Representation of operator %"/%" when used in a composite%N%
				%metric definition to ease metric calculation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_OPERATOR_DIVIDE

inherit
	EB_METRIC_OPERATOR

create
	make

feature -- Initialization

	make (v1, v2: EB_METRIC_VALUE) is
			--	Set values for division.
		require
			effective_values: v1 /= Void and v2 /= Void
		do
			value1 := v1
			value2 := v2
		end

feature -- Access

	value1, value2: EB_METRIC_VALUE
		-- values current operator applies to.

feature -- Value

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate division of `value2' over `value1' over scope `s'.
		do
			if value1.value (s) /= 0 then
				Result := value2.value (s) / value1.value (s)
					-- Caution !! Value1 and value2 are inverted when
					-- storing in a stack. That is why we calculate
					-- value2 / value1 and not value1 / value2
			else
				Result := -123456
			end
		end

indexing
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

end -- class EB_METRIC_OPERATOR_DIVIDE
