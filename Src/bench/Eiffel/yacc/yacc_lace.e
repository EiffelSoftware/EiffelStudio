class YACC_LACE

inherit

	LACE_YACC_CONST

creation

	init

feature

	init is
			-- Initialize the Eiffel-Yacc interface.
		local
			as_1: ID_SD;
			as0: LACE_LIST [AST_LACE];
			as1: ACE_SD;
			as2: ALL_SD;
			as6: CHECK_SD;
			as7: CLAS_VISI_SD;
			as9: CLUST_IGN_SD;
			as10: CLUST_PROP_SD;
			as11: CLUST_REN_SD;
			as12: CLUSTER_SD;
			as13: D_OPTION_SD;
			as14: ENSURE_SD;
			as15: INVARIANT_SD;
			as16: LANG_GEN_SD;
			as17: LANG_TRIB_SD;
			as18: LOOP_SD;
			as19: NAME_SD;
			as20: NO_SD;
			as21: O_OPTION_SD;
			as24: REQUIRE_SD;
			as25: ROOT_SD;
			as26: TWO_NAME_SD;
			as27: YES_SD;
			as29: INCLUDE_SD;
			as30: EXCLUDE_SD;
			as31: ASSERTION_SD;
			as32: DEBUG_SD;
			as33: OPTIMIZE_SD;
			as34: TRACE_SD;
			as35: FREE_OPTION_SD;
			as36: C_NAME_SD;
			as37: MAKE_NAME_SD;
			as38: OBJECT_NAME_SD;
			as39: LANGUAGE_NAME_SD;
			as40: CLICK_LIST;
			as41: CLICK_AST;
			as42: EXECUTABLE_NAME_SD;
			as43: INCLUDE_PATH_NAME_SD;
			as44: D_PRECOMPILED_SD
			as45: PRECOMPILED_SD
			as46: MULTITHREADED_SD
		do
			!!as_1.make (0);
			as_1.pass_address(id_sd);
			!!as0.make (0);
			as0.pass_address(construct_list_sd);
			!!as1;
			as1.pass_address(ace_sd);
			!!as2;
			as2.pass_address(all_sd);
			!!as6;
			as6.pass_address(check_sd);
			!!as7;
			as7.pass_address(clas_visi_sd);
			!!as9;
			as9.pass_address(clust_ign_sd);
			!!as10;
			as10.pass_address(clust_prop_sd);
			!!as11;
			as11.pass_address(clust_ren_sd);
			!!as12;
			as12.pass_address(cluster_sd);
			!!as13;
			as13.pass_address(d_option_sd);
			!!as14;
			as14.pass_address(ensure_sd);
			!!as15;
			as15.pass_address(invariant_sd);
			!!as16;
			as16.pass_address(lang_gen_sd);
			!!as17;
			as17.pass_address(lang_trib_sd);
			!!as18;
			as18.pass_address(loop_sd);
			!!as19;
			as19.pass_address(name_sd);
			!!as20;
			as20.pass_address(no_sd);
			!!as21;
			as21.pass_address(o_option_sd);
			!!as24;
			as24.pass_address(require_sd);
			!!as25;
			as25.pass_address(root_sd);
			!!as26;
			as26.pass_address(two_name_sd);
			!!as27;
			as27.pass_address(yes_sd);
			!!as29;
			as29.pass_address (include_sd);
			!!as30;
			as30.pass_address (exclude_sd);
			!!as31;
			as31.pass_address (assertion_sd);
			!!as32;
			as32.pass_address (debug_sd);
			!!as33;
			as33.pass_address (optimize_sd);
			!!as34;
			as34.pass_address (trace_sd);
			!!as35;
			as35.pass_address (free_option_sd);
			!!as36;
			as36.pass_address (c_name_sd);
			!!as37;
			as37.pass_address (make_name_sd);
			!!as38;
			as38.pass_address (object_name_sd);
			!!as39;
			as39.pass_address (language_name_sd);
			!!as40.make (0);
			as40.pass_address (click_list_sd);
			!!as41;
			as41.pass_address (click_elem_sd);
			as41.pass_click_set;
			!!as42;
			as42.pass_address (executable_name_sd);
			!!as43;
			as43.pass_address (include_path_name_sd);
			!!as44;
			as44.pass_address (d_precompiled_sd);
			!!as45;
			as45.pass_address (precompiled_sd)
			!! as46
			as46.pass_address (multithreaded_sd)
		end;

end
