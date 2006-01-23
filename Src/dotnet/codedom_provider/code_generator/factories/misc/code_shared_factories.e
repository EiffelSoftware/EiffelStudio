indexing 
	description: "Shared instances of code factories"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_SHARED_FACTORIES

feature -- Access

	Eiffel_factory: CODE_EIFFEL_FACTORY is
			-- Factory for compile units and namespaces
		once
			create Result
		end
	
	Type_factory: CODE_TYPE_FACTORY is
			-- Factory for types
		once
			create Result
		end
	
	Member_factory: CODE_MEMBER_FACTORY is
			-- Factory for type members
		once
			create Result
		end

	Routine_factory: CODE_ROUTINE_FACTORY is
			-- Factory for type routines
		once
			create Result
		end

	Custom_attribute_factory: CODE_CUSTOM_ATTRIBUTE_FACTORY is
			-- Factory for custom attributes
		once
			create Result
		end

	Statement_factory: CODE_STATEMENT_FACTORY is
			-- Factory for statements
		once
			create Result
		end

	Event_statement_factory: CODE_EVENT_STATEMENT_FACTORY is
			-- Factory for event related statements
		once
			create Result
		end

	Exception_statement_factory: CODE_EXCEPTION_STATEMENT_FACTORY is
			-- Factory for exception statements
		once
			create Result
		end

	Argument_expression_factory: CODE_ARGUMENT_EXPRESSION_FACTORY is
			-- Factory for argument expressions
		once
			create Result
		end

	Array_expression_factory: CODE_ARRAY_EXPRESSION_FACTORY is
			-- Factory for array expressions
		once
			create Result
		end

	Property_expression_factory: CODE_PROPERTY_EXPRESSION_FACTORY is
			-- Factory for property expressions
		once
			create Result
		end
	
	Expression_factory: CODE_EXPRESSION_FACTORY is
			-- Factory for expressions
		once
			create Result
		end

	Delegate_expression_factory: CODE_DELEGATE_EXPRESSION_FACTORY is
			-- Factory for delegate expressions
		once
			create Result
		end
	
	Routine_expression_factory: CODE_ROUTINE_EXPRESSION_FACTORY is
			-- Factory for routine expressions
		once
			create Result
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


end -- class CODE_SHARED_FACTORIES

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