indexing
	description: "References to standard .NET types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_STOCK_TYPE_REFERENCES

inherit
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

feature -- Access

	None_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to NONE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Void"))
		end

	Object_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to NONE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Object"))
		end

	Boolean_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to BOOLEAN
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Boolean"))
		end

	Double_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to System.Double
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Double"))
		end

	Type_type_reference: CODE_TYPE_REFERENCE is
			-- Reference to SYSTEM_TYPE
		once
			Result := Type_reference_factory.type_reference_from_type ({SYSTEM_TYPE}.get_type ("System.Type"))
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
end -- class CODE_STOCK_TYPE_REFERENCES

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------