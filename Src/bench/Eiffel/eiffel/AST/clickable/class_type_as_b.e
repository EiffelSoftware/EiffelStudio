indexing

	description: "Node for normal class type. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_TYPE_AS_B

inherit

	CLASS_TYPE_AS
		undefine
			same_as
		redefine
			class_name, generics,
			associated_eiffel_class, append_to
		end;

	TYPE_B
		undefine
			has_like, simple_format
		redefine
			fill_calls_list, replicate,
			check_constraint_type, solved_type_for_format,
			append_to
		end;

	SHARED_INST_CONTEXT;

feature -- Attributes

	class_name: ID_AS_B;
			-- Class type name

	generics: EIFFEL_LIST_B [TYPE_B];
			-- Possible generical parameters

feature -- Conveniences

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C;
			a_classi: CLASS_I;
			gen_type: GEN_TYPE_A;
			tuple_type : TUPLE_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
			type_a: TYPE_A;
			abort: BOOLEAN
		do
			if class_name.string_value.is_equal ("tuple") then
				!!tuple_type
				Result := tuple_type
			end

			if generics /= Void then
				if Result = Void then
					!!gen_type
					Result := gen_type
				end
				from
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
				until
					i > count or else abort
				loop
					type_a := generics.i_th (i).solved_type_for_format (feat_table, f);
					if type_a = Void then
						abort := True
					else
						actual_generic.put (type_a, i);
					end;
					i := i + 1;
				end;

				if gen_type /= Void then
					gen_type.set_generics (actual_generic);
				else
					tuple_type.set_generics (actual_generic);
				end
			else
				if tuple_type /= Void then
					tuple_type.set_generics (Void)
				end
			end

			if abort then
				Result := Void
			else
				if Result = Void then
					!!Result
				end
				a_classi := Universe.class_named (class_name, Inst_context.cluster);
				if a_classi /= Void and then a_classi.compiled_class /= Void then
					a_class := a_classi.compiled_class;
					Result.set_base_class_id (a_class.id);
						-- Base type class is expanded
					Result.set_is_expanded (a_class.is_expanded);
				else
					Result := Void
				end
			end
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C;
			gen_type: GEN_TYPE_A;
			tuple_type : TUPLE_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
		do
			if class_name.string_value.is_equal ("tuple") then
				!!tuple_type
				Result := tuple_type
			end

			if generics /= Void then
				if Result = Void then
					!!gen_type
					Result := gen_type
				end
				from
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
				until
					i > count
				loop
					actual_generic.put
						(generics.i_th (i).solved_type (feat_table, f), i);
					i := i + 1;
				end;
				if gen_type /= Void then
					gen_type.set_generics (actual_generic);
				else
					tuple_type.set_generics (actual_generic);
				end
			else
				if tuple_type /= Void then
					tuple_type.set_generics (Void)
				end
			end

			if Result = Void then
				!!Result
			end

			a_class :=
		Universe.class_named (class_name, Inst_context.cluster).compiled_class;
			Result.set_base_class_id (a_class.id);
				-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
			if a_class.is_expanded then
				record_exp_dependance (a_class);
			end;
				-- Base type class is expanded
			Result.set_is_separate (a_class.is_separate);
			if a_class.is_separate then
				record_separate_dependance (a_class);
			end;
		end;

	record_exp_dependance (a_class: CLASS_C) is
		local
			d: DEPEND_UNIT;
			f: FEATURE_I;
			c_class: CLASS_C
		do
			c_class := System.current_class;
			if c_class /= Void then
-- *** FIXME ****
-- This was done since actual_type is called on the generic
-- parameters when the signature of the class is requested.
-- This approach seems ok but the FIXME is to make YOU
-- aware that there could be potential problems.
				-- Only mark the class if it is used during a
				-- compilation not when querying the actual
				-- type
				c_class.set_has_expanded;
				a_class.set_is_used_as_expanded
				if System.in_pass3 then
					!!d.make_expanded_unit (a_class.id);
					context.supplier_ids.extend (d);
					f := a_class.creation_feature;
					if f /= Void then
						!!d.make (a_class.id, f.feature_id);
						context.supplier_ids.extend (d);
					end;
				end
			end;
		end;

	record_separate_dependance (a_class: CLASS_C) is
			-- Mark the class `a_class' used as separate
		do
			a_class.set_is_used_as_separate
		end

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		local
			a_class: CLASS_C;
			a_class_i: CLASS_I;
			gen_type: GEN_TYPE_A;
			tuple_type : TUPLE_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
			a_cluster: CLUSTER_I;
		do
			a_cluster := Inst_context.cluster;
			a_class_i := Universe.class_named (class_name, a_cluster);
				-- Bug fix: `append_signature' can be called on invalid
				-- types by the error mechanism
			if a_class_i /= Void then
				if class_name.string_value.is_equal ("tuple") then
					!!tuple_type
					Result := tuple_type
				end

				if generics /= Void then
					if Result = Void then
						!!gen_type
						Result := gen_type
					end
					from
						i := 1;
						count := generics.count;
						!!actual_generic.make (1, count);
					until
						i > count
					loop
						actual_generic.put (generics.i_th (i).actual_type, i);
						i := i + 1;
					end;
					if gen_type /= Void then
						gen_type.set_generics (actual_generic);
					else
						tuple_type.set_generics (actual_generic);
					end
				else
					if tuple_type /= Void then
						tuple_type.set_generics (Void)
					end
				end

				if Result = Void then
					!!Result
				end

				a_class := a_class_i.compiled_class;
				Result.set_base_class_id (a_class.id);
						-- Base type class is expanded
				Result.set_is_expanded (a_class.is_expanded);
				if a_class.is_expanded then
					record_exp_dependance (a_class);
				end;
			end;
		end;

	check_constraint_type (a_class: CLASS_C) is
		local
			associated_class: CLASS_C;
			temp, cl_generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B];
			class_i: CLASS_I;
			cluster: CLUSTER_I;
			vcfg3: VCFG3;
			vtct: VTCT;
			vtug: VTUG;
			error: BOOLEAN;
			nb_errors: INTEGER;
			t1, t2: TYPE_B;
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
							!! cl_generics.make_filled (temp.count);
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

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
		local
			class_c: CLASS_C;
			class_i: CLASS_I;
			c_name: STRING
		do
			c_name := clone (class_name);
			c_name.to_lower;
			class_i := associated_classi;
			c_name.to_upper;
			if class_i = Void then
				st.add_string (c_name)
			else
				st.add_classi (class_i, c_name)
			end;
			if generics /= Void then
				from
					generics.start;
					st.add_string (" [");
				until
					generics.after
				loop
					generics.item.append_to (st);
					if not generics.islast then
						st.add_string (", ");
					end;
					generics.forth;
				end;
				st.add_string ("]");
			end;
		end;
 
	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		local
			aclassi: CLASS_I;
		do
				-- Check if we can find the class in the cluster.
				-- If the class is not compiled anymore (or doesnot
				-- exist at all), the resulting stone will not be
				-- valid (`is_valid' = false because `class_c' = Void).
			aclassi := Universe.class_named 
						(class_name, reference_class.cluster);
			if aclassi /= Void then
				Result := aclassi.compiled_eclass
			end
		end;

	associated_classi: CLASS_I is
			-- Associated class_i
		local
			class_i: CLASS_I
		do
			check
				Inst_context.cluster /= Void
			end
			Result := Universe.class_named (class_name,
						Inst_context.cluster);
		end

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
			Result := clone (Current);
			if generics /= void then
				Result.set_generics (generics.replicate (ctxt));
			end;
		end;

end -- class CLASS_TYPE_AS_B
