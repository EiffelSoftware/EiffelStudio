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
		local
			free_option: FREE_OPTION_SD;
			vd32: VD32;
		do
			option ?= yacc_arg (0);
			value ?= yacc_arg (1);

			free_option ?= option;
			if free_option /= Void then
				!!vd32;
				vd32.set_node (Current);
				vd32.set_option_name (free_option.option_name);
				Error_handler.insert_warning (vd32);
				-- see also ETL p526 (VDOC error message)	
			end;
		end;

feature -- Lace compilation

	adapt is
			-- Cluster adaptation
		local
			vd15: VD15;
			error: BOOLEAN;
			debug_tag: DEBUG_TAG_I;
			tag_value: STRING;
		do
			if option.is_debug then
				if value /= Void then
					if value.is_no then
						update_debug (No_debug);
					elseif value.is_yes then
						update_debug (Yes_debug);
					elseif value.is_all then
						update_debug (Yes_debug);
					elseif value.is_name then
						tag_value := value.value.duplicate;
						tag_value.to_lower;
						!!debug_tag.make;
						debug_tag.tags.put (tag_value);
						update_debug (debug_tag);
					else
						error := True;
					end;
				else
					update_debug (No_debug);
				end;
			elseif option.is_assertion then
				if value /= Void then
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
				else
					update_assertion (Require_level);
				end;
			elseif option.is_trace then
				if value /= Void then
					if value.is_no then
						update_trace (No_trace);
					elseif value.is_yes then
						update_trace (All_trace);
					elseif value.is_all then
						update_trace (All_trace);
					else
						error := True;
					end;
				else
					update_trace (No_trace);
				end;
			elseif option.is_optimize then
				if value /= Void then
					if value.is_no then
						update_optimize (No_optimize);
					elseif value.is_yes then
						update_optimize (Yes_optimize);
					elseif value.is_all then
						update_optimize (All_optimize);
					else
						error := True;
					end;
				else
					update_optimize (No_optimize);
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
