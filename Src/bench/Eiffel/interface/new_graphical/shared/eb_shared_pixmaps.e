indexing
	description: "Pixmaps used in interface."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_PIXMAPS

inherit
	SHARED_EXEC_ENVIRONMENT

	SHARED_PLATFORM_CONSTANTS

feature -- Access

	bm_ISE_Power: EV_PIXMAP is
		once
			Result := pixmap_file_content ("isepower")
		end

	bm_Breakpoint: EV_PIXMAP is
		once
			Result := pixmap_file_content ("breakpt")
		end

	bm_Clear_breakpoints: EV_PIXMAP is
		once
			Result := pixmap_file_content ("clr_bp")
		end

	bm_Graph: EV_PIXMAP is
		once
			Result := pixmap_file_content ("graph")
		end

	bm_graphical_Breakablepoint: EV_PIXMAP is
		once
			Result := pixmap_file_content ("gbreakpt")
		end

	bm_graphical_Stoppoint: EV_PIXMAP is
		once
			Result := pixmap_file_content ("gstoppt")
		end

	bm_Case_storage: EV_PIXMAP is
		once
			Result := pixmap_file_content ("casestor")
		end

	bm_Class: EV_PIXMAP is
		once
			Result := pixmap_file_content ("class")
		end

	bm_Class_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("classdot")
		end

	bm_Class_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("classico")
		end

	bm_Dynamic_lib: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dynlib")
		end

	bm_Dynamic_lib_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dynlibdot")
		end

	bm_Dynamic_lib_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dynlibico")
		end

	bm_Clickable: EV_PIXMAP is
		once
			Result := pixmap_file_content ("clckable")
		end

	bm_Current: EV_PIXMAP is
		once
			Result := pixmap_file_content ("current")
		end

	bm_Debug_quit: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dbgquit")
		end

	bm_Debug_run: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dbgrun")
		end

	bm_Debug_status: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dbgstatu")
		end

	bm_Down_stack: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dn_stack")
		end

	bm_Exec_last: EV_PIXMAP is
		once
			Result := pixmap_file_content ("execlast")
		end

	bm_Exec_nostop: EV_PIXMAP is
		once
			Result := pixmap_file_content ("execnost")
		end

	bm_Exec_step: EV_PIXMAP is
		once
			Result := pixmap_file_content ("execstep")
		end

	bm_Exec_stop: EV_PIXMAP is
		once
			Result := pixmap_file_content ("execstop")
		end

	bm_Explain: EV_PIXMAP is
		once
			Result := pixmap_file_content ("explain")
		end

	bm_Explain_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("expldot")
		end

	bm_Explain_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("explicon")
		end

	bm_General: EV_PIXMAP is
		once
			Result := pixmap_file_content ("general")
		end

	bm_Hide_object: EV_PIXMAP is
		once
			Result := pixmap_file_content ("obj_up")
		end

	bm_Hide_routine: EV_PIXMAP is
		once
			Result := pixmap_file_content ("rout_up")
		end

	bm_Next_target: EV_PIXMAP is
		once
			Result := pixmap_file_content ("histfort")
		end

	bm_disabled_next_target: EV_PIXMAP is
		once
			Result := pixmap_file_content ("dis_histfort")
		end

	bm_Object: EV_PIXMAP is
		once
			Result := pixmap_file_content ("object")
		end

	bm_Object_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("objdot")
		end

	bm_Object_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("objicon")
		end

	bm_Open: EV_PIXMAP is
		once
			Result := pixmap_file_content ("open")
		end

	bm_Preference_project: EV_PIXMAP is
		once
			Result := pixmap_file_content ("project")
		end

	bm_Previous_target: EV_PIXMAP is
		once
			Result := pixmap_file_content ("histback")
		end

	bm_Profiler: EV_PIXMAP is
		once
			Result := pixmap_file_content ("profiler")
		end

	bm_Project_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("projicon")
		end

	bm_Quick_update: EV_PIXMAP is
		once
			Result := pixmap_file_content ("qupdate")
		end

	bm_Quit: EV_PIXMAP is
		once
			Result := pixmap_file_content ("quit")
		end

	bm_Routine: EV_PIXMAP is
		once
			Result := pixmap_file_content ("routine")
		end

	bm_Routine_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("routdot")
		end

	bm_Routine_icon: EV_PIXMAP is
		once
			Result := pixmap_file_content ("routicon")
		end

	bm_Save: EV_PIXMAP is
		once
			Result := pixmap_file_content ("save")
		end

	bm_Modified: EV_PIXMAP is
		once
			Result := pixmap_file_content ("modified")
		end

	bm_Save_as: EV_PIXMAP is
		once
			Result := pixmap_file_content ("save_as")
		end

	bm_Search: EV_PIXMAP is
		once
			Result := pixmap_file_content ("search")
		end
	
	bm_Setstop: EV_PIXMAP is
		once
			Result := pixmap_file_content ("setstop")
		end

	bm_Shell: EV_PIXMAP is
		once
			Result := pixmap_file_content ("shell")
		end
	
	bm_Showaversions: EV_PIXMAP is
		once
			Result := pixmap_file_content ("saversio")
		end

	bm_Showdversions: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdversio")
		end

	bm_Showancestors: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sancesto")
		end

	bm_Showhistory: EV_PIXMAP is
		once
			Result := pixmap_file_content ("shistory")
		end

	bm_Showindexing: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sindexin")
		end

	bm_Showattributes: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sattribu")
		end

	bm_Showcallers: EV_PIXMAP is
		once
			Result := pixmap_file_content ("scallers")
		end

	bm_Showclass_list: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sclasses")
		end

	bm_Showclients: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sclients")
		end

	bm_Showclusters: EV_PIXMAP is
		once
			Result := pixmap_file_content ("scluster")
		end

	bm_Showdeferreds: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdeferre")
		end

	bm_Showdescendants: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sdescend")
		end

	bm_Showexported: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sexporte")
		end

	bm_Showexternals: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sexterna")
		end

	bm_Showflat: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sflat")
		end

	bm_Showfs: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sfshort")
		end

	bm_Showcluster_hier_list: EV_PIXMAP is
		once
			Result := pixmap_file_content ("scluhier")
		end

	bm_Showmodified: EV_PIXMAP is
		once
			Result := pixmap_file_content ("smodifie")
		end

	bm_Showonces: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sonces")
		end

	bm_Showroutines: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sroutine")
		end

	bm_Showshort: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sshort")
		end

	bm_Showstatistics: EV_PIXMAP is
		once
			Result := pixmap_file_content ("sstatist")
		end

	bm_Showsuppliers: EV_PIXMAP is
		once
			Result := pixmap_file_content ("ssupplie")
		end

	bm_Showhomonyms: EV_PIXMAP is
		once
			Result := pixmap_file_content ("shomonym")
		end

	bm_Showtext: EV_PIXMAP is
		once
			Result := pixmap_file_content ("stext")
		end

	bm_Show_object: EV_PIXMAP is
		once
			Result := pixmap_file_content ("obj_down")
		end

	bm_Show_routine: EV_PIXMAP is
		once
			Result := pixmap_file_content ("routdown")
		end

	bm_Slice: EV_PIXMAP is
		once
			Result := pixmap_file_content ("slice")
		end

	bm_System: EV_PIXMAP is
		once
			Result := pixmap_file_content ("system")
		end

	bm_System_dot: EV_PIXMAP is
		once
			Result := pixmap_file_content ("systdot")
		end

	bm_Update: EV_PIXMAP is
		once
			Result := pixmap_file_content ("update")
		end

	bm_Up_stack: EV_PIXMAP is
		once
			Result := pixmap_file_content ("up_stack")
		end

feature {NONE} -- Update

	Pixmap_suffix: STRING is
			-- Suffix for pixmaps (bmp for windows - xpm for motif).
		once
			if Platform_constants.is_windows then
				Result := "bmp"
			else
				Result := "xpm"
			end
		end

	Eiffel_installation_dir_name: STRING is
		once
			Result := Execution_environment.get ("EIFFEL4")
		end;

	Bitmap_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Eiffel_installation_dir_name);
			Result.extend_from_array (<<"bench", "bitmaps">>);
			Result.extend (Pixmap_suffix)
		end;

	pixmap_file_content (fn: STRING): EV_PIXMAP is
		local
			full_path: FILE_NAME
		do
			create full_path.make_from_string (Bitmap_path)
			full_path.set_file_name (fn)
			full_path.add_extension (Pixmap_suffix)
			create Result.make_from_file (full_path)
	--		if not Result.is_valid then
	--			io.error.putstring ("Warning: cannot read pixmap file ")
	--			io.error.putstring (full_path)
	--			io.error.new_line
	--		end
		end

end -- class EB_SHARED_PIXMAPS
