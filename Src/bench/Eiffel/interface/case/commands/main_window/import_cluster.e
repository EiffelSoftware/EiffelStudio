indexing
	description: "Import a Cluster : Retrieve the project and update the Current System";
	date: "$Date$";
	revision: "$Revision$"

class IMPORT_CLUSTER

inherit
	
	EC_COMMAND
	ONCES;
	CONSTANTS;
	EXCEPTIONS;
	SHARED_FILE_SERVER
	WARNING_CALLER

creation

	make

feature {NONE} -- Initialization

	make (a_load_box : like import_cluster_box; m: like main_window) is
		require
			has_box : a_load_box /= Void
		local
			graph_page: GRAPH_PAGE
			drawing_component: DRAWING_COMPONENT
		do
			import_cluster_box := a_load_box
	
			if m /= Void then
				main_window := m

				graph_page := main_window.graph_page
				if graph_page /= Void then
					drawing_component := graph_page.drawing_area

					if drawing_component /= Void then
						workarea := drawing_component.drawing_area
					end
				end
			end				

			
		ensure
			import_box_correctly_set : import_cluster_box = a_load_box
		end 



feature -- Properties

	import_cluster_box: EV_DIRECTORY_DIALOG

	main_window: MAIN_WINDOW

	workarea: WORKAREA

feature -- String operations

	extract_directory ( s : STRING ): STRING is
		-- extract the directory where s is contained
	local
		ind1,ind : INTEGER
		end_of_string	: BOOLEAN
	do

		end_of_string	:= false

		!! Result.make(20)
		from
			ind1:=0
			ind:=1
		until
			ind = 0	or
			end_of_string 
		loop
			if	ind1 < s.count
			then
				ind	:= s.index_of	( environment.directory_separator	, ind1+1	)
				if	ind > 0 
				then
					ind1	:= ind
				end
			else
				end_of_string	:= true
			end
		end
		-- the last position of '/' orr '\' is contained in ind1
		if ind1>0  then
			-- no problemo
			Result.append(s.substring(1,ind1-1))
		end
	end


feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Import a Cluster
	require else
		environment_valid	: environment	/= void
	local
		real_file_name	: STRING
		system_imported	: S_SYSTEM_DATA
		fi : FILE_NAME
		err : BOOLEAN

	do
		if not err then
			!! fi.make
			fi.extend(import_cluster_box.directory)	
			fi.extend(environment.storage_relative_directory	) 
			fi.extend(environment.system_name	) 
			if not is_case_project (import_cluster_box.directory) then
						warning_message
			else
				system_imported	?= system.retrieve_by_name(fi)	
				if	system_imported /= void
				then
					-- The routine make_spc must be tested
					make_spc	( system_imported	)
					import_cluster_box.destroy
				else
					warning_message
				end
			end
		--else
			-- an error occured
		--	Windows_manager.popup_error ("E26", fi, main_window)
		end
		rescue
			warning_message
			err := TRUE
			retry
	end -- execute	


	is_case_project (path: STRING): BOOLEAN is
		require
			path_exists: path /= Void
		local
			dir_name: DIRECTORY_NAME
			dir: DIRECTORY
			str: STRING
		do
			!! dir_name.make_from_string (path)
			if dir_name.is_valid then
				str := clone (Environment.Casegen_name)
				dir_name.extend (str)
				if dir_name.is_valid then
					!! dir.make (dir_name)
					Result := dir.exists
				end
			end
		end

feature -- warning caller

	ok_action is
		do
			
		end;

	cancel_action is
		do
			import_cluster_box.destroy
		end 

	no_action (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			import_cluster_box.destroy
		end

	warning_message is
		local
			warning: EV_WARNING_DIALOG
			fail: EV_ROUTINE_COMMAND
			browser: LOAD_PROJECT_AUX
		do
			warning := windows_manager.warning (Message_keys.valid_proj_name_wa, import_cluster_box.directory, main_window)
			if warning /= Void then
				!! fail.make (~no_action)
				!! browser.make (main_window)
				warning.show_yes_no_buttons
				warning.add_no_command (fail, Void)
				warning.add_yes_command (browser, Void)
				warning.show
			end
		end

feature -- Implementation

	make_spc	( s	: S_SYSTEM_DATA	) is
			-- case where we import a cluster
			require
				valid_storer: s /= Void;
			local
				add_cluster_u: ADD_CLUSTER_U
				cluster : CLUSTER_DATA
			do

				if main_window.entity /= Void then
					-- new implementation, pascalf, beginning of July, 1998
					if system.cluster_of_name(s.root_cluster.name)/= Void then
						-- a cluster already exists with this name !!
						Windows_manager.popup_message("Mz" , s.root_cluster.name, main_window)
					else
						-- no problem at this point	
			
						system.init_import
						build_cluster_clone ( s.root_cluster, system.root_cluster, TRUE )
						system.set_system_to_load ( FALSE )
						system.look_for_inh_in_imported_cluster ( s )
						system.look_for_links 
						system.update_system_link

						workarea.update_lists
						workareas.update_drawing
					end
				else
					Windows_manager.popup_message("Mg" , s.root_cluster.name, main_window)
				end
			end

		build_cluster_clone ( s_clus : S_CLUSTER_DATA ; cl : CLUSTER_DATA; b : BOOLEAN)  is
				-- b is t know if it is the root or not
			local
					add_cluster_u: ADD_CLUSTER_U
					new_clu : CLUSTER_DATA
			do
				if system.cluster_of_name(s_clus.name)/= Void then
					-- a cluster already exists with this name !!
					Windows_manager.popup_message("Mz", s_clus.name, main_window)
				else
					system.decrement_cluster_view_number
					!! new_clu.make ( s_clus.name, system.cluster_view_number )
					if b then 
						new_clu.set_x (50)
						new_clu.set_y (50)
						new_clu.set_default
						new_clu.set_icon ( TRUE )
					else
						new_clu.set_x ( s_clus.x )
						new_clu.set_y ( s_clus.y )
						new_clu.set_default
						new_clu.set_icon ( TRUE )
						new_clu.set_hidden ( s_clus.is_hidden )
					end
					if s_clus.chart /= VOid then
					--	new_clu.set_chart ( s_clus )
					end

					!! add_cluster_u.make ( cl, new_clu, workarea)
					if s_clus.clusters/= Void 
						and then  s_clus.clusters.count >0 then
						from
							s_clus.clusters.start
						until
							s_clus.clusters.after
						loop
							build_cluster_clone ( s_clus.clusters.item, new_clu, FALSE)
							s_clus.clusters.forth
						end
					end
					if s_clus.classes/= Void
							and then s_clus.classes.count >0 then
						from
							s_clus.classes.start
						until
							s_clus.classes.after
						loop
							if system.class_of_name ( s_clus.classes.item.name ) /= Void 
									--and then class_of_name ( s_clus.classes.item.name)	/= void then
							then
								Windows_manager.popup_message ("Mz", s_clus.classes.item.name, main_window)
							else
								system.build_class_clone ( s_clus.classes.item, new_clu )
							end
							s_clus.classes.forth
						end
					end
					system.resize_cluster_if_glutton ( new_clu )
				end
			end
end

