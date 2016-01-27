note
	description: "[
		Application to generate void-safe and non void-safe version of ECFs 
		using the configuration library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ECF_VOIDSAFE

inherit
	ANY

	ECF_SHARED_CONF_HELPERS

	CONF_ACCESS

	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make (args: ECF_VOIDSAFE_ARGUMENT_PARSER)
			-- Application entry point
		do
			start (args)
		end

feature {NONE} -- Execution

	start (a_options: ECF_VOIDSAFE_ARGUMENT_PARSER)
			-- Starts application once all arguments have been parsed.
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			dv: ECF_DIRECTORY_CUSTOM_ITERATOR
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_eprinter: ERROR_CUI_PRINTER
		do
				-- Settings
			is_verbose := not a_options.is_quiet
			is_simulation := a_options.is_simulation
			is_updating_to_voidsafe_all := a_options.is_updating_to_voidsafe_all
			is_updating_to_voidsafe_none := a_options.is_updating_to_voidsafe_none
			is_generating_both_voidsafe_files := a_options.is_generating_both_voidsafe_files

			if is_simulation then
				print ("Simulation mode.%N")
			end

				-- Add specified files
			create l_files.make (0)
			across
				a_options.files as ic
			loop
				l_files.force (ic.item)
			end

				-- Add scanned directories
			create dv.make (agent (ia_fn: PATH; ia_files: LIST [READABLE_STRING_32])
					do
						ia_files.force (ia_fn.name)
					end (?, l_files)
				)
			if not a_options.use_directory_recusion then
				dv.set_directory_excluded_function (agent (ia_fn: PATH): BOOLEAN
						do
							Result := True -- no recursion!
						end
					)
			end
			across
				a_options.directories as ic
			loop
				dv.process_directory (create {PATH}.make_from_string (ic.item))
			end

			if l_files.is_empty then
					-- No files or directories, use current directory
				dv.process_directory (execution_environment.current_working_path)
			end

				-- Resave files
			across
				l_files as ic
			loop
				process_config (ic.item)
			end

			if attached conf_helpers.error_handler as l_eh then
				create l_eprinter
				if l_eh.has_warnings then
					print ("%N")
					l_eh.trace_warnings (l_eprinter)
				end
				if not l_eh.is_successful then
					print ("%N")
					l_eh.trace_errors (l_eprinter)
					(create {EXCEPTIONS}).die (1)
				end
			end
		end

feature -- Settings

	is_verbose: BOOLEAN
	is_simulation: BOOLEAN
	is_updating_to_voidsafe_all: BOOLEAN
	is_updating_to_voidsafe_none: BOOLEAN
	is_generating_both_voidsafe_files: BOOLEAN

