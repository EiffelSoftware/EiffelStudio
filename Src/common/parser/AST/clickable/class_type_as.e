-- Node for normal class type

class CLASS_TYPE_AS

inherit

	TYPE
		redefine
			has_like, format, fill_calls_list, replicate,
			check_constraint_type
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
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
			a_cluster: CLUSTER_I;
		do
			a_cluster := Inst_context.cluster;
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
			temp, cl_generics: EIFFEL_LIST [FORMAL_DEC_AS];
			class_i: CLASS_I;
			cluster: CLUSTER_I;
			vcfg3: VCFG3;
			vtct: VTCT;
			vtug: VTUG;
			error: BOOLEAN;
			nb_errors: INTEGER;
			t1, t2: TYPE;
			pos: INTEGER
		do
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
						vtug.set_type (actual_type);
						vtug.set_base_class (associated_class);
						Error_handler.insert_error (vtug);
					elseif generics /= Void then
						from
							temp := cl_generics;
							!! cl_generics.make (temp.count);
							pos := temp.index;
							temp.start
						until
							temp.after
						loop
							cl_generics.put_i_th (temp.item, temp.index);
							temp.forth
						end;
						temp.go_i_th (pos);
						from
							generics.start;
							cl_generics.start
						until
							generics.after or else error
						loop
							nb_errors := Error_handler.nb_errors;
							t1 := generics.item;
							t1.check_constraint_type (a_class);
							error := Error_handler.nb_errors /= nb_errors;
							if not error then
								t2 := cl_generics.item.constraint;
								if t2 /= Void then
									t1.actual_type.check_const_gen_conformance
										(t2.actual_type, a_class);
									error := Error_handler.new_error;
								end;
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
-- FIXME append_clickable_signature should be redefined
-- some parts of the signature can be clickable !!!

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
					Result.append (generics.item.dump);
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
			s := class_name.duplicate;
			s.to_upper;
			ctxt.put_class_name (Universe.class_named (class_name,
						Inst_context.cluster).compiled_class);
			if generics /= void then
				ctxt.put_special (" [");
				ctxt.no_new_line_between_tokens;
				ctxt.set_separator (", ");
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
			Result := twin;
			if generics /= void then
				Result.set_generics (generics.replicate (ctxt));
			end;
		end;


end
