indexing
	description: "Actual type for manifest array conformance."
	date: "$Date$"
	revision: "$Revision $"

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
		do
			array_make (1, n)
		end

feature -- Property

	last_type: GEN_TYPE_A
			-- Last type conforming to Current

	is_multi_type: BOOLEAN is True


feature -- Access

	associated_class: CLASS_C is
			-- Class ARRAY
		once
			Result := System.array_class.compiled_class
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			i, nb: INTEGER
			local_copy: like Current
		do
			nb := other.count
			if count = nb then
				from
					local_copy := Current
					i := 1
					Result := True
				until
					not Result or else i > nb
				loop
					Result := equivalent (local_copy.item (i), other.item (i))
					i := i + 1
				end
			end
		end

feature -- Output

	dump: STRING is
			-- Dump trace
		local
			i: INTEGER
			local_copy: like Current
		do
			!!Result.make (10 * count)
			Result.append ("<<")
			from
				local_copy := Current
				i := 1
			until
				i > count
			loop
				Result.append (local_copy.item (i).dump)
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
			local_copy: like Current
		do
			st.add (ti_L_array)
			from
				local_copy := Current
				i := 1
			until
				i > count
			loop
				local_copy.item (i).ext_append_to (st, f)
				if i /= count then
					st.add (ti_Comma)
					st.add_space
				end
				i := i + 1
			end
			st.add (ti_R_array)
		end

feature {COMPILER_EXPORTER}

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			gen_type: GEN_TYPE_A
			i: INTEGER
			generic_param, type_a: TYPE_A
			local_copy: like Current
		do
			gen_type ?= other
			if
				gen_type /= Void and then
				gen_type.base_class_id = System.array_id
			then
				generic_param := gen_type.generics.item (1)
				from
					local_copy := Current
					Result := True
					i := 1
				until
					(i > count) or else
					(not Result)
				loop
					type_a := local_copy.item (i)
					Result := type_a.conform_to (generic_param) 
								and then not (type_a.is_true_expanded 
									and not generic_param.is_true_expanded)
					i := i + 1
				end
			end
			if Result then
				last_type := gen_type
			end
		end

	deep_actual_type : MULTI_TYPE_A is

		local
			i: INTEGER
			type_a: TYPE_A
			local_copy: like Current
		do
			from
				local_copy := Current
				i := 1
				!!Result.make (count)
			until
				i > count
			loop
				type_a := local_copy.item (i)
				Result.put (type_a.deep_actual_type, i)
				i := i + 1
			end
		end

	array_type_a: TYPE_A is
		once
			Result := System.instantiator.Array_type_a
		end

	type_i: GEN_TYPE_I is
			-- Compiled type
		local
			b: BOOLEAN
		do
			if last_type = Void then
				b := internal_conform_to (Array_type_a, False)
			end
			check
				last_type_exists: last_type /= Void
			end
			-- We must resolve anchors here!
			Result := last_type.deep_actual_type.type_i
		end

	create_info: CREATE_INFO is
			-- Creation information
		do
		ensure then
			False
		end
	
end -- class MULTI_TYPE_A
