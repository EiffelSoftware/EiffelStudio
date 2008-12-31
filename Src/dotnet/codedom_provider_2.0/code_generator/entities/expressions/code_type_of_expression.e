note 
	description: "Source code generator for type of expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_TYPE_OF_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target)
			-- Creation routine
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end
		
feature -- Access

	target: CODE_TYPE_REFERENCE
			-- Type of expression target
			
	code: STRING
			-- | Result := "{TYPE_NAME}"
			-- | Result C# := "typeof(`type_name')"
			-- Eiffel code of `type of' expression
		do
			create Result.make (120)
			Result.append ("{")
			Result.append (target.eiffel_name)
			Result.append ("}")
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE
			-- Type
		do
			Result := Type_type_reference
		end

invariant
	non_void_target: target /= Void
	
note
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
end -- class CODE_TYPE_OF_EXPRESSION

