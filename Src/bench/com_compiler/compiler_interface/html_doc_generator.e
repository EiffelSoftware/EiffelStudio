indexing
	description: "Generates the HTML code documentation from a project"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_DOC_GENERATOR
	
inherit
	IEIFFEL_HTMLDOC_GENERATOR_IMPL_STUB
		redefine
			is_corrupted,
			is_loaded,
			is_incompatible,
			add_excluded_cluster,
			remove_excluded_cluster,
			generate,
			add_status_callback,
			remove_status_callback
		end
		
	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end
	
	EIFFEL_ENV
		export
			{NONE} all
		end
		
	SHARED_PROJECT_PROPERTIES
		export
			{NONE} all
		end
		
create 
	make
	
feature {NONE} -- Implementation 

	make  is
			-- create and instance
		do
			create output.make	
			Eiffel_project.set_degree_output (output)
			create excluded_clusters.make
			add_default_excluded_clusters
		end


feature -- Access
	
	excluded_clusters: LINKED_LIST[STRING]
			-- sorted list of excluded clusters

feature -- Status report

	is_loaded: BOOLEAN is
			-- is the project loaded?
		do
			if Eiffel_project /= Void then
				Result := True
			end
		end

	is_incompatible: BOOLEAN is
			-- is the project incompatible with current compiler?
		do
			if Eiffel_project /= Void then
				Result := Eiffel_project.is_incompatible	
			end
		end
		
	is_corrupted: BOOLEAN is
			-- is the project corrupted?
		do
			if Eiffel_project /= Void then
				Result := Eiffel_project.is_corrupted
			end
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

feature -- Basic operations

	add_excluded_cluster (a_cluster_name: STRING) is
			-- add a 'a_cluster_name' to the list of excluded clusters
			-- 'a_cluster_name' must be the full cluster name
		require else
			cluster_name_exists: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		do
			excluded_clusters.compare_objects
			if not excluded_clusters.has (a_cluster_name) then
				excluded_clusters.extend (a_cluster_name)
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
			excluded_clusters.compare_objects
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
			du: DOCUMENTATION_UNIVERSE
			retried: BOOLEAN
		do
			if not retried then
				create doc_generator.make
				create du.make_all
				doc_generator.set_filter ("html-stylesheet")
				doc_generator.set_directory (create {DIRECTORY}.make (generation_path))
				doc_generator.set_all_universe
				doc_generator.set_cluster_formats (true, false)
				doc_generator.set_system_formats (true, true, true)
				doc_generator.set_class_formats (false, false, false, true, false, false)
				
				-- set the excluded clusters
				from
					excluded_clusters.start
				until
					excluded_clusters.after
				loop
					du.exclude_cluster (doc_generator.Universe.cluster_of_name (excluded_clusters.item), true)
					excluded_clusters.forth
				end
				doc_generator.set_universe (du)
				
				doc_generator.set_excluded_indexing_items (create {LINKED_LIST[STRING]}.make)
				
				set_html_document_generator (Current)
				main_window.process_generate_message
			else
				output.put_string ("Unable to complete generation of documentation")
			end
		rescue
			retried := True
			Retry
		end
		
	generate_docs is
			-- generate the documentation
		do
			-- generate the output
			doc_generator.generate (output)	
		end
		
		
	add_status_callback (interface: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
			-- add an interface to the list of call backs
		do
			output.add_callback (interface)			
		end
		
	remove_status_callback (interface: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
			-- remove an interface from the list of call backs
		do
			output.remove_callback (interface)
		end
		
		
		
feature {NONE} -- Basic Operations 

	add_default_excluded_clusters is
			-- remove the default set of clusters - these include those that are external (precompiled or assemblies)
		local
			clusters: ARRAYED_LIST [CLUSTER_I]
			cluster: CLUSTER_I
			assembly: ASSEMBLY_I
		do
			clusters := Eiffel_universe.clusters
			from 
				clusters.start
			until
				clusters.after
			loop
				cluster := clusters.item
				assembly ?= cluster
				if assembly /= Void then
					add_excluded_cluster (cluster.cluster_name)	
				end
				clusters.forth
			end
		end

feature {NONE} -- Implementation

	output: COM_HTML_DOC_DEGREE_OUTPUT
			-- generation output
			
	doc_generator: DOCUMENTATION
			-- html documentation generator
			
invariant
	non_void_excluded_clusters: excluded_clusters /= Void
	non_void_output: output /= Void

end -- class HTML_DOC_GENERATOR
