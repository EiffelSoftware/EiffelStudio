indexing
	description: "Automatically generated class to access COM+ runtime and Reflection.Emit"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_IL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR_I
		undefine
			start_class_mappings
		end
		
	CORE_PROXY
		rename
			generate_external_identification as proxy_generate_external_identification,
			generate_feature_identification as proxy_generate_feature_identification,
			generate_external_call as proxy_generate_external_call,
			mark_creation_routines as proxy_mark_creation_routines,
			put_character_constant as proxy_put_character_constant,
			add_cacharacter_arg as proxy_add_cacharacter_arg,
			add_caarray_boolean_arg as proxy_add_caarray_boolean_arg,
			add_caarray_character_arg as proxy_add_caarray_character_arg,
			add_caarray_double_arg as proxy_add_caarray_double_arg,
			add_caarray_integer_arg as proxy_add_caarray_integer_arg,
			add_caarray_real_arg as proxy_add_caarray_real_arg,
			add_caarray_string_arg as proxy_add_caarray_string_arg
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end
		
create
	make

feature -- Basic Operations

	generate_key is
			-- Generate key pair for corresponding assembly.
		local
			key_path: STRING
		do
			create key_path.make_from_string ((create {PROJECT_CONTEXT}).Final_generation_path)
			key_path := key_path + (create {OPERATING_ENVIRONMENT}).Directory_separator.out + Key_filename
			if not (create {RAW_FILE}.make (key_path)).exists then
				(create {WEL_PROCESS_LAUNCHER}).launch (Sn_command + key_path, (create {EXECUTION_ENVIRONMENT}).current_working_directory, Void)
			end
		end

	generate_external_call (base_name: STRING; name: STRING; external_kind: INTEGER;
				parameters: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN;
				type_id, feature_id: INTEGER) is
			-- Build an empty array if `parameter_types' is Void.
		local
			actual_parameters: ECOM_ARRAY [STRING]
			actual_return_type: STRING
		do
			if parameters = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (parameters.count, 1)
				create actual_parameters.make_from_array (parameters, 1, Zero_array, Parameterized_array)
			end
			if return_type = Void then
				actual_return_type := Empty_string
			else
				actual_return_type := return_type
			end
			proxy_generate_external_call (base_name, name, external_kind, actual_parameters,
				actual_return_type, is_virtual, type_id, feature_id)
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER; routine_ids: ARRAY [INTEGER]; in_current_class: BOOLEAN; written_type_id: INTEGER) is
		local
			actual_routine_ids: ECOM_ARRAY [INTEGER]
			rout_id_set: ROUT_ID_SET
		do
			rout_id_set ?= routine_ids
			check
				rout_id_set_not_void: rout_id_set /= Void
			end
			Parameterized_array.put (rout_id_set.count, 1)
			create actual_routine_ids.make_from_array (rout_id_set, 1, Zero_array, Parameterized_array)
			proxy_generate_feature_identification (name, feature_id, actual_routine_ids, in_current_class, written_type_id)
		end

	generate_external_identification (name, com_name: STRING; external_kind, feature_id: INTEGER; routine_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; parameters: ARRAY [STRING]; return_type: STRING) is
			-- Build an empty array if `parameter_types' is Void.
			-- Build an empty string is `return_type' is Void.
		local
			actual_parameters: ECOM_ARRAY [STRING]
			actual_return_type: STRING
		do
			if parameters = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (parameters.count, 1)
				create actual_parameters.make_from_array (parameters, 1, Zero_array, Parameterized_array)
			end
			if return_type = Void then
				actual_return_type := Empty_string
			else
				actual_return_type := return_type
			end
			proxy_generate_external_identification (name, com_name, external_kind, feature_id, routine_id, in_current_class, written_type_id, actual_parameters, actual_return_type)
		end

	generate_deferred_external_identification (name: STRING; feature_id, routine_id, written_type_id: INTEGER) is
			-- Generate feature identification.
		do
			check
				not_called: False
			end
		end

feature -- Object creation

	mark_creation_routines (feature_ids: ARRAY [INTEGER]) is
		local
			actual_feature_ids: ECOM_ARRAY [INTEGER]
		do
			Parameterized_array.put (feature_ids.count, 1)
			create actual_feature_ids.make_from_array (feature_ids, 1, Zero_array, Parameterized_array)
			proxy_mark_creation_routines (actual_feature_ids)
		end

feature -- Custom Attributes Generation

	add_cacharacter_arg (a_value: CHARACTER) is
			-- Add custom attribute constructor character argument `a_value'.
		do
			proxy_add_cacharacter_arg (a_value.code)
		end

	add_caarray_integer_arg (a_value: ARRAY [INTEGER]) is
			-- Add custom attribute constructor integer array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [INTEGER]
		do
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (a_value.count, 1)
				create actual_parameters.make_from_array (a_value, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_integer_arg (actual_parameters)
		end

	add_caarray_string_arg (a_value: ARRAY [STRING]) is
			-- Add custom attribute constructor string array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [STRING]
		do
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (a_value.count, 1)
				create actual_parameters.make_from_array (a_value, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_string_arg (actual_parameters)
		end

	add_caarray_real_arg (a_value: ARRAY [REAL]) is
			-- Add custom attribute constructor real array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [REAL]
		do
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (a_value.count, 1)
				create actual_parameters.make_from_array (a_value, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_real_arg (actual_parameters)
		end

	add_caarray_double_arg (a_value: ARRAY [DOUBLE]) is
			-- Add custom attribute constructor double array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [DOUBLE]
		do
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (a_value.count, 1)
				create actual_parameters.make_from_array (a_value, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_double_arg (actual_parameters)
		end

	add_caarray_character_arg (a_value: ARRAY [CHARACTER]) is
			-- Add custom attribute constructor character array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [INTEGER]
			array: ARRAY [INTEGER]
			i: INTEGER
		do
			from
				i := 1
				create array.make (1, a_value.count)
			until
				i > a_value.count
			loop
				array.put (a_value.item (i).code, i)
				i := i + 1
			end
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (array.count, 1)
				create actual_parameters.make_from_array (array, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_character_arg (actual_parameters)
		end

	add_caarray_boolean_arg (a_value: ARRAY [BOOLEAN]) is
			-- Add custom attribute constructor boolean array argument `a_value'.
		local
			actual_parameters: ECOM_ARRAY [BOOLEAN]
		do
			if a_value = Void then
				create actual_parameters.make (1, Zero_array, Zero_array)
			else
				Parameterized_array.put (a_value.count, 1)
				create actual_parameters.make_from_array (a_value, 1, Zero_array, Parameterized_array)
			end
			proxy_add_caarray_boolean_arg (actual_parameters)
		end

feature -- Character handling

	put_character_constant (c: CHARACTER) is
			-- Put `c' onto stack.
		do
			proxy_put_character_constant (c.code)
		end

feature {NONE} -- Implementation

	Empty_string: STRING is ""
			-- Empty string

	Key_filename: STRING is
			-- Key pair filename
		do
			Result := System.system_name + Key_filename_extension
		end

	Key_filename_extension: STRING is ".snk"
			-- Key filename extension

	Sn_command: STRING is "sn -k "
			-- Sn utility command line

	Zero_array: ARRAY [INTEGER] is
			-- Array that contains only one element being zero.
		once
			Result := <<0>>
		end

	Parameterized_array: ARRAY [INTEGER] is
			-- Array that contains one element that can be set to
			-- a specific value later on.
		once
			Result := <<0>>
		end

end -- class COM_IL_CODE_GENERATOR
