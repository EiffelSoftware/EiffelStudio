indexing
	description: "Iterator that iterates through a configuration, looking only at objects that are enabled for the current platform/build."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITIONED_ITERATOR

inherit
	CONF_VISITOR

	CONF_ITERATOR
		redefine
			process_target
		end

create
	make

feature {NONE} -- Initialization

	make (a_state: like state) is
			-- Create.
		require
			a_state_not_void: a_state /= Void
		do
			state := a_state
		ensure
			state_set: state = a_state
		end

feature -- Access

	state: CONF_STATE
			-- Current state.

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_pre: CONF_PRECOMPILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_pre := a_target.precompile
				if l_pre /= Void and then l_pre.is_enabled (state) then
					a_target.precompile.process (Current)
				end
				a_target.libraries.linear_representation.do_if (agent {CONF_LIBRARY}.process (Current), agent {CONF_LIBRARY}.is_enabled (state))
				a_target.assemblies.linear_representation.do_if (agent {CONF_ASSEMBLY}.process (Current), agent {CONF_ASSEMBLY}.is_enabled (state))
				a_target.clusters.linear_representation.do_if (agent {CONF_CLUSTER}.process (Current), agent {CONF_CLUSTER}.is_enabled (state))
					-- overrides must be processed at the end
				a_target.overrides.linear_representation.do_if (agent {CONF_OVERRIDE}.process (Current), agent {CONF_OVERRIDE}.is_enabled (state))
			end
		rescue
			if {lt_ex: CONF_EXCEPTION}exception_manager.last_exception.original then
				l_retried := True
				retry
			end
		end

invariant
	state_not_void: state /= Void

indexing
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
end
