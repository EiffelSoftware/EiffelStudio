indexing
	description: "Node for normal class type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit
	TYPE
		redefine
			has_like, simple_format, is_equivalent,
			fill_calls_list, replicate,
			check_constraint_type, solved_type_for_format,
			append_to
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
		end

	SHARED_INST_CONTEXT

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
		do
			class_name := n
			generics := g
		ensure
			class_name_set: class_name = n
			generics_set: generics = g
		end

feature -- Attributes

	class_name: ID_AS
			-- Class type name

	generics: EIFFEL_LIST [TYPE]
			-- Possible generical parameters

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (generics, other.generics)
		end

feature -- Access

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_like
					generics.forth
				end
			end
		end

	is_tuple : BOOLEAN is
			-- Is it a TUPLE type?
		do
			Result := class_name.string_value.is_equal ("tuple")
		end

feature -- Conveniences

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C
			a_classi: CLASS_I
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			type_a: TYPE_A
			abort: BOOLEAN
		do
			if generics /= Void then
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
					if is_tuple then
						create {TUPLE_TYPE_A} Result.make (actual_generic)
					else
						create {GEN_TYPE_A} Result.make (actual_generic)
					end
				until
					i > count or else abort
				loop
					type_a := generics.i_th (i).solved_type_for_format (feat_table, f)
					if type_a = Void then
						abort := True
					else
						actual_generic.put (type_a, i)
					end
					i := i + 1
				end
			else
				if is_tuple then
					create actual_generic.make (1, 0)
					create {TUPLE_TYPE_A} Result.make (actual_generic)
				end
			end

			if abort then
				Result := Void
			else
				if Result = Void then
					!! Result
				end
				a_classi := Universe.class_named (class_name, Inst_context.cluster)
				if a_classi /= Void and then a_classi.compiled_class /= Void then
					a_class := a_classi.compiled_class
					Result.set_base_class_id (a_class.class_id)
						-- Base type class is expanded
					Result.set_is_true_expanded (a_class.is_expanded)
				else
					Result := Void
				end
			end
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			a_class: CLASS_C
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
		do
			if generics /= Void then
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
					if is_tuple then
						create {TUPLE_TYPE_A} Result.make (actual_generic)
					else
						create {GEN_TYPE_A} Result.make (actual_generic)
					end
				until
					i > count
				loop
					actual_generic.put
						(generics.i_th (i).solved_type (feat_table, f), i)
					i := i + 1
				end
			else
				if is_tuple then
					create actual_generic.make (1, 0)
					create {TUPLE_TYPE_A} Result.make (actual_generic)
				end
			end

			if Result = Void then
				!! Result
			end

			a_class := Universe.class_named (class_name, Inst_context.cluster).compiled_class
			Result.set_base_class_id (a_class.class_id)
				-- Base type class is expanded
			Result.set_is_true_expanded (a_class.is_expanded)
			if a_class.is_expanded then
				record_exp_dependance (a_class)
			end
				-- Base type class is expanded
			Result.set_is_separate (a_class.is_separate)
			if a_class.is_separate then
				record_separate_dependance (a_class)
			end
		end

	record_exp_dependance (a_class: CLASS_C) is
		local
			d: DEPEND_UNIT
			f: FEATURE_I
			c_class: CLASS_C
		do
			c_class := System.current_class
			if c_class /= Void then
