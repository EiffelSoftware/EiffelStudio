indexing

	description: 
		"Descritpion of an actual generical type.";
	date: "$Date$";
	revision: "$Revision $"

class GEN_TYPE_A

inherit

	CL_TYPE_A
		rename
			expanded_deferred as basic_expanded_deferred,
			valid_expanded_creation as basic_valid_expanded_creation,
			is_valid as basic_is_valid,
			dump as old_dump,
			append_to as old_append_to
		redefine
			generics,
			valid_generic,
			parent_type,
			has_like,
			duplicate,
			solved_type, 
			type_i,
			good_generics,
			error_generics,
			check_generics,
			has_formal_generic,
			instantiated_in,
			has_expanded,
			same_as,
			same_class_type,
			format,
			is_equivalent,
			storage_info,
			storage_info_with_name
		end;
	CL_TYPE_A
		redefine
			generics,
			valid_generic,
			parent_type,
			dump,
			append_to,
			has_like,
			duplicate,
			solved_type,
			type_i,
			good_generics,
			error_generics,
			check_generics,
			has_formal_generic,
			instantiated_in,
			has_expanded,
			is_valid,
			expanded_deferred,
			valid_expanded_creation,
			same_as,
			same_class_type,
			format,
			is_equivalent,
			storage_info,
			storage_info_with_name
		select
			dump, expanded_deferred, valid_expanded_creation,
			is_valid, append_to
		end;

feature -- Property

	generics: ARRAY [TYPE_A];
			-- Actual generical parameter

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
			other_generics: like generics;
		do
			Result := is_expanded = other.is_expanded and then
				is_separate = other.is_separate and then
				equal (base_class_id, other.base_class_id)
			if Result then
				from
					i := 1;
					nb := generics.count;
					other_generics := other.generics;
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := equivalent (generics.item (i),
							other_generics.item (i));
					i := i + 1;
				end;
			end
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_gen_type: GEN_TYPE_A;
			i, nb: INTEGER;
			other_generics: like generics;
		do
			other_gen_type ?= other;
			if 	other_gen_type /= Void
				and then
				other_gen_type.base_class_id.is_equal (base_class_id)
				and then
				is_expanded = other_gen_type.is_expanded
			then
				from
					i := 1;
					nb := generics.count;
					other_generics := other_gen_type.generics;
					Result := nb = other_generics.count
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).same_as
												(other_generics.item (i));
					i := i + 1;
				end;
			end;
		end;

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			i, count: INTEGER;
		do
			Result := old_dump;
			Result.append (" [");
			from
				i := 1;
				count := generics.count;
			until
				i > count
			loop
				Result.append (generics.item (i).dump);
				if i /= count then
					Result.append (", ");
				end;
				i := i + 1;
			end;
			Result.append ("]");
		end;

	append_to (st: STRUCTURED_TEXT) is
		local
			i, count: INTEGER;
		do
			old_append_to (st);
			st.add_string (" [");
			from
				i := 1;
				count := generics.count;
			until
				i > count
			loop
				generics.item (i).append_to (st);
				if i /= count then
					st.add_string (", ");
				end;
				i := i + 1;
			end;
			st.add_string ("]");
		end;

