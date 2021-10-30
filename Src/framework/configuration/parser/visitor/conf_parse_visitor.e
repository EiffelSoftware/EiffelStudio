note
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

	CONF_PARSER_CONTROLLER

create
	make_build

feature {NONE} -- Initialization

	make_build (a_state: like state; an_application_target: like application_target; a_factory: like factory)
			-- Create.
		require
			a_state_not_void: a_state /= Void
			an_application_target_not_void: an_application_target /= Void
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory
			make (a_state)
			create libraries.make (20)
			create processed_targets.make (20)
			application_target := an_application_target

				-- add the application target to the libraries list
			libraries.force ([application_target, application_target], application_target.system.uuid)
			processed_targets.force (application_target)
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET)
			-- Visit `a_target'.
		local
			l_libs: HASH_TABLE [CONF_TARGET, UUID]
		do
			if not is_error then
					-- TODO: check if it makes sense to set the application target for a remote parent target.

					-- set application target
				a_target.system.set_application_target (application_target)

				if attached a_target.precompile as p and then p.is_enabled (state) then
					p.process (Current)
				end

				across
					a_target.libraries as ic
				loop
					if ic.is_enabled (state) then
						ic.process (Current)
					end
				end

					-- set `all_libraries' from `libraries' but discarding the
					-- parent information which is only used internally to report nice errors.
				create l_libs.make (libraries.count)
				across libraries as l_library loop
					l_libs.put (l_library.base, @ l_library.key)
				end
				a_target.system.set_all_libraries (l_libs)

					-- Also parse remaining info for remote parents (such as libraries...)!
				if
					attached a_target.parent_reference as l_parent_ref and then
					attached a_target.extends as l_extends
				then
					l_extends.process (Current)
				end
			end
		ensure then
			all_libraries_set: not is_error implies a_target.system.all_libraries /= Void
			fully_parsed: not is_error implies a_target.system.is_fully_parsed
		rescue
			if
				attached exception_manager.last_exception as e and then
				attached {CONF_EXCEPTION} e.original
			then
				retry
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		local
			l_existing_target: detachable TUPLE [parent, base: CONF_TARGET]
			l_target: detachable CONF_TARGET
			l_load: CONF_LOAD
			l_uuid: detachable UUID
			l_path: like {CONF_LIBRARY}.path
			l_cond: CONF_CONDITION
			l_last_warnings: like last_warnings
		do
			l_path := a_library.path
			create l_load.make (factory)
			l_load.set_parent_target (application_target)
			l_load.retrieve_uuid (l_path)
			if attached l_load.last_error as l_load_last_error then
				if attached {CONF_ERROR_FILE} l_load_last_error as l_ferr then
					l_ferr.set_config (a_library.target.system.file_name)
					l_ferr.set_original_file (a_library.location.original_path)
				end
				if is_ignore_bad_libraries then
						-- Add the warning.
					l_last_warnings := last_warnings
					if l_last_warnings = Void then
						last_warnings := l_load.last_warnings
					elseif attached l_load.last_warnings as l_load_last_warnings then
						l_last_warnings.append (l_load_last_warnings)
					end
					add_warning (l_load_last_error)

						-- Now continue as if the library was not included by creating this
						-- compiler specific condition which is always false (as if library was excluded
						-- from current build).
					create l_cond.make
					l_cond.add_custom ("backup_ignore_bad_library", "false", create {CONF_CONDITION_CUSTOM_ATTRIBUTES})
					a_library.set_conditions (Void)
					a_library.add_condition (l_cond)
				else
					add_and_raise_error (l_load_last_error)
				end
			else
				check l_load_has_no_error: not l_load.is_error end

					-- add warnings
				if l_load.is_warning then
					l_last_warnings := last_warnings
					if l_last_warnings = Void then
						last_warnings := l_load.last_warnings
					elseif attached l_load.last_warnings as l_load_last_warnings then
						l_last_warnings.append (l_load_last_warnings)
					end
				end

				l_uuid := l_load.last_uuid
				if l_uuid /= Void then
					l_existing_target := libraries.item (l_uuid)
				end
				if l_existing_target /= Void then
					a_library.set_library_target (l_existing_target.base)
					if level + 1 < l_existing_target.base.system.level then
						l_existing_target.base.system.set_level (level + 1)
					end

					if
						application_target.options.is_warning_enabled (w_same_uuid) and then
						not (create {PATH}.make_from_string (l_path)).is_same_file_as (l_existing_target.base.system.file_path)
					then
							-- Check for redirection cases.
						if
							attached l_load.last_redirected_location as l_new_path and then
							l_new_path.is_same_file_as (l_existing_target.base.system.file_path)
						then
								-- Ok same final file, as it is an ecf redirection.
						else
							add_warning (create {CONF_ERROR_UUIDFILE}.make (a_library.target.system.file_name, l_path, l_existing_target.parent.system.file_name, l_existing_target.base.system.file_name))
						end
					end
				else
					l_load.retrieve_configuration (l_path)
					if attached l_load.last_error as l_load_last_error then
						check is_error: l_load.is_error end
						add_and_raise_error (l_load_last_error)
					elseif attached l_load.last_system as l_last_system then
						l_last_system.set_application_target (application_target)
						l_target := l_last_system.library_target

						if l_target = Void then
							add_and_raise_error (create {CONF_ERROR_NOLIB}.make (a_library.name))
						else
							if l_target.precompile /= Void and then not a_library.is_precompile then
								add_and_raise_error (create {CONF_ERROR_PREINLIB}.make (a_library.name))
							else
									-- set environment to our global environment
								l_target.set_environ_variables (application_target.environ_variables)

								if l_uuid /= Void then
										-- Implied by not `l_load.is_error'
									libraries.force ([a_library.target, l_target], l_uuid)
								else
									add_and_raise_error (create {CONF_ERROR_UUID})
								end
								processed_targets.force (l_target)

								level := level + 1
								a_library.set_library_target (l_target)
								l_target.system.set_level (level)
								l_target.process (Current)
								level := level - 1
							end
						end
					else
						check no_error_implies_has_system: False end
					end
				end
			end
		ensure then
			target_set: (not is_error and not is_ignore_bad_libraries) implies a_library.library_target /= Void
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
				-- if precompile has all_libraries set, use those
			if
				attached a_precompile.library_target as l_precomp_target and then
				attached l_precomp_target.system.all_libraries as l_libs
			then
				across
					l_libs as l
				loop
					l.system.set_application_target (application_target)
					libraries.force ([application_target, l], @ l.key)
					processed_targets.force (l)
				end
			end
			process_library (a_precompile)
		end

feature -- Access

	processed_targets: SEARCH_TABLE [CONF_TARGET]
			-- Process targets

feature {NONE} -- Implementation

	factory: CONF_PARSE_FACTORY
			-- Factory to use for creation of new nodes.

	application_target: CONF_TARGET
			-- The application target of the system.

	libraries: HASH_TABLE [TUPLE [parent, base: CONF_TARGET], UUID]
			-- Mapping of processed library targets, mapped with their uuid.

	level: NATURAL_32
			-- Current system level (application itself is 0, libraries of application 1, ...)

invariant
	libraries_not_void: libraries /= Void
	application_target_not_void: application_target /= Void
	factory_not_void: factory /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
end
