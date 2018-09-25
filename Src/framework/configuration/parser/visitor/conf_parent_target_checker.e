note
	description: "Check the validity of parent target (detect cycle, and missing target)."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PARENT_TARGET_CHECKER

inherit
	CONF_ACCESS

create
	make,
	make_with_observer

feature {NONE} -- Creation

	make (fac: like factory)
			-- Build current checker.
		do
			factory := fac
			create targets.make (0)
		ensure
			error_reported_as_error: error_reported_as_error
		end

	make_with_observer (fac: like factory; o: CONF_ERROR_OBSERVER)
			-- Build Current checker, and associate with observer `o`,
			-- and report error (if any) to observer `o`.
		do
			observer := o
			make (fac)
		end

feature -- Access	

	factory: CONF_PARSE_FACTORY

	observer: detachable CONF_ERROR_OBSERVER

	report_conf_error (e: CONF_ERROR)
		do
			last_error := e
			if attached observer as obs then
				if error_reported_as_warning then
					obs.report_warning (e)
				else
					obs.report_error (e)
				end
			end
		ensure
			has_error: has_error
			last_error_set: last_error /= Void
		end

feature -- Access		

	has_error: BOOLEAN
		do
			Result := last_error /= Void
		end

	last_error: detachable CONF_ERROR

feature -- Settings

	error_reported_as_warning: BOOLEAN
			-- Error reported as warning?

	error_reported_as_error: BOOLEAN
			-- Error reported as error?
		do
			Result := not error_reported_as_warning
		end

	report_issue_as_warning
		do
			error_reported_as_warning := True
		end

	report_issue_as_error
		do
			error_reported_as_warning := False
		end

feature -- Basic operation

	check_target (a_target: CONF_TARGET)
			-- Check target `a_target` for parent target validity, especially remote parent target issues.
		do
			reset
			process_target (a_target)
		end

	resolve_system (a_system: CONF_SYSTEM)
			-- Check all target from `a_system` for parent target validity, especially remote parent target issues,
			-- and update the `CONF_TARGET.extends` attribute with resolved remote target.
		do
			reset
			across
				a_system.targets as ic
			until
				has_error
			loop
				process_target (ic.item)
			end
		end

feature {NONE} -- Execution

	reset
		do
			targets.wipe_out
			last_error := Void
		ensure
			no_target_recorded: targets.count = 0
			no_error: last_error = Void
			has_no_error: not has_error
		end

	process_target (a_target: CONF_TARGET)
			-- Check validity of remote parent `CONF_TARGET.remote_parent` and report any issue,
			-- and update the `CONF_TARGET.extends` attribute.
		local
			cfg: CONF_SYSTEM
			tgt, par: detachable CONF_TARGET
			loc: CONF_FILE_LOCATION
			l_load: CONF_LOAD
		do
			tgt := a_target
			cfg := a_target.system
			if has_target (tgt) then
					-- Cycle
				report_conf_error (create {CONF_ERROR_CYCLE_IN_PARENTS}.make (tgt, targets))
			elseif attached tgt.extends as p_tgt then
				enter_target (tgt)
				process_target (p_tgt)
				leave_target (tgt)
			elseif attached tgt.parent_reference as l_parent_ref then
				enter_target (tgt)
				if attached {CONF_REMOTE_TARGET_REFERENCE} l_parent_ref as l_remote then
						-- Remote parent
					loc := factory.new_file_location_from_path (l_remote.location, tgt)
					create l_load.make (factory)
					l_load.retrieve_configuration (loc.evaluated_path.name) -- Follow redirection.
					if attached l_load.last_error as err then
						report_conf_error (err)
					end
					if not has_error and attached l_load.last_system as l_remote_cfg then
						if attached l_remote.name as l_parent_name then
							par := l_remote_cfg.target (l_parent_name)
						else
							par := l_remote_cfg.library_target
						end
						if par = Void then
							report_conf_error (create {CONF_ERROR_PARSE}.make ({STRING_32} "Unable to find parent target of '" + tgt.name + {STRING_32} "' (" + tgt.system.file_path.name + {STRING_32} ")!"))
						else
							tgt.set_remote_parent (par)
							process_target (par)
							if attached l_load.last_error as err then
								report_conf_error (err)
							end
						end
					else
							-- Due to `l_load.recursive_retrieve_configuration` "no_error_implies_last_system_not_void" postcondition.
						check is_error: has_error end
					end
				elseif attached {CONF_LOCAL_TARGET_REFERENCE} l_parent_ref as l_local_parent then
						-- Local parent, eventually declared after `tgt`.
					if attached cfg.target (l_local_parent.name) as p then
						tgt.set_parent (p)
					else
						report_conf_error (create {CONF_ERROR_PARSE}.make ({STRING_32} "Unable to find parent target '" + l_local_parent.name + "' of '" + tgt.name + {STRING_32} "' !"))
					end
				else
					check should_not_occur: False end
				end
				leave_target (tgt)
			end
		end

feature {NONE} -- Access: parent target

	targets: ARRAYED_LIST [CONF_TARGET]
			-- structure containing current processed target, and eventual parents.

	has_target (tgt: CONF_TARGET): BOOLEAN
		do
			across
				targets as ic
			until
				Result
			loop
				if tgt.same_as (ic.item) then
					Result := True
				end
			end
		end

feature {NONE} -- Events

	enter_target (t: CONF_TARGET)
		do
			targets.force (t)
		end

	leave_target (t: CONF_TARGET)
		local
			lst: like targets
		do
			lst := targets
			if
				lst.last = t
			then
				lst.finish
				lst.remove
			else
				check is_created: False end
			end
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
