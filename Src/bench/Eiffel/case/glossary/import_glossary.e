indexing
	description: "Class which allows/check importing a glossary"
	date: "$Date$"
	revision: "$Revision$"

class
	IMPORT_GLOSSARY

inherit
	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make (m: like main_window; w: like workarea) is
			-- Creation routine
		do
			main_window := m
			workarea := w

			error := FALSE
			!! classes.make
			!! clusters.make(20)	
			!! new_clusters.make
			browse	
		end

feature -- Attributes

	error : BOOLEAN
		-- Does an error occured ?

	file_s : EV_FILE_OPEN_DIALOG--CASE_FILE_SELECTOR -- FILE_SEL_D
		-- file descriptor

	table : LINKED_LIST [ LINKED_LIST [ STRING ] ]
		-- table of arguments build from the list
	
	list : LINKED_LIST [ STRING ]
		-- retrieved list

	nb_arguments : INTEGER 
		-- nb arguments : "","","","",""

	classes : LINKED_LIST [ CLASS_DATA ]
			-- Lists of the classes imported 

	clusters : HASH_TABLE [ CLUSTER_DATA, STRING ]
			-- imported/modified clusters with their name 
			-- we need the name for avoiding adding twice the same element into the list

	new_clusters : LINKED_LIST [ CLUSTER_DATA ]

	main_window : MAIN_WINDOW

	workarea: WORKAREA

feature  -- Execution

	browse is
		local
			com : OK_BROWSE_IMPORT
		do
			warning	
			if not error then
				file_s := windows_manager.open_file_browser (main_window)
				!! com.make ( Current )
				if System.index_directory/= Void then
					file_s.set_base_directory ( System.index_directory )
				end
				file_s.add_ok_command ( com, Void )
				file_s.show
			else
				Windows_manager.popup_message("Mad", Void, main_window)
				--Windows_manager.add_message("browse of import_glossary", 1 )
			end
		rescue
			error := TRUE	
			retry	
		end

	warning is
		-- initialize the process by launching a message
		-- for informing the user that only the .csv format is
		-- recognized	
	do
		Windows_manager.popup_message ("Maf", Void, main_window)
	end
	
	exec is
		-- routine which is in charge of controlling the process	
	do 
		file_s.destroy
		--Windows.message_popdown	
		if not error then	
			load_model
			if not error then 
				fill_with_model
				if not error then
					create_entities_with_model
					if not error then 
						process_layout
					end	
				end
			end
		end
		if error then
				--Windows.message (Windows.main_graph_window, "Mae", Void )
		end	
	end

	load_model is
	local
		fi : PLAIN_TEXT_FILE
		fn : FILE_NAME
		err : BOOLEAN -- if an error occurs during the process
	do
		if not err then
			!! fn.make_from_string(file_s.file_name)
			!! fi.make_open_read ( fn )
			read_file ( fi ) 
		end
		rescue
			err := TRUE
			error := TRUE	
			retry
	end

	read_file ( fi : PLAIN_TEXT_FILE ) is
	local
		err : BOOLEAN
		st : STRING
	do
		if not err and then fi.exists then
			from
				!! list.make
			until
				fi.end_of_file
			loop
				fi.read_line
				st := deep_clone ( fi.last_string )
				if not fi.end_of_file then
					list.extend ( st ) 
				end
			end
			fi.close
		end
	rescue
		err := TRUE
		error := TRUE
		--Windows.add_message( "read_file of import_glossary", 1 )	
		retry	
	end

	fill_with_model is
		-- search of "class" and "cluster" + affectation of the other fields ...
	local
		inter : LINKED_LIST [ STRING ]
		err : BOOLEAN
		tmp : STRING
		ind1,ind2 : INTEGER
	do
		if not err then
			!! table.make
			from
				list.start
			until
				list.after
			loop
				from
					tmp := list.item
					ind1 := 2
					ind2 := 1
					!! inter.make
				until
					ind1=ind2 or ind1=0 or ind2=0 
				loop
					ind1 := tmp.index_of ('"', 1 )
					ind2 := tmp.index_of ('"', ind1+1 )
					if ind2>0 and then ind2>ind1 then
						inter.extend ( tmp.substring(ind1+1,ind2-1 ))
						tmp := tmp.substring (ind2+1, tmp.count )
					end
				end
				table.extend ( inter )
				list.forth
			end
		end
		rescue
			err := TRUE
			error := TRUE
			--Windows.add_message("fill_with_model of import_glossary",1)
			retry	
	end
	
	create_entities_with_model is
	require
		table_not_void : table /= Void
	local
		cl : CLUSTER_DATA
		cla1 : CLASS_DATA
		st1,st2 : STRING
		add_cluster : ADD_CLUSTER_U
		add_class : ADD_CLASS_U
		cla : CLASS_DATA 
		add_ind : ADD_INDEX_U	
		content : CLASS_CONTENT	
		s_class : S_CLASS_DATA	
		err : BOOLEAN	
	do
		if not err then
		nb_arguments := table.first.count
		if table.count>1 and then nb_arguments >1 then
			from
				table.start
				table.forth
			until
				table.after
			loop
				-- processing the class
				table.item.start
				st1 := table.item.item
				cla1 := System.class_of_name ( st1 )	
				table.item.forth
				-- processing the cluster ...
				st2 := table.item.item
				st2.to_upper	
				cl := System.cluster_of_name ( st2 )
				if cl= Void then
					-- we have to create the cluster 
					!! cl.make(table.item.item,System.cluster_view_number)
					System.decrement_cluster_view_number
					cl.set_x ( 30 )
					cl.set_y ( 30 )
					cl.set_default	
					cl.set_icon ( TRUE )	
					!!add_cluster.make(System.root_cluster, cl, workarea)
					new_clusters.extend ( cl )	
				end
				-- adding the class if not present ...
				if cla1=Void then
					-- we add everything ...
						System.increment_class_view_number
						System.increment_class_id_number	
						!! cla.make ( st1, System.class_view_number )
						if System.class_id_number= 0 then
							System.increment_class_id_number
						end	
						cla.set_id ( System.class_id_number )
						!!add_class.make (cl, cla, workarea)
						classes.extend ( cla )
						clusters.put ( cl, cl.name )	
				else
					-- we do not need to add it, but we will with the 
					-- indexing clauses ...
						cla := cla1	
				end
				if not table.item.after then	
				-- let's deal with the indexing clauses now ...
					--from
					--	table.item.forth	
					--	!! content.make ( cla )
					--	cla.set_content ( content )	
					--until
					--	table.item.after
					--loop
					--	!! add_ind.make ( cla )
					--	add_ind.set_data (table.first.i_th ( table.item.index )
					--		   	, table.item.item )
					--	add_ind.execute
					--	table.item.forth
					--end
					-- Workaround for storing the class content correctly	
					s_class := cla.storage_info
					-- We have as soon as possible to review all
					-- the storage stuff for the s_class_data.
				end
				cla.request_for_information -- added ajdn	
				table.forth
			end
		end
	end
	rescue
		err := TRUE
		error := TRUE
		--Windows_manager.add_message("create_entities_with_model", 1)
		retry	
	end


	process_layout is
	local
		link_scatter : LINKABLES_SCATTERING
		clus : LINKED_LIST [ CLUSTER_DATA ]	
	do
		!! clus.make
		from
			clusters.start
		until
			clusters.after
		loop
			clus.extend ( clusters.item_for_iteration )
			clusters.forth
		end
		!! link_scatter
		link_scatter.execute ( classes, clus )	
		link_scatter.process_clusters ( new_clusters )	
	end

end -- class IMPORT_GLOSSARY
