indexing
	description: "Generate all elements for html documentation";
	date: "$Date$";
	revision: "$Revision$"

class
	GENERATE_CLASSES_HTML

inherit

	ONCES

	CONSTANTS

--creation
--	make

feature

--	make(win: HTML_WINDOW)  is
--		-- generate HTML sources.
--	require
--		window_exists: win /= Void
--	local
--		dir : DIRECTORY
--		file_n : FILE_NAME
--		ratio, total, ind : INTEGER
--		st : STRING
--		i: INTEGER
--	do
--		System.set_generation_html( TRUE )
--		System.init_counter
--		System.set_total ( System.root_cluster)
--		!! st.make (20)
--		!! file_n.make
--		file_n.extend(Environment.html_directory)
--		!! dir.make (file_n)
--		if not dir.exists then
--			dir.create_dir
--		end
--		ind :=1
--		total := system.clusters_in_system.count + system.system_classes.count
--		win.progress_bar.text.set_text("generating Clusters ... ")
--		clusters := System.clusters_in_system
--		!! cluster_html.make
--		!! cluster_chart_html.make
--		from
--			clusters.start
--			i := 0
--		until
--			clusters.after
--		loop
--			cluster_html.generate (clusters.item)
--			cluster_chart_html.generate ( clusters.item )
--			clusters.forth
--			i := i+1
--			win.progress_bar.set_percentage((i*100)//total)
--		end
--		classes := System.system_classes
--		!! class_html.make
--		!! class_chart_html.make
--		total := system.system_classes.count
--		win.progress_bar.text.set_text("Generating Classes ...")
--		from
--			classes.start
--			i := 0
--		until
--			classes.after
--		loop
--			class_html.generate(classes.item_for_iteration)
--			class_chart_html.generate (classes.item_for_iteration)
--			classes.forth
--			i:= i+1
--			win.progress_bar.set_percentage((i*100)//total)
--			ind := ind+1
--		end

--		win.progress_bar.text.set_text("Generating Dictionary ...")
	--	-- dico generation
	--	!! dico_html.make 
	--	dico_html.generate(System)
	--	
	--	win.progress_bar.text.set_text("Generating Indexes")
	--	-- presentation
	--	!! present_html.make
	--	present_html.generate ( System )
	--
	--	win.progress_bar.text.set_text("Generation Complete")
--
	--	System.set_generation_html ( FALSE )
	--	win.destroy
	--end

	clusters : SORTED_TWO_WAY_LIST[ CLUSTER_DATA ]

	class_html : CLASS_HTML

	cluster_html : CLUSTER_HTML

	cluster_chart_html : CLUSTER_CHART_HTML

	class_chart_html : CLASS_CHART_HTML

	present_html : PRESENT_HTML

	dico_html : DICO_HTML

	classes : HASH_TABLE [ CLASS_DATA, INTEGER ]	

end -- class GENERATE_CLASSES_HTML
