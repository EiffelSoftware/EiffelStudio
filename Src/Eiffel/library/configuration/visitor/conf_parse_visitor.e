indexing
	description: "Visitor that parses all needed configuration files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PARSE_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		export
			{NONE} process_system
		redefine
			process_target,
			process_library,
			process_precompile
		end

	CONF_ACCESS

	CONF_CONSTANTS
		export
			{NONE} all
		end

create
	make_build

feature {NONE} -- Initialization

	make_build (a_state: like state; an_application_target: like application_target; a_factory: like factory) is
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory
			make (a_state)
			create libraries.make (Libraries_per_target)
			application_target := an_application_target
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_pre: CONF_PRECOMPILE
		do
			if not is_error then
					-- set application target
				a_target.system.set_application_target (application_target)
					-- set all libraries
				a_target.set_all_libraries (libraries)

					-- if it is the library or application target, add the target to the libraries
				if a_target = a_target.system.library_target or a_target = application_target then
					libraries.force (a_target, a_target.system.uuid)
				end

				l_pre := a_target.precompile
				if l_pre /= Void then
					l_pre.process (Current)
				end

				a_target.libraries.linear_representation.do_if (agent {CONF_LIBRARY}.process (Current), agent {CONF_LIBRARY}.is_enabled (state))
			end
		ensure then
			all_libraries_set: not is_error implies a_target.all_libraries /= Void
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		local
			l_target: CONF_TARGET
			l_load: CONF_LOAD
			l_uuid: UUID
			l_path: STRING
		do
			if not is_error then
				l_path := a_library.location.evaluated_path
				create l_load.make (factory)
				l_load.retrieve_uuid (l_path)
				if l_load.is_error then
					add_error (l_load.last_error)
				else
					l_uuid := l_load.last_uuid
					l_target := libraries.item (l_uuid)
					if l_target /= Void then
						a_library.set_library_target (l_target)
						a_library.set_uuid (l_uuid)
						if a_library.options.is_warning_enabled (w_same_uuid) and not l_path.is_case_insensitive_equal (l_target.system.file_name) then
							add_warning (create {CONF_ERROR_UUIDFILE}.make (l_path, l_target.system.file_name))
						end
					else
						l_load.retrieve_configuration (l_path)
						if l_load.is_error then
							add_error (l_load.last_error)
						else
							l_load.last_system.set_application_target (application_target)
							l_target := l_load.last_system.library_target

							if l_target = Void then
								add_error (create {CONF_ERROR_NOLIB}.make (a_library.name))
							else
									-- set environment to our global environment
								l_target.set_environ_variables (application_target.environ_variables)

								check
									uuid_correct: l_uuid.is_equal (l_target.system.uuid)
								end
								libraries.force (l_target, l_uuid)

								l_target.process (Current)
								a_library.set_library_target (l_target)
								a_library.set_uuid (l_uuid)
							end
						end
					end
				end
			end
		ensure then
			uuid_set: not is_error implies a_library.uuid /= Void
			target_set: not is_error implies a_library.library_target /= Void
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		local
			l_libs: like libraries
		do
				-- if precompile has all_libraries set, use those
			if a_precompile.library_target /= Void then
				l_libs := a_precompile.library_target.all_libraries
			end
			if l_libs /= Void then
				libraries.merge (l_libs)
			end
			process_library (a_precompile)
		end

feature {NONE} -- Implementation

	factory: CONF_FACTORY
			-- Factory to use for creation of new nodes.

	application_target: CONF_TARGET
			-- The application target of the system.

	libraries: HASH_TABLE [CONF_TARGET, UUID]
			-- Mapping of processed library targets, mapped with their uuid.

feature {NONE} -- Size constants

	Groups_per_system: INTEGER is 100
			-- How many groups do we have per average system.

	Libraries_per_target: INTEGER is 5
			-- How many libraries do we have per average target.

invariant
	libraries_not_void: libraries /= Void
	application_target_not_void: application_target /= Void
	factory_not_void: factory /= Void

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
