note
	description: "An Objective-C category declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_CATEGORY_DECL

inherit
	OBJC_ENTITY_DECL

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_base_class: OBJC_CLASS_DECL; a_framework: STRING; a_header: STRING)
			-- Initialize Current with `a_name', `a_base_class', `a_framework' and `a_header'
		require
			a_valid_name: not a_name.is_empty
			a_valid_framework: not a_framework.is_empty
			a_valid_header: not a_header.is_empty
		do
			name := a_name
			base_class := a_base_class
			framework := a_framework
			header := a_header
			create methods.make (0)
			create protocols.make (0)
			create properties.make (0)
		ensure
			name_set: name = a_name
			base_class_set: base_class = a_base_class
			framework_set: framework = a_framework
			header_set: header = a_header
		end

feature -- Visitor Pattern

	accept (visitor: OBJC_ENTITY_DECL_VISITOR)
			-- Accept `visitor'.
		do
			visitor.visit_category_decl (Current)
		end

feature -- Access

	name: STRING
			-- Name of this category.

	base_class: OBJC_CLASS_DECL
			-- The class corresponding to this category declaration.

	methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			-- Table of class declarations indexed by the name.

	protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			-- Table of protocol declarations indexed by the name.

	properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
			-- Table of properties declarations indexed by the name.

	framework: STRING
			-- The framework this class declaration belongs to.

	header: STRING
			-- The name of the header file this class was declared in.

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			visitor: OBJC_DEBUG_VISITOR
		do
			create visitor.make
			accept (visitor)
			Result := visitor.last_result
		end

end
