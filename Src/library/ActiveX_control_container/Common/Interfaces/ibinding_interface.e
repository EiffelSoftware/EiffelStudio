note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IBINDING_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	abort_user_precondition: BOOLEAN
			-- User-defined preconditions for `abort'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	suspend_user_precondition: BOOLEAN
			-- User-defined preconditions for `suspend'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	resume_user_precondition: BOOLEAN
			-- User-defined preconditions for `resume'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_priority_user_precondition (n_priority: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_priority'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_priority_user_precondition (pn_priority: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `get_priority'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_bind_result_user_precondition (pclsid_protocol: ECOM_GUID; pdw_result: INTEGER_REF; psz_result: CELL [STRING]; dw_reserved: INTEGER): BOOLEAN
			-- User-defined preconditions for `get_bind_result'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	abort
			-- No description available.
		require
			abort_user_precondition: abort_user_precondition
		deferred

		end

	suspend
			-- No description available.
		require
			suspend_user_precondition: suspend_user_precondition
		deferred

		end

	resume
			-- No description available.
		require
			resume_user_precondition: resume_user_precondition
		deferred

		end

	set_priority (n_priority: INTEGER)
			-- No description available.
			-- `n_priority' [in].  
		require
			set_priority_user_precondition: set_priority_user_precondition (n_priority)
		deferred

		end

	get_priority (pn_priority: INTEGER_REF)
			-- No description available.
			-- `pn_priority' [out].  
		require
			non_void_pn_priority: pn_priority /= Void
			get_priority_user_precondition: get_priority_user_precondition (pn_priority)
		deferred

		end

	get_bind_result (pclsid_protocol: ECOM_GUID; pdw_result: INTEGER_REF; psz_result: CELL [STRING]; dw_reserved: INTEGER)
			-- No description available.
			-- `pclsid_protocol' [out].  
			-- `pdw_result' [out].  
			-- `psz_result' [out].  
			-- `dw_reserved' [in].  
		require
			non_void_pclsid_protocol: pclsid_protocol /= Void
			valid_pclsid_protocol: pclsid_protocol.item /= default_pointer
			non_void_pdw_result: pdw_result /= Void
			non_void_psz_result: psz_result /= Void
			get_bind_result_user_precondition: get_bind_result_user_precondition (pclsid_protocol, pdw_result, psz_result, dw_reserved)
		deferred

		ensure
			valid_psz_result: psz_result.item /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IBINDING_INTERFACE

