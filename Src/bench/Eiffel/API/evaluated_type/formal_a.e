indexing
	description: "Descripion of a actual formal generic type"
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_A

inherit
	NAMED_TYPE_A
		redefine
			is_formal,
			instantiation_in,
			has_formal_generic,
			instantiated_in,
			same_as,
			format,
			is_full_named_type,
			convert_to,
			check_const_gen_conformance
		end
		
create
	default_create,
	make_constraint_with_reference

feature {NONE} -- Initialization

	make_constraint_with_reference is
			-- Initialize new instance of FORMAL_A which is garanteed to
			-- be instantiated as a reference type.
		do
			is_reference := True
		end
		
feature -- Property

	is_formal: BOOLEAN is True
			-- Is the current actual type a formal generic type ?

	is_full_named_type: BOOLEAN is True
			-- Current is a named type.
			
	is_reference: BOOLEAN
			-- Is current constrained to be always a reference?

	hash_code: INTEGER is
			-- 
		do
			Result := position
		end
		
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
			create Result.make (10)
			Result.append ("Generic #")
			Result.append_integer (position)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			s: STRING
			l_class: CLASS_AS
		do
			if f /= Void then
				l_class := f.associated_class.ast
				if l_class.generics.valid_index (position) then
					s := l_class.generics.i_th (position).formal_name.as_upper
					st.add (create {GENERIC_TEXT}.make (s))
				else
						-- We are in case where actual generic position does not match
						-- any generics in written class of `f'. E.g: A [H, G] inherits
						-- from B [G], therefore in B, `G' at position 2 does not make sense.
						--| FIXME: Manu 05/29/2002: we cannot let this happen, the reason is
						-- due to bad initialization of `f' in wrong class.
					st.add (Ti_generic_index)
					st.add_int (position)
				end
			else
				st.add (Ti_generic_index)
				st.add_int (position)
			end
		end

feature {COMPILER_EXPORTER} -- Type checking

	check_const_gen_conformance (a_gen_type: GEN_TYPE_A; a_target_type: TYPE_A; a_class: CLASS_C; i: INTEGER) is
			-- Is `Current' a valid generic parameter at position `i' of `gen_type'?
			-- For formal generic parameter, we do check that their constraint
			-- conforms to `a_target_type'.
		local
			l_is_ref: BOOLEAN
		do
				-- We simply consider conformance as if current formal
				-- was constrained to be a reference type, it enables us
				-- to accept the following code:
				-- class B [G -> STRING]
				-- class A [G -> STRING, H -> B [G]]
			l_is_ref := is_reference
			is_reference := True
			Precursor {NAMED_TYPE_A} (a_gen_type, a_target_type, a_class, i)
			is_reference := l_is_ref
		end

feature {COMPILER_EXPORTER}

	has_formal_generic: BOOLEAN is
			-- Does the current actual type have formal generic type ?
		do
			Result := True
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_formal: FORMAL_A
			l_constraint: TYPE_A
		do
			other_formal ?= other.actual_type
			if other_formal /= Void then
				Result := position = other_formal.position
			elseif is_reference then
					-- We are always a reference, we can check conformance
					-- of constrained generic type to `other'.
				check
					has_generics: System.current_class.generics /= Void
					count_ok: System.current_class.generics.count >= position
				end
				l_constraint := System.current_class.constraint (position)
				Result := l_constraint.conform_to (other)
			end
		end

	convert_to (a_context_class: CLASS_C; a_target_type: TYPE_A): BOOLEAN is
			-- Does current convert to `a_target_type' in `a_context_class'?
			-- Update `last_conversion_info' of AST_CONTEXT.
		local
			l_checker: CONVERTIBILITY_CHECKER
		do
				-- Check conformance of constained generic type
				-- to `other'
			check
				has_generics: System.current_class.generics /= Void
				count_ok: System.current_class.generics.count >= position
			end
			
			create l_checker
			l_checker.check_formal_conversion (System.current_class, Current, a_target_type)
			Result := l_checker.last_conversion_check_successful
			if Result then
				context.set_last_conversion_info (l_checker.last_conversion_info)
			else
				context.set_last_conversion_info (Void)
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
			create Result.make (position)
		end

	create_info: CREATE_FORMAL_TYPE is
			-- Create formal type info.
		do
			create Result.make (type_i)
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- reconstitute text
		do
			ctxt.put_text_item (create {GENERIC_TEXT}.make (ctxt.formal_name (position)))
--			ctxt.put_string (ctxt.formal_name (position))
		end

end -- class FORMAL_A
