indexing
	description: "Names and descriptions for configuration components."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_INTERFACE_NAMES

feature {NONE} -- System names and descriptions

	system_name_name: STRING is "Name"
	system_name_description: STRING is "Name of the system."
	system_description_name: STRING is "Description"
	system_description_description: STRING is "Description of the system."
	system_library_target_name: STRING is "Library target"
	system_library_target_description: STRING is "Target used if system is used as a library."
	system_uuid_name: STRING is "UUID"
	system_uuid_description: STRING is "Unique identifier for the system."
	system_targets_name: STRING is "Targets"
	system_targets_description: STRING is "Targets of the system."

feature {NONE} -- Target names and descriptions

	target_name_name: STRING is "Name"
	target_name_description: STRING is "Name of the target."
	target_description_name: STRING is "Description"
	target_description_description: STRING is "Description of the target."
	target_base_name: STRING is "Base target"
	target_base_description: STRING is "Base target of this target."
	target_compilation_type_name: STRING is "Compilation type"
	target_compilation_type_description: STRING is "Type of compilation."
	target_compilation_type_standard: STRING is "Standard (C/byte code)"
	target_compilation_type_dotnet: STRING is ".NET (msil)"
	target_executable_name: STRING is "Output name"
	target_executable_description: STRING is "Name of the generated binary."
	target_root_name: STRING is "Root"
	target_root_description: STRING is "Root cluster, class, feature of the system."
	target_version_name: STRING is "Version"
	target_version_description: STRING is "Version number."
	target_product_name: STRING is "Product"
	target_product_description: STRING is "Name of the product."
	target_company_name: STRING is "Company"
	target_company_description: STRING is "Name of the company."
	target_copyright_name: STRING is "Copyright"
	target_copyright_description: STRING is "Copyright of this product."
	target_trademark_name: STRING is "Trademark"
	target_trademark_description: STRING is "Trademark of this product."

	target_dialog_root_cluster: STRING is "Root cluster"
	target_dialog_root_class: STRING is "Root class"
	target_dialog_root_feature: STRING is "Root feature"
	target_dialog_root_all: STRING is "Compile all classes"

feature {NONE} -- Option names and descriptions

	option_require_name: STRING is "Require"
	option_require_description: STRING is "Evaluate precondition assertions."
	option_ensure_name: STRING is "Ensure"
	option_ensure_description: STRING is "Evaluate postcondition assertions."
	option_check_name: STRING is "Check"
	option_check_description: STRING is "Evaluate check assertions."
	option_invariant_name: STRING is "Invariant"
	option_invariant_description: STRING is "Evaluate invariant assertions."
	option_loop_name: STRING is "Loop"
	option_loop_description: STRING is "Evaluate loop assertions."

	option_warnings_name: STRING is "Enabled"
	option_warnings_description: STRING is "Are warnings enabled?"

feature {NONE} -- Validation warnings

	library_target_override: STRING is "Library target can not be used because it contains overrides which is forbidden."
	target_move_up_extends: STRING is "Target can not be moved up because it extends the target that is above it."
	target_move_down_extends: STRING is "Target can not be moved down because the target below it extends this target."
	target_add_duplicate: STRING is "Can not add target because there is already a target with the same name."
	target_remove_library_target: STRING is "Target can not be rmeoved because it is the library target."
	target_remove_extends (other_target: STRING): STRING is
		do
			Result := "Target can not be removed because "+other_target+" extends it."
		end

	target_name_duplicate: STRING is "Can not rename target because there is already a target with the new name."

end
