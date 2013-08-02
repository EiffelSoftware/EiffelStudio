note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TPL_TEST

inherit
	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			get_data
			set_template_folder ("U:\edev\src\lib\framework\tests\template\tpl")
			set_template_file_name ("index-bug.tpl")
--			set_template_file_name ("index.tpl")
			template.add_value (data, "TheData")
			template_context.enable_verbose
			template.analyze
			template.get_output
			output := template.output
			print (output)
		end

feature -- Status

	output: STRING

	set_template_folder (v: STRING)
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
		do
			template := v
		end

	template: TEMPLATE_FILE

feature {NONE} -- Implementation

	get_data
		local
			z_item: Z_TREE_ITEM
			z_tree: Z_TREE
		do
			create z_tree.make ("My test tree")

			create z_item.make ("part A")
			z_tree.add_node (z_item)
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a1"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a2"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a3"))

			z_item ?= z_item.nodes.first
			z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - i"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - ii"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - iii"))

			create z_item.make ("part B")
			z_tree.add_node (z_item)
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b1"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b2"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b3"))

			data := z_tree
		end

	data: Z_TREE

invariant
--	invariant_clause: True

end -- class $classname
