
indexing
	description: "Generate Documentation under an HTML format"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_GENERATOR
 
inherit
	SHARED_EXEC_ENVIRONMENT

	SHARED_EIFFEL_PROJECT 

creation
	make

feature -- Initialization

	make (dir_path: STRING) is
			-- Initialize
		local
			fi: FILE_NAME
		do
				
			Create fi.make_from_String(dir_path)
			fi.extend("cluster_repository.html")
			cluster_repository.wipe_out
			cluster_repository.append("<A HREF=%""+fi+"%">Clusters</A>")

			Create fi.make_from_string(dir_path)
			fi.extend("class_repository.html")
			class_repository.wipe_out
			class_repository.append("<A HREF=%""+fi+"%">Dictionary</A>")

		end

	initialize(s: STRING) is
			-- Initialize the generator with filename 's'.
		require
			not_void: s /= Void
		local
			fi_n: FILE_NAME
		do
			Create fi_n.make_from_string(documentation_path)
			fi_n.extend(s)
			documentation_reader.process_file(fi_n)			
		end

feature -- Specific Generation

	generate_dictionary(li: LINKED_LIST[CLASS_ITEM]) is
			-- Print Dictionnary
		local
			s: STRING
			tab: HASH_TABLE[STRING, STRING]
		do
			Create tab.make(2)
			from
				li.start
			until
				li.after
			loop
				s := hyperlink(li.item,li.item.parent_cluster,
						li.item,"_chart.html")
				tab.force(s, "class_name")
				tab.force(li.item.description, "class_description")
				documentation_reader.insert_in_a_loop(tab)
				li.forth
			end
			generate_navigation(<<cluster_repository,class_repository>>)
		end

	generate_class_chart(cl: CLASS_I;par_li, com_li, qu_li,con_li,ind_li: LINKED_LIST[STRING];
				desc: STRING) is
		local
			s: STRING
			tab: HASH_TABLE[STRING,STRING]
		do
			generate_list(par_li,"class_parent","_chart",1)
			generate_list(com_li,"class_command","_chart",0)
			generate_list(qu_li,"class_query","_chart",0)
			generate_list(ind_li,"class_indexing","_chart",0)
			generate_list(con_li,"class_constraint","_chart",0)
			Create tab.make(4)
			tab.put(desc,"description")
			tab.put(cl.name,"class_name")
			documentation_reader.insert_outside_a_loop(tab)
		end

	generate_class_relations(cl: CLASS_I;cli_li, des_li, par_li,sup_li: LINKED_LIST[STRING]) is
		local
			s: STRING
			tab: HASH_TABLE[STRING,STRING]
		do
			generate_list(cli_li,"class_client","_links",1)
			generate_list(des_li,"class_descendant","_links",1)
			generate_list(par_li,"class_parent","_links",1)
			generate_list(sup_li,"class_supplier","_links",1)
			Create tab.make(3)
			tab.put(cl.name,"class_name")
			documentation_reader.insert_outside_a_loop(tab)
		end

	generate_cluster_relations(cl: CLUSTER_I; heir_li,cla_li: LINKED_LIST[STRING]) is
		local
			s: STRING
			tab: HASH_TABLE[STRING,STRING]
		do
			generate_list(heir_li,"cluster_heir","_links",1)
			generate_list(cla_li,"class_name","_links",1)
			Create tab.make(4)
			tab.put(clone(cl.cluster_name),"cluster_name")
			if cl.parent_cluster /= Void then
				tab.put(clone(cl.parent_cluster.cluster_name),"cluster_parent")
			end
			documentation_reader.insert_outside_a_loop(tab)
			generate_navigation(<<cluster_repository,class_repository>>)
		end

feature -- General Generation

	generate_list(li: LINKED_LIST[STRING];type,ext: STRING; i : INTEGER) is
			-- Generate list.
			-- i=1 => type = class, so hyperlink has to be computed.
		local
			tab: HASH_TABLE[STRING, STRING]
		do
			from
				li.start
			until
				li.after
			loop
				Create tab.make(1)
				if i=1 then
					set_hyperlink_class(li.item,ext)
				elseif i=2 then
					set_hyperlink_cluster(li.item,ext)
				end
				tab.force(li.item, type)
				documentation_reader.insert_in_a_loop(tab)
				li.forth
			end
		end

	generate_navigation(t: ARRAY[STRING]) is
		local
			i: INTEGER
			tab: HASH_TABLE[STRING,STRING]
		do
			from
				i := 1
				Create tab.make(1)
			until
				i >t.count 
			loop
				tab.force(t.item(i),"item")
				documentation_reader.insert_in_a_loop(tab)
				i := i+1
			end
		end

feature -- Processing

	process_iteration(tab: HASH_TABLE[STRING,STRING]) is
		do
			documentation_reader.insert_in_a_loop(tab)
		end

feature -- Hyperlink

	hyperlink(to_be_appened,a_path,name,ext: STRING): STRING is
			-- Append hyperling whose text is 'to_be_appened' to the 
			-- text 'a_string', with the extension 'ext'. The relative 
			-- directory is 'a_path'.
		require
			not_Void: to_be_appened/= Void and a_path /= Void
		do
			Result := "<A HREF="+a_path+"/"+name+ext+" TARGET=%"main%">"
			Result.append(to_be_appened+"</A>")
		ensure
			not_Void: Result /= Void
		end

	set_hyperlink_class(cl_name,ext: STRING) is
			-- Set Hyperlink if possible to class whose
			-- name is 'cl_name', and its format extension 'ext'.
			-- Do nothing if class not compiled.
		require
			not_void: cl_name /= Void
		local
			li: LINKED_LIST[CLASS_I]
			class_found: CLASS_I
			s: STRING
		do
			li := eiffel_universe.classes_with_name(cl_name)
			from
				li.start
			until
				class_found/=Void or li.after
			loop
				if li.item.compiled then
					class_found := li.item
				end
				li.forth
			end
			if class_found /= Void then
				s := hyperlink (class_found.name,
						 "../"+class_found.cluster.cluster_name,
						 class_found.name,ext+".html")
				cl_name.wipe_out
				cl_name.append(s)
			end
		end

	set_hyperlink_cluster(cl_name,ext: STRING) is
			-- Set Hyperlink if possible to class whose
			-- name is 'cl_name', and its format extension 'ext'.
			-- Do nothing if class not compiled.
		require
			not_void: cl_name /= Void
		local
			clu: CLUSTER_I
			s: STRING
		do
			clu := eiffel_universe.cluster_of_name(cl_name)
			if clu /= Void then 
				s := hyperlink (clu.cluster_name,
						 clu.cluster_name,
						 clu.cluster_name,ext+".html")
				cl_name.wipe_out
				cl_name.append(s)
			end
		end

feature -- Access

	result_string: STRING is
		do
			Result := documentation_reader.result_string
		ensure
			not_void: Result /= Void
		end

	documentation_reader: XML_DOCUMENTATION_READER is
			-- Module which is going to allow
			-- to retrieve the templates necessary for
			-- generating documentation.
		once
			Create Result.make
		end

feature -- Path Access

	Eiffel_installation_dir_name: STRING is
		once
			Result := Execution_environment.get ("EIFFEL4")
		end

	documentation_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name);
			Result.extend_from_array (<<"bench", "documentation">>);
		end

	cluster_repository: STRING is
			-- Cluster Repository
		once
			Create Result.make(20)
		end

	 class_repository: STRING is
			-- Class Repository
		once
			Create Result.make(20)
		end

end -- class HTML_GENERATOR

