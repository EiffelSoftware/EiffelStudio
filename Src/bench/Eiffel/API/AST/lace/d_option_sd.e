-- D_option_clause            : /* empty */
--                            | Name Option_mark
--                            ;
-- Option_mark                : /* empty */
--                            | LEX_LEFT_PARAM Option_value LEX_RIGHT_PARAM
--                            ;

class D_OPTION_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_ASSERTION_LEVEL;
	SHARED_TRACE_LEVEL;
	SHARED_OPTIMIZE_LEVEL;
	SHARED_DEBUG_LEVEL;

feature -- Attributes

	option: OPTION_SD;
			-- Option name

	value: OPT_VAL_SD;
			-- option value

feature -- Initialization

	set is
			-- Yacc initialization
		do
			option ?= yacc_arg (0);
			value ?= yacc_arg (1)
		end;

feature -- Lace compilation

	adapt is
			-- Cluster adaptation
		local
			vd15: VD15;
			error: BOOLEAN;
			debug_tag: DEBUG_TAG_I;
		do
			if option.is_debug then
				if value.is_no then
					update_debug (No_debug);
				elseif value.is_yes then
					update_debug (Yes_debug);
				elseif value.is_all then
					update_debug (Yes_debug);
				elseif value.is_name then
					!!debug_tag.make;
					debug_tag.tags.put (value.value);
					update_debug (debug_tag);
				else
					error := True;
				end;
			elseif option.is_assertion then
				if value.is_no then
					update_assertion (No_level);
				elseif value.is_require then
					update_assertion (Require_level);
				elseif value.is_ensure then
					update_assertion (Ensure_level);
				elseif value.is_invariant then
					update_assertion (Invariant_level);
				elseif value.is_loop then
					update_assertion (Loop_level);
				elseif value.is_check then
					update_assertion (Check_level);
				elseif value.is_all then
					update_assertion (Check_level);
				else
					error := True;
				end;
			elseif option.is_trace then
				if value.is_no then
					update_trace (No_trace);
				elseif value.is_yes then
					update_trace (All_trace);
				elseif value.is_all then
					update_trace (All_trace);
				else
					error := True;
				end;
			elseif option.is_optimize then
				if value.is_no then
					update_optimize (No_optimize);
				elseif value.is_yes then
					update_optimize (Yes_optimize);
				elseif value.is_all then
					update_optimize (All_optimize);
				else
					error := True;
				end;
			end;
			if error then
				!!vd15;
				vd15.set_node (Current);
				Error_handler.insert_error (vd15);
			end;
		end;

	update_assertion (a: ASSERTION_I) is
			-- Update assertion level of classes in cluster.
		require
			good_argument: a /= Void;
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
		do
			from
				classes := context.current_cluster.classes;
				classes.start;
			until
				classes.offright
			loop
				classes.item_for_iteration.set_assertion_level (a);
				classes.forth;
			end;
		end;

	update_trace (t: TRACE_I) is
			-- Update traceing level of classes in cluster
		require
			good_argument: t /= Void;
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
		do
			from
				classes := context.current_cluster.classes;
				classes.start;
			until
				classes.offright
			loop
				classes.item_for_iteration.set_trace_level (t);
				classes.forth;
			end;
		end;

	update_debug (d: DEBUG_i) is
			-- Update debug level of classes in cluster
		require
			good_argument: d /= Void;
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
		do
			from
				classes := context.current_cluster.classes;
				classes.start;
			until
				classes.offright
			loop
				classes.item_for_iteration.set_debug_level (d);
				classes.forth;
			end;
		end;

	update_optimize (o: OPTIMIZE_I) is
			-- Update optimization level for classes in cluster.
		require
			good_argument: o /= Void;
		local
			classes: EXTEND_TABLE [CLASS_I, STRING];
		do
			from
				classes := context.current_cluster.classes;
				classes.start;
			until
				classes.offright
			loop
				classes.item_for_iteration.set_optimize_level (o);
				classes.forth;
			end;
		end;

end
