note
	description: "Constants to define a type. See Partition II 22.1.14"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE_ATTRIBUTES

feature -- Visibility attributes

	visibility_mask: INTEGER = 0x00000007
			-- Use this mask to retrieve visibility information.
			
	not_public: INTEGER = 0x00000000
			-- Class has no public scope.

	Public: INTEGER = 0x00000001
			-- Class has public scope.

	nested_public: INTEGER = 0x00000002
			-- Class is nested with public visibility.

	nested_private: INTEGER = 0x00000003
			-- Class is nested with private visibility.

	nested_family: INTEGER = 0x00000004
			-- Class is nested with family visibility.

	nested_assembly: INTEGER = 0x00000005
			-- Class is nested with assembly visibility.

	nested_family_and_assembly: INTEGER = 0x00000006
			-- Class is nested with family and assembly visibility.

	nested_family_or_assembly: INTEGER = 0x00000007
			-- Class is nested with family or assembly visibility.

feature -- Class layout attributes

	layout_mask: INTEGER = 0x00000018
			-- Use this mask to retrieve class layout information.

	auto_layout: INTEGER = 0x00000000
			-- Class fields are auto-laid out.

	sequential_layout: INTEGER = 0x00000008
			-- Class fields are laid out sequentially.

	explicit_layout: INTEGER = 0x00000010
			-- Layout is supplied explicitly.

feature -- Class semantics attributes

	class_semantic_mask: INTEGER = 0x00000020
			-- Use this mask to retrive class semantics information.

	is_class: INTEGER = 0x00000000
			-- Type is a class.

	is_interface: INTEGER = 0x00000020
			-- Type is an interface.

feature -- Special semantics in addition to class semantics

	abstract: INTEGER = 0x00000080
			-- Class is abstract.

	sealed: INTEGER = 0x00000100
			-- Class cannot be extended.

	special_name: INTEGER = 0x00000400
			-- Class name is special.

feature -- Implementation Attributes

	import: INTEGER = 0x00001000
			-- Class/Interface is imported.

	serializable: INTEGER = 0x00002000
			-- Class is serializable.

feature -- String formatting Attributes

	string_format_mask: INTEGER = 0x00030000
			-- Use this mask to retrieve string information for native interop.

	ansi_class: INTEGER = 0x00000000
			-- LPSTR is interpreted as ANSI.

	unicode_class: INTEGER = 0x00010000
			-- LPSTR is interpreted as Unicode.

	auto_class: INTEGER = 0x00020000
			-- LPSTR is interpreted automatically.

feature -- Class Initialization Attributes

	before_field_init: INTEGER = 0x00100000
			-- Initialize the class before first static field access.

feature -- Additional Flags

	rt_special_name: INTEGER = 0x00000800
			-- CLI provides 'special' behavior, depending upon the name of the Type.

	has_security: INTEGER = 0x00040000;
			-- Type has security associate with it.

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

end -- class MD_TYPE_ATTRIBUTES
