-- Internal representation of the workbench.

class WORKBENCH_I

inherit

	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	SHARED_PASS;
	STORABLE;

feature -- Attributes

	universe: UNIVERSE_I;
			-- Universe of the workbench

	system: SYSTEM_I;
			-- Current system of the workbench

	lace: LACE_I;
			-- Current lace description

	precompiled_directory_name: STRING;
			-- Name of the precompiled directory

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

	set_precompiled_directory_name (s: STRING) is
		do
			precompiled_directory_name := s;
		end;

feature -- Creation feature

	make is
		do
			!!universe.make;
			!!system;
			!!lace;
			init;
		end;

	init is
			-- Workbench controller initialization
		local
			eiffel_init: YACC_EIFFEL;
			lace_init: YACC_LACE;
			feature_as: FEATURE_AS_B;
			invariant_as: INVARIANT_AS_B;
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

	retried: BOOLEAN;

	recompile is
			-- Incremental recompilation
		require
			system_exists: system /= Void;
		do
			if not retried then

					-- Clear error handler
				Error_handler.wipe_out;

				Lace.recompile;

				System.recompile;

			else
				retried := False
			end;
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				retried := True;
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
		end;
		
	change_all is
			-- Record all the classes in the universe as
			-- changed (for precompilation)
		local
			class_list: EXTEND_TABLE [CLASS_I, STRING];
			i: INTEGER;
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
					class_list.after
				loop
					i := i + 1;
					change_class (class_list.item_for_iteration);
					class_list.forth
				end;
				Universe.clusters.forth
			end;
				-- Verbose
			io.putstring ("Precompiling ");
			io.putint (i);
			io.putstring (" classes%N");
		end;

	change_all_new_classes is
			-- Record all the classes in the universe as
			-- changed (for compilation using `NONE' as root class)
		local
			class_list: EXTEND_TABLE [CLASS_I, STRING];
			c: CLUSTER_I;
			cl: CLASS_I;
			file_date: INTEGER;
			str: ANY;
		do
			from
				Universe.clusters.start
			until
				Universe.clusters.after
			loop
				c := Universe.clusters.item;
				if not c.is_precompiled then
					from
						class_list := c.classes;
						class_list.start
					until
						class_list.after
					loop
						cl := class_list.item_for_iteration;
						if cl.compiled then
							str := cl.file_name.to_c;
							file_date := eif_date ($str);
							if file_date /= cl.date then
								change_class (class_list.item_for_iteration);
							end;
						else
							change_class (class_list.item_for_iteration);
						end;
						class_list.forth
					end;
				end;
				Universe.clusters.forth
			end;
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

	set_dtype1 (o: POINTER) is
			-- Record dynamic type of FEATURE_AS
		external	
			"C"
		end;

	set_dtype2 (o: POINTER) is
			-- Record dynamic type of INVARIANT_AS
		external
			"C"
		end;

	eif_date (s: POINTER): INTEGER is
			-- Date of file of name `str'.
		external
			"C"
		end;

end
