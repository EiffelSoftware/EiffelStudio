note
	description: "[
		The basic unit of translation.
		Denotes an element that has to be translated to Boogie.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_TRANSLATION_UNIT

inherit
	E2B_SHARED_CONTEXT
	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

feature -- Access

	id: STRING
			-- Unique ID of this translation unit.
		deferred
		end

feature -- Basic operations

	translate
			-- Translate this unit.
		deferred
		end

feature {NONE} -- Helper functions

	type_id (a_type: CL_TYPE_A): STRING
			-- Id for type `a_type'.
		local
			i: INTEGER
			t: TYPE_A
		do
			if attached {GEN_TYPE_A} a_type as l_gen_type then
				Result := l_gen_type.base_class.name_in_upper.twin
				Result.append ("^")
				from
					i := l_gen_type.generics.lower
				until
					i > l_gen_type.generics.upper
				loop
					t := l_gen_type.generics [i]
					if attached {CL_TYPE_A} t as c then
						Result.append (type_id (c))
					elseif attached {CL_TYPE_A} l_gen_type.base_class.single_constraint (i) as c then
						Result.append (type_id (c))
					else
						check class_type_constraint: False then end
					end
					if i < l_gen_type.generics.upper then
						Result.append ("#")
					end
					i := i + 1
				end
				Result.append ("^")
			else
				Result := a_type.base_class.name_in_upper.twin
			end
		end

	feature_id (a_feature: FEATURE_I): STRING
			-- Id for feature `a_feature'.
		do
			Result := a_feature.feature_name
-- TODO: use body index to account for renaming
--			Result := "f-body-" + a_feature.body_index.out
			;(create {REFACTORING_HELPER}).fixme ("use body index to account for renaming")
		end

invariant
	id_attached: attached id
	id_valid: not id.is_empty

end
