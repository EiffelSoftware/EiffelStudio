indexing
	description: "Generation of call to creation generation"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXTERNAL_B

inherit
	CREATION_EXPR_CALL_B

	EXTERNAL_B
		redefine
			is_first, context_type
		end

feature -- Code generation

	is_first: BOOLEAN is False
			-- A creation expression is like a nested call without real
			-- first paramenter

	generate_il_array_creation is
		do
			check
				False
			end
		end

feature -- Type info

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		do
			Result := Context.creation_type (info.type)
		end

feature -- Copy

	fill_from (f: EXTERNAL_B) is
			-- Fill in node with call `f'
		do
			feature_name_id := f.feature_name_id
			feature_id := f.feature_id
			type := f.type
			parameters := f.parameters
			routine_id := f.routine_id
			written_in := f.written_in
			extension := f.extension
			is_static_call := f.is_static_call
			static_class_type := f.static_class_type
		end

end -- class CREATION_EXTERNAL_B
