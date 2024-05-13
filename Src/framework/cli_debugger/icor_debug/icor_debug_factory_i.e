note
	description: "Summary description for {ICOR_DEBUG_FACTORY_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_FACTORY_I

feature {ICOR_EXPORTER} -- Factory

	new_md_import (p: POINTER): ICOR_MD_IMPORT
		require
			not p.is_default_pointer
		deferred
		end

	new_controller (p: POINTER): ICOR_DEBUG_CONTROLLER
		require
			not p.is_default_pointer
		deferred
		end

	new_assembly (p: POINTER): ICOR_DEBUG_ASSEMBLY
		require
			not p.is_default_pointer
		deferred
		end

	new_app_domain (p: POINTER): ICOR_DEBUG_APP_DOMAIN
		require
			not p.is_default_pointer
		deferred
		end

	new_module (p: POINTER): ICOR_DEBUG_MODULE
		require
			not p.is_default_pointer
		deferred
		end

	new_class (p: POINTER): ICOR_DEBUG_CLASS
		require
			not p.is_default_pointer
		deferred
		end

	new_chain (p: POINTER): ICOR_DEBUG_CHAIN
		require
			not p.is_default_pointer
		deferred
		end

	new_code (p: POINTER): ICOR_DEBUG_CODE
		require
			not p.is_default_pointer
		deferred
		end

	new_function (p: POINTER): ICOR_DEBUG_FUNCTION
		require
			not p.is_default_pointer
		deferred
		end

	new_thread (p: POINTER): ICOR_DEBUG_THREAD
		require
			not p.is_default_pointer
		deferred
		end

	new_register_set (p: POINTER): ICOR_DEBUG_REGISTER_SET
		require
			not p.is_default_pointer
		deferred
		end

	new_frame (p: POINTER): ICOR_DEBUG_FRAME
		require
			not p.is_default_pointer
		deferred
		end

	new_native_frame (p: POINTER): ICOR_DEBUG_NATIVE_FRAME
		require
			not p.is_default_pointer
		deferred
		end

	new_il_frame (p: POINTER): ICOR_DEBUG_IL_FRAME
		require
			not p.is_default_pointer
		deferred
		end

	new_stepper (p: POINTER): ICOR_DEBUG_STEPPER
		require
			not p.is_default_pointer
		deferred
		end

	new_function_breakpoint (p: POINTER): ICOR_DEBUG_FUNCTION_BREAKPOINT
		require
			not p.is_default_pointer
		deferred
		end

	new_breakpoint (p: POINTER): ICOR_DEBUG_BREAKPOINT
		require
			not p.is_default_pointer
		deferred
		end

	new_module_breakpoint (p: POINTER): ICOR_DEBUG_MODULE_BREAKPOINT
		require
			not p.is_default_pointer
		deferred
		end

	new_value_breakpoint (p: POINTER): ICOR_DEBUG_VALUE_BREAKPOINT
		require
			not p.is_default_pointer
		deferred
		end

	new_eval (p: POINTER): ICOR_DEBUG_EVAL
		require
			not p.is_default_pointer
		deferred
		end

	new_process (p: POINTER): ICOR_DEBUG_PROCESS
		require
			not p.is_default_pointer
		deferred
		end

feature -- Value		

	new_value (p: POINTER): ICOR_DEBUG_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_handle_value (p: POINTER): ICOR_DEBUG_HANDLE_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_generic_value (p: POINTER): ICOR_DEBUG_GENERIC_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_array_value (p: POINTER): ICOR_DEBUG_ARRAY_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_box_value (p: POINTER): ICOR_DEBUG_BOX_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_reference_value (p: POINTER): ICOR_DEBUG_REFERENCE_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_string_value (p: POINTER): ICOR_DEBUG_STRING_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_object_value (p: POINTER): ICOR_DEBUG_OBJECT_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_heap_value (p: POINTER): ICOR_DEBUG_HEAP_VALUE
		require
			not p.is_default_pointer
		deferred
		end

	new_heap_value2 (p: POINTER): ICOR_DEBUG_HEAP_VALUE2
		require
			not p.is_default_pointer
		deferred
		end

feature -- Enum	

	new_enum (p: POINTER): ICOR_DEBUG_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_frame_enum (p: POINTER): ICOR_DEBUG_FRAME_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_stepper_enum (p: POINTER): ICOR_DEBUG_STEPPER_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_breakpoint_enum (p: POINTER): ICOR_DEBUG_BREAKPOINT_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_assembly_enum (p: POINTER): ICOR_DEBUG_ASSEMBLY_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_app_domain_enum (p: POINTER): ICOR_DEBUG_APP_DOMAIN_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_module_enum (p: POINTER): ICOR_DEBUG_MODULE_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_chain_enum (p: POINTER): ICOR_DEBUG_CHAIN_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_value_enum (p: POINTER): ICOR_DEBUG_VALUE_ENUM
		require
			not p.is_default_pointer
		deferred
		end

	new_thread_enum (p: POINTER): ICOR_DEBUG_THREAD_ENUM
		require
			not p.is_default_pointer
		deferred
		end

end
