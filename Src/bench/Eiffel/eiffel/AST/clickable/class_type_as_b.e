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
			class_name, generics, is_deep_equal,
			associated_eiffel_class, append_to
		end;

	TYPE_B
		undefine
			is_deep_equal, has_like, simple_format
		redefine
			format, fill_calls_list, replicate,
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

	is_deep_equal (other: TYPE_B): BOOLEAN is
		local
			o: CLASS_TYPE_AS_B;
			o_g: like generics;
			p, o_p: INTEGER
		do
			o ?= other;
			Result := o /= Void and then
				class_name.is_equal (o.class_name)
			if Result then
				o_g := o.generics;
				if generics = Void then
					Result := o_g = Void
				elseif o_g = Void then
					Result := False
				else
					p := generics.index;
					o_p := o_g.index;
					from
						generics.start;
						o_g.start;
						Result := o_g.count = generics.count
					until
						generics.after or else not Result
					loop
						Result := generics.item.is_deep_equal (o_g.item);
						generics.forth;
						o_g.forth
					end;
				end;
				generics.go_i_th (p);
				o_g.go_i_th (o_p);
			end;
		end;

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C;
			a_classi: CLASS_I;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
			type_a: TYPE_A;
			abort: BOOLEAN
		do
			if generics = Void then
				!! Result;
			else
				from
					!! gen_type;
					i := 1;
					count := generics.count;
					!!actual_generic.make (1, count);
					gen_type.set_generics (actual_generic);
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
				Result := gen_type;
			end;
			if abort then
				Result := Void
			else
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
			Result.set_base_class_id (a_class.id);
				-- Base type class is expanded
			Result.set_is_expanded (a_class.is_expanded);
			if a_class.is_expanded then
				record_exp_dependance (a_class);
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

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		local
			a_class: CLASS_C;
			a_class_i: CLASS_I;
			gen_type: GEN_TYPE_A;
			actual_generic: ARRAY [TYPE_A];
			i, count: INTEGER;
			a_cluster: CLUSTER_I;
		do
			a_cluster := Inst_context.cluster;
			a_class_i := Universe.class_named (class_name, a_cluster);
				-- Bug fix: `append_signature' can be called on invalid
				-- types by the error mechanism
			if a_class_i /= Void then
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

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
		local
			class_c: CLASS_C;
			class_i: CLASS_I;
			c_name: STRING
		do
			c_name := clone (class_name);
			c_name.to_lower;
			class_c := System.current_class;
			if class_c /= Void then
				class_i := Universe.class_named (c_name, class_c.cluster)
			else
				class_i := Universe.class_with_name (c_name)
			end;
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
 
	associated_eiffel_class (reference_class: E_CLASS): E_CLASS is
		local
			aclassi: CLASS_I;
			eclass: E_CLASS
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

	associated_classc: CLASS_C is
			-- Associated class_c.
		local
			class_i: CLASS_I
		do
			check
				Inst_context.cluster /= Void
			end
			class_i := Universe.class_named (class_name,
						Inst_context.cluster);
			if class_i /= Void then
				Result := class_i.compiled_class
			end;	
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is 
			-- Reconstitute text
		local
			class_c: CLASS_C;
			c_name: STRING
		do
			class_c := associated_classc;
			if class_c = Void then
				c_name := clone (class_name);
				c_name.to_upper;
				ctxt.put_string (c_name)
			else
				ctxt.put_class_name (class_c)
			end;
			if generics /= Void then
				ctxt.put_space;
				ctxt.put_text_item_without_tabs (ti_L_bracket);
				ctxt.set_space_between_tokens;
				ctxt.set_separator (ti_Comma);
				generics.format (ctxt);
				ctxt.put_text_item_without_tabs (ti_R_bracket)
			end;
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
			Result := clone (Current);
			if generics /= void then
				Result.set_generics (generics.replicate (ctxt));
			end;
		end;

end -- class CLASS_TYPE_AS_B
