
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
			Result.append ("/bin/finish_freezing ")
		end;

	help_path: STRING is
		once
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/help/")
		end;

	bm_Breakpoint: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/breakpoint.bm")
		end;

	bm_Check: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/check.bm")
		end;

	bm_Class: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/class.bm")
		end;

	bm_Continue: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/continue.bm")
		end;

	bm_Dark_save: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/dark_save.bm")
		end;

	bm_Debug_quit: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/debug_quit.bm")
		end;

	bm_Debug_run: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/debug_run.bm")
		end;

	bm_Explain: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/explain.bm")
		end;

	bm_Finalize: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/finalize.bm")
		end;

	bm_Font: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/font.bm")
		end;

	bm_Freeze: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/freeze.bm")
		end;

	bm_Ice: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/ice.bm")
		end;

	bm_Line: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/line.bm")
		end;

	bm_Next: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/next.bm")
		end;

	bm_Object: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/object.bm")
		end;

	bm_Object_inv: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/object_inv.bm")
		end;

	bm_Open: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/open.bm")
		end;

	bm_Quit: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/quit.bm")
		end;

	bm_Routine: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/routine.bm")
		end;

	bm_Run: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/run.bm")
		end;

	bm_Save: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/save.bm")
		end;

	bm_Save_as: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/save_as.bm")
		end;

	bm_Search: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/search.bm")
		end;

	bm_Showancestors: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showancestors.bm")
		end;

	bm_Showattributes: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showattributes.bm")
		end;

	bm_Showclients: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showclients.bm")
		end;

	bm_Showclusters: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showclusters.bm")
		end;

	bm_Showcustom: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showcustom.bm")
		end;

	bm_Showdeferreds: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showdeferreds.bm")
		end;

	bm_Showdescendants: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showdescendants.bm")
		end;

	bm_Showexternals: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showexternals.bm")
		end;

	bm_Showflat: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showflat.bm")
		end;

	bm_Showfs: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showfs.bm")
		end;

	bm_Showonces: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showonces.bm")
		end;

	bm_Showroutines: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showroutines.bm")
		end;

	bm_Showshort: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showshort.bm")
		end;

	bm_Showsuppliers: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showsuppliers.bm")
		end;

	bm_Showtext: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/showtext.bm")
		end;

	bm_Step: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/step.bm")
		end;

	bm_System: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/system.bm")
		end;

	bm_Update: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/update.bm")
		end;

	bm_Tower: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/tower.bm")
		end;
 
	bm_class_cur: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/class_cur.bm")
		end;

	bm_entity_cur: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/entity_cur.bm")
		end;

	bm_object_cur: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/object_cur.bm")
		end;

	bm_explain_cur: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/explain_cur.bm")
		end;

	bm_default: STRING is
		do
			!!Result.make (50); Result.append (Eiffel3_dir_name);
			Result.append ("/bitmaps/default.bm")
		end;


end
