indexing
	description: "Actual type for manifest array conformance."
	date: "$Date$"
	revision: "$Revision$"

class MULTI_TYPE_A 
	
inherit
	CL_TYPE_A
		rename
			make as class_make
		undefine
			copy, is_equal
		redefine
			is_multi_type, deep_actual_type, is_equivalent,
			dump, ext_append_to, internal_conform_to, type_i,
			create_info, instantiation_of
		end

	ARRAY [TYPE_A]
		rename
			make as array_make
		end

creation {COMPILER_EXPORTER}
	make
	
feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Initialization
		require
			valid_n: n >= 0
		do
			class_make (System.array_id)
			array_make (1, n)
		end

feature -- Property

	last_type: GEN_TYPE_A
			-- Last type conforming to Current

	is_multi_type: BOOLEAN is True
			-- We are handling a manifest array.

feature {ARRAY_AS, MULTI_TYPE_A}

	set_last_type (t: like last_type) is
		require
			t_not_void: t /= Void
		do
			last_type := t
		ensure
			last_type_set: last_type = t
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
		do
			Result := Precursor {CL_TYPE_A} (other)
			nb := other.count
			if count = nb then
				from
					i := 1
					Result := True
				until
					not Result or else i > nb
				loop
					Result := equivalent (item (i), other.item (i))
					i := i + 1
				end
			end
		end

feature -- Output

	dump: STRING is
			-- Dump trace
		local
			i: INTEGER
		do
			!!Result.make (10 * count)
			Result.append ("<<")
			from
				i := 1
			until
				i > count
			loop
				Result.append (item (i).dump)
				if i /= count then
					Result.append (", ")
				end
				i := i + 1
			end
			Result.append (">>")
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		local
			i: INTEGER
		do
			st.add (ti_l_array)
			from
				i := 1
			until
				i > count
			loop
				item (i).ext_append_to (st, f)
				if i /= count then
					st.add (ti_comma)
					st.add_space
				end
				i := i + 1
			end
			st.add (ti_r_array)
		end

feature {COMPILER_EXPORTER}

	instantiation_of (type: TYPE; a_class_id: INTEGER): TYPE_A is
			-- Instantiation of type `type' written in class of id `a_class_id'
			-- in the context of Current
		do
			check
				last_type_not_void: last_type /= Void
			end
			Result := last_type.instantiation_of (type, a_class_id)
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
			-- The rule is the following:
			-- <<e1,...,en>> conforms to A means that:
			-- if A is an ARRAY of T type, every element type of current conforms
			-- to T.
			-- Otherwise, computed type of Current conforms to A.
		local
			gen_type: GEN_TYPE_A
			generic_param, type_a: TYPE_A
			i, nb: INTEGER
		do
			nb := count
			gen_type ?= other
			if
				gen_type /= Void and then
				gen_type.class_id = System.array_id
			then
				Result := True
				if nb > 0 then
					generic_param := gen_type.generics.item (1)
					from
						i := 1
					until
						(i > count) or else (not Result)
					loop
						type_a := item (i)
						Result := type_a.conform_to (generic_param) 
									and then not (type_a.is_true_expanded 
									and not generic_param.is_true_expanded)
						i := i + 1
					end
				end
				if Result then
					last_type := gen_type
				end
			else
				check
					last_type_not_void: last_type /= Void
				end
				Result := last_type.conform_to (other)
			end
		end

	deep_actual_type : MULTI_TYPE_A is

		local
			i: INTEGER
			type_a: TYPE_A
		do
			from
				i := 1
				create Result.make (count)
			until
				i > count
			loop
				type_a := item (i)
				Result.put (type_a.deep_actual_type, i)
				i := i + 1
			end
			check
				last_type_not_void: last_type /= Void
			end
			Result.set_last_type (last_type.deep_actual_type)
		end

	type_i: GEN_TYPE_I is
			-- Compiled type
		do
				-- FIXME: Manu 11/1/2001: why this sentence?
				-- We must resolve anchors here!
			check
				last_type_not_void: last_type /= Void
			end
			Result := last_type.deep_actual_type.type_i
		end

	create_info: CREATE_TYPE is
			-- Creation information
		do
			check
				False
			end
		end
	
end -- class MULTI_TYPE_A
