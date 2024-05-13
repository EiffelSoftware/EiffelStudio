note
	description: "Summary description for {ICOR_DEBUG_FACTORY_BRIDGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_FACTORY_BRIDGE

inherit
	ICOR_EXPORTER

	ICOR_DEBUG_FACTORY_I

feature -- Bridge

	icor_debug_factory: detachable ICOR_DEBUG_FACTORY_I
		deferred
		end

feature {ICOR_EXPORTER} -- Factory

	new_md_import (p: POINTER): ICOR_MD_IMPORT
		do
			check attached icor_debug_factory as f then
				Result := f.new_md_import (p)
			end
		end

	new_controller (p: POINTER): ICOR_DEBUG_CONTROLLER
		do
			check attached icor_debug_factory as f then
				Result := f.new_controller (p)
			end
		end

	new_assembly (p: POINTER): ICOR_DEBUG_ASSEMBLY
		do
			check attached icor_debug_factory as f then
				Result := f.new_assembly (p)
			end
		end

	new_app_domain (p: POINTER): ICOR_DEBUG_APP_DOMAIN
		do
			check attached icor_debug_factory as f then
				Result := f.new_app_domain (p)
			end
		end

	new_module (p: POINTER): ICOR_DEBUG_MODULE
		do
			check attached icor_debug_factory as f then
				Result := f.new_module (p)
			end
		end

	new_class (p: POINTER): ICOR_DEBUG_CLASS
		do
			check attached icor_debug_factory as f then
				Result := f.new_class (p)
			end
		end

	new_chain (p: POINTER): ICOR_DEBUG_CHAIN
		do
			check attached icor_debug_factory as f then
				Result := f.new_chain (p)
			end
		end

	new_code (p: POINTER): ICOR_DEBUG_CODE
		do
			check attached icor_debug_factory as f then
				Result := f.new_code (p)
			end
		end

	new_function (p: POINTER): ICOR_DEBUG_FUNCTION
		do
			check attached icor_debug_factory as f then
				Result := f.new_function (p)
			end
		end

	new_thread (p: POINTER): ICOR_DEBUG_THREAD
		do
			check attached icor_debug_factory as f then
				Result := f.new_thread (p)
			end
		end

	new_register_set (p: POINTER): ICOR_DEBUG_REGISTER_SET
		do
			check attached icor_debug_factory as f then
				Result := f.new_register_set (p)
			end
		end

	new_frame (p: POINTER): ICOR_DEBUG_FRAME
		do
			check attached icor_debug_factory as f then
				Result := f.new_frame (p)
			end
		end

	new_native_frame (p: POINTER): ICOR_DEBUG_NATIVE_FRAME
		do
			check attached icor_debug_factory as f then
				Result := f.new_native_frame (p)
			end
		end

	new_il_frame (p: POINTER): ICOR_DEBUG_IL_FRAME
		do
			check attached icor_debug_factory as f then
				Result := f.new_il_frame (p)
			end
		end

	new_stepper (p: POINTER): ICOR_DEBUG_STEPPER
		do
			check attached icor_debug_factory as f then
				Result := f.new_stepper (p)
			end
		end

	new_function_breakpoint (p: POINTER): ICOR_DEBUG_FUNCTION_BREAKPOINT
		do
			check attached icor_debug_factory as f then
				Result := f.new_function_breakpoint (p)
			end
		end

	new_breakpoint (p: POINTER): ICOR_DEBUG_BREAKPOINT
		do
			check attached icor_debug_factory as f then
				Result := f.new_breakpoint (p)
			end
		end

	new_module_breakpoint (p: POINTER): ICOR_DEBUG_MODULE_BREAKPOINT
		do
			check attached icor_debug_factory as f then
				Result := f.new_module_breakpoint (p)
			end
		end

	new_value_breakpoint (p: POINTER): ICOR_DEBUG_VALUE_BREAKPOINT
		do
			check attached icor_debug_factory as f then
				Result := f.new_value_breakpoint (p)
			end
		end

	new_eval (p: POINTER): ICOR_DEBUG_EVAL
		do
			check attached icor_debug_factory as f then
				Result := f.new_eval (p)
			end
		end

	new_process (p: POINTER): ICOR_DEBUG_PROCESS
		do
			check attached icor_debug_factory as f then
				Result := f.new_process (p)
			end
		end

feature -- Value		

	new_value (p: POINTER): ICOR_DEBUG_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_value (p)
			end
		end

	new_handle_value (p: POINTER): ICOR_DEBUG_HANDLE_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_handle_value (p)
			end
		end

	new_generic_value (p: POINTER): ICOR_DEBUG_GENERIC_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_generic_value (p)
			end
		end

	new_array_value (p: POINTER): ICOR_DEBUG_ARRAY_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_array_value (p)
			end
		end

	new_box_value (p: POINTER): ICOR_DEBUG_BOX_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_box_value (p)
			end
		end

	new_reference_value (p: POINTER): ICOR_DEBUG_REFERENCE_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_reference_value (p)
			end
		end

	new_string_value (p: POINTER): ICOR_DEBUG_STRING_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_string_value (p)
			end
		end

	new_object_value (p: POINTER): ICOR_DEBUG_OBJECT_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_object_value (p)
			end
		end

	new_heap_value (p: POINTER): ICOR_DEBUG_HEAP_VALUE
		do
			check attached icor_debug_factory as f then
				Result := f.new_heap_value (p)
			end
		end

	new_heap_value2 (p: POINTER): ICOR_DEBUG_HEAP_VALUE2
		do
			check attached icor_debug_factory as f then
				Result := f.new_heap_value2 (p)
			end
		end

feature -- Enum	

	new_enum (p: POINTER): ICOR_DEBUG_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_enum (p)
			end
		end

	new_frame_enum (p: POINTER): ICOR_DEBUG_FRAME_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_frame_enum (p)
			end
		end

	new_stepper_enum (p: POINTER): ICOR_DEBUG_STEPPER_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_stepper_enum (p)
			end
		end

	new_breakpoint_enum (p: POINTER): ICOR_DEBUG_BREAKPOINT_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_breakpoint_enum (p)
			end
		end

	new_assembly_enum (p: POINTER): ICOR_DEBUG_ASSEMBLY_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_assembly_enum (p)
			end
		end

	new_app_domain_enum (p: POINTER): ICOR_DEBUG_APP_DOMAIN_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_app_domain_enum (p)
			end
		end

	new_module_enum (p: POINTER): ICOR_DEBUG_MODULE_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_module_enum (p)
			end
		end

	new_chain_enum (p: POINTER): ICOR_DEBUG_CHAIN_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_chain_enum (p)
			end
		end

	new_value_enum (p: POINTER): ICOR_DEBUG_VALUE_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_value_enum (p)
			end
		end

	new_thread_enum (p: POINTER): ICOR_DEBUG_THREAD_ENUM
		do
			check attached icor_debug_factory as f then
				Result := f.new_thread_enum (p)
			end
		end

end

