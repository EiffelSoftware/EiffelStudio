-- O_option_clause         : /* empty */
--                         | Name Option_mark Target_list
-- 
-- Target_list             : /* empty */
--                         | LEX_COLUMN Name Class_name_list
--                         ;
-- 
-- Class_name_list         : Name_star
--                         | Class_name_list LEX_COMMA Name_star

class O_OPTION_SD

inherit

	D_OPTION_SD
		redefine
			adapt,
			set, update_assertion, update_trace, update_debug,
			update_optimize
		select
			adapt
		end;
	D_OPTION_SD
		rename
			adapt as old_adapt
		redefine
			set, update_assertion, update_trace, update_debug,
			update_optimize
		end;

feature

	target_list: LACE_LIST [ID_SD];
			-- List of class targets

	set is
			-- Yacc initialization
		do
			option ?= yacc_arg (0);
			value ?= yacc_arg (1);
			target_list ?= yacc_arg (2);
		ensure then
			target_list_exists: target_list /= Void;
		end;

	adapt is
			-- Option adaptation
		do
				-- Check class names valididty
			check_target_list;

				-- Check sum error
			Error_handler.checksum;

				-- Option adaptation
			old_adapt;
		end;

	check_target_list is
			-- Check target list validity
		local
			vd16: VD16;
			cluster: CLUSTER_I;
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				cluster := context.current_cluster;
				classes := cluster.classes;
				target_list.start;
			until
				target_list.offright
			loop
				class_name := target_list.item.duplicate;
				class_name.to_lower;

				if not classes.has (class_name) then
					!!vd16;
					vd16.set_class_name (target_list.item);
					vd16.set_cluster (cluster);
					vd16.set_node (Current);
					Error_handler.insert_error (vd16);
				end;

				target_list.forth;
			end;
		end;

	update_assertion (a: ASSERTION_I) is
			-- Update assertion level for classes in the target list
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				classes := context.current_cluster.classes;
				target_list.start;
			until
				target_list.offright
			loop
				class_name := target_list.item.duplicate;
				class_name.to_lower;
				classes.item (class_name).set_assertion_level (a);
	
				target_list.forth;
			end;
		end;

	update_trace (a: TRACE_I) is
			-- Update trace level for classes in the target list
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				classes := context.current_cluster.classes;
				target_list.start;
			until
				target_list.offright
			loop
				class_name := target_list.item.duplicate;
				class_name.to_lower;
				classes.item (class_name).set_trace_level (a);
	
				target_list.forth;
			end;
		end;

	update_debug (a: DEBUG_I) is
			-- Update debug level for classes in the target list
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				classes := context.current_cluster.classes;
				target_list.start;
			until
				target_list.offright
			loop
				class_name := target_list.item.duplicate;
				class_name.to_lower;
				classes.item (class_name).set_debug_level (a);
	
				target_list.forth;
			end;
		end;

	update_optimize (a: OPTIMIZE_I) is
			-- Update optimization level for classes in the target list
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				classes := context.current_cluster.classes;
				target_list.start;
			until
				target_list.offright
			loop
				class_name := target_list.item.duplicate;
				class_name.to_lower;
				classes.item (class_name).set_optimize_level (a);
	
				target_list.forth;
			end;
		end;

end
