note
	description: "Automatically generated class to access COM+ runtime and Reflection.Emit"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_IL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR_I
		redefine
			start_parents_list,
			start_arguments_list,
			end_arguments_list
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization of current object.
		do
		end

feature -- Target of generation

	set_for_interfaces
			-- Set generation mode for `interfaces'.
		do
		end

	set_for_implementations
			-- Set generation mode for `implementations'.
		do
		end

feature -- Generation Structure

	generate_key (final_mode: BOOLEAN)
		do
		end

	start_assembly_generation (name, file_name, location: STRING)
			-- Create Assembly with `name'.
		do
		end

	add_assembly_reference (name: STRING)
			-- Add reference to assembly file `name' for type lookups.
		do
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN)
			-- Create Module `name' within current assembly.
		do
		end

	define_entry_point (creation_type_id, type_id: INTEGER; feature_id: INTEGER)
			-- Define entry point for IL component from `feature_id' in
			-- class `type_id'.
		do
		end

	end_assembly_generation
			-- Finish creation of current assembly.
		do
		end

	end_module_generation
			-- Finish creation of current module.
		do
		end

feature -- Generation type

	set_console_application
			-- Current generated application is a CONSOLE application.
		do
		end

	set_window_application
			-- Current generated application is a WINDOW application.
		do
		end

	set_dll
			-- Current generated application is a DLL.
		do
		end

feature -- Generation Info

	set_version (build, major, minor, revision: INTEGER)
			-- Assign current generated assembly with given version.
		do
		end

	set_verifiability (verifiable: BOOLEAN)
			-- Mark current generation to generate verifiable code.
		do
		end

	set_cls_compliant (cls_compliant: BOOLEAN)
			-- Mark current generation to generate cls compliant code.
		do
		end

	set_any_type_id (id: INTEGER)
		do
		end

feature -- Class info

	generate_class_mappings (dotnet_name, eiffel_name: STRING; id, interface_id: INTEGER; filename, element_type_name: STRING)
			-- Create a correspondance table between `id' and `class_name'.
		do
		end

	generate_type_class_mapping,
	generate_class_type_class_mapping,
	generate_generic_type_class_mapping,
	generate_basic_type_class_mapping,
	generate_formal_type_class_mapping,
	generate_none_type_class_mapping,
	generate_eiffel_type_info_type_class_mapping (type_id: INTEGER)
		do
		end

	generate_array_class_mappings (class_name, element_type_name: STRING; id: INTEGER)
			-- Create a correspondance table between `id' and `class_name'.
		do
		end

	start_class_description
			-- Following calls to current will only describe parents and features of current class.
		do
		end

	generate_class_header (is_interface, is_deferred, is_frozen, is_expanded, is_external: BOOLEAN; type_id: INTEGER)
			-- Generate class name and its specifier.
		do
		end

	end_class
			-- Finish description of current class structure.
		do
		end

	start_parents_list
			-- Starting inheritance part description
		do
		end

	add_to_parents_list (type_id: INTEGER)
			-- Add class `name' into list of parents of current type.
		do
		end

	add_interface (type_id: INTEGER)
			-- Add interface of `type_id' into list of parents of current type.
		do
		end

	set_implementation_class
			-- Add interface of `type_id' into list of parents of current type.
		do
		end

	end_parents_list
			-- Finishing inheritance part description
		do
		end
	
feature -- Features info

	start_features_list (type_id: INTEGER)
			-- Starting enumeration of features written in current class.
		do
		end

	start_feature_description (count: INTEGER)
			-- Start description of a feature of current class.
		do
		end

	create_feature_description
			-- End description of a feature of current class.
		do
		end

	check_renaming
			-- Check renaming for current feature and class.
		do
		end

	check_renaming_and_redefinition
			-- Check covariance for current feature and class.
		do
		end

	end_features_list
			-- Finishing enumeration of features written in current class.
		do
		end

	generate_feature_nature (is_redefined, is_deferred, is_frozen, is_attribute: BOOLEAN)
			-- Generate nature of current feature.
		do
		end

	generate_interface_feature_identification (name: STRING; feature_id: INTEGER; is_attribute: BOOLEAN)
			-- Generate feature name.
		do
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER;
			is_redefined, is_deferred, is_frozen, is_attribute, is_c_external, is_static: BOOLEAN)
		
			-- Generate feature name.
		do
		end

	generate_external_identification (name, il_name: STRING; ext_kind, feature_id, rout_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [STRING]; return_type: STRING)
			-- Generate feature identification.
		do
		end

	generate_deferred_external_identification (name: STRING; feature_id, rout_id, written_type_id: INTEGER)
			-- Generate feature name.
		do
		end

	generate_feature_return_type (type_id: INTEGER)
			-- Generate return type `type_id' of current feature.
		do
		end

	start_arguments_list (count: INTEGER)
			-- Start declaration of arguments list of `count' size of current feature.
		do
		end

	generate_feature_argument (name: STRING; type_id: INTEGER)
			-- Generate argument `name' of type `type_a'.
		do
		end

	end_arguments_list
			-- End declaration of arguments list of current feature.
		do
		end

