indexing
	description: "Node for normal class type. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_TYPE_AS

inherit
	TYPE_AS
		redefine
			has_formal_generic, has_like, is_loose,
			is_equivalent,
			check_constraint_type, solved_type_for_format,
			append_to, start_location, end_location
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
		end

	SHARED_INST_CONTEXT

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; g: like generics; a_is_exp, a_is_sep: BOOLEAN) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
		do
			class_name := n
			class_name.to_upper
			generics := g
			is_expanded := a_is_exp
			if a_is_exp then
				record_expanded
			end
			is_separate := a_is_sep
		ensure
			class_name_set: class_name.is_equal (n.as_upper)
			generics_set: generics = g
			is_expanded_set: is_expanded = a_is_exp
			is_separate_st: is_separate = a_is_sep
		end

feature {NONE} -- Initialization

	record_expanded is
			-- This must be done before pass2 `solved_type' and `actual type'
			-- are called in pass3 for local variables
		do
			System.set_has_expanded
			check
				system_initialized: System.current_class /= Void
			end
			System.current_class.set_has_expanded
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_class_type_as (Current)
		end

feature -- Attributes

	class_name: ID_AS
			-- Class type name

	generics: EIFFEL_LIST [TYPE_AS]
			-- Possible generical parameters

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

	is_expanded: BOOLEAN
			-- Is current type used with `expanded' keyword?
			
	is_separate: BOOLEAN
			-- Is current type used with `separate' keyword?

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := class_name.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			if generics /= Void then
				Result := generics.end_location
			else
				Result := class_name.end_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (generics, other.generics) and then
				is_expanded = other.is_expanded
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

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		do
			if generics /= Void then
				from
					generics.start
				until
					generics.after or else Result
				loop
					Result := generics.item.has_formal_generic
					generics.forth
				end
			end
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		local
			g: like generics
		do
			g := generics
			if g /= Void then
				from
					g.start
				until
					g.after or else Result
				loop
					Result := g.item.is_loose
					g.forth
				end
			end
		end

feature -- Conveniences

	solved_type_for_format (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			l_class: CLASS_C
			l_class_i: CLASS_I
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			type_a: TYPE_A
			abort: BOOLEAN
		do
			l_class_i := Universe.class_named (class_name, Inst_context.cluster)
			if l_class_i /= Void and then l_class_i.compiled_class /= Void then
				l_class := l_class_i.compiled_class
				if generics /= Void then
					from
						i := 1
						count := generics.count
						create actual_generic.make (1, count)
						Result := l_class.partial_actual_type (actual_generic,
							is_expanded, is_separate)
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
					Result := l_class.partial_actual_type (Void, is_expanded, is_separate)
				end

				if abort then
					Result := Void
				end
			end
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
			-- Track expanded classes
		local
			l_class: CLASS_C
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
		do
				-- Lookup class in universe, it should be present.
			check
				class_found: Universe.class_named (class_name, Inst_context.cluster) /= Void
			end
			l_class := Universe.class_named (class_name, Inst_context.cluster).compiled_class

			check
				class_found_is_compiled: l_class /= Void
			end

			if generics /= Void then
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
					Result := l_class.partial_actual_type (actual_generic, is_expanded, is_separate)
				until
					i > count
				loop
					actual_generic.put (generics.i_th (i).solved_type (feat_table, f), i)
					i := i + 1
				end
			else
				Result := l_class.partial_actual_type (Void, is_expanded, is_separate)
			end
			if Result.is_expanded and not Result.is_basic then
					-- Only record when necessary.
				record_exp_dependance (l_class)
			end
		end

	actual_type: CL_TYPE_A is
			-- Actual class type without processing like types
		local
			l_class: CLASS_C
			l_class_i: CLASS_I
			actual_generic: ARRAY [TYPE_A]
			i, count: INTEGER
			a_cluster: CLUSTER_I
		do
			a_cluster := Inst_context.cluster
			l_class_i := Universe.class_named (class_name, a_cluster)
				-- Bug fix: `append_signature' can be called on invalid
				-- types by the error mechanism, thus the protection
			if l_class_i /= Void and then l_class_i.compiled_class /= Void then
				l_class := l_class_i.compiled_class
				if generics /= Void then
					from
						i := 1
						count := generics.count
						create actual_generic.make (1, count)
					until
						i > count
					loop
						actual_generic.put (generics.i_th (i).actual_type, i)
						i := i + 1
					end
				end
				Result := l_class.partial_actual_type (actual_generic, is_expanded, is_separate)

				if Result.is_expanded and not Result.is_basic then
						-- Only record when necessary.
					record_exp_dependance (l_class)
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
			t1, t2: TYPE_AS
			pos: INTEGER
			is_tuple_type : BOOLEAN
			l_gen_type: GEN_TYPE_A
		do
			if has_like then
				create vcfg3
				vcfg3.set_class (a_class)
				vcfg3.set_formal_name ("Constraint genericity")
				vcfg3.set_location (generics.start_location)
				Error_handler.insert_error (vcfg3)
			else
				cluster := a_class.cluster
				class_i := Universe.class_named (class_name, cluster)
				if class_i = Void then
					create vtct
					vtct.set_class (a_class)
					vtct.set_class_name (class_name)
					vtct.set_location (class_name)
					Error_handler.insert_error (vtct)
					error_handler.raise_error
				else
					associated_class := class_i.compiled_class
					is_tuple_type := associated_class.is_tuple
					cl_generics := associated_class.generics
						-- TUPLEs can have any number of generics
					if not is_tuple_type then
						if generics /= Void then
							if (cl_generics = Void) then
								create {VTUG1} vtug
							elseif (cl_generics.count /= generics.count) then
								create {VTUG2} vtug
							end
						elseif cl_generics /= Void then
							create {VTUG2} vtug
						end
					end
					if vtug /= Void then
						vtug.set_class (a_class)
						vtug.set_type (actual_type)
						vtug.set_base_class (associated_class)
						vtug.set_location (class_name)
						Error_handler.insert_error (vtug)
					elseif generics /= Void then
						if not is_tuple_type then
							from
								temp := cl_generics
								create cl_generics.make_filled (temp.count)
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
								l_gen_type ?= actual_type
								check
										-- Should be not Void since we have
										-- some generic parameters
									l_gen_type_not_void: l_gen_type /= Void
								end
								generics.start
								cl_generics.start
								pos := 1
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
											(l_gen_type, t2.actual_type, a_class, pos)
										error := Error_handler.new_error
									end
								end
								pos := pos + 1
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
					create d.make_expanded_unit (a_class.class_id)
					context.supplier_ids.extend (d)
					f := a_class.creation_feature
					if f /= Void then
						create d.make (a_class.class_id, f)
						context.supplier_ids.extend (d)
					end
				end
			end
		end

feature -- Output

	append_to (st: STRUCTURED_TEXT) is
		local
			class_i: CLASS_I
		do
			class_i := Universe.class_named (class_name, Inst_context.cluster)
			if class_i = Void then
				st.add_string (class_name)
			else
				st.add_classi (class_i, class_name)
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
 
	associated_eiffel_class (reference_class: CLASS_I): CLASS_I is
			-- Search for Current compiled class in context of `reference_class'.
		do
			Result := Universe.class_named (class_name, reference_class.cluster)
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
		do
			create Result.make (class_name.count)
			Result.append (class_name)
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
