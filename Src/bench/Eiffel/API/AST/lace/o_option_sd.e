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
			set, adapt
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
		local
			vd39: VD39
		do
				-- Check class names valididty
			if 
				(target_list /= Void)
			then
				check_target_list;
			else
				!!vd39;
				vd39.set_cluster (context.current_cluster);
				vd39.set_option_name (option.option_name);
				Error_handler.insert_error (vd39)
			end;

				-- Check sum error
			Error_handler.checksum;

				-- Option adaptation
			option.adapt (value, context.current_cluster.classes, target_list);
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
				target_list.after
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

end
