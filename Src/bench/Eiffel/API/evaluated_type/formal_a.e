-- Descripion of a actual formal generic type: the base type is the class
-- to which the formal generic belongs to and `position' is the position
-- of the formal in the formal generic parameter declaration of this
-- class

class FORMAL_A

inherit

	TYPE_A
		redefine
			is_formal,
			instantiation_in,
			has_formal_generic,
			instantiated_in,
			same_as,
			format
		end;

feature

	is_formal: BOOLEAN is
			-- Is the current actual type a formal generic type ?
		do
			Result := True;
		end;

	has_formal_generic: BOOLEAN is
			-- Does the current actual type have formal generic type ?
		do
			Result := True;
		end;

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			other_actual, constrain: TYPE_A;
		do
			other_actual := other.actual_type;
			if other_actual.is_formal then
				Result := base_type = other_actual.base_type
			else
					-- Check conformance of constained generic type
					-- to `other'
				check
					has_generics: System.current_class.generics /= Void;
					count_ok: System.current_class.generics.count >= base_type;
				end;
				constrain := System.current_class.constraint (base_type);
				Result := constrain.internal_conform_to (other, in_generics);
			end;
		end;

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_formal: FORMAL_A;
		do
			if other.is_formal then
				other_formal ?= other;
				Result := base_type = other_formal.base_type;
			end;
		end;

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (10);
			Result.append ("Generic #");
			Result.append_integer (base_type);
		end;

	append_clickable_signature (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("Generic #");
			a_clickable.put_int (base_type);
		end;

	associated_class: CLASS_C is
		do
			-- No associated class
		end; -- associated_class

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		local
			class_type: CL_TYPE_A;
		do
			class_type ?= type;
			if class_type /= Void then
				Result := class_type.instantiation_of (Current, written_id);
			else
				Result := Current;
			end;
		end;

	instantiated_in (class_type: CL_TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := class_type.generics.item (base_type);
		end;

	type_i: FORMAL_I is
			-- C type
		do
			!!Result;
			Result.set_position (base_type);
		end;

	create_info: CREATE_TYPE is
		do
			-- Do nothing
		ensure then
			False
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- reconstitute text
		do
			ctxt.put_string (ctxt.formal_name (base_type));
		end;

feature -- Storage information for EiffelCase

	storage_info_with_name, storage_info (classc: CLASS_C): S_BASIC_TYPE_INFO is
			-- Storage info for Current type in class `classc'
		local
			gens: EIFFEL_LIST [FORMAL_DEC_AS];
            gen_name: STRING
        do
			gens := classc.generics;
			if gens /= Void and then base_type <= gens.count then
				!! gen_name.make (0);
				gen_name.append (gens.i_th (base_type).formal_name);
				gen_name.to_upper;
				!! Result.make (gen_name)
			else
				!! Result.make ("G")
			end
		end;

end
