indexing

	description: 
		"Pixmaps used in interface.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_PIXMAPS

inherit

	EIFFEL_ENV
	
feature -- Access

	bm_Breakpoint: PIXMAP is
		once
			Result := pixmap_file_content ("breakpt");
		end;

	bm_Clear_breakpoints: PIXMAP is
		once
			Result := pixmap_file_content ("clr_bp");
		end;

	bm_Graph: PIXMAP is
		once
			Result := pixmap_file_content ("graph");
		end;

	bm_graphical_Breakablepoint: PIXMAP is
		once
			Result := pixmap_file_content ("gbreakpt");
			if not Result.is_valid then
				Result := Bm_default
			end
		end;

	bm_graphical_Stoppoint: PIXMAP is
		once
			Result := pixmap_file_content ("gstoppt");
			if not Result.is_valid then
				Result := Bm_default
			end
		end;

	bm_Case_storage: PIXMAP is
		once
			Result := pixmap_file_content ("casestor");
		end;

	bm_Check: PIXMAP is
		once
			Result := pixmap_file_content ("check");
		end;

	bm_Class: PIXMAP is
		once
			Result := pixmap_file_content ("class");
		end;

	bm_Class_dot: PIXMAP is
		once
			Result := pixmap_file_content ("classdot");
		end;

	bm_Class_icon: PIXMAP is
		once
			Result := pixmap_file_content ("classico");
		end;

	bm_Clickable: PIXMAP is
		once
			Result := pixmap_file_content ("clckable");
		end;

	bm_Continue: PIXMAP is
		once
			Result := pixmap_file_content ("continue");
		end;

	bm_Current: PIXMAP is
		once
			Result := pixmap_file_content ("current")
		end;

	bm_Debug_quit: PIXMAP is
		once
			Result := pixmap_file_content ("dbgquit");
		end;

	bm_Debug_run: PIXMAP is
		once
			Result := pixmap_file_content ("dbgrun");
		end;

	bm_Debug_status: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstatu");
		end;

	bm_Debug_step: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstep");
		end;

	bm_Down_stack: PIXMAP is
		once
			Result := pixmap_file_content ("dn_stack");
		end;

	bm_Exec_last: PIXMAP is
		once
			Result := pixmap_file_content ("execlast");
		end;

	bm_Exec_nostop: PIXMAP is
		once
			Result := pixmap_file_content ("execnost");
		end;

	bm_Exec_step: PIXMAP is
		once
			Result := pixmap_file_content ("execstep");
		end;

	bm_Exec_stop: PIXMAP is
		once
			Result := pixmap_file_content ("execstop");
		end;

	bm_Explain: PIXMAP is
		once
			Result := pixmap_file_content ("explain");
		end;

	bm_Explain_dot: PIXMAP is
		once
			Result := pixmap_file_content ("expldot");
		end;

	bm_Explain_icon: PIXMAP is
		once
			Result := pixmap_file_content ("explicon");
		end;

	bm_Filter: PIXMAP is
		once
			Result := pixmap_file_content ("filter");
		end;

	bm_General: PIXMAP is
		once
			Result := pixmap_file_content ("general");
		end;

	bm_Hide_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_up")
		end;

	bm_Hide_routine: PIXMAP is
		once
			Result := pixmap_file_content ("rout_up")
		end;

	bm_Next_target: PIXMAP is
		once
			Result := pixmap_file_content ("histfort")
		end;

	bm_Object: PIXMAP is
		once
			Result := pixmap_file_content ("object");
		end;

	bm_Object_dot: PIXMAP is
		once
			Result := pixmap_file_content ("objdot");
		end;

	bm_Object_icon: PIXMAP is
		once
			Result := pixmap_file_content ("objicon");
		end;

	bm_Object_inv: PIXMAP is
		once
			Result := pixmap_file_content ("objinv");
		end;

	bm_Open: PIXMAP is
		once
			Result := pixmap_file_content ("open");
		end;

	bm_Preference_project: PIXMAP is
		once
			Result := pixmap_file_content ("project");
		end;

	bm_Previous_target: PIXMAP is
		once
			Result := pixmap_file_content ("histback")
		end;

	bm_Profiler: PIXMAP is
		once
			Result := pixmap_file_content ("profiler");
		end;

	bm_Project: PIXMAP is
		once
			Result := pixmap_file_content ("tower");
		end;

	bm_Project_icon: PIXMAP is
		once
			Result := pixmap_file_content ("projicon");
		end;

	bm_Quick_update: PIXMAP is
		once
			Result := pixmap_file_content ("qupdate");
		end;

	bm_Quit: PIXMAP is
		once
			Result := pixmap_file_content ("quit");
		end;

	bm_Routine: PIXMAP is
		once
			Result := pixmap_file_content ("routine");
		end;

	bm_Routine_dot: PIXMAP is
		once
			Result := pixmap_file_content ("routdot");
		end;

	bm_Routine_icon: PIXMAP is
		once
			Result := pixmap_file_content ("routicon");
		end;

	bm_Run: PIXMAP is
		once
			Result := pixmap_file_content ("run");
		end;

	bm_Save: PIXMAP is
		once
			Result := pixmap_file_content ("save");
		end;

	bm_Save_as: PIXMAP is
		once
			Result := pixmap_file_content ("save_as");
		end;

	bm_Search: PIXMAP is
		once
			Result := pixmap_file_content ("search");
		end;
	
	bm_Setstop: PIXMAP is
		once
			Result := pixmap_file_content ("setstop");
		end;

	bm_Shell: PIXMAP is
		once
			Result := pixmap_file_content ("shell");
		end;
	
	bm_Showaversions: PIXMAP is
		once
			Result := pixmap_file_content ("saversio");
		end;

	bm_Showdversions: PIXMAP is
		once
			Result := pixmap_file_content ("sdversio");
		end;

	bm_Showancestors: PIXMAP is
		once
			Result := pixmap_file_content ("sancesto");
		end;

	bm_Showhistory: PIXMAP is
		once
			Result := pixmap_file_content ("shistory");
		end;

	bm_Showindexing: PIXMAP is
		once
			Result := pixmap_file_content ("sindexin");
		end;

	bm_Showattributes: PIXMAP is
		once
			Result := pixmap_file_content ("sattribu");
		end;

	bm_Showcallers: PIXMAP is
		once
			Result := pixmap_file_content ("scallers");
		end;

	bm_Showclass_list: PIXMAP is
		once
			Result := pixmap_file_content ("sclasses");
		end;

	bm_Showclients: PIXMAP is
		once
			Result := pixmap_file_content ("sclients");
		end;

	bm_Showclusters: PIXMAP is
		once
			Result := pixmap_file_content ("scluster");
		end;

	bm_Showdeferreds: PIXMAP is
		once
			Result := pixmap_file_content ("sdeferre");
		end;

	bm_Showdescendants: PIXMAP is
		once
			Result := pixmap_file_content ("sdescend");
		end;

	bm_Showexported: PIXMAP is
		once
			Result := pixmap_file_content ("sexporte");
		end;

	bm_Showexternals: PIXMAP is
		once
			Result := pixmap_file_content ("sexterna");
		end;

	bm_Showflat: PIXMAP is
		once
			Result := pixmap_file_content ("sflat");
		end;

	bm_Showfs: PIXMAP is
		once
			Result := pixmap_file_content ("sfshort");
		end;

	bm_Showcluster_hier_list: PIXMAP is
		once
			Result := pixmap_file_content ("scluhier");
		end;

	bm_Showmodified: PIXMAP is
		once
			Result := pixmap_file_content ("smodifie");
		end;

	bm_Showonces: PIXMAP is
		once
			Result := pixmap_file_content ("sonces");
		end;

	bm_Showroutines: PIXMAP is
		once
			Result := pixmap_file_content ("sroutine");
		end;

	bm_Showshort: PIXMAP is
		once
			Result := pixmap_file_content ("sshort");
		end;

	bm_Showstatistics: PIXMAP is
		once
			Result := pixmap_file_content ("sstatist");
		end;

	bm_Showstops: PIXMAP is
		once
			Result := pixmap_file_content ("sstops");
		end;

	bm_Showsuppliers: PIXMAP is
		once
			Result := pixmap_file_content ("ssupplie");
		end;

	bm_Showhomonyms: PIXMAP is
		once
			Result := pixmap_file_content ("shomonym");
		end;

	bm_Showtext: PIXMAP is
		once
			Result := pixmap_file_content ("stext");
		end;

	bm_Show_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_down")
		end;

	bm_Show_routine: PIXMAP is
		once
			Result := pixmap_file_content ("routdown")
		end;

	bm_Slice: PIXMAP is
		once
			Result := pixmap_file_content ("slice")
		end;

	bm_Step: PIXMAP is
		once
			Result := pixmap_file_content ("step");
		end;

	bm_System: PIXMAP is
		once
			Result := pixmap_file_content ("system");
		end;

	bm_System_dot: PIXMAP is
		once
			Result := pixmap_file_content ("systdot");
		end;

	bm_System_icon: PIXMAP is
		once
			Result := pixmap_file_content ("systicon");
		end;

	bm_Update: PIXMAP is
		once
			Result := pixmap_file_content ("update");
		end;

	bm_Up_stack: PIXMAP is
		once
			Result := pixmap_file_content ("up_stack");
		end;

	bm_default: PIXMAP is
		once
			Result := pixmap_file_content ("default");
		end;

