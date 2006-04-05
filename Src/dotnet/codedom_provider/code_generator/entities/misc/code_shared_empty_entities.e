indexing
	description: "Empty entities used when CodeDom tree is corrupted"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_EMPTY_ENTITIES

inherit
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

feature -- Access

	Empty_snippet_feature: CODE_SNIPPET_FEATURE is
			-- Empty snippet feature
		once
			create Result.make ("empty_", "empty_ is do end%N")
		end

	Empty_attribute: CODE_ATTRIBUTE is
			-- Empty attribute
		once
			create Result.make ("empty_", "empty_")
			Result.set_result_type (Empty_type_reference)
		end

	Empty_routine: CODE_ROUTINE is
			-- Empty routine
		once
			create {CODE_ROUTINE_IMP} Result.make ("empty_", "empty_")
		end

	Empty_type_reference: CODE_TYPE_REFERENCE is
			-- Empty type reference
		local
			l_member_reference: CODE_MEMBER_REFERENCE
		once
			Result := None_type_reference
			create l_member_reference.make ("empty_", None_type_reference, False)
			l_member_reference.set_initialized
			Result.add_member (l_member_reference)
		end
		
	Empty_member_reference: CODE_MEMBER_REFERENCE is
			-- Empty member reference
		once
			Result := Empty_type_reference.member ("empty_", Void)
		end
	
	Empty_expression: CODE_EXPRESSION is
			-- Empty expression
		once
			create {CODE_PRIMITIVE_EXPRESSION} Result.make (("").to_cil)
		end

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


end -- class CODE_SHARED_EMPTY_ENTITIES

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------