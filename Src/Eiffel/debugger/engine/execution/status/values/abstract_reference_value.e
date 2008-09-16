indexing
	description: "[
		Represents the abstraction of a Reference value for the debugger
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ABSTRACT_REFERENCE_VALUE

inherit
	ABSTRACT_DEBUG_VALUE
		redefine
			address,
			debug_value_type_id
		end

feature -- Properties

	address: DBG_ADDRESS
			-- Address of referenced object (Void if no object)

	string_value: STRING_32
			-- Value if the reference object is a STRING

	is_null: BOOLEAN
			-- Value represents Void element

feature -- Expanded status

	is_expanded: BOOLEAN
			-- Is Current value an expanded object ?

feature {NONE} -- Output

	output_value: STRING_32 is
			-- Return a string representing `Current'.
		do
			if
				is_null or else
				(not {add: like address} address or else add.is_void)
			then
				Result := "Void"
			else
				Result := "[" + add.output + "]"
			end
		end

feature -- Output

	expandable: BOOLEAN is
			-- Does `Current' have sub-items?
			-- (Is it a non void reference, a special object, ...)
		do
			Result := not is_null
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		local
			cl: CLASS_C
		do
			if not is_null then
				Result := Reference_value
				cl := dynamic_class
				if is_expanded then
					Result := Expanded_value
				end
			else
				Result := Void_value
			end
		end

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := abstract_reference_value_id
		end

invariant
	address_void_only_for_expanded: address = Void implies is_expanded

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

end -- class ABSTRACT_REFERENCE_VALUE
