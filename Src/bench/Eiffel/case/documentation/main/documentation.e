
indexing
	description: "Project Documentation"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENTATION

inherit
	SHARED_WORKBENCH
		rename
			system as bench_system
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize
		do
			Create classes.make
			Create clusters.make
			Create directories.make(universe.clusters.count)	
		end

feature -- Actions

	generate is
			-- Generate documentation.
		local
			class_chart: CLASS_CHART_GENERATOR
			navigation: NAVIGATION_GENERATOR
			class_code: CLASS_CODE_GENERATOR
			class_dico: CLASS_DICO_GENERATOR
			cluster_repository: CLUSTER_REPOSITORY_GENERATOR
			cluster_links: CLUSTER_LINKS_GENERATOR
			html_generator: HTML_GENERATOR
			dir_path: STRING
			i: INTEGER
		do
			Create html_generator.make(root_directory.name)
			Create navigation.make(html_generator)
			Create cluster_links.make(html_generator)
			Create class_chart.make(html_generator)
			Create class_code.make(html_generator)
			Create class_dico.make(html_generator)
			Create cluster_repository.make(html_generator)
			
			navigation.generate_index(root_directory.name)
			class_dico.generate(classes,root_directory.name)
			cluster_repository.generate(clusters,root_directory.name)
			
			from
				clusters.start
			until
				clusters.after
			loop
				cluster_links.generate(clusters.item,directories.item(clusters.item.cluster_name))
				clusters.forth
			end
			from
				i := 1
				classes.start
			until
				i>20 or classes.after
			loop
				dir_path := directories.item(classes.item.cluster.cluster_name)
				if class_chart_generated then
					class_chart.generate(classes.item,dir_path)
				end
				if class_code_generated then
					class_code.generate(classes.item,dir_path)
				end
				i := i + 1
				classes.forth
			end
		end

	create_directories is
		require
			root_directory /= Void
		local
			d: DIRECTORY
			fi: FILE_NAME
			s: STRING
		do
			from
				clusters.start
			until
				clusters.after
			loop
				Create fi.make_from_string(root_directory.name)
				fi.extend(clusters.item.cluster_name)
				directories.put(fi,clusters.item.cluster_name)
				Create d.make(fi)
				if not d.exists then
					d.create_dir
				end
				clusters.forth
			end
		end

feature -- Settings

	set_directory(p: DIRECTORY) is
			-- Set directory where the documentation will be generated.
		require
			not_void: p /= Void
			p.exists
			p.is_writable
		do
			root_directory := p
		ensure
			set: root_directory = p
		end

	set_all_universe is
			-- Set 'classes' to all the universe classes,
			-- and 'clusters' to all universe clusters.
		require
			-- Universe has to exist.
		local
			li_clu: LINKED_LIST[CLUSTER_I]
			tab: EXTEND_TABLE[CLASS_I,STRING]
		do
			from
				li_clu := universe.clusters
				li_clu.start
			until
				li_clu.after
			loop
				from
					tab := li_clu.item.classes
					tab.start
				until
					tab.after
				loop
					if tab.item_for_iteration.compiled then
						classes.extend(clone(tab.item_for_iteration))
					end
					tab.forth
				end
				clusters.extend(li_clu.item)
				li_clu.forth
			end
		end

	set_class_chart(b: BOOLEAN) is
		do
			class_chart_generated := b
		end
	
	set_class_code(b: BOOLEAN) is
		do
			class_Code_generated := b
		end

feature -- Access

	root_directory: DIRECTORY

	class_chart_generated: BOOLEAN

	cluster_chart_generated: BOOLEAN

	class_code_generated: BOOLEAN

	classes: LINKED_LIST [ CLASS_I ]

	clusters: LINKED_LIST [ CLUSTER_I ]

feature -- Implementation

	directories: HASH_TABLE [ STRING, STRING ]
		-- Paths relative to cluster names.

invariant
	generation_directory: root_directory /= Void implies root_directory.exists and root_directory.is_writable

end -- class DOCUMENTATION
