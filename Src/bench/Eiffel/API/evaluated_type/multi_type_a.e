indexing
	description: "Actual type for manifest array conformance."
	date: "$Date$"
	revision: "$Revision$"

class MULTI_TYPE_A 
	
inherit
	TYPE_A
		rename
			duplicate as twin
		undefine
			copy, is_equal
		redefine
			is_multi_type, deep_actual_type
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
			array_make (1, n)
		end

feature -- Property

	last_type: GEN_TYPE_A
			-- Last type conforming to Current

	is_multi_type: BOOLEAN is True
			-- We are handling a manifest array.
			
feature -- Access

	associated_class: CLASS_C is
			-- Class ARRAY
		once
			Result := System.array_class.compiled_class
		end

feature {ARRAY_AS}

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

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
			-- The rule is the following:
			-- <<e1,...,en>> conforms to A, if and only if, for each element ei
			-- in manifest array, type ARRAY [Type of ei] conforms to A.
		local
			gen_type, array_type: GEN_TYPE_A
			l_generics: ARRAY [TYPE_A]
			i, nb: INTEGER
			generic_param, type_a: TYPE_A
		do
			nb := count
			gen_type ?= other
			if
				gen_type /= Void and then
				gen_type.base_class_id = System.array_id
			then
				Result := True
				if nb > 0 then
					create l_generics.make (1, 1)
					create array_type.make (l_generics)
					array_type.set_base_class_id (System.array_id)
					from
						i := 1
					until
						(i > nb) or else (not Result)
					loop
						l_generics.put (item (i), 1)
						Result := array_type.conform_to (gen_type) 
						i := i + 1
					end
				end
				if Result then
					last_type := gen_type
				end
			else
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
				!!Result.make (count)
			until
				i > count
			loop
				type_a := item (i)
				Result.put (type_a.deep_actual_type, i)
				i := i + 1
			end
		end

	type_i: GEN_TYPE_I is
			-- Compiled type
		do
				-- FIXME: Manu 11/1/2001: why this sentence?
				-- We must resolve anchors here!
			Result := last_type.deep_actual_type.type_i
		end

	create_info: CREATE_INFO is
			-- Creation information
		do
			check
				False
			end
		end
	
end -- class MULTI_TYPE_A
