
-- Environment for bitmaps, help, binaries, scripts....

class SHARED_PIXMAPS

inherit

	EIFFEL_ENV
	
feature {NONE}

	bm_Breakpoint: PIXMAP is
		do
			Result := pixmap_file_content ("breakpoint.bm");
		end;

	bm_Check: PIXMAP is
		do
			Result := pixmap_file_content ("check.bm");
		end;

	bm_Class: PIXMAP is
		do
			Result := pixmap_file_content ("class.bm");
		end;

	bm_Class_dot: PIXMAP is
		do
			Result := pixmap_file_content ("class_dot.bm");
		end;

	bm_Class_icon: PIXMAP is
		do
			Result := pixmap_file_content ("class_icon.bm");
		end;

	bm_Clickable: PIXMAP is
		do
			Result := pixmap_file_content ("clickable.bm");
		end;

	bm_Continue: PIXMAP is
		do
			Result := pixmap_file_content ("continue.bm");
		end;

	bm_Current: PIXMAP is
		do
			Result := pixmap_file_content ("current.bm")
		end;

	bm_Dark_breakpoint: PIXMAP is
		do
			Result := pixmap_file_content ("dbreakpoint.bm");
		end;

	bm_Dark_clickable: PIXMAP is
		do
			Result := pixmap_file_content ("dclickable.bm");
		end;

	bm_Dark_exec_last: PIXMAP is
		do
			Result := pixmap_file_content ("dexeclast.bm");
		end;

	bm_Dark_exec_nostop: PIXMAP is
		do
			Result := pixmap_file_content ("dexecnostop.bm");
		end;

	bm_Dark_exec_step: PIXMAP is
		do
			Result := pixmap_file_content ("dexecstep.bm");
		end;

	bm_Dark_exec_stop: PIXMAP is
		do
			Result := pixmap_file_content ("dexecstop.bm");
		end;

	bm_Dark_save: PIXMAP is
		do
			Result := pixmap_file_content ("dark_save.bm");
		end;

	bm_Dark_showancestors: PIXMAP is
		do
			Result := pixmap_file_content ("dshowancestors.bm");
		end;

	bm_Dark_showattributes: PIXMAP is
		do
			Result := pixmap_file_content ("dshowattributes.bm");
		end;

	bm_Dark_showaversions: PIXMAP is
		do
			Result := pixmap_file_content ("dshowaversions.bm");
		end;

	bm_Dark_showcallers: PIXMAP is
		do
			Result := pixmap_file_content ("dshowcallers.bm");
		end;

	bm_Dark_showclients: PIXMAP is
		do
			Result := pixmap_file_content ("dshowclients.bm");
		end;

	bm_Dark_showclusters: PIXMAP is
		do
			Result := pixmap_file_content ("dshowclusters.bm");
		end;

	bm_Dark_showdeferreds: PIXMAP is
		do
			Result := pixmap_file_content ("dshowdeferreds.bm");
		end;

	bm_Dark_showdescendants: PIXMAP is
		do
			Result := pixmap_file_content ("dshowdescendants.bm");
		end;

	bm_Dark_showdversions: PIXMAP is
		do
			Result := pixmap_file_content ("dshowdversions.bm");
		end;

	bm_Dark_showexternals: PIXMAP is
		do
			Result := pixmap_file_content ("dshowexternals.bm");
		end;

	bm_Dark_showflat: PIXMAP is
		do
			Result := pixmap_file_content ("dshowflat.bm");
		end;

	bm_Dark_showfs: PIXMAP is
		do
			Result := pixmap_file_content ("dshowfs.bm");
		end;

	bm_Dark_showhistory: PIXMAP is
		do
			Result := pixmap_file_content ("dshowhistory.bm");
		end;

	bm_Dark_showindexing: PIXMAP is
		do
			Result := pixmap_file_content ("dshowindexing.bm");
		end;

	bm_Dark_showmodifs: PIXMAP is
		do
			Result := pixmap_file_content ("dshowmodifs.bm");
		end;

	bm_Dark_showonces: PIXMAP is
		do
			Result := pixmap_file_content ("dshowonces.bm");
		end;

	bm_Dark_showroutines: PIXMAP is
		do
			Result := pixmap_file_content ("dshowroutines.bm");
		end;

	bm_Dark_showshort: PIXMAP is
		do
			Result := pixmap_file_content ("dshowshort.bm");
		end;

	bm_Dark_showsuppliers: PIXMAP is
		do
			Result := pixmap_file_content ("dshowsuppliers.bm");
		end;

	bm_Dark_showsynonyms: PIXMAP is
		do
			Result := pixmap_file_content ("dshowsynonyms.bm");
		end;

	bm_Dark_showtext: PIXMAP is
		do
			Result := pixmap_file_content ("dshowtext.bm");
		end;

	bm_Debug_quit: PIXMAP is
		do
			Result := pixmap_file_content ("debug_quit.bm");
		end;

	bm_Debug_run: PIXMAP is
		do
			Result := pixmap_file_content ("debug_run.bm");
		end;

	bm_Debug_status: PIXMAP is
		do
			Result := pixmap_file_content ("debug_status.bm");
		end;

	bm_Debug_step: PIXMAP is
		do
			Result := pixmap_file_content ("debug_step.bm");
		end;

	bm_Exec_last: PIXMAP is
		do
			Result := pixmap_file_content ("execlast.bm");
		end;

	bm_Exec_nostop: PIXMAP is
		do
			Result := pixmap_file_content ("execnostop.bm");
		end;

	bm_Exec_step: PIXMAP is
		do
			Result := pixmap_file_content ("execstep.bm");
		end;

	bm_Exec_stop: PIXMAP is
		do
			Result := pixmap_file_content ("execstop.bm");
		end;

	bm_Explain: PIXMAP is
		do
			Result := pixmap_file_content ("explain.bm");
		end;

	bm_Explain_dot: PIXMAP is
		do
			Result := pixmap_file_content ("explain_dot.bm");
		end;

	bm_Explain_icon: PIXMAP is
		do
			Result := pixmap_file_content ("expl_icon.bm");
		end;

	bm_Finalize: PIXMAP is
		do
			Result := pixmap_file_content ("finalize.bm");
		end;

	bm_Font: PIXMAP is
		do
			Result := pixmap_file_content ("font.bm");
		end;

	bm_Freeze: PIXMAP is
		do
			Result := pixmap_file_content ("freeze.bm");
		end;

	bm_Ice: PIXMAP is
		do
			Result := pixmap_file_content ("ice.bm");
		end;

	bm_Line: PIXMAP is
		do
			Result := pixmap_file_content ("line.bm");
		end;

	bm_Next: PIXMAP is
		do
			Result := pixmap_file_content ("next.bm");
		end;

	bm_Next_target: PIXMAP is
		do
			Result := pixmap_file_content ("hist_forth.bm")
		end;

	bm_Object: PIXMAP is
		do
			Result := pixmap_file_content ("object.bm");
		end;

	bm_Object_dot: PIXMAP is
		do
			Result := pixmap_file_content ("object_dot.bm");
		end;

	bm_Object_icon: PIXMAP is
		do
			Result := pixmap_file_content ("obj_icon.bm");
		end;

	bm_Object_inv: PIXMAP is
		do
			Result := pixmap_file_content ("obj_inv.bm");
		end;

	bm_Open: PIXMAP is
		do
			Result := pixmap_file_content ("open.bm");
		end;

	bm_Previous_target: PIXMAP is
		do
			Result := pixmap_file_content ("hist_back.bm")
		end;

	bm_Project: PIXMAP is
		do
			Result := pixmap_file_content ("tower.bm");
		end;

	bm_Project_icon: PIXMAP is
		do
			Result := pixmap_file_content ("project_icon.bm");
		end;

	bm_Quit: PIXMAP is
		do
			Result := pixmap_file_content ("quit.bm");
		end;

	bm_Removestop: PIXMAP is
		do
			Result := pixmap_file_content ("removestop.bm");
		end;

	bm_Routine: PIXMAP is
		do
			Result := pixmap_file_content ("routine.bm");
		end;

	bm_Routine_dot: PIXMAP is
		do
			Result := pixmap_file_content ("rout_dot.bm");
		end;

	bm_Routine_icon: PIXMAP is
		do
			Result := pixmap_file_content ("routine_icon.bm");
		end;

	bm_Run: PIXMAP is
		do
			Result := pixmap_file_content ("run.bm");
		end;

	bm_Save: PIXMAP is
		do
			Result := pixmap_file_content ("save.bm");
		end;

	bm_Save_as: PIXMAP is
		do
			Result := pixmap_file_content ("save_as.bm");
		end;

	bm_Search: PIXMAP is
		do
			Result := pixmap_file_content ("search.bm");
		end;
	
	bm_Setstop: PIXMAP is
		do
			Result := pixmap_file_content ("setstop.bm");
		end;

	bm_Setstop_cur: PIXMAP is
		do
			Result := pixmap_file_content ("setstop_cur.bm");
		end; -- bm_Setstop_cur
	
	bm_Shell: PIXMAP is
		do
			Result := pixmap_file_content ("shell.bm");
		end;
	
	bm_Showaversions: PIXMAP is
		do
			Result := pixmap_file_content ("showaversions.bm");
		end;

	bm_Showdversions: PIXMAP is
		do
			Result := pixmap_file_content ("showdversions.bm");
		end;

	bm_Showancestors: PIXMAP is
		do
			Result := pixmap_file_content ("showancestors.bm");
		end;

	bm_Showhistory: PIXMAP is
		do
			Result := pixmap_file_content ("showhistory.bm");
		end;

	bm_Showindexing: PIXMAP is
		do
			Result := pixmap_file_content ("showindexing.bm");
		end;

	bm_Showattributes: PIXMAP is
		do
			Result := pixmap_file_content ("showattributes.bm");
		end;

	bm_Showcallers: PIXMAP is
		do
			Result := pixmap_file_content ("showcallers.bm");
		end;

	bm_Showclients: PIXMAP is
		do
			Result := pixmap_file_content ("showclients.bm");
		end;

	bm_Showclusters: PIXMAP is
		do
			Result := pixmap_file_content ("showclusters.bm");
		end;

	bm_Showcustom: PIXMAP is
		do
			Result := pixmap_file_content ("showcustom.bm");
		end;

	bm_Showcustom_dot: PIXMAP is
		do
			Result := pixmap_file_content ("scust_dot.bm");
		end;

	bm_Showdeferreds: PIXMAP is
		do
			Result := pixmap_file_content ("showdeferreds.bm");
		end;

	bm_Showdescendants: PIXMAP is
		do
			Result := pixmap_file_content ("showdescendants.bm");
		end;

	bm_Showexternals: PIXMAP is
		do
			Result := pixmap_file_content ("showexternals.bm");
		end;

	bm_Showflat: PIXMAP is
		do
			Result := pixmap_file_content ("showflat.bm");
		end;

	bm_Showfs: PIXMAP is
		do
			Result := pixmap_file_content ("showfs.bm");
		end;

	bm_Showmodifs: PIXMAP is
		do
			Result := pixmap_file_content ("showmodifs.bm");
		end;

	bm_Showonces: PIXMAP is
		do
			Result := pixmap_file_content ("showonces.bm");
		end;

	bm_Showroutines: PIXMAP is
		do
			Result := pixmap_file_content ("showroutines.bm");
		end;

	bm_Showshort: PIXMAP is
		do
			Result := pixmap_file_content ("showshort.bm");
		end;

	bm_Showstops: PIXMAP is
		do
			Result := pixmap_file_content ("showstops.bm");
		end;

	bm_Showsuppliers: PIXMAP is
		do
			Result := pixmap_file_content ("showsuppliers.bm");
		end;

	bm_Showsynonyms: PIXMAP is
		do
			Result := pixmap_file_content ("showsynonyms.bm");
		end;

	bm_Showtext: PIXMAP is
		do
			Result := pixmap_file_content ("showtext.bm");
		end;

	bm_Step: PIXMAP is
		do
			Result := pixmap_file_content ("step.bm");
		end;

	bm_System: PIXMAP is
		do
			Result := pixmap_file_content ("system.bm");
		end;

	bm_System_dot: PIXMAP is
		do
			Result := pixmap_file_content ("system_dot.bm");
		end;

	bm_System_icon: PIXMAP is
		do
			Result := pixmap_file_content ("system_icon.bm");
		end;

	bm_Update: PIXMAP is
		do
			Result := pixmap_file_content ("update.bm");
		end;

	bm_class_cur: PIXMAP is
		do
			Result := pixmap_file_content ("class_cur.bm");
		end;

	bm_entity_cur: PIXMAP is
		do
			Result := pixmap_file_content ("entity_cur.bm");
		end;

	bm_object_cur: PIXMAP is
		do
			Result := pixmap_file_content ("object_cur.bm");
		end;

	bm_explain_cur: PIXMAP is
		do
			Result := pixmap_file_content ("expl_cur.bm");
		end;

	bm_default: PIXMAP is
		do
			Result := pixmap_file_content ("default.bm");
		end;

	bm_system_cur: PIXMAP is
		do
			Result := pixmap_file_content ("system_cur.bm");
		end;

	pixmap_file_content (fn: STRING): PIXMAP is
		local
			full_path: STRING;
			c: CHARACTER
		do
			c := Directory_separator;
			full_path := clone (Eiffel3_dir_name)
			full_path.extend (c);
			full_path.append ("bench");
			full_path.extend (c);
			full_path.append ("bitmaps");
			full_path.extend (c);
			full_path.append (fn);
			!!Result.make;
			Result.read_from_file (full_path);
			if not Result.last_operation_correct then
				io.error.putstring ("Warning: cannot read pixmap file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;


end