-- *** FIXME ****
-- This was done since actual_type is called on the generic
-- parameters when the signature of the class is requested.
-- This approach seems ok but the FIXME is to make YOU
-- aware that there could be potential problems.
				-- Only mark the class if it is used during a
				-- compilation not when querying the actual
				-- type
				c_class.set_has_expanded
				a_class.set_is_used_as_expanded
				if System.in_pass3 then
					!!d.make_expanded_unit (a_class.class_id)
					context.supplier_ids.extend (d)
					f := a_class.creation_feature
					if f /= Void then
						!!d.make (a_class.class_id, f)
						context.supplier_ids.extend (d)
					end
				end
			end
		end

	record_separate_dependance (a_class: CLASS_C) is
			-- Mark the class `a_class' used as separate
		do
			a_class.set_is_used_as_separate
		end

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		local
			a_class: CLASS_C
			a_class_i: CLASS_I
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			a_cluster: CLUSTER_I
		do
			a_cluster := Inst_context.cluster
			a_class_i := Universe.class_named (class_name, a_cluster)
				-- Bug fix: `append_signature' can be called on invalid
				-- types by the error mechanism
			if a_class_i /= Void then
				if generics /= Void then
					from
						i := 1
						count := generics.count
						create actual_generic.make (1, count)
						if is_tuple then
							create {TUPLE_TYPE_A} Result.make  (actual_generic)
						else
							create {GEN_TYPE_A} Result.make (actual_generic)
						end
					until
						i > count
					loop
						actual_generic.put (generics.i_th (i).actual_type, i)
						i := i + 1
					end
				else
					if is_tuple then
						create actual_generic.make (1, 0)
						create {TUPLE_TYPE_A} Result.make (actual_generic)
					end
				end

				if Result = Void then
					!! Result
				end

				a_class := a_class_i.compiled_class
				Result.set_base_class_id (a_class.class_id)
						-- Base type class is expanded
				Result.set_is_true_expanded (a_class.is_expanded)
				if a_class.is_expanded then
					record_exp_dependance (a_class)
				end
			end
		end

	check_constraint_type (a_class: CLASS_C) is
		local
			associated_class: CLASS_C
			temp, cl_generics: EIFFEL_LIST [FORMAL_DEC_AS]
			class_i: CLASS_I
			cluster: CLUSTER_I
			vcfg3: VCFG3
			vtct: VTCT
			vtug: VTUG
			error: BOOLEAN
			nb_errors: INTEGER
			t1, t2: TYPE
			pos: INTEGER
			is_tuple_type : BOOLEAN
		do
			if has_like then
				!!vcfg3
				vcfg3.set_class (a_class)
				vcfg3.set_formal_name ("Constraint genericity")
				Error_handler.insert_error (vcfg3)
			else
				cluster := a_class.cluster
				class_i := Universe.class_named (class_name, cluster)
				if class_i = Void then
					!!vtct
					vtct.set_class (a_class)
					vtct.set_class_name (class_name)
					Error_handler.insert_error (vtct)
					error_handler.raise_error
				else
					is_tuple_type := is_tuple
					associated_class := class_i.compiled_class
					cl_generics := associated_class.generics
						-- TUPLEs can have any number of generics
					if not is_tuple_type then
						if generics /= Void then
							if (cl_generics = Void) then
								!VTUG1!vtug
							elseif (cl_generics.count /= generics.count) then
								!VTUG2!vtug
							end
						elseif cl_generics /= Void then
							!VTUG2!vtug
						end
					end
					if vtug /= Void then
						vtug.set_class (a_class)
						vtug.set_type (actual_type)
						vtug.set_base_class (associated_class)
						Error_handler.insert_error (vtug)
					elseif generics /= Void then
						if not is_tuple_type then
							from
								temp := cl_generics
								!! cl_generics.make_filled (temp.count)
								pos := temp.index
								temp.start
							until
								temp.after
							loop
								cl_generics.put_i_th (temp.item, temp.index)
								temp.forth
							end
							temp.go_i_th (pos)
							from
								generics.start
								cl_generics.start
							until
								generics.after or else error
							loop
								nb_errors := Error_handler.nb_errors
								t1 := generics.item
								t1.check_constraint_type (a_class)
								error := Error_handler.nb_errors /= nb_errors
								if not error then
									t2 := cl_generics.item.constraint
									if t2 /= Void then
										t1.actual_type.check_const_gen_conformance
											(t2.actual_type, a_class)
										error := Error_handler.new_error
									end
								end
								generics.forth
								cl_generics.forth
							end
						else
								-- TUPLE: has no generics
							from
								generics.start
							until
								generics.after or else error
							loop
								nb_errors := Error_handler.nb_errors
								t1 := generics.item
								t1.check_constraint_type (a_class)
								error := Error_handler.nb_errors /= nb_errors
								generics.forth
							end
						end
					end
				end
			end
		end

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
		local
			class_i: CLASS_I
			c_name: STRING
		do
			c_name := clone (class_name)
			c_name.to_lower
			class_i := associated_classi
			c_name.to_upper
			if class_i = Void then
				st.add_string (c_name)
			else
				st.add_classi (class_i, c_name)
			end
			if generics /= Void then
				from
					generics.start
					st.add_string (" [")
				until
					generics.after
				loop
					generics.item.append_to (st)
					if not generics.islast then
						st.add_string (", ")
					end
					generics.forth
				end
				st.add_string ("]")
			end
		end
 
	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
		local
			aclassi: CLASS_I
		do
				-- Check if we can find the class in the cluster.
				-- If the class is not compiled anymore (or doesnot
				-- exist at all), the resulting stone will not be
				-- valid (`is_valid' = false because `class_c' = Void).
			aclassi := Universe.class_named (class_name, reference_class.cluster)
			if aclassi /= Void then
				Result := aclassi.compiled_class
			end
		end

	associated_classi: CLASS_I is
			-- Associated class_i
			-- require: `Inst_context.cluster' not `Void'.
		do
			check
				Inst_context.cluster /= Void
			end
			Result := Universe.class_named (class_name,
						Inst_context.cluster)
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			if generics /= Void then
				generics.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current)
			if generics /= Void then
				Result.set_generics (generics.replicate (ctxt))
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
		do
			s := clone (class_name)
			s.to_upper

			ctxt.put_class_name (s)
			if generics /= Void then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_L_bracket)
				ctxt.set_space_between_tokens
				ctxt.set_separator (ti_Comma)
				ctxt.format_ast (generics)
				ctxt.put_text_item_without_tabs (ti_R_bracket)
			end
		end

feature {COMPILER_EXPORTER} -- Conveniences

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g
		end

	dump: STRING is
			-- Dumped string
		local
			dumped_class_name: STRING
		do
			!! Result.make (class_name.count)
			dumped_class_name := clone (class_name)
			dumped_class_name.to_upper
			Result.append (dumped_class_name)
			if generics /= Void then
				from
					generics.start; 
					Result.append (" [")
				until
					generics.after
				loop
					Result.append (generics.item.dump)
					if not generics.islast then
						Result.append (", ")
					end
					generics.forth
				end
				Result.append ("]")
			end
		end

end -- class CLASS_TYPE_AS
