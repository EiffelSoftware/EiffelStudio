indexing
	description: "Generates the HTML code documentation from a project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_DOC_GENERATOR
	
inherit
	CEIFFEL_HTML_DOCUMENTATION_GENERATOR_COCLASS_IMP
		redefine
			add_included_cluster,
			remove_included_cluster,
			start_generation,
			make
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
			eiffel_project.set_degree_output (output)
			create included_clusters.make
		end

feature -- Access
	
	included_clusters: LINKED_LIST[STRING]
			-- list of included clusters

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

	set_included_clusters (a_list: ARRAYED_LIST[STRING]) is
			-- set the list of included clusters with a different list
		do
			create included_clusters.make
			from
				a_list.start
			until
				a_list.after
			loop
				included_clusters.extend (a_list.item)
				a_list.forth
			end
		end

feature -- Basic operations

	add_included_cluster (a_cluster_name: STRING) is
			-- add a 'a_cluster_name' to the list of included clusters
			-- 'a_cluster_name' must be the full cluster name
		require else
			cluster_name_exists: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		do
			included_clusters.compare_objects
			if not included_clusters.has (a_cluster_name) then
				included_clusters.extend (a_cluster_name)
			end
		ensure then
		end
		
	remove_included_cluster (a_cluster_name: STRING) is
			-- remove 'a_cluster_name' from the list of included clusters
			-- 'a_cluster_name' must be the full cluster name
		require else
			cluster_name_exists: a_cluster_name /= Void
			valid_cluster_name: not a_cluster_name.is_empty
		local
			index: INTEGER
		do
			included_clusters.compare_objects
			if included_clusters.has (a_cluster_name) then
				index := included_clusters.index_of (a_cluster_name, 1)
				if index > 0 then
					included_clusters.go_i_th (index)
					included_clusters.remove
				end
			end
		ensure then	
		end
		
	start_generation (generation_path: STRING) is
			-- generate the HTML documentation into 'generation_path'
		local
			du: DOCUMENTATION_UNIVERSE
			l_cluster: CLUSTER_I
			retried: BOOLEAN
		do
			create doc_generator.make
			create du.make

				-- set the included clusters
			from
				included_clusters.start
			until
				included_clusters.after
			loop
				l_cluster := doc_generator.Universe.cluster_of_name (included_clusters.item)
				if l_cluster /= Void then
					du.include_cluster (l_cluster, true)
				end
				included_clusters.forth
			end
			doc_generator.set_universe (du)

			doc_generator.set_filter ("html-stylesheet")
			doc_generator.set_directory (create {DIRECTORY}.make (generation_path))
			doc_generator.set_cluster_formats (true, false)
			doc_generator.set_system_formats (true, true, true)
			doc_generator.set_class_formats (false, false, false, true, false, false)			
			doc_generator.set_excluded_indexing_items (create {LINKED_LIST[STRING]}.make)
			
			set_html_document_generator (Current)
			generate_docs
		end
		
	generate_docs is
			-- generate the documentation
		local
			retried: BOOLEAN
		do
			if not retried then
					-- generate the output
				doc_generator.generate (output)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	output: COM_HTML_DOC_DEGREE_OUTPUT is	
			-- generation output
		once
			create Result.make (Current)
		end
			
	doc_generator: DOCUMENTATION
			-- html documentation generator
			
invariant
	non_void_included_clusters: included_clusters /= Void
	non_void_output: output /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class HTML_DOC_GENERATOR
