indexing

	description: "Lace AST node factories"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_AST_FACTORY

feature -- Checking

	valid_identifier (st: STRING): BOOLEAN is
			-- Is `st' a valid identifer for Lace syntax.
		local
			i, nb: INTEGER
		do
			Result := st /= Void and then not st.is_empty
			if
				Result and then
				valid_first_identifier_character (st.item (1))
			then
				from
					nb := st.count
					i := 2
				until
					i > nb or not Result
				loop
					Result := valid_identifier_character (st.item (i))
					i := i + 1
				end
			end
		end

	valid_first_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z' then
				Result := True
			else
			end
		end

	valid_identifier_character (c: CHARACTER): BOOLEAN is
			-- Is `c' a good character as first character of a Lace identifier?
		do
			inspect
				c
			when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
				Result := True
			else
			end
		end

feature -- Access

	new_ace_sd (sn: ID_SD; r: ROOT_SD; d: LACE_LIST [D_OPTION_SD];
		c: LACE_LIST [CLUSTER_SD]; e: LACE_LIST [LANG_TRIB_SD];
		cl: CLICK_LIST): ACE_SD is
			-- New ACE AST node
		require
			sn_not_void: sn /= Void
			r_not_void: r /= Void
			cl_not_void: cl /= Void
		do
			!! Result
			Result.initialize (sn, r, d, c, e, cl)
		ensure
			ace_sd_not_void: Result /= Void
			system_name_set: Result.system_name = sn
			root_set: Result.root = r
			defaults_set: Result.defaults = d
			clusters_set: Result.clusters = c
			externals_set: Result.externals = e
			click_list_set: Result.click_list = cl
		end

	new_all_sd (v: ID_SD): ALL_SD is
			-- New ALL AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			all_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_assertion_sd: ASSERTION_SD is
			-- New ASSERTION AST node
		do
			!! Result
			Result.initialize
		ensure
			assertion_sd_not_void: Result /= Void
		end

	new_check_sd (v: ID_SD): CHECK_SD is
			-- New CHECK AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			check_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_click_ast (n: CLICKABLE_AST; s, e: INTEGER): CLICK_AST is
			-- New clickable element for `n'
		require
			n_not_void: n /= Void
		do
			!! Result
			Result.initialize (n, s, e)
		ensure
			click_ast_not_void: Result /= Void
			node_set: Result.node = n
			start_position_set: Result.start_position = s
			end_position_set: Result.end_position = e
		end

	new_clas_visi_sd (cn, vn: ID_SD; cr, er: LACE_LIST [ID_SD];
		r: LACE_LIST [TWO_NAME_SD]): CLAS_VISI_SD is
			-- New CLAS_VISI AST node
		require
			cn_not_void: cn /= Void
		do
			!! Result
			Result.initialize (cn, vn, cr, er, r)
		ensure
			clas_visi_sd_not_void: Result /= Void
			class_name_set: Result.class_name = cn
			visible_name_set: Result.visible_name = vn
			creation_restriction_set: Result.creation_restriction = cr
			export_restriction_set: Result.export_restriction = er
			renamings_set: Result.renamings = r
		end

	new_clust_ign_sd (cn: ID_SD): CLUST_IGN_SD is
			-- New CLUST_IGN AST node
		require
			cn_not_void: cn /= Void
		do
			!! Result
			Result.initialize (cn)
		ensure
			clust_ign_sd_not_void: Result /= Void
			cluster_name_set: Result.cluster_name = cn
		end

	new_clust_prop_sd (dep: LACE_LIST [DEPEND_SD]; us: ID_SD;
		iop: LACE_LIST [INCLUDE_SD]; eo: LACE_LIST [EXCLUDE_SD];
		ao: LACE_LIST [CLUST_ADAPT_SD]; dop: LACE_LIST [D_OPTION_SD];
		o: LACE_LIST [O_OPTION_SD]; vo: LACE_LIST [CLAS_VISI_SD]
		): CLUST_PROP_SD is
			-- New CLUST_PROP AST node
		do
			!! Result
			Result.initialize (dep, us, iop, eo, ao, dop, o, vo)
		ensure
			clust_prop_sd_not_void: Result /= Void
			use_name_set: Result.use_name = us
			include_option_set: Result.include_option = iop
			exclude_option_set: Result.exclude_option = eo
			adapt_option_set: Result.adapt_option = ao
			default_option_set: Result.default_option = dop
			options_set: Result.options = o
			visible_option_set: Result.visible_option = vo
		end

	new_clust_ren_sd (cn: ID_SD; r: LACE_LIST [TWO_NAME_SD]): CLUST_REN_SD is
			-- New CLUST_REN AST node
		require
			cn_not_void: cn /= Void
		do
			!! Result
			Result.initialize (cn, r)
		ensure
			clust_ren_sd_not_void: Result /= Void
			cluster_name_set: Result.cluster_name = cn
			renamings_set: Result.renamings = r
		end

	new_cluster_sd (cn, pn, dn: ID_SD; cp: CLUST_PROP_SD; is_recursive, is_library: BOOLEAN): CLUSTER_SD is
			-- New CLUSTER AST node
		require
			cn_not_void: cn /= Void
			dn_not_void: dn /= Void
		do
			!! Result
			Result.initialize (cn, pn, dn, cp, is_recursive, is_library)
		ensure
			cluster_sd_not_void: Result /= Void
			cluster_name_set: Result.cluster_name = cn
			parent_name_set: Result.parent_name = pn
			directory_name_set: Result.directory_name = dn
			cluster_properties_set: Result.cluster_properties = cp
			recursive_cluster_set: Result.is_recursive = is_recursive
			library_cluster_set: Result.is_library = is_library
		end

	new_d_option_sd (o: OPTION_SD; v: OPT_VAL_SD): D_OPTION_SD is
			-- New D_OPTION AST node
		require
			o_not_void: o /= Void
		do
			!! Result
			Result.initialize (o, v)
		ensure
			d_option_sd_not_void: Result /= Void
			option_set: Result.option = o
			value_set: Result.value = v
		end

	new_d_precompiled_sd (o: OPTION_SD; v: OPT_VAL_SD;
		r: LACE_LIST [TWO_NAME_SD]): D_PRECOMPILED_SD is
			-- New D_PRECOMPILED AST node
		require
			o_not_void: o /= Void
		do
			!! Result
			Result.initialize (o, v, r)
		ensure
			d_precompiled_sd_not_void: Result /= Void
			option_set: Result.option = o
			value_set: Result.value = v
			renamings_set: Result.renamings = r
		end

	new_debug_sd (enabled: BOOLEAN): DEBUG_SD is
			-- New DEBUG AST node
		do
			create Result
			Result.initialize (enabled)
		ensure
			debug_sd_not_void: Result /= Void
		end

	new_ensure_sd (v: ID_SD): ENSURE_SD is
			-- New ENSURE AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			ensure_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_exclude_sd (fn: ID_SD): EXCLUDE_SD is
			-- New EXCLUDE AST node
		require
			fn_not_void: fn /= Void
		do
			!! Result
			Result.initialize (fn)
		ensure
			exclude_sd_not_void: Result /= Void
			file__name: Result.file__name = fn
		end

	new_free_option_sd (on: ID_SD): FREE_OPTION_SD is
			-- New FREE_OPTION AST node
		require
			on_not_void: on /= Void
		do
			!! Result
			Result.initialize (on)
		ensure
			free_option_sd_not_void: Result /= Void
			option_name_set: Result.option_name.is_equal (on)
		end

	new_id_sd (s: STRING; is_str: BOOLEAN): ID_SD is
			-- New ID AST node
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			!! Result.initialize (s)
			if is_str then
				Result.set_is_string
			end
		ensure
			id_sd_not_void: Result /= Void
		end

	new_include_sd (fn: ID_SD): INCLUDE_SD is
			-- New INCLUDE AST node
		require
			fn_not_void: fn /= Void
		do
			!! Result
			Result.initialize (fn)
		ensure
			include_sd_not_void: Result /= Void
			file__name: Result.file__name = fn
		end

	new_invariant_sd (v: ID_SD): INVARIANT_SD is
			-- New INVARIANT AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			invariant_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_lace_list_clas_visi_sd (n: INTEGER): LACE_LIST [CLAS_VISI_SD] is
			-- New empty list of CLAS_VISI_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_clust_adapt_sd (n: INTEGER): LACE_LIST [CLUST_ADAPT_SD] is
			-- New empty list of CLUST_ADAPT_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_cluster_sd (n: INTEGER): LACE_LIST [CLUSTER_SD] is
			-- New empty list of CLUSTER_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_d_option_sd (n: INTEGER): LACE_LIST [D_OPTION_SD] is
			-- New empty list of D_OPTION_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_exclude_sd (n: INTEGER): LACE_LIST [EXCLUDE_SD] is
			-- New empty list of EXCLUDE_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_id_sd (n: INTEGER): LACE_LIST [ID_SD] is
			-- New empty list of ID_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_include_sd (n: INTEGER): LACE_LIST [INCLUDE_SD] is
			-- New empty list of INCLUDE_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_lang_trib_sd (n: INTEGER): LACE_LIST [LANG_TRIB_SD] is
			-- New empty list of LANG_TRIB_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_o_option_sd (n: INTEGER): LACE_LIST [O_OPTION_SD] is
			-- New empty list of O_OPTION_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_two_name_sd (n: INTEGER): LACE_LIST [TWO_NAME_SD] is
			-- New empty list of TWO_NAME_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lace_list_depend_sd (n: INTEGER): LACE_LIST [DEPEND_SD] is
			-- New empty list of DEPEND_SD
		require
			n_positive: n >= 0
		do
			!! Result.make (n)
		ensure
			list_not_void: Result /= Void
			list_empty: Result.is_empty
		end

	new_lang_trib_sd (ln: LANGUAGE_NAME_SD; fn: LACE_LIST [ID_SD]): LANG_TRIB_SD is
			-- New LANG_TRIB AST node
		require
			ln_not_void: ln /= Void
			fn_not_void: fn /= Void
		do
			!! Result
			Result.initialize (ln, fn)
		ensure
			lang_trib_sd_not_void: Result /= Void
			language_name_set: Result.language_name = ln
			file_names_set: Result.file_names = fn
		end

	new_language_name_sd (ln: ID_SD): LANGUAGE_NAME_SD is
			-- New LANGUAGE_NAME AST node
		require
			ln_not_void: ln /= Void
		do
			!! Result
			Result.initialize (ln)
		ensure
			language_name_sd_not_void: Result /= Void
			language_name_set: Result.language_name = ln
		end

	new_loop_sd (v: ID_SD): LOOP_SD is
			-- New LOOP AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			loop_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_name_sd (v: ID_SD): NAME_SD is
			-- New NAME AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			name_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_no_sd (v: ID_SD): NO_SD is
			-- New NO AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			no_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_o_option_sd (o: OPTION_SD; v: OPT_VAL_SD; t: LACE_LIST [ID_SD]): O_OPTION_SD is
			-- New O_OPTION AST node
		require
			o_not_void: o /= Void
		do
			!! Result
			Result.initialize (o, v, t)
		ensure
			o_option_sd_not_void: Result /= Void
			option_set: Result.option = o
			value_set: Result.value = v
			target_list_set: Result.target_list = t
		end

	new_optimize_sd: OPTIMIZE_SD is
			-- New OPTIMIZE AST node
		do
			!! Result
			Result.initialize
		ensure
			optimize_sd_not_void: Result /= Void
		end

	new_precompiled_sd: PRECOMPILED_SD is
			-- New PRECOMPILED AST node
		do
			!! Result
			Result.initialize
		ensure
			precompiled_sd_not_void: Result /= Void
		end

	new_require_sd (v: ID_SD): REQUIRE_SD is
			-- New REQUIRE AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			require_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

	new_root_sd (rn, cm, cp: ID_SD): ROOT_SD is
			-- New ROOT AST node
		require
			rn_not_void: rn /= Void
		do
			!! Result
			Result.initialize (rn, cm, cp)
		ensure
			root_sd_not_void: Result /= Void
			root_name_set: Result.root_name = rn
			cluster_mark_set: Result.cluster_mark = cm
			creation_procedure_name_set: Result.creation_procedure_name = cp
		end

	new_trace_sd: TRACE_SD is
			-- New TRACE AST node
		do
			!! Result
			Result.initialize
		ensure
			trace_sd_not_void: Result /= Void
		end

	new_two_name_sd (o, n: ID_SD): TWO_NAME_SD is
			-- New TWO_NAME AST node
		require
			o_not_void: o /= Void
			n_not_void: n /= Void
		do
			!! Result
			Result.initialize (o, n)
		ensure
			two_name_sd_not_void: Result /= Void
			old_name_set: Result.old_name = o
			new_name_set: Result.new_name = n
		end

	new_depend_sd (d: LACE_LIST [ID_SD]; s: ID_SD): DEPEND_SD is
			-- New DEPEND AST node
		require
			d_not_void: d /= Void
			s_not_void: s /= Void
		do
			!! Result
			Result.initialize (d, s)
		ensure
			depend_sd_not_void: Result /= Void
			depend_on_set: Result.depend_on = d
			script_set: Result.script = s
		end

	new_yes_sd (v: ID_SD): YES_SD is
			-- New YES AST node
		require
			v_not_void: v /= Void
		do
			!! Result
			Result.initialize (v)
		ensure
			yes_sd_not_void: Result /= Void
			value_set: Result.value = v
		end

end -- class LACE_AST_FACTORY

--|----------------------------------------------------------------
--| Copyright (C) 1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
