indexing
	description: "Generates the HTML code documentation from a project"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_DOC_GENERATOR
	
inherit
	CEIFFEL_HTMLDOC_GENERATOR_COCLASS_IMP
		redefine
			make,
			add_excluded_cluster,
			remove_excluded_cluster,
			generate
		end
		
	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end

create 
	make
	
feature {NONE} -- Implementation 

	make is
			-- create and instance
		do
			Precursor
			create excluded_clusters.make
		end
		

feature -- Access

	project_file: PROJECT_EIFFEL_FILE
			-- eiffel project file to generate the project docs from
			
	excluded_clusters: LINKED_LIST[STRING]
			-- sorted list of excluded clusters
			
feature -- Measurement

feature -- Status report

	is_incompatible: BOOLEAN is
			-- is the project incompatible with current compiler
		require else
			project_loaded: project_file /= Void
		do
			Result := project_file.is_incompatible
		end
		
	is_corrupted: BOOLEAN is
			-- is the project corrupted
		require else
			project_loaded: project_file /= Void
		do
			Result := project_file.is_corrupted
		end

feature -- Status setting

	set_excluded_clusters (a_list: ARRAYED_LIST[STRING]) is
			-- set the list of excluded clusters with a different list
		do
			create excluded_clusters.make
			from
				a_list.start
			until
				a_list.after
			loop
				excluded_clusters.extend (a_list.item)
				a_list.forth
			end
		end
		

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations



	add_excluded_cluster (a_cluster_name: STRING) is
			-- add a 'a_cluster_name' to the list of excluded clusters
			-- 'a_cluster_name' must be the full cluster name
		require else
			cluster_name_exists: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		do
			--excluded_clusters.object_comparison
			if not excluded_clusters.has (a_cluster_name) then
				excluded_clusters.extend (a_cluster_name)
				io.putstring ("cluster: " + a_cluster_name + " added%N")
			end
		ensure then
		end
		
	remove_excluded_cluster (a_cluster_name: STRING) is
			-- remove 'a_cluster_name' from the list of excluded clusters
			-- 'a_cluster_name' must be the full cluster name
		require else
			cluster_name_exists: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		local
			index: INTEGER
		do
			--excluded_clusters.object_comparison
			if excluded_clusters.has (a_cluster_name) then
				index := excluded_clusters.index_of (a_cluster_name, 1)
				if index > 0 then
					excluded_clusters.go_i_th (index)
					excluded_clusters.remove
				end
			end
		ensure then	
		end
		
	generate (generation_path: STRING) is
			-- generate the HTML documentation into 'generation_path'
		local
			doc_generator: DOCUMENTATION
			output: DEGREE_OUTPUT
			retried: BOOLEAN
		do
			if not retried then
				create doc_generator.make
				doc_generator.set_filter ("html-stylesheet")
				doc_generator.set_directory (create {DIRECTORY}.make (generation_path))
				doc_generator.set_all_universe
				add_default_excluded_clusters
				io.putstring ("number of cluster to be excluded : ")
				io.putint (excluded_clusters.count)
				doc_generator.set_excluded_indexing_items (excluded_clusters)
				doc_generator.set_cluster_formats (true, false)
				doc_generator.set_system_formats (true, true, true)
				doc_generator.set_class_formats (false, false, false, true, false, false)
				create output
				doc_generator.generate (output)
			end
		rescue
			retried := true
			retry
		end
		
feature {NONE} -- Basic Operations 

	add_default_excluded_clusters is
			-- add the library and assembly clusters to the list of excluded clusters
		do
			
		end
		
feature -- Obsolete

	load_project (filename: STRING): BOOLEAN is
			-- load the project file. returns true if successful
		do
			create project_file.make (filename)
			Result := project_file.error
		end

feature -- Inapplicable

feature {NONE} -- Implementation

	

invariant
	excluded_clusters_exists: excluded_clusters /= Void

end -- class HTML_DOC_GENERATOR
