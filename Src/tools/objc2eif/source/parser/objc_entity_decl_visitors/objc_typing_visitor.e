note
	description: "[
			A visitor that completes the types of the Objective-C entities declarations
			with the corresponding Objective-C type encodings.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_TYPING_VISITOR

inherit
	OBJC_ENTITY_DECL_VISITOR
		redefine
			visit_argument_decl,
			visit_method_decl,
			visit_property_decl
		end

create
	make

feature {NONE} -- Initialization

	make (a_types: HASH_TABLE [STRING, STRING])
			-- Initialize Current with `a_types'.
		do
			types := a_types
		ensure
			types_set: types = a_types
		end

feature -- Operations

	visit_argument_decl (a: OBJC_ARGUMENT_DECL)
			-- Visit an argument declaration.
		local
			type_encoding_parser: OBJC_TYPE_ENCODING_PARSER
			type_decl: OBJC_TYPE_DECL
			type_name: STRING
		do
			if attached a.type as type and attached a.argument_name as argument_name then
				create type_encoding_parser
				type_name := type.name
				if attached types.item (type_name) as type_encoding then
					type_decl := type_encoding_parser.parse_type_encoding (type_encoding)
					type_decl.name := type_name
					a.set_type_and_argument_name (type_decl, argument_name)
				else
					check type_encoding_not_void: False end
				end
			end
		end

	visit_method_decl (m: OBJC_METHOD_DECL)
			-- Visit a method declaration.
		local
			type_encoding_parser: OBJC_TYPE_ENCODING_PARSER
			type_decl: OBJC_TYPE_DECL
			return_type_name: STRING
		do
			return_type_name := m.return_type.name
			if attached types.item (return_type_name) as type_encoding then
				create type_encoding_parser
				type_decl := type_encoding_parser.parse_type_encoding (type_encoding)
				type_decl.name := return_type_name
				m.return_type := type_decl
			else
				check type_encoding_not_void: False end
			end
			m.arguments.do_all (agent visit_argument_decl)
		end

	visit_property_decl (p: OBJC_PROPERTY_DECL)
			-- Visit a property declaration.
		local
			type_encoding_parser: OBJC_TYPE_ENCODING_PARSER
			type_decl: OBJC_TYPE_DECL
			type_name: STRING
		do
			create type_encoding_parser
			type_name := p.type.name
			if attached types.item (type_name) as type_encoding then
				type_decl := type_encoding_parser.parse_type_encoding (type_encoding)
				type_decl.name := type_name
				p.type := type_decl
			else
				check type_encoding_not_void: False end
			end
		end

feature {NONE} -- Implementation

	types: HASH_TABLE [STRING, STRING]
			-- Objective-C type encodings indexed by their type name.

end
