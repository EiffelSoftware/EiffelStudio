indexing
	description: "Class which allows the retrieving of the graphical layout after a Reverse";
	date: "$Date$";
	revision: "$Revision$"

class 
	TRANSITION_TABLE

inherit

	ONCES

	STORABLE

creation
	
	make

feature -- creation & commands 

	make is 
	do
	end
	
	update_table is
	local
		cla: HASH_TABLE [ INTEGER, STRING ]
		clu : HASH_TABLE [ INTEGER, STRING ]
		system_clusters : SORTED_TWO_WAY_LIST [ CLUSTER_DATA ]
		table : HASH_TABLE [ CLASS_DATA, INTEGER ]
		i: INTEGER
	do
		!! table.make (system.system_classes.count )
		table := system.system_classes

		!! cla.make (10) 
		
		if table/= Void then
		from 
			table.start
		until
			table.after
		loop
			cla.put ( table.item_for_iteration.view_id,
					 table.item_for_iteration.name )
			table.forth
		end
		end
		!! clu.make (10)
		!! system_clusters.make
		system_clusters := system.clusters_in_system 
		if system_clusters/= Void then
		from 
			system_clusters.start
			i := 0
		until
			system_clusters.after
		loop
						
			clu.put ( system_clusters.item.view_id,
				 system_clusters.item.name )
			system_clusters.forth
			i := i+1
		end
		end
		classes := cla
		clusters := clu
	end

	save_table is
		local
			file_name : FILE_NAME
			file : RAW_FILE
		do
			!! file_name.make
			file_name.extend(system.environment.view_directory)
			file_name.extend("/") 
			file_name.extend("transition")
			!! file.make ( file_name )
			file.open_write
			independent_store ( file )
			file.close	
		end

	retrieve_view is
		local
			retrieved_t : TRANSITION_TABLE
			file : RAW_FILE
			file_name : FILE_NAME
		do
			!! file_name.make
			file_name.extend(system.environment.view_directory)
			file_name.extend("/transition")
			!! file.make (file_name)
			!! retrieved_t.make
			if file.exists 
			then if file.is_readable then
				file.open_read
				retrieved_t ?= retrieved ( file )
				file.close
				classes := retrieved_t.classes
				clusters := retrieved_t.clusters
			--else
				-- error
			end
			end
		end

feature -- attributes
	
		-- the string is for the name of the entities,
		-- the integer for the view_id of these ones.

	classes : HASH_TABLE [ INTEGER, STRING ]

	clusters : HASH_TABLE [ INTEGER, STRING ]


end -- class TRANSITION_TABLE