feature {NONE} -- Basic operations

	process_config (a_file_name: READABLE_STRING_32)
			-- Loads and resaves `a_file_name' using the configuration system.
		local
			fn: STRING_32
			tgt: detachable CONF_TARGET
			opts: CONF_OPTION
			fut: FILE_UTILITIES
			b: BOOLEAN
			l_is_voidsafe: BOOLEAN
		do
			if a_file_name /= Void and then not a_file_name.is_empty and then conf_helpers.is_file_readable (a_file_name) then
				if is_verbose then
					localized_print (a_file_name)
					print (" : ")
				end
				if attached {CONF_SYSTEM} config_system_from (a_file_name) as l_cfg then
					if is_updating_to_voidsafe_all then
						check not_unsafe_ecf_name: a_file_name.ends_with_general ("-unsafe.ecf") end
						if is_verbose then
							print ("update to complete void-safety ...")
						end
						update_config_to_voidsafe_all (l_cfg)
						if is_simulation then
							if is_verbose then
								print ("Simulated.%N")
							end
						else
							b := save_conf_file (l_cfg, a_file_name)
							if is_verbose then
								print (if b then "Done.%N" else "Failed!%N" end)
							end
						end
					elseif is_updating_to_voidsafe_none then
						check not_safe_ecf_name: a_file_name.ends_with_general ("-safe.ecf") end
						if is_verbose then
							print ("update to none void-safety ...")
						end
						update_config_to_voidsafe_none (l_cfg)
						if is_simulation then
							if is_verbose then
								print ("Simulated.%N")
							end
						else
							b := save_conf_file (l_cfg, a_file_name)
							if is_verbose then
								print (if b then "Done.%N" else "Failed!%N" end)
							end
						end
					elseif is_generating_both_voidsafe_files then
						tgt := l_cfg.library_target
						l_is_voidsafe := True
						if tgt = Void and then not l_cfg.target_order.is_empty then
							tgt := l_cfg.target_order.first
						end
						if tgt /= Void then
							opts := tgt.options
							l_is_voidsafe := opts.void_safety.index = opts.void_safety_index_all
												or opts.void_safety.index = opts.void_safety_index_transitional
						end
						if l_is_voidsafe then
							fn := non_void_safe_filename (a_file_name)
							if fut.file_exists (fn) then
								if similar_config (a_file_name, fn) then
									if is_verbose then
										print ("SKIPPED non Void-safe ecf already exists %"")
										localized_print (filename(fn))
										print ("%" !%N")
									end
								else
									print ("CONFLICT with existing non Void-safe ecf %"")
									localized_print (filename(fn))
									print ("%" !%N")
								end
							else
								if is_verbose then
									print ("CREATE non Void-safe ecf %"")
									localized_print (filename(fn))
									print ("%" ... ")
								end
								update_config_to_voidsafe_none (l_cfg)
								if is_simulation then
									if is_verbose then
										print ("Simulated.%N")
									end
								else
									b := save_conf_file (l_cfg, fn)
									if is_verbose then
										print (if b then "Done.%N" else "Failed!%N" end)
									end
								end
							end
						else
							fn := void_safe_filename (a_file_name)
							if fut.file_exists (fn) then
								if similar_config (a_file_name, fn) then
									if is_verbose then
										print ("SKIPPED Void-safe ecf already exists %"")
										localized_print (filename(fn))
										print ("%" !%N")
									end
								else
									print ("CONFLICT with existing Void-safe ecf %"")
									localized_print (filename(fn))
									print ("%" !%N")
								end
							else
								if is_verbose then
									print ("CREATE Void-safe ecf %"")
									localized_print (filename(fn))
									print ("%" ... ")
								end
								update_config_to_voidsafe_all (l_cfg)
								if is_simulation then
									if is_verbose then
										print ("Simulated.%N")
									end
								else
									b := save_conf_file (l_cfg, fn)
									if is_verbose then
										print (if b then "Done.%N" else "Failed!%N" end)
									end
								end
							end
						end
					else
						check known_operation: False end
					end
				else
					print ("Failed!%N")
				end
			else
				print ("Invalid file!%N")
			end
		end

	update_config_to_voidsafe_all (cfg: CONF_SYSTEM)
		local
			opts: CONF_OPTION
			tgt: CONF_TARGET
		do
			across
				cfg.targets as ic
			loop
				tgt := ic.item
				opts := tgt.options
				opts.set_is_attached_by_default (True)
				opts.void_safety.put_index (opts.void_safety_index_all)
				across
					tgt.libraries as libs
				loop
					if attached {CONF_FILE_LOCATION} libs.item.location as loc then
						loc.set_full_path (void_safe_location (loc))
					end
				end
				tgt.set_options (opts)
			end
		end

	update_config_to_voidsafe_none (cfg: CONF_SYSTEM)
		local
			opts: CONF_OPTION
			tgt: CONF_TARGET
		do
			across
				cfg.targets as ic
			loop
				tgt := ic.item
				opts := tgt.options
				opts.unset_is_attached_by_default
				opts.void_safety.put_index (opts.void_safety_index_none)
				across
					tgt.libraries as libs
				loop
					if attached {CONF_FILE_LOCATION} libs.item.location as loc then
						loc.set_full_path (non_void_safe_location (loc))
					end
				end
				tgt.set_options (opts)
			end
		end

	filename (fn: READABLE_STRING_GENERAL): STRING_32
		local
			p: PATH
		do
			create p.make_from_string (fn)
			if attached p.entry as e then
				Result := e.name
			else
				Result := p.name
			end
		end

	void_safe_location (loc: CONF_FILE_LOCATION): STRING_32
		do
			Result := void_safe_filename (loc.original_path)
		end

	void_safe_filename (fn: READABLE_STRING_32): STRING_32
		do
			if fn.ends_with_general ("-safe.ecf") then
				check already_void_safe: False end
				Result := fn
			else
				Result := fn.substring (1, fn.count - (".ecf").count) + {STRING_32} "-safe.ecf"
			end
		end

	non_void_safe_location (loc: CONF_FILE_LOCATION): STRING_32
		do
			Result := non_void_safe_filename (loc.original_path)
		end

	non_void_safe_filename (fn: READABLE_STRING_32): STRING_32
		do
			if fn.ends_with_general ("-safe.ecf") then
				Result := fn.substring (1, fn.count - ("-safe.ecf").count) + {STRING_32} ".ecf"
			else
				Result := fn.substring (1, fn.count - (".ecf").count) + {STRING_32} "-unsafe.ecf"
			end
		end

feature {NONE} -- Helpers

	similar_config (fn1, fn2: READABLE_STRING_GENERAL): BOOLEAN
		local
		do
			if
				attached {CONF_SYSTEM} conf_helpers.config_system_from (fn1) as sys1 and
				attached {CONF_SYSTEM} conf_helpers.config_system_from (fn2) as sys2
			then
				Result := similar_system (sys1, sys2)
			end
		end

	similar_system (cfg1, cfg2: CONF_SYSTEM): BOOLEAN
		do
			if
				cfg1.name ~ cfg2.name and
				cfg1.uuid ~ cfg2.uuid
			then
				if
					attached cfg1.library_target as tgt1 and
					attached cfg2.library_target as tgt2
				then
					Result := similar_target (tgt1, tgt2)
				else
						-- TODO: check each target.
				end
			end
		end

	similar_target (tgt1, tgt2: CONF_TARGET): BOOLEAN
		local
			g1, g2: detachable CONF_GROUP
			l_groups2: STRING_TABLE [CONF_GROUP]
		do
			if
				tgt1.name ~ tgt2.name
			then
				Result := True
				create l_groups2.make_caseless (0)
				across
					tgt2.groups as ic
				loop
					l_groups2.put (ic.item, ic.key)
				end
				across
					tgt1.groups as ic
				until
					not Result
				loop
					g1 := ic.item
					g2 := l_groups2.item (ic.key)
					if g2 = Void then
						Result := False
					elseif similar_location (g1.location, g2.location) then
						l_groups2.remove (ic.key)
					else
						Result := False
					end
				end
				if Result then
					Result := l_groups2.is_empty
				end
			end
		end

	similar_location (loc1, loc2: CONF_LOCATION): BOOLEAN
		local
			p1, p2: STRING_32
			lst: ARRAY [READABLE_STRING_GENERAL]
		do
			lst := <<"-safe.ecf", "-unsafe.ecf", ".ecf">>
			p1 := loc1.original_path
			p2 := loc2.original_path
			across
				lst as ic
			loop
				if p1.ends_with_general (ic.item) then
					p1.remove_tail (ic.item.count)
				end
				if p2.ends_with_general (ic.item) then
					p2.remove_tail (ic.item.count)
				end
			end
			Result := p1 ~ p2
		end

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
