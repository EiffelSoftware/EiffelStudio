indexing
	description: "Type of operand `?' in argument list of an agent creation. Just a placeholder during type check."
	date: "$Date$"
	revision: "$Revision $"

class
	OPEN_TYPE_A

inherit
	CL_TYPE_A
		redefine
			is_valid,
			is_equivalent,
			same_as,
			associated_class,
			ext_append_to,
			dump,
			type_i,
			good_generics,
			internal_conform_to,
			generic_conform_to,
			instantiation_in,
			instantiation_of,
			same_class_type,
			format
		end

feature -- Properties

	is_valid: BOOLEAN is
		do
			Result := True
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			t : OPEN_TYPE_A
		do
			t ?= other
			Result := (t /= Void)
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_type: OPEN_TYPE_A
		do
			other_type ?= other
			Result := (other_type /= Void)
		end

	associated_class: CLASS_C is
			-- Associated class to the type (Void)
		do
			-- Nothing.
		ensure then
			not_called : False
		end

feature -- Output

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_Open_arg)
		end

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (1)
			Result.append (".")
		end

feature {COMPILER_EXPORTER}

	type_i : CL_TYPE_I is

		do
		ensure then
			not_called : False
		end

	good_generics: BOOLEAN is

		do
			Result := True
		end

feature {COMPILER_EXPORTER} -- Conformance

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		do
			-- An open type can be replaced by anything
			Result := True
		end

	generic_conform_to (gen_type: GEN_TYPE_A): BOOLEAN is
			-- Does Current conform to `gen_type' ?
		do
			-- An open type can be replaced by anything
			Result := True
		end

feature {COMPILER_EXPORTER} -- Instantitation of a feature type

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in `written_id'
		do
			Result := Current
		end

feature {COMPILER_EXPORTER} -- Instantiation of a type in the context of a descendant one

	instantiation_of (type: TYPE; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `class_id'
			-- in the context of Current
		do
			Result := Current
		end

	same_class_type (other: CL_TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_type : OPEN_TYPE_A
		do
			other_type ?= other
			Result := (other_type /= Void)
		end

	format (ctxt: FORMAT_CONTEXT) is

		do
			ctxt.put_string (".")
		end

end -- class OPEN_TYPE_A

