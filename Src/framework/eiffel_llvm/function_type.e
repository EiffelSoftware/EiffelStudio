note
	description: "Summary description for {FUNCTION_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION_TYPE

inherit

	DERIVED_TYPE

create

	make_from_pointer,
	make_with_parameters,
	make_with_parameter_array,
	make_without_parameters

feature {NONE}

	make_with_parameters (return_type: TYPE_L; parameters: TYPE_VECTOR)
		obsolete
			"use make_with_parameter_array"
		local
			array: TYPE_ARRAY_REF
		do
			create array.make_from_vector (parameters)
			make_with_parameter_array (return_type, array)
		end

	make_with_parameter_array (return_type: TYPE_L; parameters: TYPE_ARRAY_REF)
		do
			item := get_with_parameters_external (return_type.item, parameters.item)
		end

	make_without_parameters (return_type: TYPE_L)
		do
			item := get_without_parameters_external (return_type.item)
		end

feature

	get_num_params: NATURAL_32
		do
			Result := get_num_params_external (item)
		end

	get_param_type (i: NATURAL_32): TYPE_L
		do
			create Result.make_from_pointer (get_param_type_external (item, i))
		end

feature {NONE} -- Externals

	get_param_type_external (item_a: POINTER; i: NATURAL_32): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return (EIF_POINTER)((llvm::FunctionType *)$item_a)->getParamType ($i);
			]"
		end

	get_num_params_external (item_a: POINTER): NATURAL_32
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return ((llvm::FunctionType *)$item_a)->getNumParams ();
			]"
		end

	get_without_parameters_external (return_type: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return llvm::FunctionType::get ((llvm::Type *)$return_type, false);
			]"
		end

	get_with_parameters_external (return_type: POINTER; parameters: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return llvm::FunctionType::get (((llvm::Type *)$return_type), *((llvm::ArrayRef <llvm::Type *> *)$parameters), false);
			]"
		end
end