feature {COMPILER_EXPORTER} -- Primitives

	set_generics (g: like generics) is
			-- Assign `g' to `generics'.
		do
			generics := g;
		end;

	has_formal: BOOLEAN is
			-- Are some formal generic parameter present in the array
			-- `generics' ?
		local
			i, count: INTEGER;
		do
			from
				i := 1;
				count := generics.count;
			until
				i > count or else Result
			loop
				Result := generics.item (i).is_formal;
				i := i + 1;
			end;
		end;

	has_expanded: BOOLEAN is
			-- Are some expanded type in the current generic declaration ?
		local
			i, count: INTEGER;
		do
			from
				Result := is_expanded;
				i := 1;
				count := generics.count;
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_expanded;
				i := i + 1;
			end;
		end;

	is_valid: BOOLEAN is
		local
			i, count: INTEGER
		do
			from
				Result := basic_is_valid;
				i := 1;
				count := generics.count
			until
				i > count or else not Result
			loop
				Result := generics.item (i).is_valid;
				i := i + 1;
			end;
		end;

	has_formal_generic: BOOLEAN is
			-- Are smae formal generic paraemter in the type ?
		local
			i, count: INTEGER;
		do
			from
				i := 1;
				count := generics.count;
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_formal_generic;
				i := i + 1;
			end;
		end;

	type_i: GEN_TYPE_I is
			-- Meta generic interpretation of the generic type
		local
			i, count: INTEGER;
			meta_generic: META_GENERIC;
		do
			from
				i := 1;
				count := generics.count;
				!!meta_generic.make (count);
				!!Result;
				Result.set_base_id (base_class_id);
				Result.set_meta_generic (meta_generic);
				Result.set_is_expanded (is_expanded);
			until
				i > count
			loop
				meta_generic.put (generics.item (i).meta_type, i);
				i := i + 1;
			end;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): GEN_TYPE_A is
			-- Calculate type in function of feature `f' and the feature
			-- table `feat_table'.
		local
			i, count: INTEGER;
			new_generics: like generics;
		do
			if not has_like then
				Result := Current;
			else
				from
					i := 1;
					count := generics.count;
					!!new_generics.make (1, count);
					!!Result;
					Result.set_base_class_id (base_class_id);
					Result.set_generics (new_generics);
				until
					i > count
				loop
					new_generics.put
							(generics.item (i).solved_type (feat_table, f), i);
					i := i + 1;
				end;
			end;
		end;

	instantiated_in (class_type: CL_TYPE_A): like Current is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		local
			i, count: INTEGER;
			new_generics: like generics;
		do	
			from
				Result := duplicate;
				i := 1;
				count := generics.count;
				new_generics := Result.generics;
			until
				i > count
			loop
				new_generics.put
					(generics.item (i).instantiated_in (class_type), i);
				i := i + 1;
			end;
		end;

	valid_generic (type: CL_TYPE_A): BOOLEAN is
			-- Check generic parameters
		require else
			good_argument: type /= Void;
			type.associated_class.conform_to (associated_class);
		local
			i, count: INTEGER;
			gen_type: GEN_TYPE_A;
			gen_type_generics: like generics;
		do
			if base_class_id.is_equal (type.base_class_id) then
				gen_type ?= type;
				if gen_type /= Void then
					from
						i := 1;
						gen_type_generics := gen_type.generics;
						count := generics.count;
						Result := count = gen_type_generics.count;
					until
						i > count or else not Result
					loop
						Result := gen_type_generics.item (i).internal_conform_to
													(generics.item (i), True);
						i := i + 1;
					end;
				end;
			else
					-- `type' is a descendant type of Current: so we
					-- have to check the current generic parameters
				Result := type.generic_conform_to (Current);
			end;
		end;
				
	parent_type (parent: CL_TYPE_A): TYPE_A is
			-- Parent actual type in the current context
		do
			Result := instantiate (parent.duplicate);
		end;

	instantiate (type: TYPE_A): TYPE_A is
			-- Instantiates `type'. Given that `type' may hold
			-- some formal generics, instantiate them with the
			-- generics from Current.	
		require
			good_argument: type /= Void;
		local
			i, count: INTEGER;
			gen_type: GEN_TYPE_A;
			gen_type_generics: like generics;
			formal_type: FORMAL_A
		do
			formal_type ?= type;
			if formal_type /= Void then
					-- Instantiation of a formal generic
				Result := generics.item (formal_type.position);
			elseif type.has_generics then
					-- Instantiation of the generic parameter of `type'
				gen_type ?= type;
				Result := gen_type.duplicate;
				from
					i := 1;
					gen_type_generics := Result.generics;
					count := gen_type_generics.count;
				until
					i > count
				loop
					gen_type_generics.put
					  (instantiate (gen_type_generics.item (i).actual_type), i);
					i := i + 1;
				end;
			else
				Result := type;
			end;
		end;

	has_like: BOOLEAN is
			-- Has the type anchored type in its definition ?
		local
			i, count: INTEGER;
		do
			from
				i := 1;
				count := generics.count;
			until
				i > count or else Result
			loop
				Result := generics.item (i).has_like;
				i := i + 1;
			end;
		end;

	duplicate: like Current is
			-- Duplication
		local
			i, count: INTEGER;
			duplicate_generics: like generics;
		do
			from
				i := 1;
				count := generics.count;
				!!duplicate_generics.make (1, count);
				Result := clone (current);
				Result.set_generics (duplicate_generics);
			until
				i > count
			loop
				duplicate_generics.put (generics.item (i).duplicate, i);
				i := i + 1;
			end;
		end;

	good_generics: BOOLEAN is
			-- Has the base class exactly the same number of generic
			-- parameters in its formal generic declarations ?
		local
			base_generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B];
			i, generic_count: INTEGER;
		do
			base_generics := associated_class.generics;
			if base_generics /= Void then
				generic_count := base_generics.count;
				Result := generic_count = generics.count;
				from
					i := 1
				until
					i > generic_count or else not Result
				loop
					Result := generics.item (i).good_generics;
					i := i + 1
				end
			end;
		end;

	error_generics: VTUG is
		local
			base_generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B];
			i, generic_count: INTEGER;
		do
			base_generics := associated_class.generics;
			if base_generics /= Void then
				generic_count := base_generics.count;
				if (generic_count = generics.count) then
					from
						i := 1
					until
						i > generic_count or else (Result /= Void)
					loop
						if not generics.item (i).good_generics then
							Result := generics.item (i).error_generics
						end;
						i := i + 1
					end
				end;
			end;
			if Result = Void then
				if base_generics = Void then
					!VTUG1!Result;
				else
					!VTUG2!Result;
				end;
				Result.set_type (Current);
				Result.set_base_class (associated_class);
			end;
		end;

	check_generics (context_class: CLASS_C) is
			-- Check the constained genericity validity rule
		local
			i, count: INTEGER;
			gen_param, to_check, constraint_type: TYPE_A;
			constraint_info: CONSTRAINT_INFO;
			formal_type: FORMAL_A
		do
			from
				i := 1;
				count := generics.count;
			until
				i > count
			loop
				gen_param := generics.item (i);
				formal_type ?= gen_param;
				if formal_type /= Void then
						-- Check if constraint associated conform to the
						-- i_th generic parameter of context_type
					check
						context_class.generics /= Void;
					end;
					to_check := context_class.generics.i_th
										(formal_type.position).constraint_type;
				else
					to_check := gen_param;
				end;
					-- Evaluation of the constraint
				constraint_type :=
							associated_class.generics.i_th (i).constraint_type;
				if not to_check.conform_to (constraint_type) then
						-- Error
					!!constraint_info;
					constraint_info.set_type (Current);
					constraint_info.set_actual_type (to_check);
					constraint_info.set_formal_number (i);
					constraint_info.set_constraint_type (constraint_type);
					Constraint_error_list.put_front (constraint_info);
				end;

					-- Recursion
				gen_param.check_generics (context_class);

				i := i + 1;
			end;
		end;

	same_class_type (other: CL_TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_gen_type: GEN_TYPE_A;
			i, nb: INTEGER;
			other_generics: like generics;
		do
			other_gen_type ?= other;
			if  other_gen_type /= Void
				and then
				other_gen_type.base_class_id.is_equal (base_class_id)
			then
				from
					Result := True;
					i := 1;
					nb := generics.count;
					other_generics := other_gen_type.generics;
				until
					i > nb or else not Result
				loop
					Result := generics.item (i).actual_type.same_as
								(other_generics.item (i).actual_type);
				   i := i + 1;
				end;
			end;
		end;

	expanded_deferred: BOOLEAN is
			-- Are the expanded class types present in the current generic
			-- type not based on deferred classes ?
		local
			i, nb: INTEGER;
			gen_param: TYPE_A;
		do
			from
				Result := basic_expanded_deferred;
				i := 1;
				nb := generics.count;
			until
				i > nb or else Result
			loop
				gen_param := generics.item (i);
				if gen_param.has_expanded then
					Result := gen_param.expanded_deferred
				end;
				i := i + 1;
			end;
		end;

	valid_expanded_creation (a_class: CLASS_C): BOOLEAN is
			-- Is the expanded type has an associated class with one
			-- creation routine with no arguments only ?
		local
			i, nb: INTEGER;
			gen_param: TYPE_A;
		do
			from
				Result := basic_valid_expanded_creation (a_class);
				i := 1;
				nb := generics.count;
			until
				i > nb or else not Result
			loop
				gen_param := generics.item (i);
				if gen_param.has_expanded then
					Result := gen_param.valid_expanded_creation (a_class);
				end;
				i := i + 1;
			end;
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
		local
			i, count: INTEGER;
		do
			ctxt.put_classi (associated_class.lace_class);
			ctxt.put_space;
			ctxt.put_text_item (ti_L_bracket);
			from
				i := 1;
				count := generics.count;
			until
				i > count
			loop
				generics.item (i).format (ctxt);
				if i /= count then
					ctxt.put_text_item (ti_Comma);
					ctxt.put_space
				end;
				i := i + 1;
			end;
			ctxt.put_text_item (ti_R_bracket)
		end;

feature {COMPILER_EXPORTER} -- Storage information for EiffelCase

	storage_info (classc: CLASS_C): S_GEN_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		local
			gens: FIXED_LIST [S_TYPE_INFO];
			count, i: INTEGER
		do
			!! Result.make (Void, associated_class.id.id);
			count := generics.count;
			!! gens.make (count);
			from
				gens.start;
				i := 1;
			until
				i > count
			loop
				gens.replace (generics.item (i).storage_info (classc));
				gens.forth;
				i := i + 1
			end;
			Result.set_generics (gens)
		end;

    storage_info_with_name (classc: CLASS_C): S_GEN_TYPE_INFO is
            -- Storage info for Current type in class `classc'
            -- and store the name of the class for Current
		local
			gens: FIXED_LIST [S_TYPE_INFO];
			count, i: INTEGER
            ass_classc: CLASS_C
            class_name: STRING
        do
            ass_classc := associated_class;
            !! class_name.make (ass_classc.class_name.count);
			class_name.append (ass_classc.class_name);
			!! Result.make (class_name, ass_classc.id.id);
			count := generics.count;
			!! gens.make (count);
			from
				gens.start;
				i := 1;
			until
				i > count
			loop
				gens.replace (generics.item (i).storage_info_with_name 
								(classc));
				gens.forth;
				i := i + 1
			end;
			Result.set_generics (gens)
        end;

end -- class GEN_TYPE_A
