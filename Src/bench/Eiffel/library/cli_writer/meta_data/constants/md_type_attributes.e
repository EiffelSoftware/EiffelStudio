indexing
	description: "Constants to define a type. See Partition II 22.1.14"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TYPE_ATTRIBUTES

feature -- Visibility attributes

	visibility_mask: INTEGER is 0x00000007
			-- Use this mask to retrieve visibility information.
			
	not_public: INTEGER is 0x00000000
			-- Class has no public scope.

	Public: INTEGER is 0x00000001
			-- Class has public scope.

	nested_public: INTEGER is 0x00000002
			-- Class is nested with public visibility.

	nested_private: INTEGER is 0x00000003
			-- Class is nested with private visibility.

	nested_family: INTEGER is 0x00000004
			-- Class is nested with family visibility.

	nested_assembly: INTEGER is 0x00000005
			-- Class is nested with assembly visibility.

	nested_family_and_assembly: INTEGER is 0x00000006
			-- Class is nested with family and assembly visibility.

	nested_family_or_assembly: INTEGER is 0x00000007
			-- Class is nested with family or assembly visibility.

feature -- Class layout attributes

	layout_mask: INTEGER is 0x00000018
			-- Use this mask to retrieve class layout information.

	auto_layout: INTEGER is 0x00000000
			-- Class fields are auto-laid out.

	sequential_layout: INTEGER is 0x00000008
			-- Class fields are laid out sequentially.

	explicit_layout: INTEGER is 0x00000010
			-- Layout is supplied explicitly.

feature -- Class semantics attributes

	class_semantic_mask: INTEGER is 0x00000020
			-- Use this mask to retrive class semantics information.

	is_class: INTEGER is 0x00000000
			-- Type is a class.

	is_interface: INTEGER is 0x00000020
			-- Type is an interface.

feature -- Special semantics in addition to class semantics

	abstract: INTEGER is 0x00000080
			-- Class is abstract.

	sealed: INTEGER is 0x00000100
			-- Class cannot be extended.

	special_name: INTEGER is 0x00000400
			-- Class name is special.

feature -- Implementation Attributes

	import: INTEGER is 0x00001000
			-- Class/Interface is imported.

	serializable: INTEGER is 0x00002000
			-- Class is serializable.

feature -- String formatting Attributes

	string_format_mask: INTEGER is 0x00030000
			-- Use this mask to retrieve string information for native interop.

	ansi_class: INTEGER is 0x00000000
			-- LPSTR is interpreted as ANSI.

	unicode_class: INTEGER is 0x00010000
			-- LPSTR is interpreted as Unicode.

	auto_class: INTEGER is 0x00020000
			-- LPSTR is interpreted automatically.

feature -- Class Initialization Attributes

	before_field_init: INTEGER is 0x00100000
			-- Initialize the class before first static field access.


feature -- Additional Flags

	rt_special_name: INTEGER is 0x00000800
			-- CLI provides 'special' behavior, depending upon the name of the Type.

	has_security: INTEGER is 0x00040000
			-- Type has security associate with it.

end -- class MD_TYPE_ATTRIBUTES
