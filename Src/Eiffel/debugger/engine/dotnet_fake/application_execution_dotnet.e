note
	description	: "Controls execution of debugged application under dotnet."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class APPLICATION_EXECUTION_DOTNET

inherit
	APPLICATION_EXECUTION

create {DEBUGGER_MANAGER}
	make_with_debugger

feature {NONE} -- Ancestor facade

	build_status do end
	impl_check_assert (b: BOOLEAN): BOOLEAN do end
	impl_ignore_current_assertion_violation (b: BOOLEAN): BOOLEAN do end
	run_with_env_string (app, args, cwd: STRING; env: STRING_GENERAL) do end
	continue_ignoring_kept_objects do end
	interrupt do end
	notify_breakpoints_change do end
	kill do  end
	keep_only_objects (kept_objects: LIST [DBG_ADDRESS]) do end

	dump_value_at_address_with_class (a_addr: DBG_ADDRESS; a_cl: CLASS_C): DUMP_VALUE do end
	debug_value_at_address_with_class (a_addr: DBG_ADDRESS; a_cl: CLASS_C): ABSTRACT_DEBUG_VALUE do  end
	onces_values (flist: LIST [E_FEATURE]; a_addr: DBG_ADDRESS; a_cl: CLASS_C): ARRAY [ABSTRACT_DEBUG_VALUE] do  end

	imp_remote_rt_object: ABSTRACT_REFERENCE_VALUE do end
	set_application_breakpoint (loc: BREAKPOINT_LOCATION) do end
	unset_application_breakpoint (loc: BREAKPOINT_LOCATION) do end
	set_catcall_detection_mode (a_console, a_dbg: BOOLEAN) do end


feature -- Client facade

	get_exception_value_details (e: EXCEPTION_DEBUG_VALUE; a_details_level: INTEGER) do end

	remote_current_exception_value: EXCEPTION_DEBUG_VALUE do end

	callback_notification_processing: BOOLEAN do end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class APPLICATION_EXECUTION_DOTNET
