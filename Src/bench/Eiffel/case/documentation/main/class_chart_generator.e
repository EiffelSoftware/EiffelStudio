
indexing
	description: "Class which generate a class chart"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_CHART_GENERATOR

inherit
	CLASS_GENERATOR

creation
	make

feature -- Initialize

	make (gen: HTML_GENERATOR) is
		do
			format_generator := gen
			Create parent_list.make
			Create command_list.make
			Create query_list.make
			Create constraint_list.make
			Create indexing_list.make
			description := ""
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
			parent_list.wipe_out
			command_list.wipe_out
			query_list.wipe_out
			constraint_list.wipe_out
			indexing_list.wipe_out
			description := ""

			parent_list := generated_parents(cl)
			generate_features(query_list,command_list,
				cl)
			generate_indexing(cl,description,indexing_list)
			generate_constraints(cl, constraint_list)

			format_generator.initialize("class_chart.html")
			format_generator.generate_class_chart(cl,parent_list,
				command_list,query_list,constraint_list,
				indexing_list,description)

			Create fi_n.make_from_string(dir_path)
			fi_n.extend(cl.name+"_chart.html")
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

	description: STRING

	parent_list,query_list,
		command_list,constraint_list,
		indexing_list: LINKED_LIST[STRING]

end -- class CLASS_CHART_GENERATOR

