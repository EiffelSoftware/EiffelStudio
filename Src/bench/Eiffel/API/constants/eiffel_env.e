
-- Environment for bitmaps, help, binaries, scripts....

class EIFFEL_ENV

inherit

	FILE_HANDLER
	
feature {NONE}

	Eiffel3_dir_name: STRING is
		once
			Result := env_variable ("EIFFEL3")
		end;

	Freeze_command_name: STRING is
		once
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bench/spec/$PLATFORM/bin/finish_freezing ")
		end;

	help_path: STRING is
		once
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bench/help/errors/")
		end;

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

	bm_Dark_save: PIXMAP is
		do
			Result := pixmap_file_content ("dark_save.bm");
		end;

	bm_Debug_quit: PIXMAP is
		do
			Result := pixmap_file_content ("debug_quit.bm");
		end;

	bm_Debug_run: PIXMAP is
		do
			Result := pixmap_file_content ("debug_run.bm");
		end;

	bm_Explain: PIXMAP is
		do
			Result := pixmap_file_content ("explain.bm");
		end;

	bm_Explain_icon: PIXMAP is
		do
			Result := pixmap_file_content ("explain_icon.bm");
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

	bm_Object: PIXMAP is
		do
			Result := pixmap_file_content ("object.bm");
		end;

	bm_Object_icon: PIXMAP is
		do
			Result := pixmap_file_content ("object_icon.bm");
		end;

	bm_Object_inv: PIXMAP is
		do
			Result := pixmap_file_content ("object_inv.bm");
		end;

	bm_Open: PIXMAP is
		do
			Result := pixmap_file_content ("open.bm");
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
			Result := pixmap_file_content ("explain_cur.bm");
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
			full_path: STRING
		do
			full_path := Eiffel3_dir_name.duplicate;
			full_path.append ("/bench/bitmaps/");
			full_path.append (fn);
			!!Result.make;
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Warning: cannot read pixmap file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;


end
