
-- Environment for bitmaps, help, binaries, scripts....

class SHARED_PIXMAPS

inherit

	EIFFEL_ENV
	
feature {NONE}

	bm_Breakpoint: PIXMAP is
		do
			Result := pixmap_file_content ("breakpt.bm");
		end;

	bm_Case_storage: PIXMAP is
		do
			Result := pixmap_file_content ("casestor.bm");
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
			Result := pixmap_file_content ("classdot.bm");
		end;

	bm_Class_icon: PIXMAP is
		do
			Result := pixmap_file_content ("classico.bm");
		end;

	bm_Clickable: PIXMAP is
		do
			Result := pixmap_file_content ("clckable.bm");
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
			Result := pixmap_file_content ("dbreakpt.bm");
		end;

	bm_Dark_clickable: PIXMAP is
		do
			Result := pixmap_file_content ("dclckabl.bm");
		end;

	bm_Dark_exec_last: PIXMAP is
		do
			Result := pixmap_file_content ("dexeclas.bm");
		end;

	bm_Dark_exec_nostop: PIXMAP is
		do
			Result := pixmap_file_content ("dexecnos.bm");
		end;

	bm_Dark_exec_step: PIXMAP is
		do
			Result := pixmap_file_content ("dexecste.bm");
		end;

	bm_Dark_exec_stop: PIXMAP is
		do
			Result := pixmap_file_content ("dexecsto.bm");
		end;

	bm_Dark_save: PIXMAP is
		do
			Result := pixmap_file_content ("darksave.bm");
		end;

	bm_Dark_showancestors: PIXMAP is
		do
			Result := pixmap_file_content ("dsancest.bm");
		end;

	bm_Dark_showattributes: PIXMAP is
		do
			Result := pixmap_file_content ("dsattrib.bm");
		end;

	bm_Dark_showaversions: PIXMAP is
		do
			Result := pixmap_file_content ("dsaversi.bm");
		end;

	bm_Dark_showcallers: PIXMAP is
		do
			Result := pixmap_file_content ("dscaller.bm");
		end;

	bm_Dark_showclass_list: PIXMAP is
		do
			Result := pixmap_file_content ("dsclasse.bm");
		end;

	bm_Dark_showclients: PIXMAP is
		do
			Result := pixmap_file_content ("dsclient.bm");
		end;

	bm_Dark_showclusters: PIXMAP is
		do
			Result := pixmap_file_content ("dscluste.bm");
		end;

	bm_Dark_showdeferreds: PIXMAP is
		do
			Result := pixmap_file_content ("dsdeferr.bm");
		end;

	bm_Dark_showdescendants: PIXMAP is
		do
			Result := pixmap_file_content ("dsdescen.bm");
		end;

	bm_Dark_showdversions: PIXMAP is
		do
			Result := pixmap_file_content ("dsdversi.bm");
		end;

	bm_Dark_showexported: PIXMAP is
		do
			Result := pixmap_file_content ("dsexport.bm");
		end;

	bm_Dark_showexternals: PIXMAP is
		do
			Result := pixmap_file_content ("dsextern.bm");
		end;

	bm_Dark_showflat: PIXMAP is
		do
			Result := pixmap_file_content ("dsflat.bm");
		end;

	bm_Dark_showfs: PIXMAP is
		do
			Result := pixmap_file_content ("dsfshort.bm");
		end;

	bm_Dark_showhistory: PIXMAP is
		do
			Result := pixmap_file_content ("dshistor.bm");
		end;

	bm_Dark_showindexing: PIXMAP is
		do
			Result := pixmap_file_content ("dsindexi.bm");
		end;

	bm_Dark_showmodified: PIXMAP is
		do
			Result := pixmap_file_content ("dsmodifi.bm");
		end;

	bm_Dark_showonces: PIXMAP is
		do
			Result := pixmap_file_content ("dsonces.bm");
		end;

	bm_Dark_showroutines: PIXMAP is
		do
			Result := pixmap_file_content ("dsroutin.bm");
		end;

	bm_Dark_showshort: PIXMAP is
		do
			Result := pixmap_file_content ("dsshort.bm");
		end;

	bm_Dark_showstatistics: PIXMAP is
		do
			Result := pixmap_file_content ("dsstatis.bm");
		end;

	bm_Dark_showsuppliers: PIXMAP is
		do
			Result := pixmap_file_content ("dssuppli.bm");
		end;

	bm_Dark_showhomonyms: PIXMAP is
		do
			Result := pixmap_file_content ("dshomony.bm");
		end;

	bm_Dark_showtext: PIXMAP is
		do
			Result := pixmap_file_content ("dstext.bm");
		end;

	bm_Debug_quit: PIXMAP is
		do
			Result := pixmap_file_content ("dbgquit.bm");
		end;

	bm_Debug_run: PIXMAP is
		do
			Result := pixmap_file_content ("dbgrun.bm");
		end;

	bm_Debug_status: PIXMAP is
		do
			Result := pixmap_file_content ("dbgstatu.bm");
		end;

	bm_Debug_step: PIXMAP is
		do
			Result := pixmap_file_content ("dbgstep.bm");
		end;

	bm_Exec_last: PIXMAP is
		do
			Result := pixmap_file_content ("execlast.bm");
		end;

	bm_Exec_nostop: PIXMAP is
		do
			Result := pixmap_file_content ("execnost.bm");
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
			Result := pixmap_file_content ("expldot.bm");
		end;

	bm_Explain_icon: PIXMAP is
		do
			Result := pixmap_file_content ("explicon.bm");
		end;

	bm_Filter: PIXMAP is
		do
			Result := pixmap_file_content ("filter.bm");
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

	bm_Next_target: PIXMAP is
		do
			Result := pixmap_file_content ("histfort.bm")
		end;

	bm_Object: PIXMAP is
		do
			Result := pixmap_file_content ("object.bm");
		end;

	bm_Object_dot: PIXMAP is
		do
			Result := pixmap_file_content ("objdot.bm");
		end;

	bm_Object_icon: PIXMAP is
		do
			Result := pixmap_file_content ("objicon.bm");
		end;

	bm_Object_inv: PIXMAP is
		do
			Result := pixmap_file_content ("objinv.bm");
		end;

	bm_Open: PIXMAP is
		do
			Result := pixmap_file_content ("open.bm");
		end;

	bm_Previous_target: PIXMAP is
		do
			Result := pixmap_file_content ("histback.bm")
		end;

	bm_Project: PIXMAP is
		do
			Result := pixmap_file_content ("tower.bm");
		end;

	bm_Project_icon: PIXMAP is
		do
			Result := pixmap_file_content ("projicon.bm");
		end;

	bm_Quit: PIXMAP is
		do
			Result := pixmap_file_content ("quit.bm");
		end;

	bm_Routine: PIXMAP is
		do
			Result := pixmap_file_content ("routine.bm");
		end;

	bm_Routine_dot: PIXMAP is
		do
			Result := pixmap_file_content ("routdot.bm");
		end;

	bm_Routine_icon: PIXMAP is
		do
			Result := pixmap_file_content ("routicon.bm");
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
			Result := pixmap_file_content ("stopcur.bm");
		end; -- bm_Setstop_cur
	
	bm_Shell: PIXMAP is
		do
			Result := pixmap_file_content ("shell.bm");
		end;
	
	bm_Showaversions: PIXMAP is
		do
			Result := pixmap_file_content ("saversio.bm");
		end;

	bm_Showdversions: PIXMAP is
		do
			Result := pixmap_file_content ("sdversio.bm");
		end;

	bm_Showancestors: PIXMAP is
		do
			Result := pixmap_file_content ("sancesto.bm");
		end;

	bm_Showhistory: PIXMAP is
		do
			Result := pixmap_file_content ("shistory.bm");
		end;

	bm_Showindexing: PIXMAP is
		do
			Result := pixmap_file_content ("sindexin.bm");
		end;

	bm_Showattributes: PIXMAP is
		do
			Result := pixmap_file_content ("sattribu.bm");
		end;

	bm_Showcallers: PIXMAP is
		do
			Result := pixmap_file_content ("scallers.bm");
		end;

	bm_Showclass_list: PIXMAP is
		do
			Result := pixmap_file_content ("sclasses.bm");
		end;

	bm_Showclients: PIXMAP is
		do
			Result := pixmap_file_content ("sclients.bm");
		end;

	bm_Showclusters: PIXMAP is
		do
			Result := pixmap_file_content ("scluster.bm");
		end;

	bm_Showdeferreds: PIXMAP is
		do
			Result := pixmap_file_content ("sdeferre.bm");
		end;

	bm_Showdescendants: PIXMAP is
		do
			Result := pixmap_file_content ("sdescend.bm");
		end;

	bm_Showexported: PIXMAP is
		do
			Result := pixmap_file_content ("sexporte.bm");
		end;

	bm_Showexternals: PIXMAP is
		do
			Result := pixmap_file_content ("sexterna.bm");
		end;

	bm_Showflat: PIXMAP is
		do
			Result := pixmap_file_content ("sflat.bm");
		end;

	bm_Showfs: PIXMAP is
		do
			Result := pixmap_file_content ("sfshort.bm");
		end;

	bm_Showmodified: PIXMAP is
		do
			Result := pixmap_file_content ("smodifie.bm");
		end;

	bm_Showonces: PIXMAP is
		do
			Result := pixmap_file_content ("sonces.bm");
		end;

	bm_Showroutines: PIXMAP is
		do
			Result := pixmap_file_content ("sroutine.bm");
		end;

	bm_Showshort: PIXMAP is
		do
			Result := pixmap_file_content ("sshort.bm");
		end;

	bm_Showstatistics: PIXMAP is
		do
			Result := pixmap_file_content ("sstatist.bm");
		end;

	bm_Showstops: PIXMAP is
		do
			Result := pixmap_file_content ("sstops.bm");
		end;

	bm_Showsuppliers: PIXMAP is
		do
			Result := pixmap_file_content ("ssupplie.bm");
		end;

	bm_Showhomonyms: PIXMAP is
		do
			Result := pixmap_file_content ("shomonym.bm");
		end;

	bm_Showtext: PIXMAP is
		do
			Result := pixmap_file_content ("stext.bm");
		end;

	bm_Slice: PIXMAP is
		do
			Result := pixmap_file_content ("slice.bm")
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
			Result := pixmap_file_content ("systdot.bm");
		end;

	bm_System_icon: PIXMAP is
		do
			Result := pixmap_file_content ("systicon.bm");
		end;

	bm_Update: PIXMAP is
		do
			Result := pixmap_file_content ("update.bm");
		end;

	bm_class_cur: PIXMAP is
		do
			Result := pixmap_file_content ("classcur.bm");
		end;

	bm_entity_cur: PIXMAP is
		do
			Result := pixmap_file_content ("entitcur.bm");
		end;

	bm_object_cur: PIXMAP is
		do
			Result := pixmap_file_content ("objcur.bm");
		end;

	bm_explain_cur: PIXMAP is
		do
			Result := pixmap_file_content ("explcur.bm");
		end;

	bm_default: PIXMAP is
		do
			Result := pixmap_file_content ("default.bm");
		end;

	bm_system_cur: PIXMAP is
		do
			Result := pixmap_file_content ("systcur.bm");
		end;

	pixmap_file_content (fn: STRING): PIXMAP is
		local
			full_path: FILE_NAME;
		do
			!!full_path.make_from_string (Eiffel3_dir_name);
			full_path.extend_from_array (<<"bench", "bitmaps">>);
			full_path.set_file_name (fn);
			!!Result.make;
			Result.read_from_file (full_path);
			if not Result.last_operation_correct then
				io.error.putstring ("Warning: cannot read pixmap file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;


end
