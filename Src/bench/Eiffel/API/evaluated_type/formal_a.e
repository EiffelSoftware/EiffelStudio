indexing
	description: "Descripion of a actual formal generic type"
	date: "$Date$"
	revision: "$Revision $"

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
		end

feature -- Property

	is_formal: BOOLEAN is True
			-- Is the current actual type a formal generic type ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_formal: FORMAL_A
		do
			other_formal ?= other
			if other_formal /= Void then
				Result := position = other_formal.position
			end
		end

	associated_class: CLASS_C is
		do
			-- No associated class
		end

	position: INTEGER
			-- Position of the formal parameter in the
			-- generic class declaration

feature -- Setting

	set_position (p: like position) is
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (10)
			Result.append ("Generic #")
			Result.append_integer (position)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			s: STRING
		do
			if f /= Void then
				s := clone (f.associated_class.ast.generics.i_th (position).formal_name)
				s.to_upper
				st.add (create {GENERIC_TEXT}.make (s))
			else
				st.add (ti_Generic_index)
				st.add_int (position)
			end
		end

feature {COMPILER_EXPORTER}

	has_formal_generic: BOOLEAN is
			-- Does the current actual type have formal generic type ?
		do
			Result := True
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does `other' conform to Current ?
		local
			other_formal: FORMAL_A
			constrain: TYPE_A
		do
			other_formal ?= other.actual_type
			if other_formal /= Void then
				Result := position = other_formal.position
			else
					-- Check conformance of constained generic type
					-- to `other'
				check
					has_generics: System.current_class.generics /= Void
					count_ok: System.current_class.generics.count >= position
				end
				constrain := System.current_class.constraint (position)
				Result := constrain.internal_conform_to (other, in_generics)
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): TYPE_A is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		local
			class_type: CL_TYPE_A
		do
			class_type ?= type
			if class_type /= Void then
				Result := class_type.instantiation_of (Current, written_id)
			else
				Result := Current
			end
		end

	instantiated_in (class_type: CL_TYPE_A): TYPE_A is
			-- Instantiation of Current in the context of `class_type'
			-- assuming that Current is written in the associated class
			-- of `class_type'.
		do
			Result := class_type.generics.item (position)
		end

	type_i: FORMAL_I is
			-- C type
		do
			!!Result
			Result.set_position (position)
		end

	create_info: CREATE_TYPE is
		do
			-- Do nothing
		ensure then
			False
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- reconstitute text
		do
			ctxt.put_text_item (create {GENERIC_TEXT}.make (ctxt.formal_name (position)))
--			ctxt.put_string (ctxt.formal_name (position))
		end

end -- class FORMAL_A
