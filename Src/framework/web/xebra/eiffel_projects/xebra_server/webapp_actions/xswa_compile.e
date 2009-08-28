note
	description: "[
		Deferred class for compiling actions.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XSWA_COMPILE

inherit
	XS_WEBAPP_ACTION


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.	
		do
			create error_output_cache.make_empty
		ensure
			error_output_cache_attached: error_output_cache /= Void
		end

feature {NONE} -- Access

	needs_cleaning: BOOLEAN assign set_needs_cleaning
			-- Can be used to force the action to execute and add -clean option to compilation

	error_output_cache: STRING
			-- Stores the current output from error output to be displayed delayed.

feature -- Status setting

	set_needs_cleaning (a_needs_cleaning: like needs_cleaning)
			-- Setts needs_cleaning
		do
			needs_cleaning := a_needs_cleaning
		ensure
			needs_cleaning_set: needs_cleaning ~ a_needs_cleaning
		end

feature {NONE} -- Agents

	compile_process_exited
			-- Is executed when the compilation process has exited
		do
			set_running (False)
			set_needs_cleaning (False)
			if is_successful then
				execute_next_action
			else
				log.eprint (error_output_cache, generating_type)
			end
		end

	handle_compile_output (a_string: STRING)
			-- Adds output to `error_output_cache' or prints
		do
			if log.debug_level >= log.debug_subtasks then
				log.dprint (a_string, log.debug_subtasks)
			else
				error_output_cache.append (a_string)
			end
		end

invariant
	error_output_cache_attached: error_output_cache /= Void
note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
