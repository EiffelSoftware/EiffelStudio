indexing

	description: "Pixmaps used in interface."
	date: "$Date$"
	revision: "$Revision $"

class SHARED_PIXMAPS

inherit
	SHARED_EXEC_ENVIRONMENT

	SHARED_PLATFORM_CONSTANTS

feature -- Access

	bm_ISE_Power: PIXMAP is
		once
			Result := pixmap_file_content ("isepower")
		end

	bm_Breakpoint: PIXMAP is
		once
			Result := pixmap_file_content ("breakpt")
		end

	bm_Clear_breakpoints: PIXMAP is
		once
			Result := pixmap_file_content ("clr_bp")
		end

	bm_Disable_breakpoints: PIXMAP is
		once
			Result := pixmap_file_content ("dis_bp")
		end

	bm_Debug_edit_object: PIXMAP is
		once
			Result := pixmap_file_content ("editobj")
		end

	bm_Graph: PIXMAP is
		once
			Result := pixmap_file_content ("graph")
		end

	bm_graphical_Breakablepoint: PIXMAP is
		once
			Result := pixmap_file_content ("gbreakpt")
		end

	bm_graphical_Stoppoint: PIXMAP is
		once
			Result := pixmap_file_content ("gstoppt")
		end

	bm_Case_storage: PIXMAP is
		once
			Result := pixmap_file_content ("casestor")
		end

	bm_Class: PIXMAP is
		once
			Result := pixmap_file_content ("class")
		end

	bm_Class_dot: PIXMAP is
		once
			Result := pixmap_file_content ("classdot")
		end

	bm_Class_icon: PIXMAP is
		once
			Result := pixmap_file_content ("classico")
		end

	bm_Dynamic_lib: PIXMAP is
		once
			Result := pixmap_file_content ("dynlib")
		end

	bm_Dynamic_lib_dot: PIXMAP is
		once
			Result := pixmap_file_content ("dynlibdot")
		end

	bm_Dynamic_lib_icon: PIXMAP is
		once
			Result := pixmap_file_content ("dynlibico")
		end

	bm_Clickable: PIXMAP is
		once
			Result := pixmap_file_content ("clckable")
		end

	bm_Current: PIXMAP is
		once
			Result := pixmap_file_content ("current")
		end

	bm_Debug_dynamic_eval: PIXMAP is
		once
			Result := pixmap_file_content ("dbg_dyneval")
		end

	bm_Debug_quit: PIXMAP is
		once
			Result := pixmap_file_content ("dbgquit")
		end

	bm_Debug_interrupt: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstop")
		end

	bm_Debug_run: PIXMAP is
		once
			Result := pixmap_file_content ("dbgrun")
		end

	bm_Debug_status: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstatu")
		end

	bm_Down_stack: PIXMAP is
		once
			Result := pixmap_file_content ("dn_stack")
		end

	bm_Exec_last: PIXMAP is
		once
			Result := pixmap_file_content ("execlast")
		end

	bm_Exec_nostop: PIXMAP is
		once
			Result := pixmap_file_content ("execnost")
		end

	bm_Exec_step: PIXMAP is
		once
			Result := pixmap_file_content ("execstep")
		end

	bm_Exec_into: PIXMAP is
		once
			Result := pixmap_file_content ("execinto")
		end

	bm_Exec_stop: PIXMAP is
		once
			Result := pixmap_file_content ("execstop")
		end

	bm_Explain: PIXMAP is
		once
			Result := pixmap_file_content ("explain")
		end

	bm_Explain_dot: PIXMAP is
		once
			Result := pixmap_file_content ("expldot")
		end

	bm_Explain_icon: PIXMAP is
		once
			Result := pixmap_file_content ("explicon")
		end

	bm_General: PIXMAP is
		once
			Result := pixmap_file_content ("general")
		end

	bm_Hide_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_up")
		end

	bm_Hide_routine: PIXMAP is
		once
			Result := pixmap_file_content ("rout_up")
		end

	bm_Next_target: PIXMAP is
		once
			Result := pixmap_file_content ("histfort")
		end

	bm_disabled_next_target: PIXMAP is
		once
			Result := pixmap_file_content ("dis_histfort")
		end

	bm_Object: PIXMAP is
		once
			Result := pixmap_file_content ("object")
		end

	bm_Object_dot: PIXMAP is
		once
			Result := pixmap_file_content ("objdot")
		end

	bm_Object_icon: PIXMAP is
		once
			Result := pixmap_file_content ("objicon")
		end

	bm_Open: PIXMAP is
		once
			Result := pixmap_file_content ("open")
		end

	bm_Preference_project: PIXMAP is
		once
			Result := pixmap_file_content ("project")
		end

	bm_Previous_target: PIXMAP is
		once
			Result := pixmap_file_content ("histback")
		end

	bm_Profiler: PIXMAP is
		once
			Result := pixmap_file_content ("profiler")
		end

	bm_Project_icon: PIXMAP is
		once
			Result := pixmap_file_content ("projicon")
		end

	bm_Quick_update: PIXMAP is
		once
			Result := pixmap_file_content ("qupdate")
		end

	bm_Quit: PIXMAP is
		once
			Result := pixmap_file_content ("quit")
		end

	bm_Routine: PIXMAP is
		once
			Result := pixmap_file_content ("routine")
		end

	bm_Routine_dot: PIXMAP is
		once
			Result := pixmap_file_content ("routdot")
		end

	bm_Routine_icon: PIXMAP is
		once
			Result := pixmap_file_content ("routicon")
		end

	bm_Save: PIXMAP is
		once
			Result := pixmap_file_content ("save")
		end

	bm_Modified: PIXMAP is
		once
			Result := pixmap_file_content ("modified")
		end

	bm_Save_as: PIXMAP is
		once
			Result := pixmap_file_content ("save_as")
		end

	bm_Search: PIXMAP is
		once
			Result := pixmap_file_content ("search")
		end
	
	bm_Setstop: PIXMAP is
		once
			Result := pixmap_file_content ("setstop")
		end

	bm_Shell: PIXMAP is
		once
			Result := pixmap_file_content ("shell")
		end
	
	bm_Showaversions: PIXMAP is
		once
			Result := pixmap_file_content ("saversio")
		end

	bm_Showdversions: PIXMAP is
		once
			Result := pixmap_file_content ("sdversio")
		end

	bm_Showancestors: PIXMAP is
		once
			Result := pixmap_file_content ("sancesto")
		end

	bm_Showhistory: PIXMAP is
		once
			Result := pixmap_file_content ("shistory")
		end

	bm_Showindexing: PIXMAP is
		once
			Result := pixmap_file_content ("sindexin")
		end

	bm_Showattributes: PIXMAP is
		once
			Result := pixmap_file_content ("sattribu")
		end

	bm_Showcallers: PIXMAP is
		once
			Result := pixmap_file_content ("scallers")
		end

	bm_Showclass_list: PIXMAP is
		once
			Result := pixmap_file_content ("sclasses")
		end

	bm_Showclients: PIXMAP is
		once
			Result := pixmap_file_content ("sclients")
		end

	bm_Showclusters: PIXMAP is
		once
			Result := pixmap_file_content ("scluster")
		end

	bm_Showdeferreds: PIXMAP is
		once
			Result := pixmap_file_content ("sdeferre")
		end

	bm_Showdescendants: PIXMAP is
		once
			Result := pixmap_file_content ("sdescend")
		end

	bm_Showexported: PIXMAP is
		once
			Result := pixmap_file_content ("sexporte")
		end

	bm_Showexternals: PIXMAP is
		once
			Result := pixmap_file_content ("sexterna")
		end

	bm_Showflat: PIXMAP is
		once
			Result := pixmap_file_content ("sflat")
		end

	bm_Showfs: PIXMAP is
		once
			Result := pixmap_file_content ("sfshort")
		end

	bm_Showcluster_hier_list: PIXMAP is
		once
			Result := pixmap_file_content ("scluhier")
		end

	bm_Showmodified: PIXMAP is
		once
			Result := pixmap_file_content ("smodifie")
		end

	bm_Showonces: PIXMAP is
		once
			Result := pixmap_file_content ("sonces")
		end

	bm_Showroutines: PIXMAP is
		once
			Result := pixmap_file_content ("sroutine")
		end

	bm_Showshort: PIXMAP is
		once
			Result := pixmap_file_content ("sshort")
		end

	bm_Showstatistics: PIXMAP is
		once
			Result := pixmap_file_content ("sstatist")
		end

	bm_Showsuppliers: PIXMAP is
		once
			Result := pixmap_file_content ("ssupplie")
		end

	bm_Showhomonyms: PIXMAP is
		once
			Result := pixmap_file_content ("shomonym")
		end

	bm_Showtext: PIXMAP is
		once
			Result := pixmap_file_content ("stext")
		end

	bm_Show_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_down")
		end

	bm_Show_routine: PIXMAP is
		once
			Result := pixmap_file_content ("routdown")
		end

	bm_Slice: PIXMAP is
		once
			Result := pixmap_file_content ("slice")
		end

	bm_System: PIXMAP is
		once
			Result := pixmap_file_content ("system")
		end

	bm_System_dot: PIXMAP is
		once
			Result := pixmap_file_content ("systdot")
		end

	bm_Update: PIXMAP is
		once
			Result := pixmap_file_content ("update")
		end

	bm_Up_stack: PIXMAP is
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

	Bitmap_path: DIRECTORY_NAME is
		once
			!! Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name);
			Result.extend_from_array (<<"bench", "bitmaps">>);
			Result.extend (Pixmap_suffix)
		end;

	pixmap_file_content (fn: STRING): PIXMAP is
		local
			full_path: FILE_NAME
		do
			!! full_path.make_from_string (Bitmap_path)
			full_path.set_file_name (fn)
			full_path.add_extension (Pixmap_suffix)
			!! Result.make
			Result.read_from_file (full_path)
			if not Result.is_valid then
				io.error.putstring ("Warning: cannot read pixmap file ")
				io.error.putstring (full_path)
				io.error.new_line
			end
		end


end -- class SHARED_PIXMAPS
