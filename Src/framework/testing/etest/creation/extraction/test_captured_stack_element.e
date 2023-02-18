note
	description: "[
		Objects representing a call stack element, referring to the feature called in the specific
		element and its attributes and objects.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURED_STACK_ELEMENT

create
	make

feature {NONE} -- Initialization

	make (a_feature: like called_feature; a_type: like type)
			-- Initialize `Current'.
		do
			type := a_type
			called_feature := a_feature
			if is_creation_procedure then
				create internal_operands.make (called_feature.argument_count)
			else
				create internal_operands.make (called_feature.argument_count + 1)
			end
			create internal_types.make (internal_operands.capacity)
		ensure
			called_feature_set: called_feature = a_feature
		end

feature -- Access

	called_feature: E_FEATURE
			-- Feature called in stack element

	type: STRING
			-- Dynamic type for `called_feature'

	operands: LIST [STRING_32]
			-- Operands needed to invoce `called_feature'
		do
			Result := internal_operands
		end

	types: LIST [STRING_32]
			-- Types for `operands'
		do
			Result := internal_types
		end

feature {NONE} -- Access

	internal_operands: ARRAYED_LIST [STRING_32]
			-- Internal storage for `operands'

	internal_types: ARRAYED_LIST [STRING_32]
			-- Internal storage for `types'

feature -- Status report

	are_operands_complete: BOOLEAN
			-- Does `operands' have correct amount of items to invoce `called_feature'?
		local
			l_count: INTEGER
		do
			l_count := called_feature.argument_count
			if not is_creation_procedure then
				l_count := l_count + 1
			end
			Result := internal_operands.count = l_count
		end

	is_creation_procedure: BOOLEAN
			-- Is `called_feature' a creation procedure?
		local
			l_class: CLASS_C
		do
			l_class := called_feature.associated_class
			Result := l_class.creation_feature = called_feature.associated_feature_i
			if not Result then
				Result := l_class.has_creator_named_with (called_feature)
			end
		end

feature {TEST_CAPTURER} -- Element change

	add_operand (a_operand: STRING_32; a_type: STRING_32)
			-- Add `a_operand' to `operands'.
		require
			not_complete: not are_operands_complete
		do
			internal_operands.force (a_operand)
			internal_types.force (a_type)
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
