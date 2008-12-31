note
	description: "Icon indices in icon bitmap"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_ICONS_INDICES

feature -- Access

	Class_group: INTEGER = 6
			-- Index of classes icons
	
	Enum_group: INTEGER = 24
			-- Index of enums icons
	
	Interface_group: INTEGER = 12
			-- Index of interfaces icons
	
	Struct_group: INTEGER = 18
			-- Index of value types icons
		
	Constructor_group: INTEGER = 48
			-- Index of constructors icons
	
	Method_group: INTEGER = 60
			-- Index of methods icons
	
	Event_group: INTEGER = 126
			-- Index of events icons
	
	Property_group: INTEGER = 90
			-- Index of properties icons
	
	Read_only_property_group: INTEGER = 102
			-- Index of read-only properties icons
	
	Write_only_property_group: INTEGER = 114
			-- Index of write-only properties icons
	
	Field_group: INTEGER = 72
			-- Index of fields icons
	
	Type_snippet_group: INTEGER = 84
			-- Type snippet icons
		
	Internal_offset: INTEGER = 1
			-- Offset to internal icon in icon group
	
	Private_offset: INTEGER = 4
			-- Offset to private icon in icon group
			
	Protected_offset: INTEGER = 3
			-- Offset to protected icon in icon group
			
	Internal_and_protected_offset: INTEGER = 5
			-- Offset to internal protected icon in icon group
			
	Internal_or_protected_offset: INTEGER = 2
			-- Offset to internal protected icon in icon group
	
	Static_offset: INTEGER = 6
			-- Offset to static icon in icon group
	
	Compile_unit_icon: INTEGER = 141
			-- Index of compile unit icon
	
	Namespace_icon: INTEGER = 0
			-- Index to namespace icon

	Expression_icon: INTEGER = 146
			-- Index to expression icon
	
	Statement_icon: INTEGER = 147
			-- Index to statement icon
		
	Variable_icon: INTEGER = 2
			-- Index to variable icon		
		
	Argument_icon: INTEGER = 1
			-- Index to argument icon		
		
	Primitive_icon: INTEGER = 36
			-- Index to primitive icon		
		
	Error_icon: INTEGER = 138;
			-- Index to statement icon		
		
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


end -- class TESTER_ICONS_INDICES

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------