feature -- Custom attribute

	add_ca (target_type_id: INTEGER; attribute_type_id: INTEGER; arg_count: INTEGER)
			-- No description available.
			-- `target_type_id' [in].  
			-- `attribute_type_id' [in].  
			-- `arg_count' [in].  
		do
		end

	generate_class_ca
			-- No description available.
		do
		end

	generate_feature_ca (feature_id: INTEGER)
			-- No description available.
			-- `feature_id' [in].  
		do
		end

	add_cainteger_arg (a_value: INTEGER)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_castring_arg (a_value: STRING)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_careal_arg (a_value: REAL)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_cadouble_arg (a_value: DOUBLE)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_cacharacter_arg (a_value: CHARACTER)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_caboolean_arg (a_value: BOOLEAN)
			-- No description available.
			-- `a_value' [in].  
		do
		end

	add_caarray_integer_arg (a_value: ARRAY [INTEGER])
			-- Add custom attribute constructor integer array argument `a_value'.
		do
		end

	add_caarray_string_arg (a_value: ARRAY [STRING])
			-- Add custom attribute constructor string array argument `a_value'.
		do
		end

	add_caarray_real_arg (a_value: ARRAY [REAL])
			-- Add custom attribute constructor real array argument `a_value'.
		do
		end

	add_caarray_double_arg (a_value: ARRAY [DOUBLE])
			-- Add custom attribute constructor double array argument `a_value'.
		do
		end

	add_caarray_character_arg (a_value: ARRAY [CHARACTER])
			-- Add custom attribute constructor character array argument `a_value'.
		do
		end

	add_caarray_boolean_arg (a_value: ARRAY [BOOLEAN])
			-- Add custom attribute constructor boolean array argument `a_value'.
		do
		end

	add_catyped_arg (a_value: INTEGER; type_id: INTEGER)
			-- No description available.
			-- `a_value' [in].  
			-- `type_id' [in].  
		do
		end
		
feature -- IL Generation

	start_il_generation (type_id: INTEGER)
		do
		end

	generate_feature_il (feature_id, type_id, code_feature_id: INTEGER)
			-- Start il generation for feature `feature_id' of class `class_id'.
		do
		end

	generate_implementation_feature_il (feature_id: INTEGER)
		do
		end

	generate_finalize_feature (feature_id: INTEGER)
		do
		end

	generate_method_impl (feature_id, parent_type_id, parent_feature_id: INTEGER)
			-- Generate a MethodImpl from `parent_type_id' and `parent_feature_id'
		do
		end

	generate_feature_internal_duplicate (feature_id: INTEGER)
		do
		end

	generate_creation_feature_il (feature_id: INTEGER)
			-- Start il generation for creation feature `feature_id' of class `class_id'.
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER; parameters_type: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN)
			-- Generate call to `name' with signature `parameters_type'.
		do
		end

feature -- Local variable info generation

	put_result_info (type_id: INTEGER)
			-- Specifies `type_id' of type of result.
		do
		end

	put_local_info (type_id: INTEGER; name: STRING)
			-- Specifies `type_id' of type local.
		do
		end

