indexing
	description: "Description of an actual Native array type for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY_TYPE_I

inherit
	GEN_TYPE_I
		redefine
			same_as, il_type_name, duplicate, instantiation_in
		end
	
create
	make

feature -- Comparison

	same_as (other: TYPE_I): BOOLEAN is
			-- Is `other' equal to Current?
		local
			l_native_array: NATIVE_ARRAY_TYPE_I
		do
			l_native_array ?= other
			if l_native_array /= Void then
				Result := Precursor {GEN_TYPE_I} (other)
			end
		end

feature -- Access

	il_type_name: STRING is
			-- Name of current class
		do
			Result := clone (true_generics.item (1).il_type_name)
			Result.append ("[]")
		end

	deep_il_element_type: CL_TYPE_I is
			-- Find type of array element.
			-- I.e. if you have NATIVE_ARRAY [NATIVE_ARRAY [INTEGER]], it
			-- will return INTEGER.
		require
			true_generics_not_void: true_generics /= Void
		local
			l_native: NATIVE_ARRAY_TYPE_I
		do
			Result ?= true_generics.item (1)
			check
				result_not_void: Result /= Void
			end
			l_native ?= Result
			if l_native /= Void then
				Result := l_native.deep_il_element_type
			end
		ensure
			deep_il_element_type_not_void: Result /= Void
		end

		
feature -- Duplication

	duplicate: NATIVE_ARRAY_TYPE_I is
			-- Duplicate current.
		local
			l_meta: like meta_generic
		do
			Result := clone (Current)
			l_meta := clone (meta_generic)
			Result.set_meta_generic (l_meta)
			Result.set_true_generics (l_meta)
		end

feature -- Status report

	instantiation_in (other: GEN_TYPE_I): like Current is
			-- Instantiation of Current in context of `other'
		local
			l_type: TYPE_I
		do
			Result := duplicate
			l_type := meta_generic.item (1)
			if l_type.is_formal then
				l_type := l_type.complete_instantiation_in (other)
				if l_type.is_formal then
					l_type := object_type
				end
			else
				l_type := l_type.complete_instantiation_in (other)
			end
			Result.meta_generic.put (l_type, 1)
		end

feature {NONE} -- Implementation

	Object_type: CL_TYPE_I is
			-- Type of SYSTEM_OBJECT.
		require
			system_not_void: system /= Void
			object_class_not_void: system.system_object_class /= Void
			object_class_compiled: system.system_object_class.is_compiled
		once
			Result := system.system_object_class.compiled_class.actual_type.type_i
		ensure
			object_type_not_void: Result /= Void
		end
		
invariant
	il_generation: System.il_generation
	count_set: true_generics /= Void implies true_generics.count = 1
	aliasing: (true_generics /= Void and meta_generic /= Void) implies true_generics = meta_generic
		
end -- class NATIVE_ARRAY_TYPE_I
