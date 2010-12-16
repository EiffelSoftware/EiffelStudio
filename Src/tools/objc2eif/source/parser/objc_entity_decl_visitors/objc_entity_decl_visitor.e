note
	description: "[
			A general Objective-C entity declaration visitor.
			By default it recursively visits the Objective-C entity declaration.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJC_ENTITY_DECL_VISITOR

feature -- Operations

	visit_argument_decl (a: OBJC_ARGUMENT_DECL)
			-- Visit an argument declaration.
		do
			if attached a.type as type then
				visit_type_decl (type)
			end
		end

	visit_category_decl (c: OBJC_CATEGORY_DECL)
			-- Visit a category declaration.
		local
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
		do
				-- Visit methods.
			methods := c.methods
			from
				methods.start
			until
				methods.after
			loop
				visit_method_decl (methods.item_for_iteration)
				methods.forth
			end
				-- Visit properties.
			properties := c.properties
			from
				properties.start
			until
				properties.after
			loop
				visit_property_decl (properties.item_for_iteration)
				properties.forth
			end
		end

	visit_class_decl (c: OBJC_CLASS_DECL)
			-- Visit a class declaration.
		local
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
			categories: HASH_TABLE [OBJC_CATEGORY_DECL, STRING]
		do
				-- Visit methods.
			methods := c.methods
			from
				methods.start
			until
				methods.after
			loop
				visit_method_decl (methods.item_for_iteration)
				methods.forth
			end
				-- Visit properties.
			properties := c.properties
			from
				properties.start
			until
				properties.after
			loop
				visit_property_decl (properties.item_for_iteration)
				properties.forth
			end
				-- Visit categories.
			categories := c.categories
			from
				categories.start
			until
				categories.after
			loop
				visit_category_decl (categories.item_for_iteration)
				categories.forth
			end
		end

	visit_method_decl (m: OBJC_METHOD_DECL)
			-- Visit a method declaration.
		do
			visit_type_decl (m.return_type)
			m.arguments.do_all (agent visit_argument_decl)
		end

	visit_property_decl (p: OBJC_PROPERTY_DECL)
			-- Visit a property declaration.
		do
			visit_type_decl (p.type)
		end

	visit_protocol_decl (p: OBJC_PROTOCOL_DECL)
			-- Visit a protocol declaration.
		local
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			properties: HASH_TABLE [OBJC_PROPERTY_DECL, STRING]
		do
				-- Visit methods.
			methods := p.methods
			from
				p.methods.start
			until
				p.methods.after
			loop
				visit_protocol_method_decl (p.methods.item_for_iteration)
				p.methods.forth
			end
				-- Visit properties.
			properties := p.properties
			from
				p.properties.start
			until
				p.properties.after
			loop
				visit_property_decl (p.properties.item_for_iteration)
				p.properties.forth
			end
		end

	visit_protocol_method_decl (m: OBJC_PROTOCOL_METHOD_DECL)
			-- Visit a method declaration.
		do
			visit_method_decl (m)
		end

	visit_type_decl (t: OBJC_TYPE_DECL)
			-- Visit a type declaration.
		do
		end

end
