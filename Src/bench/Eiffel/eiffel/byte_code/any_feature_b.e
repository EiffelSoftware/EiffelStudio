indexing
	description: "Special calls to features of ANY for .NET code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	ANY_FEATURE_B
	
inherit
	FEATURE_B
		redefine
			is_any_feature, generate_il_any_call
		end
		
	IL_PREDEFINED_STRINGS
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- IL code generation

	is_any_feature: BOOLEAN is True
			-- Is Current an instance of ANY_FEATURE_B?
			
	generate_il_any_call (written_type, target_type: TYPE_I; is_virtual: BOOLEAN) is
			-- Generate call to routine of ANY that works for both ANY and SYSTEM_OBJECT.
			-- Arguments and target of the call are already pushed on the stack.
		local
			l_count: INTEGER
			l_return_type: TYPE_I
		do
			if parameters /= Void then
				l_count := parameters.count
			end

			l_return_type := context.real_type (type)

				-- It is safe to use the name and not the routine ID to identify the routine
				-- because we are in ANY and therefore no renaming took place.
			inspect
				feature_name_id
			when
				{PREDEFINED_NAMES}.conforms_to_name_id,
				{PREDEFINED_NAMES}.deep_equal_name_id,
				{PREDEFINED_NAMES}.same_type_name_id,
				{PREDEFINED_NAMES}.standard_equal_name_id,
				{PREDEFINED_NAMES}.standard_is_equal_name_id
			then
				generate_frozen_boolean_routine

			when {PREDEFINED_NAMES}.default_name_id then
				generate_default (target_type)

			when {PREDEFINED_NAMES}.default_pointer_name_id then
				generate_default_pointer (target_type)

			when {PREDEFINED_NAMES}.do_nothing_name_id then
				generate_do_nothing (target_type)

			when {PREDEFINED_NAMES}.io_name_id then
				generate_io (written_type, target_type)

			when {PREDEFINED_NAMES}.operating_environment_name_id then
				generate_operating_environment (written_type, target_type)

			when
				{PREDEFINED_NAMES}.generating_type_name_id,
				{PREDEFINED_NAMES}.generator_name_id,
				{PREDEFINED_NAMES}.out_name_id,
				{PREDEFINED_NAMES}.tagged_out_name_id
			then
				generate_string_routine (written_type)

			when
				{PREDEFINED_NAMES}.clone_name_id,
				{PREDEFINED_NAMES}.deep_clone_name_id,
				{PREDEFINED_NAMES}.standard_clone_name_id
			then
				generate_clone_routine (l_return_type)

			when
				{PREDEFINED_NAMES}.copy_name_id,
				{PREDEFINED_NAMES}.deep_copy_name_id,
				{PREDEFINED_NAMES}.standard_copy_name_id
			then
				generate_copy_routine

			when
				{PREDEFINED_NAMES}.deep_twin_name_id,
				{PREDEFINED_NAMES}.standard_twin_name_id,
				{PREDEFINED_NAMES}.twin_name_id
			then
				generate_twin_routine (l_return_type)

			when
				{PREDEFINED_NAMES}.equal_name_id,
				{PREDEFINED_NAMES}.is_equal_name_id
			then
				generate_equal_routine

			when
				{PREDEFINED_NAMES}.default_create_name_id,
				{PREDEFINED_NAMES}.default_rescue_name_id
			then
				generate_default_routine (written_type, target_type)
			when
				{PREDEFINED_NAMES}.to_dotnet_name_id
			then
					-- Nothing to be done, we like what we have on top of the stack
					-- since it is already a .NET object.
			else
					-- We come here if a routine has been added by user in ANY, or
					-- if we handle `print' and `internal_correct_mismatch'.
				if not target_type.is_external then
						-- Normal call to Eiffel routine.
					generate_il_normal_call (written_type, is_virtual)
				else
						-- New routine of ANY, or `print' or `internal_correct_mismatch' applied
						-- to a .NET object, we raise an exception as they should not be called
						-- on .NET object.
						
						-- Remove arguments and target from stack.
					from
					until
						l_count < 0
					loop
						il_generator.pop
						l_count := l_count - 1
					end
					il_generator.generate_raise_exception ({EXCEP_CONST}.precondition,
						"Feature of ANY not implemented for .NET class")
				end
			end
		end

	generate_frozen_boolean_routine is
			-- Generate inlined call to routine of ANY that are completely frozen (that is to
			-- say their definition is frozen and they don't call non-frozen routine in their
			-- definition if ANY) and that returns a boolean value.
		require
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.conforms_to_name_id or
				feature_name_id = {PREDEFINED_NAMES}.deep_equal_name_id or
				feature_name_id = {PREDEFINED_NAMES}.same_type_name_id or
				feature_name_id = {PREDEFINED_NAMES}.standard_equal_name_id or
				feature_name_id = {PREDEFINED_NAMES}.standard_is_equal_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_boolean_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
			l_id := {PREDEFINED_NAMES}.system_object_name_id
			inspect
				feature_name_id
			when
				{PREDEFINED_NAMES}.conforms_to_name_id,
				{PREDEFINED_NAMES}.same_type_name_id,
				{PREDEFINED_NAMES}.standard_is_equal_name_id
			then
				l_extension.set_argument_types (<<l_id, l_id>>)
			when
				{PREDEFINED_NAMES}.deep_equal_name_id,
				{PREDEFINED_NAMES}.standard_equal_name_id
			then
				l_extension.set_argument_types (<<l_id, l_id, l_id>>)				
			end
			
				-- Call routine
			l_extension.generate_call (False)
		end

	generate_clone_routine (a_result_type: TYPE_I) is
			-- Generate inlined call to xx_clone' routines of ANY.
		require
			a_result_type_not_void: a_result_type /= Void
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.clone_name_id or
				feature_name_id = {PREDEFINED_NAMES}.deep_clone_name_id or
				feature_name_id = {PREDEFINED_NAMES}.standard_clone_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_object_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id, l_id>>)
			
				-- Call routine
			l_extension.generate_call (False)

				-- Cast result back to proper type
			il_generator.generate_check_cast (Void, a_result_type)
		end

	generate_copy_routine is
			-- Generate inlined call to xx_copy' routines of ANY.
		require
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.copy_name_id or
				feature_name_id = {PREDEFINED_NAMES}.deep_copy_name_id or
				feature_name_id = {PREDEFINED_NAMES}.standard_copy_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id, l_id>>)
			
				-- Call routine
			l_extension.generate_call (False)
		end
		
	generate_default (target_type: TYPE_I) is
			-- Generate inlined call to `default'.
		require
			target_type_not_void: target_type /= Void
		do
				-- Check validity of target
			generate_call_on_void_target (target_type, False)
			
			if target_type.is_expanded then
				if target_type.is_basic then
						-- Put default value for basic type
					il_generator.put_default_value (target_type)
				else
						-- Create new instance of expanded type
					(create {CREATE_TYPE}.make (target_type)).generate_il
				end
			else
					-- Reference case, we simply return Void
				il_generator.put_void
			end
		end

	generate_default_routine (written_type, target_type: TYPE_I) is
			-- Generate inlined call to routines of ANY returning a STRING object:
			-- `generator', `generating_type', `out' and `tagged_out'.
		require
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.default_create_name_id or
				feature_name_id = {PREDEFINED_NAMES}.default_rescue_name_id
		local
			l_dotnet_label, l_end_label: IL_LABEL
		do
				-- Since `default_create' and `default_rescue' are virtual in ANY,
				-- we need to perform a dynamic dispatch when we handle an Eiffel class.
			l_dotnet_label := il_generator.create_label
			l_end_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_false (l_dotnet_label)
			generate_il_normal_call (written_type, True)
			il_generator.branch_to (l_end_label)
			il_generator.mark_label (l_dotnet_label)

				-- Check validity of target for .NET case
			generate_call_on_void_target (target_type, False)
			
				-- Nothing to be done for .NET since their content is empty.
			
			il_generator.mark_label (l_end_label)
		end

	generate_default_pointer (target_type: TYPE_I) is
			-- Generate inlined call to `default_pointer'.
		require
			target_type_not_void: target_type /= Void
		do	
				-- Check validity of target
			generate_call_on_void_target (target_type, False)

				-- We simply return null pointer
			il_generator.put_integer_32_constant (0)
			il_generator.convert_to_native_int
		end

	generate_do_nothing (target_type: TYPE_I) is
			-- Generate inlined call to `do_nothing'.
		require
			target_type_not_void: target_type /= Void
		do	
				-- Check validity of target
			generate_call_on_void_target (target_type, False)
		end

	generate_equal_routine is
			-- Generate inlined call to `equal' and `is_equal' routines of ANY.
		require
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.equal_name_id or
				feature_name_id = {PREDEFINED_NAMES}.is_equal_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_boolean_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
			l_id := {PREDEFINED_NAMES}.system_object_name_id
			if feature_name_id = {PREDEFINED_NAMES}.is_equal_name_id then
				l_extension.set_argument_types (<<l_id, l_id>>)
			else
				l_extension.set_argument_types (<<l_id, l_id, l_id>>)
			end
			
				-- Call routine
			l_extension.generate_call (False)
		end

	generate_io (written_type, target_type: TYPE_I) is
			-- Generate inlined call to `io'.
		require
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
		local
			l_io_label: IL_LABEL
		do	
				-- Check validity of target
			generate_call_on_void_target (target_type, True)
			
			l_io_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_true (l_io_label)
			il_generator.pop;
			(create {CREATE_TYPE}.make (any_type)).generate_il
			il_generator.mark_label (l_io_label)
			generate_il_normal_call (written_type, True)
		end

	generate_operating_environment (written_type, target_type: TYPE_I) is
			-- Generate inlined call to `operating_environment'.
		require
			written_type_not_void: written_type /= Void
			target_type_not_void: target_type /= Void
		local
			l_oe_label: IL_LABEL
		do	
				-- Check validity of target
			generate_call_on_void_target (target_type, True)
			
			l_oe_label := il_generator.create_label
			il_generator.generate_is_true_instance_of (any_type)
			il_generator.duplicate_top
			il_generator.branch_on_true (l_oe_label)
			il_generator.pop;
			(create {CREATE_TYPE}.make (any_type)).generate_il
			il_generator.mark_label (l_oe_label)
			generate_il_normal_call (written_type, True)
		end
		
	generate_string_routine (written_type: TYPE_I) is
			-- Generate inlined call to routines of ANY returning a STRING object:
			-- `generator', `generating_type', `out' and `tagged_out'.
		require
			written_type_not_void: written_type /= Void
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.generating_type_name_id or
				feature_name_id = {PREDEFINED_NAMES}.generator_name_id or
				feature_name_id = {PREDEFINED_NAMES}.out_name_id or
				feature_name_id = {PREDEFINED_NAMES}.tagged_out_name_id
		local
			l_extension: IL_EXTENSION_I
			l_local: INTEGER
			l_out_label, l_end_label: IL_LABEL
		do
			if feature_name_id = {PREDEFINED_NAMES}.out_name_id then
					-- Since `out' is virtual in ANY, we need to perform
					-- a dynamic dispatch when we handle an Eiffel class.
				l_out_label := il_generator.create_label
				l_end_label := il_generator.create_label
				il_generator.duplicate_top
				il_generator.generate_is_true_instance_of (any_type)
				il_generator.branch_on_false (l_out_label)
				il_generator.generate_is_true_instance_of (any_type)
				generate_il_normal_call (written_type, True)
				il_generator.branch_to (l_end_label)
				il_generator.mark_label (l_out_label)
			end
			
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_string_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_argument_types (<<{PREDEFINED_NAMES}.system_object_name_id>>)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
				-- Call routine
			l_extension.generate_call (False)
			
				-- Store result in temporary variable
			context.add_local (system_string_type)
			l_local := context.local_list.count
			il_generator.put_dummy_local_info (system_string_type, l_local)
			il_generator.generate_local_assignment (l_local)
			
				-- Generate Eiffel STRING object from SYSTEM_STRING object
			il_generator.put_manifest_string_from_system_string_local (l_local)

			if feature_name_id = {PREDEFINED_NAMES}.out_name_id then
				il_generator.mark_label (l_end_label)
			end
		end

	generate_twin_routine (a_result_type: TYPE_I) is
			-- Generate inlined call to xx_twin' routines of ANY.
		require
			a_result_type_not_void: a_result_type /= Void
			valid_feature_name:
				feature_name_id = {PREDEFINED_NAMES}.twin_name_id or
				feature_name_id = {PREDEFINED_NAMES}.deep_twin_name_id or
				feature_name_id = {PREDEFINED_NAMES}.standard_twin_name_id
		local
			l_extension: IL_EXTENSION_I
			l_id: INTEGER
		do
				-- No need to check validity of target, it is done by the runtime
				-- routine we are calling.

				-- Create representation of the routine we are calling.			
			create l_extension
			l_extension.set_alias_name_id (feature_name_id)
			l_extension.set_return_type ({PREDEFINED_NAMES}.system_object_name_id)
			l_extension.set_base_class (runtime_class_name)
			l_extension.set_type ({SHARED_IL_CONSTANTS}.static_type)
			
			l_id := {PREDEFINED_NAMES}.system_object_name_id
			l_extension.set_argument_types (<<l_id>>)
			
				-- Call routine
			l_extension.generate_call (False)

				-- Cast result back to proper type
			il_generator.generate_check_cast (Void, a_result_type)
		end

