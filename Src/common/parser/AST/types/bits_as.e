indexing
	description: "Representation of a BIT type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BITS_AS

inherit
	TYPE_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (v: like bits_value; b_as: KEYWORD_AS) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		do
			bits_value := v
			bit_keyword := b_as
		ensure
			bits_value_set: bits_value = v
			bit_keyword_set: bit_keyword = b_as
		end
feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bits_as (Current)
		end

feature -- Roundtrip

	bit_keyword: KEYWORD_AS
		-- Keyword "bit" associated with this structure		

feature -- Attributes

	bits_value: INTEGER_AS
			-- Bits value

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				Result := bits_value.complete_start_location (a_list)
			else
				Result := bit_keyword.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := bits_value.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_value, other.bits_value)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bits_value.integer_32_value)
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

end -- class BITS_AS
