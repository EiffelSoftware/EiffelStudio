-- Node for normal class type

class CLASS_TYPE_AS

inherit

	TYPE
		redefine
			has_like, format, fill_calls_list, replicate,
			check_constraint_type, a_type
		end;
	SHARED_INST_CONTEXT;
	STONABLE

feature -- Attributes

	class_name: ID_AS;
			-- Class type name

	generics: EIFFEL_LIST [TYPE];
			-- Possible generical parameters

feature -- Initialization

	set is
			-- Yacc initialization
		do
			class_name ?= yacc_arg (0);
			generics ?= yacc_arg (1);
		ensure then
			class_name_exists: class_name /= Void;
		end;

feature -- Conveniences

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end;

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
		do
			if generics = Void then
				!!Result;
			else
				from
					!!gen_type;
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
				until
					i > count
				loop
					actual_generic.put
						(generics.i_th (i).solved_type (feat_table, f), i);
					i := i + 1;
				end;
				Result := gen_type;
			end;
			a_class :=
		Universe.class_named (class_name, Inst_context.cluster).compiled_class;
			Result.set_base_type (a_class.id);
				-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
		end;

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		do
			Result := a_type (Inst_context.cluster);
		end;

	a_type (a_cluster: CLUSTER_I): CL_TYPE_A is
			-- Returns the actual type associated in the
			-- context of `a_cluster'
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
		do
			if generics = Void then
				!!Result;
			else
				from
					!!gen_type;
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
				until
					i > count
				loop
					actual_generic.put (generics.i_th (i).actual_type, i);
					i := i + 1;
				end;
				Result := gen_type;
			end;
			a_class := Universe.class_named
							(class_name, a_cluster).compiled_class;
			Result.set_base_type (a_class.id);
					-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
		end;

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_like;
					generics.forth
				end;
			end;
		end;

	check_constraint_type (a_class: CLASS_C) is
		local
			associated_class: CLASS_C;
			cl_generics: EIFFEL_LIST [FORMAL_DEC_AS];
			class_i: CLASS_I;
			cluster: CLUSTER_I;
			vcfg3: VCFG3;
			vtct: VTCT;
			vtug: VTUG;
			error: BOOLEAN;
			nb_errors: INTEGER;
		do
io.error.putstring ("check_constraint_type on: ");
trace;
io.error.new_line;
			if has_like then
				!!vcfg3;
				vcfg3.set_class (a_class);
				vcfg3.set_formal_name ("Constraint genericity");
				Error_handler.insert_error (vcfg3);
			else
				cluster := a_class.cluster;
				class_i := Universe.class_named (class_name, cluster);
				if class_i = Void then
					!!vtct;
					vtct.set_class (a_class);
					vtct.set_class_name (class_name);
					Error_handler.insert_error (vtct);
				else
					associated_class := class_i.compiled_class;
					cl_generics := associated_class.generics;
					if generics /= Void then
						if (cl_generics = Void or else
							cl_generics.count /= generics.count)
						then
							!VTUG2!vtug;
						end;
					elseif cl_generics /= Void then
						!VTUG1!vtug;
					end;
					if vtug /= Void then
						vtug.set_class (a_class);
						vtug.set_type (a_type (cluster));
						vtug.set_base_class (associated_class);
						Error_handler.insert_error (vtug);
					elseif generics /= Void then
						from
							generics.start;
							cl_generics.start
						until
							generics.after or else error
						loop
							nb_errors := Error_handler.nb_errors;
							generics.item.check_constraint_type (a_class);
							error := Error_handler.nb_errors /= nb_errors;
							if not error then
								generics.item.a_type (cluster).check_conformance
									(cl_generics.item.constraint.a_type (cluster));
								error := Error_handler.new_error;
							end;
							generics.forth;
							cl_generics.forth
						end;
					end;
				end;
			end;
		end;

	dump: STRING is
			-- Dumped string
		local
			dumped_class_name: STRING;
		do
			!!Result.make (class_name.count);
			dumped_class_name := class_name.duplicate;
			dumped_class_name.to_upper;
			Result.append (dumped_class_name);
			if generics /= Void then
				from
					generics.start; 
					Result.append (" [");
				until
					generics.after
				loop
					generics.item.trace;
					if not generics.islast then
						Result.append (", ");
					end;
					generics.forth;
				end;
				Result.append ("]");
			end;
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do
			aclass := Universe.class_named (class_name, reference_class.cluster).compiled_class;
			!!Result.make (aclass)
		end;


	format (ctxt: FORMAT_CONTEXT) is 
			-- Reconstitute text
		local
			s: STRING;
		do
			ctxt.begin;
			S := class_name.duplicate;
			s.to_upper;
			ctxt.put_string (s);
			if generics /= void then
				ctxt.put_special (" [");
				generics.format (ctxt);
				ctxt.put_special ("]");
			end;
			ctxt.commit;
		end;
			
feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			if generics /= void then
				generics.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			if generics /= void then
				Result := twin;
				Result.set_generics (generics.replicate (ctxt));
			end;
		end;


end
