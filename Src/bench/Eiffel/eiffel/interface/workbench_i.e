-- Internal representation of the workbench.

class WORKBENCH_I

inherit

	SHARED_ERROR_HANDLER;
	SHARED_PASS;
	EXCEPTIONS;
	STORABLE;

feature -- Attributes

	universe: UNIVERSE_I;
			-- Universe of the workbench

	system: SYSTEM_I;
			-- Current system of the workbench

	lace: LACE_I;
			-- Current lace description

feature -- Conveniences

	set_universe (u: like universe) is
			-- Assign `u' to `universe'.
		do
			universe := u
		end;

	set_system (s: like system) is
			-- Assign `s' to `system'.
		do
			system := s
		end;

	set_lace (l: LACE_I) is
			-- Assing `l' to `lace'.
		do
			lace := l;
		end;

feature -- Creation feature

	make is
		do
			!!universe.make;
			!!system;
			system.make;
			!!lace;
			init;
		end;

	init is
			-- Workbench controller initialization
		local
			eiffel_init: YACC_EIFFEL;
			lace_init: YACC_LACE;
			feature_as: FEATURE_AS;
			invariant_as: INVARIANT_AS;
		once
				-- Initialization of Yacc-Eiffel interface
			!!eiffel_init.init;
			!!lace_init.init;

				-- Record dynamic types for instances of FEATURE_AS and
				-- INVARIANT_AS (See routine `make_index' of class
				-- TMP_AST_SERVER).
			!!feature_as;
			set_dtype1 ($feature_as);
			!!invariant_as;
			set_dtype2 ($invariant_as);

				-- Parsers initialization
			eiffel_parser_init;
			lace_parser_init;

				-- Error handler initialization
			Error_handler.send_yacc_information;

		end;

feature -- Commands

	 recompile is
			-- Incremental recompilation
		require
			system_exists: system /= Void;
		local
			error_happened: BOOLEAN
		do
			if not error_happened then

					-- Clear error handler
				Error_handler.wipe_out;

				Lace.recompile;

				System.recompile;

			end;
		rescue
			if exception = Programmer_exception then
				error_happened := True;
				Error_handler.trace;
				System.set_current_class (Void);
				retry
			end
		end;

	successfull: BOOLEAN is
			-- Is the last compilation successfull ?
		do
			Result := lace.successfull and then system.successfull
		end;

	change_class (cl: CLASS_I) is
			-- Change a class of the system.
		require
			good_argument: cl /= Void;
		local
			class_to_recompile: CLASS_C;
		do
			add_class_to_recompile (cl);

				-- Mark the class syntactically changed
			cl.set_changed (True);

			class_to_recompile := cl.compiled_class;

				-- Syntax analysis must be done
			pass1_controler.insert_new_class (class_to_recompile);

				-- Update attribute `date' of `cl'.
			class_to_recompile.set_date;
		end;
		
	change_all is
			-- Record all the classes in the universe as
			-- changed (for precompilation)
		local
			class_list: EXTEND_TABLE [CLASS_I, STRING];
			i: INTEGER
		do
			from
				Universe.clusters.start
			until
				Universe.clusters.after
			loop
				from
					class_list := Universe.clusters.item.classes;
					class_list.start
				until
					class_list.offright
				loop
					i := i + 1;
					change_class (class_list.item_for_iteration);
					class_list.forth
				end;
				Universe.clusters.forth
			end;
io.error.putstring ("Precompiling ");
io.error.putint (i);
io.error.putstring (" classes%N");
		end;


	add_class_to_recompile (cl: CLASS_I) is
			-- Recompile the class but do not do the parsing
		require
			good_argument: cl /= Void;
		local
			class_to_recompile: CLASS_C;
		do
			class_to_recompile := cl.compiled_class;
			if class_to_recompile = Void then
					-- Creation of a new instance of a class to recompile:
				   -- a class neither compiled must be compiled.
				class_to_recompile := cl.class_to_recompile;
					-- Update universe
				cl.set_compiled_class (class_to_recompile);
					-- Update system
				system.insert_new_class (class_to_recompile);
			end;

				-- Insertion in the pass controlers
			pass1_controler.insert_changed_class (class_to_recompile);
			pass2_controler.insert_new_class (class_to_recompile);
			pass3_controler.insert_new_class (class_to_recompile);
			pass4_controler.insert_new_class (class_to_recompile);
		end;

feature {NONE} -- Externals

	eiffel_parser_init is
			-- Eiffel parser initialization.
		external
			"C"
		alias
			"eif_init"
		end;

	lace_parser_init is
			-- Lace parser initialization
		external
			"C"
		alias 
			"lp_init"
		end;

	set_dtype1 (o: FEATURE_AS) is
			-- Record dynamic type of FEATURE_AS
		external	
			"C"
		end;

	set_dtype2 (o: INVARIANT_AS) is
			-- Record dynamic type of INVARIANT_AS
		external
			"C"
		end;

end
