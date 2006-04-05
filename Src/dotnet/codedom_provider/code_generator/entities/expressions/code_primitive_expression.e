indexing 
	description: "Source code generator for primitive expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_PRIMITIVE_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_value: like value) is
			-- Initialize `value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end
		
feature -- Access

	value: SYSTEM_OBJECT
			-- Object to represent
			
	code: STRING is
			-- | Result := "`value'" 
			-- | OR		:= "("`value'").to_cil" if value is SYSTEM_STRING
			-- Eiffel code of primitive expression
		local
			l_string: STRING
			l_system_string: SYSTEM_STRING
			i: INTEGER
		do
			l_string := value.to_string
			l_system_string ?= value
			if l_system_string /= Void then
				create Result.make (l_string.count + 10)			
				Result.append ("(%"")
				from
					i := 1
				until
					i > l_string.count
				loop
					inspect 
						l_string.item (i)
					when '%R' then
						Result.append ("%%R")
					when '%T' then
						Result.append ("%%T")
					when '%"' then
						Result.append ("%%%"")
					when '%%' then
						Result.append ("%%%%")
					when '%'' then
						Result.append ("%%%'")
					when '%N' then
						Result.append ("%%N")
					else
						Result.append_character (l_string.item (i))
					end
					
					i := i + 1
				end
				Result.append ("%").to_cil")
			else
				Result := l_string
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := Type_reference_factory.type_reference_from_type (value.get_type)
		end

invariant
	non_void_value: value /= Void

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


end -- class CODE_PRIMITIVE_EXPRESSION

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