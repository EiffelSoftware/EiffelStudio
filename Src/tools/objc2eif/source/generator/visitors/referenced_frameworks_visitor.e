note
	description: "A visitor that finds all the frameworks referenced by the parsed Objective-C system."
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCED_FRAMEWORKS_VISITOR

inherit
	OBJC_ENTITY_DECL_VISITOR
		redefine
			visit_class_decl,
			visit_protocol_decl,
			visit_category_decl
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create referenced_frameworks.make (0)
			referenced_frameworks.compare_objects
		end

feature -- Access

	referenced_frameworks: ARRAYED_LIST [STRING]
			-- A list of frameworks names referenced by the parsed Objective-C system.

feature -- Operations

	visit_class_decl (c: OBJC_CLASS_DECL)
			-- Visit a class declaration.
		local
			categories: HASH_TABLE [OBJC_CATEGORY_DECL, STRING]
			framework: STRING
		do
			framework := c.framework
			if not referenced_frameworks.has (framework) then
				referenced_frameworks.extend (framework)
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

	visit_protocol_decl (p: OBJC_PROTOCOL_DECL)
			-- Visit a protocol declaration.
		local
			framework: STRING
		do
			if not p.is_forward_reference then
				framework := p.framework
				if not referenced_frameworks.has (framework) then
					referenced_frameworks.extend (framework)
				end
			end
		end

	visit_category_decl (c: OBJC_CATEGORY_DECL)
			-- Visit a category declaration.
		local
			framework: STRING
		do
			framework := c.framework
			if framework.is_empty then
				print ("empty")
			end
			if not referenced_frameworks.has (framework) then
				referenced_frameworks.extend (framework)
			end
		end
end