feature {NONE} -- Convenience

	generate_call_on_void_target (target_type: TYPE_I; need_top_duplication: bOOLEAN) is
			-- Generate check that current object is not Void.
		require
			target_type_not_void: target_type /= Void
		local
			l_not_void_label: IL_LABEL
		do
			if need_top_duplication then
				il_generator.duplicate_top
			end

			if target_type.is_reference then
				l_not_void_label := il_generator.create_label
	
					-- Check that target is not Void.			
				il_generator.branch_on_true (l_not_void_label)
	
					-- If target of call is Void, throw an exception.
				il_generator.generate_call_on_void_target_exception
				
					-- Else we procede normally
				il_generator.mark_label (l_not_void_label)
			else
					-- Top element is not required so we can get rid of it.
				il_generator.pop
			end
		end
		
	any_type: CL_TYPE_I is
			-- Actual type of ANY
		require
			has_any: system.any_class /= Void
			has_any_compiled: system.any_class.is_compiled
		once
			Result := system.any_class.compiled_class.actual_type.type_i
		ensure
			any_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_I is
			-- Actual type of SYSTEM_STRING
		require
			has_system_string: system.system_string_class /= Void
			has_system_string_compiled: system.system_string_class.is_compiled
		once
			Result := system.system_string_class.compiled_class.actual_type.type_i
		ensure
			system_string_type_not_void: Result /= Void
		end

	string_type: CL_TYPE_I is
			-- Actual type of SYSTEM_STRING
		require
			has_string: system.string_class /= Void
			has_string_compiled: system.string_class.is_compiled
		once
			Result := system.string_class.compiled_class.actual_type.type_i
		ensure
			string_type_not_void: Result /= Void
		end
		
end -- class ANY_FEATURE_B
