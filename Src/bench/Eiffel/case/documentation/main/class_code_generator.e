
indexing
	description: "Generate relational code corresponding to a given class%
				% in a documentation context."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_CODE_GENERATOR

inherit
	CLASS_GENERATOR

creation
	make

feature -- Initialize

	make(gen: HTML_GENERATOR) is
		do
			format_generator := gen
			Create client_list.make
			Create parent_list.make
			Create descendant_list.make
			Create supplier_list.make
		end

feature -- Actions

	generate(cl: CLASS_I;dir_path: STRING) is
			-- Generate chart corresponding to class 'cl'
		require
			path_exists: dir_path /= Void
			not_void: cl /= Void
			compiled: cl.compiled
		local
			fi_n: FILE_NAME
			fi: PLAIN_TEXT_FILE
		do
			client_list.wipe_out
			parent_list.wipe_out
			supplier_list.wipe_out
			descendant_list.wipe_out

			client_list := generated_parents(cl)
			descendant_list := generated_heirs(cl)
			parent_list := generated_parents(cl)
			supplier_list := generated_suppliers(cl)

			format_generator.initialize("class_relations.html")
			format_generator.generate_class_relations(cl,
				client_list, descendant_list,parent_list,
				supplier_list)

			Create fi_n.make_from_string(dir_path)
			fi_n.extend(cl.name+"_links.html")
			Create fi.make_create_read_write(fi_n)
			fi.put_string(format_generator.result_string)
			fi.close
		end

feature -- Settings

	set_path(p: DIRECTORY_NAME) is
		--require
		--	valid: path.is_valid
		do
			path := p
		end

feature -- Implementation

	path: DIRECTORY_NAME

	client_list,supplier_list,
		parent_list,descendant_list: LINKED_LIST[STRING]

end -- class CLASS_CODE_GENERATOR

