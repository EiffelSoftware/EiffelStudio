indexing
	description: "Schema widget rendering routines for particular kinds of schema information."
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEMA_RENDERING_FACTORY

feature -- Element Rendering

	element_tree_render (schema: DOCUMENT_SCHEMA; tree: EV_TREE) is
			-- Render elements from `schema' in `tree'
		require
			schema_not_void: schema /= Void
			tree_not_void: tree /= Void
		do
		end

	type_tree_render (schema: DOCUMENT_SCHEMA; tree: EV_TREE) is
			-- Render types from `schema' in `tree'
		require
			schema_not_void: schema /= Void
			tree_not_void: tree /= Void
		do
		end

	attribute_list_render (element: DOCUMENT_SCHEMA_ELEMENT; list: EV_MULTI_COLUMN_LIST) is
			-- Render attributes information from schema `element' in `list'
		require
			element_not_void: element /= Void
			list_not_void: list /= Void
		do
		end	

end -- class SCHEMA_RENDERING_FACTORY
