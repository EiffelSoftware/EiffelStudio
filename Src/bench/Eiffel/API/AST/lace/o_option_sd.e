indexing
	description: "Optional option";
	date: "$Date$";
	revision: "$Revision$"

class
	O_OPTION_SD

inherit
	D_OPTION_SD
		rename
			initialize as d_initialize
		redefine
			adapt, duplicate, save, same_as
		end;

feature {O_OPTION_SD, LACE_AST_FACTORY} -- Initialization

	initialize (o: like option; v: like value; t: like target_list) is
			-- Create a new O_OPTION AST node.
		require
			o_not_void: o /= Void
		do
			option := o
			value := v
			target_list := t
		ensure
			option_set: option = o
			value_set: value = v
			target_list_set: target_list = t
		end

feature -- Properties

	target_list: LACE_LIST [ID_SD];
			-- List of class targets

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result
			Result.initialize (option.duplicate,
				duplicate_ast (value), duplicate_ast (target_list))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then option.same_as (other.option)
			 		and then same_ast (value, other.value)
					and then same_ast (target_list, other.target_list)
		end


feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		do
			Precursor {D_OPTION_SD} (st)
			st.putchar (':')
			st.putchar (' ')
			if target_list /= Void then
				target_list.save_with_interval_separator (st, ", ")
			end
		end

feature {COMPILER_EXPORTER}

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
			classes: HASH_TABLE [CLASS_I, STRING];
			class_name: STRING;
		do
			from
				cluster := context.current_cluster;
				classes := cluster.classes;
				target_list.start;
			until
				target_list.after
			loop
				class_name := clone (target_list.item)
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

end -- class O_OPTION_SD