feature -- Object creation

	create_like_current_object
			-- Create object of same type as current object.
		do
		end

	create_object (type_id: INTEGER)
			-- Create object of `type_id'.
		do
		end

	create_attribute_object (type_id, feature_id: INTEGER)
			-- Create object of `type_id'.
		do
		end

	set_eiffel_type (type_id: INTEGER)
		do
		end

	mark_creation_routines (feature_ids: ARRAY [INTEGER])
			-- Mark routines of `feature_ids' in Current class as creation
			-- routine of Current class.
		do
		end

feature -- IL stack managment

	duplicate_top
			-- Duplicate top element of IL stack.
		do
		end

	pop
			-- Remove top element of IL stack.
		do
		end

feature -- Variables access

	generate_current
			-- Generate access to `Current'.
		do
		end

	generate_result
			-- Generate access to `Result'.
		do
		end

	generate_attribute (type_id, feature_id: INTEGER)
			-- Generate access to attribute of `feature_id' in `type_id'.
		do
		end

	generate_feature_access (type_id, feature_id: INTEGER; is_virtual: BOOLEAN)
			-- Generate access to feature of `feature_id' in `type_id'.
		do
		end

	generate_precursor_feature_access (type_id, feature_id: INTEGER)
			-- Generate access to feature of `feature_id' in `type_id'.
		do
		end

	generate_type_feature (feature_id: INTEGER)
		do
		end

	put_type_token (type_id: INTEGER)
		do
		end

	put_method_token (type_id, feature_id: INTEGER)
			-- Generate access to feature of `feature_id' in `type_id'.
		do
		end

	generate_argument (n: INTEGER)
			-- Generate access to `n'-th variable arguments of current feature.
		do
		end

	generate_local (n: INTEGER)
			-- Generate access to `n'-th local variable of current feature.
		do
		end

	generate_metamorphose (type_id: INTEGER)
			-- Generate `metamorphose', ie boxing a basic type of `type_id' into its
			-- corresponding reference type.
		do
		end

	generate_unmetamorphose (type_id: INTEGER)
		do
		end

feature -- Addresses

	generate_local_address (n: INTEGER)
			-- Generate address of `n'-th local variable.
		do
		end

	generate_argument_address (n: INTEGER)
			-- Generate address of `n'-th argument variable.
		do
		end

	generate_current_address
			-- Generate address of `Current'.
		do
		end

	generate_result_address
			-- Generate address of `Result'.
		do
		end

	generate_attribute_address (type_id, feature_id: INTEGER)
			-- Generate address of attribute of `feature_id' in class `type_id'.
		do
		end

	generate_routine_address (type_id, feature_id: INTEGER)
			-- Generate address of routine of `feature_id' in class `type_id'.
		do
		end

	generate_load_from_address (type_id: INTEGER)
			-- Load value of `type_i' type from address pushed on stack.
		do
		end

feature -- Assignments

	generate_is_instance_of (type_id: INTEGER)
			-- Generate `Isinst' byte code instruction.
		do
		end

	generate_check_cast (source_type_id, target_type_id: INTEGER)
			-- Generate `checkcast' byte code instruction.
		do
		end	
	
	generate_attribute_assignment (type_id, feature_id: INTEGER)
			-- Generate assignment to attribute of `feature_id' in current class.
		do
		end

	generate_local_assignment (n: INTEGER)
			-- Generate assignment to `n'-th local variable of current feature.
		do
		end

	generate_result_assignment
			-- Generate assignment to Result variable of current feature.
		do
		end

feature -- Conversion

	convert_to_native_int,
	convert_to_integer8,
	convert_to_integer16,
	convert_to_integer32,
	convert_to_integer64,
	convert_to_double,
	convert_to_real,
	convert_to_boolean,
	convert_to_character
		
			-- Convert top of stack into an appropriate type.
		do
		end

feature -- Return statements

	generate_return
			-- Generate simple end of routine
		do
		end

	generate_return_value
			-- Generate end of routine which returns `Result'.
		do
		end

feature -- Once management

	generate_once_done_info (name: STRING)
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		do
		end

	generate_once_result_info (name: STRING; type_id: INTEGER)
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_id'.
		do
		end

	generate_once_computed
			-- Mark current once as being computed.
		do
		end

	generate_once_result_address
			-- Generate test on `done' of once feature `name'.
		do
		end

	generate_once_test
			-- Generate test on `done' of once feature `name'.
		do
		end

	generate_once_result
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		do
		end

	generate_once_store_result
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER)
			-- Generate call to `item' of ARRAY.
		do
		end

	generate_array_write (kind: INTEGER)
			-- Generate call to `put' of ARRAY.
		do
		end

	generate_array_creation (type_id: INTEGER)
		do
		end

	generate_array_count
		do
		end

	generate_array_upper
		do
		end

	generate_array_lower
		do
		end

feature --- Rescue

	generate_start_exception_block
		do
		end

	generate_start_rescue
		do
		end

	generate_end_exception_block
		do
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: INTEGER)
		do
		end

	generate_set_assertion_status
		do
		end

	generate_restore_assertion_status
		do
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING)
		do
		end

	generate_precondition_violation
		do
		end

	generate_precondition_check (tag: STRING; labelID: INTEGER)
		do
		end

	generate_invariant_checking (type_id: INTEGER)
		do
		end

	mark_invariant (feature_id: INTEGER)
		do
		end

