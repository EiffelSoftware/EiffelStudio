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
			if free_option /= Void and then
				not free_option.is_valid
			then
				!!vd32;
				vd32.set_option_name (free_option.option_name);
				Error_handler.insert_warning (vd32);
				-- see also ETL p526 (VDOC error message)	
			end;
		end;

	check_valid_free_options is
		local
			free_option: FREE_OPTION_SD;
			vd32: VD32;
		do
			if option.is_free_option then
				free_option ?= option;
				if not free_option.is_valid then
					!!vd32;
					vd32.set_option_name (free_option.option_name);
					Error_handler.insert_warning (vd32);
				end;
			end;
		end;

feature -- Lace compilation

	process_system_level_options is
		do
			if option.is_valid and then
				option.is_system_level then
				option.process_system_level_options (value);
			end;
		end;

	adapt is
			-- Cluster adaptation
		do
			option.adapt (value, context.current_cluster.classes, Void) 
		end;

end