feature -- Obsolete pixmaps (keep this routines around till 3.5 even though they are not used)

	bm_Dark_breakpoint: PIXMAP is
		once
			Result := pixmap_file_content ("dbreakpt");
		end;

	bm_Dark_class: PIXMAP is
		once
			Result := pixmap_file_content ("dclass")
		end;

	bm_Dark_clickable: PIXMAP is
		once
			Result := pixmap_file_content ("dclckabl");
		end;

	bm_Dark_exec_last: PIXMAP is
		once
			Result := pixmap_file_content ("dexeclas");
		end;

	bm_Dark_exec_nostop: PIXMAP is
		once
			Result := pixmap_file_content ("dexecnos");
		end;

	bm_Dark_exec_step: PIXMAP is
		once
			Result := pixmap_file_content ("dexecste");
		end;

	bm_Dark_exec_stop: PIXMAP is
		once
			Result := pixmap_file_content ("dexecsto");
		end;

	dm_Dark_explain: PIXMAP is
		once
			Result := pixmap_file_content ("dexplain");
		end;

	bm_Dark_object: PIXMAP is
		once
			Result := pixmap_file_content ("dobject");
		end;

	bm_Dark_project: PIXMAP is
		once
			Result := pixmap_file_content ("dproject");
		end;

	bm_Dark_routine: PIXMAP is
		once
			Result := pixmap_file_content ("droutine");
		end;

	bm_Dark_save: PIXMAP is
		once
			Result := pixmap_file_content ("darksave");
		end;

	bm_Dark_showancestors: PIXMAP is
		once
			Result := pixmap_file_content ("dsancest");
		end;

	bm_Dark_showattributes: PIXMAP is
		once
			Result := pixmap_file_content ("dsattrib");
		end;

	bm_Dark_showaversions: PIXMAP is
		once
			Result := pixmap_file_content ("dsaversi");
		end;

	bm_Dark_showcallers: PIXMAP is
		once
			Result := pixmap_file_content ("dscaller");
		end;

	bm_Dark_showclass_list: PIXMAP is
		once
			Result := pixmap_file_content ("dsclasse");
		end;

	bm_Dark_showclients: PIXMAP is
		once
			Result := pixmap_file_content ("dsclient");
		end;

	bm_Dark_showclusters: PIXMAP is
		once
			Result := pixmap_file_content ("dscluste");
		end;

	bm_Dark_showdeferreds: PIXMAP is
		once
			Result := pixmap_file_content ("dsdeferr");
		end;

	bm_Dark_showdescendants: PIXMAP is
		once
			Result := pixmap_file_content ("dsdescen");
		end;

	bm_Dark_showdversions: PIXMAP is
		once
			Result := pixmap_file_content ("dsdversi");
		end;

	bm_Dark_showexported: PIXMAP is
		once
			Result := pixmap_file_content ("dsexport");
		end;

	bm_Dark_showexternals: PIXMAP is
		once
			Result := pixmap_file_content ("dsextern");
		end;

	bm_Dark_showflat: PIXMAP is
		once
			Result := pixmap_file_content ("dsflat");
		end;

	bm_Dark_showfs: PIXMAP is
		once
			Result := pixmap_file_content ("dsfshort");
		end;

	bm_Dark_showhistory: PIXMAP is
		once
			Result := pixmap_file_content ("dshistor");
		end;

	bm_Dark_showindexing: PIXMAP is
		once
			Result := pixmap_file_content ("dsindexi");
		end;

	bm_Dark_showmodified: PIXMAP is
		once
			Result := pixmap_file_content ("dsmodifi");
		end;

	bm_Dark_showonces: PIXMAP is
		once
			Result := pixmap_file_content ("dsonces");
		end;

	bm_Dark_showroutines: PIXMAP is
		once
			Result := pixmap_file_content ("dsroutin");
		end;

	bm_Dark_showshort: PIXMAP is
		once
			Result := pixmap_file_content ("dsshort");
		end;

	bm_Dark_showstatistics: PIXMAP is
		once
			Result := pixmap_file_content ("dsstatis");
		end;

	bm_Dark_showsuppliers: PIXMAP is
		once
			Result := pixmap_file_content ("dssuppli");
		end;

	bm_Dark_showhomonyms: PIXMAP is
		once
			Result := pixmap_file_content ("dshomony");
		end;

	bm_Dark_showtext: PIXMAP is
		once
			Result := pixmap_file_content ("dstext");
		end;

	bm_Dark_system: PIXMAP is
		once
			Result := pixmap_file_content ("dsystem");
		end;

feature {NONE} -- Update

	pixmap_file_content (fn: STRING): PIXMAP is
		local
			full_path: FILE_NAME;
		do
			!! full_path.make_from_string (Bitmap_path);
			full_path.set_file_name (fn);
			full_path.add_extension (Pixmap_suffix);
			!! Result.make;
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Warning: cannot read pixmap file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;


end -- class SHARED_PIXMAPS