feature -- Constants generation

	put_void
			-- Put `Void' on IL stack.
		do
		end

	put_manifest_string (s: STRING)
			-- Put `s' on IL stack.
		do
		end

	put_integer8_constant,
	put_integer16_constant,
	put_integer32_constant (i: INTEGER)
			-- Put `i' as INTEGER_8, INTEGER_16, INTEGER on IL stack
		do
		end
		
	put_integer64_constant (i: INTEGER_64)
			-- Put `i' as INTEGER_64 on IL stack
		do
		end

	put_real_constant (r: DOUBLE)
			-- put `r' on IL stack.
		do
		end
		
	put_double_constant (d: DOUBLE)
			-- Put `d' on IL stack.
		do
		end

	put_character_constant (c: CHARACTER)
			-- Put `c' on IL stack.
		do
		end

	put_boolean_constant (b: BOOLEAN)
			-- Put `b' on IL stack.
		do
		end

feature -- Labels and branching

	branch_on_true (label: INTEGER)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
		end

	branch_on_false (label: INTEGER)
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
		end

	branch_to (label: INTEGER)
			-- Generate a branch instruction to `label'.
		do
		end

	mark_label (label: INTEGER)
			-- Mark a portion of code with `label'.
		do
		end

	create_label: INTEGER
			-- Create a new label.
		do
		end

feature -- Binary operator generation

	generate_lt
			-- Generate `<' operator.
		do
		end

	generate_le
			-- Generate `<=' operator.
		do
		end
		
	generate_gt
			-- Generate `>' operator.
		do
		end
		
	generate_ge
			-- Generate `>=' operator.
		do
		end

	generate_star
			-- Generate `*' operator.
		do
		end

	generate_slash
			-- Generate `/' operator.
		do
		end

	generate_power
			-- Generate `^' operator.
		do
		end

	generate_plus
			-- Generate `+' operator.
		do
		end

	generate_mod
			-- Generate `\\' operator.
		do
		end

	generate_minus
			-- Generate `-' operator.
		do
		end

	generate_div
			-- Generate `//' operator.
		do
		end

	generate_xor
			-- Generate `xor' operator.
		do
		end

	generate_or
			-- Generate `or' and `or else' operator.
		do
		end

	generate_and
			-- Generate `and' and `and then' operator.
		do
		end

	generate_implies
			-- Generate `implies operator.
		do
		end

	generate_eq
			-- Generate `=' operator.
		do
		end

	generate_ne
			-- Generate `/=' operator.
		do
		end

	generate_shl
			-- Generate `|<<' operator (shift left)
		do
		end

	generate_shr
			-- Generate `|>>' operator (shift right)
		do
		end

feature -- Unary operator generation

	generate_uplus
			-- Generate '+' operator.
		do
		end

	generate_uminus
			-- Generate '-' operator.
		do
		end

	generate_not
			-- Generate 'not' operator.
		do
		end

	generate_bitwise_not
			-- Generate `bitwise not' operator
		do
		end

feature -- Basic feature

	generate_max (type_id: INTEGER)
			-- Generate `max' on basic types.
		do
		end

	generate_min (type_id: INTEGER)
			-- Generate `min' on basic types.
		do
		end

	generate_abs (type_id: INTEGER)
			-- Generate `abs' on basic types.
		do
		end

	generate_to_string
			-- Generate call on `ToString'.
		do
		end
	
feature -- Line Info for debugging

	put_line_info (n1, n2, n3: INTEGER)
			-- Generate `file_name' and `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		do
		end

feature -- Compilation error handling

	last_error: STRING
			-- Last exception which occurred during IL generation
		do
			Result := ""
		end

feature {NONE} -- Formatting

	to_upper (s: STRING): STRING
			-- Uppercase version of `s'.
		do
		end

	to_lower (s: STRING): STRING
			-- Lowercase version of `s'.
		do
		end

feature {NONE} -- Internal data

	classes_name: ARRAY [STRING]
			-- Manage correspondance between a class name and its ID.

	features_list: ARRAY [ARRAY [STRING]]
			-- Manage correspondance between a class and its feature list ordered
			-- following their `feature_id'.

	need_semicolon: BOOLEAN
			-- Manage the display of `;' between arguments of feature.

	current_type_id: INTEGER
			-- Type id of class being generated.

	counter: COUNTER
			-- Counter for labels
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class COM_IL_CODE_GENERATOR
