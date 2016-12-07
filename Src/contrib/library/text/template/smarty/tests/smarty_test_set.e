note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SMARTY_TEST_SET

inherit
	EQA_TEST_SET

	SHARED_TEMPLATE_CONTEXT
		undefine
			default_create
		end

feature -- Test routines

	tpl_folder: PATH
		once
			create Result.make_current
			Result := Result.extended ("tpl")
		end

	test_simple
			-- New test routine
		local
			template: TEMPLATE_FILE
			data: like new_data
			p: PATH
			s: STRING
			res: STRING
		do
			p := tpl_folder
			template_context.set_template_folder (p)
--			create template.make_from_file ("index-bug.tpl")
--			create template.make_from_file ("index.tpl")
			create template.make_from_file ("index-id.tpl")

			data := new_data
			create s.make_empty
			append_data_to_string (data, 0, s)

			template.add_value (data, "TheData")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as output then
				print (output)
				res := "%
						%Tree name = My test tree%N%
						%%N%
						%1%N%
						%8%N"
				assert ("expected res", output.same_string (res))
			end
		end

	test_01
			-- New test routine
		local
			template: TEMPLATE_FILE
			data: like new_data
			p: PATH
			s: STRING
			res: STRING
		do
			p := tpl_folder
			template_context.set_template_folder (p)
			create template.make_from_file ("index.tpl")

			data := new_data
			create s.make_empty
			append_data_to_string (data, 0, s)

			template.add_value (data, "TheData")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as output then
				print (output)
				res := "%N%
						% Offset = %N%
						%%N%
						%Template test%N%
						% Tree name = My test tree%N%
						%%N%
						%*** List of Nodes ***%N%
						%  - part A Unicode=[Hello&#8212;Unicode] (#3)%N%
						%    - item a1 (#3)%N%
						%      - a1 - i (#0)%N%
						%      - a1 - ii (#0)%N%
						%      - a1 - iii (#0)%N%
						%    - item a2 (#0)%N%
						%    - item a3 (#0)%N%
						%  - part B (#3)%N%
						%    - item b1 (#0)%N%
						%    - item b2 (#0)%N%
						%    - item b3 (#0)%N%
						%%N"

				assert ("expected res", output.same_string (res))
			end
		end

	test_inspectors
			-- New test routine
		local
			template: TEMPLATE_FILE
			data: like new_data
			p: PATH
			s: STRING
			to_z_tree: TEMPLATE_OBJECT_Z_TREE
			res: STRING
		do
			p := tpl_folder
			template_context.set_template_folder (p)
			create template.make_from_file ("index-title.tpl")
			create to_z_tree.register ("Z_TREE")

			data := new_data
			create s.make_empty
			append_data_to_string (data, 0, s)

			template.add_value (data, "TheData")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as output then
				print (output)
				res := "%
						%Template test: Tree name = Tree named %"My test tree%"%N%
 						% Item count = 2%N%
						%"
				assert ("expected res", output.same_string (res))
			end
		end

	test_custom_counter
		local
			t: TEMPLATE_TEXT
		do
			create t.make_from_text ("[
			{assign name="counter" value="0"/}{assign name="counter" expression="$cell.item"/}{assign name="step" expression="$len.item"/}
			{sum left="$cell.item" right="$step"}counter{/sum}counter={$counter/}
			{sum left="$counter" right="$step"}counter{/sum}counter={$counter/}
			{sum left="$counter" right="$step"}counter{/sum}counter={$counter/}
			]")
			t.add_value (create {CELL [INTEGER_64]}.put (123), "cell")
			t.add_value (create {CELL [INTEGER_64]}.put (1), "len")
			template_context.add_template_custom_action (create {TEMPLATE_SUM_ACTION}, "sum")
			t.get_structure
			t.get_output
			if attached t.output as o then
				assert("output", o.same_string ("%Ncounter=124%Ncounter=125%Ncounter=126"))
			else
				assert("output set" , False)
			end
		end

feature {NONE} -- Implementation

	append_data_to_string (d: ANY; a_offset: INTEGER; a_result: STRING)
		local
			o: STRING
		do
			create o.make_filled (' ', a_offset * 2)
			if attached {Z_TREE} d as z_tree then
				across
					z_tree.nodes as c
				loop
					append_data_to_string (c.item, a_offset + 1, a_result)
				end
			elseif attached {Z_TREE_NODE} d as z_tree_node then
				a_result.append (o)
--				a_result.append (z_tree_node.name + "#" + z_tree_node.id.out + "%N")
				a_result.append ("- " + z_tree_node.name)
				if attached {Z_TREE_ITEM} z_tree_node as z_tree_item then
					a_result.append (" (#" + z_tree_item.nodes.count.out + ")%N")
					across
						z_tree_item.nodes as c
					loop
						append_data_to_string (c.item, a_offset + 1, a_result)
					end
				else
					a_result.append ("%N")
				end
			end
		end

	new_data: Z_TREE
		local
			z_item: Z_TREE_ITEM
			z_tree: Z_TREE
		do
			create z_tree.make ("My test tree")

			create z_item.make ("part A")
			z_item.set_unicode_text ({STRING_32} "Hello%/8212/Unicode")

			z_tree.add_node (z_item)
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a1"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a2"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item a3"))

			if attached {Z_TREE_ITEM} z_item.nodes.first as l_z_item then
				l_z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - i"))
				l_z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - ii"))
				l_z_item.add_node (create {Z_TREE_ITEM}.make ("a1 - iii"))
			end

			create z_item.make ("part B")
			z_tree.add_node (z_item)
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b1"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b2"))
			z_item.add_node (create {Z_TREE_ITEM}.make ("item b3"))

			Result := z_tree
		end

end


