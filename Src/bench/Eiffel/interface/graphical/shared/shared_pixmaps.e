indexing

	description: 
		"Pixmaps used in interface.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_PIXMAPS

inherit

	EIFFEL_ENV
	
feature {NONE}

	bm_Breakpoint: PIXMAP is
		once
			Result := pixmap_file_content ("breakpt.bm");
		end;

	bm_Clear_breakpoints: PIXMAP is
		once
			Result := pixmap_file_content ("clr_bp.bm");
		end;

	bm_graphical_Breakablepoint: PIXMAP is
		once
			Result := pixmap_file_content ("gbreakpt.bm");
			if not Result.is_valid then
				Result := Bm_default
			end
		end;

	bm_graphical_Stoppoint: PIXMAP is
		once
			Result := pixmap_file_content ("gstoppt.bm");
			if not Result.is_valid then
				Result := Bm_default
			end
		end;

	bm_Case_storage: PIXMAP is
		once
			Result := pixmap_file_content ("casestor.bm");
		end;

	bm_Check: PIXMAP is
		once
			Result := pixmap_file_content ("check.bm");
		end;

	bm_Class: PIXMAP is
		once
			Result := pixmap_file_content ("class.bm");
		end;

	bm_Class_dot: PIXMAP is
		once
			Result := pixmap_file_content ("classdot.bm");
		end;

	bm_Class_icon: PIXMAP is
		once
			Result := pixmap_file_content ("classico.bm");
		end;

	bm_Clickable: PIXMAP is
		once
			Result := pixmap_file_content ("clckable.bm");
		end;

	bm_Continue: PIXMAP is
		once
			Result := pixmap_file_content ("continue.bm");
		end;

	bm_Current: PIXMAP is
		once
			Result := pixmap_file_content ("current.bm")
		end;

	bm_Dark_breakpoint: PIXMAP is
		once
			Result := pixmap_file_content ("dbreakpt.bm");
		end;

	bm_Dark_clickable: PIXMAP is
		once
			Result := pixmap_file_content ("dclckabl.bm");
		end;

	bm_Dark_exec_last: PIXMAP is
		once
			Result := pixmap_file_content ("dexeclas.bm");
		end;

	bm_Dark_exec_nostop: PIXMAP is
		once
			Result := pixmap_file_content ("dexecnos.bm");
		end;

	bm_Dark_exec_step: PIXMAP is
		once
			Result := pixmap_file_content ("dexecste.bm");
		end;

	bm_Dark_exec_stop: PIXMAP is
		once
			Result := pixmap_file_content ("dexecsto.bm");
		end;

	bm_Dark_save: PIXMAP is
		once
			Result := pixmap_file_content ("darksave.bm");
		end;

	bm_Dark_showancestors: PIXMAP is
		once
			Result := pixmap_file_content ("dsancest.bm");
		end;

	bm_Dark_showattributes: PIXMAP is
		once
			Result := pixmap_file_content ("dsattrib.bm");
		end;

	bm_Dark_showaversions: PIXMAP is
		once
			Result := pixmap_file_content ("dsaversi.bm");
		end;

	bm_Dark_showcallers: PIXMAP is
		once
			Result := pixmap_file_content ("dscaller.bm");
		end;

	bm_Dark_showclass_list: PIXMAP is
		once
			Result := pixmap_file_content ("dsclasse.bm");
		end;

	bm_Dark_showclients: PIXMAP is
		once
			Result := pixmap_file_content ("dsclient.bm");
		end;

	bm_Dark_showclusters: PIXMAP is
		once
			Result := pixmap_file_content ("dscluste.bm");
		end;

	bm_Dark_showdeferreds: PIXMAP is
		once
			Result := pixmap_file_content ("dsdeferr.bm");
		end;

	bm_Dark_showdescendants: PIXMAP is
		once
			Result := pixmap_file_content ("dsdescen.bm");
		end;

	bm_Dark_showdversions: PIXMAP is
		once
			Result := pixmap_file_content ("dsdversi.bm");
		end;

	bm_Dark_showexported: PIXMAP is
		once
			Result := pixmap_file_content ("dsexport.bm");
		end;

	bm_Dark_showexternals: PIXMAP is
		once
			Result := pixmap_file_content ("dsextern.bm");
		end;

	bm_Dark_showflat: PIXMAP is
		once
			Result := pixmap_file_content ("dsflat.bm");
		end;

	bm_Dark_showfs: PIXMAP is
		once
			Result := pixmap_file_content ("dsfshort.bm");
		end;

	bm_Dark_showhistory: PIXMAP is
		once
			Result := pixmap_file_content ("dshistor.bm");
		end;

	bm_Dark_showindexing: PIXMAP is
		once
			Result := pixmap_file_content ("dsindexi.bm");
		end;

	bm_Dark_showmodified: PIXMAP is
		once
			Result := pixmap_file_content ("dsmodifi.bm");
		end;

	bm_Dark_showonces: PIXMAP is
		once
			Result := pixmap_file_content ("dsonces.bm");
		end;

	bm_Dark_showroutines: PIXMAP is
		once
			Result := pixmap_file_content ("dsroutin.bm");
		end;

	bm_Dark_showshort: PIXMAP is
		once
			Result := pixmap_file_content ("dsshort.bm");
		end;

	bm_Dark_showstatistics: PIXMAP is
		once
			Result := pixmap_file_content ("dsstatis.bm");
		end;

	bm_Dark_showsuppliers: PIXMAP is
		once
			Result := pixmap_file_content ("dssuppli.bm");
		end;

	bm_Dark_showhomonyms: PIXMAP is
		once
			Result := pixmap_file_content ("dshomony.bm");
		end;

	bm_Dark_showtext: PIXMAP is
		once
			Result := pixmap_file_content ("dstext.bm");
		end;

	bm_Debug_quit: PIXMAP is
		once
			Result := pixmap_file_content ("dbgquit.bm");
		end;

	bm_Debug_run: PIXMAP is
		once
			Result := pixmap_file_content ("dbgrun.bm");
		end;

	bm_Debug_status: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstatu.bm");
		end;

	bm_Debug_step: PIXMAP is
		once
			Result := pixmap_file_content ("dbgstep.bm");
		end;

	bm_Down_stack: PIXMAP is
		once
			Result := pixmap_file_content ("dn_stack.bm");
		end;

	bm_Exec_last: PIXMAP is
		once
			Result := pixmap_file_content ("execlast.bm");
		end;

	bm_Exec_nostop: PIXMAP is
		once
			Result := pixmap_file_content ("execnost.bm");
		end;

	bm_Exec_step: PIXMAP is
		once
			Result := pixmap_file_content ("execstep.bm");
		end;

	bm_Exec_stop: PIXMAP is
		once
			Result := pixmap_file_content ("execstop.bm");
		end;

	bm_Explain: PIXMAP is
		once
			Result := pixmap_file_content ("explain.bm");
		end;

	bm_Explain_dot: PIXMAP is
		once
			Result := pixmap_file_content ("expldot.bm");
		end;

	bm_Explain_icon: PIXMAP is
		once
			Result := pixmap_file_content ("explicon.bm");
		end;

	bm_Filter: PIXMAP is
		once
			Result := pixmap_file_content ("filter.bm");
		end;

	bm_Finalize: PIXMAP is
		once
			Result := pixmap_file_content ("finalize.bm");
		end;

	bm_Font: PIXMAP is
		once
			Result := pixmap_file_content ("font.bm");
		end;

	bm_Freeze: PIXMAP is
		once
			Result := pixmap_file_content ("freeze.bm");
		end;

	bm_Grey_finalize: PIXMAP is
		once
			Result := pixmap_file_content ("gfinaliz.bm")
		end;

	bm_Grey_font: PIXMAP is
		once
			Result := pixmap_file_content ("gfont.bm")
		end;

	bm_Hide_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_up.bm")
		end;

	bm_Hide_routine: PIXMAP is
		once
			Result := pixmap_file_content ("rout_up.bm")
		end;

	bm_Next_target: PIXMAP is
		once
			Result := pixmap_file_content ("histfort.bm")
		end;

	bm_Object: PIXMAP is
		once
			Result := pixmap_file_content ("object.bm");
		end;

	bm_Object_dot: PIXMAP is
		once
			Result := pixmap_file_content ("objdot.bm");
		end;

	bm_Object_icon: PIXMAP is
		once
			Result := pixmap_file_content ("objicon.bm");
		end;

	bm_Object_inv: PIXMAP is
		once
			Result := pixmap_file_content ("objinv.bm");
		end;

	bm_Open: PIXMAP is
		once
			Result := pixmap_file_content ("open.bm");
		end;

	bm_Previous_target: PIXMAP is
		once
			Result := pixmap_file_content ("histback.bm")
		end;

	bm_Project: PIXMAP is
		once
			Result := pixmap_file_content ("tower.bm");
		end;

	bm_Project_icon: PIXMAP is
		once
			Result := pixmap_file_content ("projicon.bm");
		end;

	bm_Quit: PIXMAP is
		once
			Result := pixmap_file_content ("quit.bm");
		end;

	bm_Routine: PIXMAP is
		once
			Result := pixmap_file_content ("routine.bm");
		end;

	bm_Routine_dot: PIXMAP is
		once
			Result := pixmap_file_content ("routdot.bm");
		end;

	bm_Routine_icon: PIXMAP is
		once
			Result := pixmap_file_content ("routicon.bm");
		end;

	bm_Run: PIXMAP is
		once
			Result := pixmap_file_content ("run.bm");
		end;

	bm_Save: PIXMAP is
		once
			Result := pixmap_file_content ("save.bm");
		end;

	bm_Save_as: PIXMAP is
		once
			Result := pixmap_file_content ("save_as.bm");
		end;

	bm_Search: PIXMAP is
		once
			Result := pixmap_file_content ("search.bm");
		end;
	
	bm_Setstop: PIXMAP is
		once
			Result := pixmap_file_content ("setstop.bm");
		end;

	bm_Shell: PIXMAP is
		once
			Result := pixmap_file_content ("shell.bm");
		end;
	
	bm_Showaversions: PIXMAP is
		once
			Result := pixmap_file_content ("saversio.bm");
		end;

	bm_Showdversions: PIXMAP is
		once
			Result := pixmap_file_content ("sdversio.bm");
		end;

	bm_Showancestors: PIXMAP is
		once
			Result := pixmap_file_content ("sancesto.bm");
		end;

	bm_Showhistory: PIXMAP is
		once
			Result := pixmap_file_content ("shistory.bm");
		end;

	bm_Showindexing: PIXMAP is
		once
			Result := pixmap_file_content ("sindexin.bm");
		end;

	bm_Showattributes: PIXMAP is
		once
			Result := pixmap_file_content ("sattribu.bm");
		end;

	bm_Showcallers: PIXMAP is
		once
			Result := pixmap_file_content ("scallers.bm");
		end;

	bm_Showclass_list: PIXMAP is
		once
			Result := pixmap_file_content ("sclasses.bm");
		end;

	bm_Showclients: PIXMAP is
		once
			Result := pixmap_file_content ("sclients.bm");
		end;

	bm_Showclusters: PIXMAP is
		once
			Result := pixmap_file_content ("scluster.bm");
		end;

	bm_Showdeferreds: PIXMAP is
		once
			Result := pixmap_file_content ("sdeferre.bm");
		end;

	bm_Showdescendants: PIXMAP is
		once
			Result := pixmap_file_content ("sdescend.bm");
		end;

	bm_Showexported: PIXMAP is
		once
			Result := pixmap_file_content ("sexporte.bm");
		end;

	bm_Showexternals: PIXMAP is
		once
			Result := pixmap_file_content ("sexterna.bm");
		end;

	bm_Showflat: PIXMAP is
		once
			Result := pixmap_file_content ("sflat.bm");
		end;

	bm_Showfs: PIXMAP is
		once
			Result := pixmap_file_content ("sfshort.bm");
		end;

	bm_Showmodified: PIXMAP is
		once
			Result := pixmap_file_content ("smodifie.bm");
		end;

	bm_Showonces: PIXMAP is
		once
			Result := pixmap_file_content ("sonces.bm");
		end;

	bm_Showroutines: PIXMAP is
		once
			Result := pixmap_file_content ("sroutine.bm");
		end;

	bm_Showshort: PIXMAP is
		once
			Result := pixmap_file_content ("sshort.bm");
		end;

	bm_Showstatistics: PIXMAP is
		once
			Result := pixmap_file_content ("sstatist.bm");
		end;

	bm_Showstops: PIXMAP is
		once
			Result := pixmap_file_content ("sstops.bm");
		end;

	bm_Showsuppliers: PIXMAP is
		once
			Result := pixmap_file_content ("ssupplie.bm");
		end;

	bm_Showhomonyms: PIXMAP is
		once
			Result := pixmap_file_content ("shomonym.bm");
		end;

	bm_Showtext: PIXMAP is
		once
			Result := pixmap_file_content ("stext.bm");
		end;

	bm_Show_object: PIXMAP is
		once
			Result := pixmap_file_content ("obj_down.bm")
		end;

	bm_Show_routine: PIXMAP is
		once
			Result := pixmap_file_content ("routdown.bm")
		end;

	bm_Slice: PIXMAP is
		once
			Result := pixmap_file_content ("slice.bm")
		end;

	bm_Step: PIXMAP is
		once
			Result := pixmap_file_content ("step.bm");
		end;

	bm_System: PIXMAP is
		once
			Result := pixmap_file_content ("system.bm");
		end;

	bm_System_dot: PIXMAP is
		once
			Result := pixmap_file_content ("systdot.bm");
		end;

	bm_System_icon: PIXMAP is
		once
			Result := pixmap_file_content ("systicon.bm");
		end;

	bm_Update: PIXMAP is
		once
			Result := pixmap_file_content ("update.bm");
		end;

	bm_Up_stack: PIXMAP is
		once
			Result := pixmap_file_content ("up_stack.bm");
		end;

	bm_default: PIXMAP is
		once
			Result := pixmap_file_content ("default.bm");
		end;

feature {NONE} -- Update

	pixmap_file_content (fn: STRING): PIXMAP is
		local
			full_path: FILE_NAME;
		do
			!! full_path.make_from_string (Bitmap_path);
			full_path.set_file_name (fn);
			!! Result.make;
			Result.read_from_file (full_path);
			if not Result.is_valid then
				io.error.putstring ("Warning: cannot read pixmap file ");
				io.error.putstring (full_path);
				io.error.new_line;
			end;
		end;


end -- class SHARED_PIXMAPS
