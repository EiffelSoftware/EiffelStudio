
indexing
	description: "Generation of class dictionary."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DICO_GENERATOR

inherit
	CLASS_GENERATOR

creation
	make

feature -- Initialize

	make (gen: HTML_GENERATOR) is
		do
			Create class_list.make
			format_generator := gen
		end

feature -- Actions

	generate(li: LINKED_LIST[CLASS_I]; dir_path: STRING) is
		local
			fi_n: FILE_NAME
			fi: PLAIN_TEXT_FILE
			lii: LINKED_LIST[STRING]
			desc: STRING
			it: CLASS_ITEM
		do
			from
				li.start
				class_list.wipe_out
				Create lii.make
			until
				li.after
			loop
				lii.wipe_out
				desc := ""
				generate_indexing(li.item,desc,	lii)
				if desc.count>0 then
					desc.replace_substring("",1,12)
				end			
				Create it.make_with_description(li.item, desc)
				class_list.extend(it)
				li.forth
			end

			class_list.sort

			format_generator.initialize("dico.html")
			format_generator.generate_dictionary(class_list)

			Create fi_n.make_from_string(dir_path)
			fi_n.extend("class_repository.html")
			Create fi.make_create_read_write(fi_n)
			fi.put_string(format_generator.result_string)
			fi.close
		end

feature -- Implementation

	class_list: SORTED_TWO_WAY_LIST[CLASS_ITEM]

end -- class CLASS_DICO_GENERATOR

