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
		local
			cnt: INTEGER
			dotnet_elem: XML_XML_SCHEMA_ELEMENT
			elem: DOCUMENT_SCHEMA_ELEMENT
		do
			from
				schema.elements.start
			until
				schema.elements.after
			loop
				elem := schema.elements.item
				render_tree (tree, Void, elem)
				schema.elements.forth
			end
		end

	type_tree_render (schema: DOCUMENT_SCHEMA; tree: EV_TREE) is
			-- Render types from `schema' in `tree'
		require
			schema_not_void: schema /= Void
			tree_not_void: tree /= Void
		local
			curr_elem: DOCUMENT_SCHEMA_ELEMENT
			type: XML_XML_SCHEMA_TYPE
		do
			from
				schema.types.start
			until
				schema.types.after
			loop
				curr_elem ?= schema.types.item
				if curr_elem.is_schema_type then
					render_tree (tree, Void, curr_elem)
				end
				schema.types.forth
			end
		end

	attribute_list_render (element: DOCUMENT_SCHEMA_ELEMENT; list: EV_MULTI_COLUMN_LIST) is
			-- Render attributes information from schema `element' in `list'
		require
			element_not_void: element /= Void
			list_not_void: list /= Void
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			list.wipe_out
			list.set_column_title ("Name", 1)
			from
				element.attributes.start
			until
				element.attributes.after
			loop
				create row
				row.set_data (element.attributes.item)
				row.extend (element.attributes.item.name)
				list.extend (row)
				element.attributes.forth
			end
		end		

feature {NONE} -- Element Rendering
		
	render_tree (tree: EV_TREE; parent: EV_TREE_ITEM; elem: DOCUMENT_SCHEMA_ELEMENT) is
			-- Render Tree
		require
			tree_not_void: tree /= Void
			element_not_void: elem /= Void
		local
			item: EV_TREE_ITEM
		do
			create item.make_with_text (elem.name)
			if (elem.type_name /= Void and then not elem.type_name.is_empty) then
				item.set_text (elem.name + " (" + elem.type_name + ")")
			else
				item.set_text (elem.name)
			end
			
			item.set_data (elem)
			
			if parent = Void then
				tree.extend (item)
			else
				parent.extend (item)
			end
			
			from
				elem.children.start
			until
				not (elem.children = Void) and then elem.children.after
			loop
				render_tree (tree, item, elem.children.item)
				elem.children.forth
			end
		end			

end -- class SCHEMA_RENDERING_FACTORY
