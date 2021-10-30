note
	description: "Loads a configuration from a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD

inherit
	CONF_ACCESS

	SHARED_CONF_SETTING

create
	make

feature {NONE} -- Initialization

	make (a_factory: like factory)
			-- Create.
		require
			a_factory_not_void: a_factory /= Void
		do
			factory := a_factory

			is_following_redirection := True

				-- Initialize configuration lib setup, this is done once.
			initialize_conf_setting

				-- Refresh mapping in case it was updated since last configuration processing
			conf_location_mapper.refresh
		ensure
			factory_set: factory = a_factory
		end

feature -- Status

	is_error: BOOLEAN
			-- Was there an error during the retrieval?

	is_warning: BOOLEAN
			-- Were there warnings during the retrieval?

	is_invalid_xml: BOOLEAN
			-- Is the file not even valid xml?

	is_following_redirection: BOOLEAN
			-- Is loader following redirection?
			--| True by default

	last_error: detachable CONF_ERROR
			-- The last error message.

	last_warnings: detachable ARRAYED_LIST [CONF_ERROR]
			-- The last warning messages.

	last_warning_messages: detachable STRING_32
			-- Warning messages as a single string.
		do
			if attached last_warnings as l_last_warnings then
				create Result.make (20)
				across
					l_last_warnings as ic
				loop
					Result.append (ic.text)
					Result.append_character ('%N')
				end
			end
		end

feature -- Error changes

	report_error (e: detachable CONF_ERROR)
		require
			e_attached: e /= Void
		do
			is_error := True
			last_error := e
		end

	reset_error
		do
			is_error := False
			last_error := Void
		end

feature -- Access

	last_system: detachable CONF_SYSTEM
			-- The last retrieved system.
			--| note: the loading follows the redirection, so it may be the system after redirection.

	last_redirection: detachable CONF_REDIRECTION
			-- Last retrieved redirection.

	last_redirected_location: detachable PATH
			-- Last redirected location.

	last_uuid: detachable UUID
			-- The last retrieved uuid.

	parent_target: detachable CONF_TARGET
			-- Associated target, when loading a library ecf file for a target.

feature -- Element change

	set_parent_target (a_target: like parent_target)
			-- Set `parent_target` to `a_target`.
		do
			parent_target := a_target
		end

feature -- Basic operation

	retrieve_and_check_configuration (a_file: READABLE_STRING_32)
			-- Retrieve the configuration in `a_file' and make it available in `last_system'.
			-- Also report as warning any validity issue, and as error cycle in (non remote) parent target.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_parent_checker: CONF_PARENT_TARGET_CHECKER
			l_group_checker: CONF_GROUPS_TARGET_CHECKER
		do
			retrieve_configuration (a_file)
			if attached last_system as syst then
				if not is_error then
					create l_parent_checker.make (factory)
					l_parent_checker.report_issue_as_warning
					l_parent_checker.resolve_system (syst)
					if attached l_parent_checker.last_cycle_error as l_cycle_err then
						report_error (l_cycle_err)
					elseif attached l_parent_checker.last_error as err then
						is_warning := True
						add_warning (err)
					end
				end
				if not is_error then
					create l_group_checker.make
					l_group_checker.report_issue_as_warning
					l_group_checker.check_system (syst)
				end
			end
		ensure
			no_error_implies_last_system_not_void: not is_error implies last_system /= Void
		end

	retrieve_configuration (a_file: READABLE_STRING_32)
			-- Retrieve the configuration in `a_file' and make it available in `last_system'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		do
			last_system := Void
			last_redirection := Void
			last_redirected_location := Void
			last_warnings := Void
			reset_error
			recursive_retrieve_configuration (a_file, Void, Void)
		ensure
			no_error_implies_last_system_not_void: not is_error implies last_system /= Void
		end

	retrieve_uuid (a_file: READABLE_STRING_32)
			-- Retrieve the uuid of the configuration in `a_file' and make it available in `last_uuid'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		do
			last_redirection := Void
			last_redirected_location := Void
			last_uuid := Void
			last_warnings := Void
			reset_error
			recursive_retrieve_uuid (a_file, Void, Void)
		ensure
			no_error_implies_last_uuid_not_void: not is_error implies last_uuid /= Void
		end

	set_is_following_redirection (b: BOOLEAN)
			-- Set `is_following_redirection' to `b'.
		do
			is_following_redirection := b
		end

	add_warning (a_warning: CONF_ERROR)
			-- Add `a_warning'.
		require
			a_warning_not_void: a_warning /= Void
		local
			l_last_warnings: like last_warnings
		do
			l_last_warnings := last_warnings
			if l_last_warnings = Void then
				create l_last_warnings.make (1)
				last_warnings := l_last_warnings
			end
			l_last_warnings.extend (a_warning)
		end

feature {CONF_LOAD} -- Implementation

	recursive_retrieve_configuration (a_file: READABLE_STRING_32; ctx: detachable CONF_LOAD_CONTEXT; a_previous_redirection: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID])
			-- Retrieve the configuration in `a_file' and make it available in `last_system',
			-- it might occur inside an ecf redirection process.
			-- `ctx' is used to keep track of potential cycle in redirection.
			-- `a_previous_redirection' is used to carry the file+uuid of previous redirected file
			--     the `file' is used to report the error with the details of the various implied ecf files.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_callback: CONF_LOAD_PARSE_CALLBACKS
			l_context: detachable CONF_LOAD_CONTEXT
			l_previous: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID]
		do
			create l_callback.make_with_factory (a_file, factory)
			parse_file (a_file, l_callback)
			if l_callback.is_error then
				is_invalid_xml := l_callback.is_invalid_xml
				report_error (l_callback.last_error)
			elseif not is_error then
				last_system := l_callback.last_system
				l_context := ctx
				if l_context = Void then
					create l_context.make
				end

				if attached l_callback.last_redirection as l_redirection then
					if last_redirection = Void then
						last_redirection := l_redirection
						last_redirected_location := l_redirection.file_path
					end
						-- This means that `a_file' is a redirection, let's follow the new location
						-- if `l_redirection.redirection_location' is an absolute path, it will be used as is
						-- otherwise compute the path relative to the parent folder or a_file
					if attached l_redirection.uuid as l_new_location_uuid then
							--| `a_file' has a UUID, then let's check if it is already in a redirection chain, and if ever
							--| a UUID was previously set. If this is the case, if UUIDs are not the same
							--| report UUID mismatch error
						if
							a_previous_redirection /= Void and then a_previous_redirection.uuid /~ l_new_location_uuid
						then
								--| The previously recorded UUID and the UUID from the `a_file' does not match -> report error
							report_error (create {CONF_ERROR_UUID_MISMATCH_IN_REDIRECTION}.make (a_previous_redirection.file, a_file, a_previous_redirection.uuid, l_new_location_uuid))
						else
							if a_previous_redirection /= Void then
									--| Update previous redirection with new uuid, so that caller gets new data
									--| when the recursive redirection instructions are done
									--| note that `a_previous_redirection.uuid' should already be the same as `l_new_location_uuid'
									--| but let's assign it again, just in case.
								check a_previous_redirection.uuid ~ l_new_location_uuid end
								a_previous_redirection.file := a_file
								l_previous := a_previous_redirection
							else
									--| There was no previous data for redirection
									--| this means, either this is the first redirection in the chain
									--| or the previous redirection did not set the UUID value (which is optional)
								l_previous := [a_file, l_new_location_uuid]
							end
						end
					elseif a_previous_redirection /= Void then
							--| `a_file' does not have any UUID value
							--| and previous redirection had a UUID value
							--| follow the redirection and keep UUID from `a_previous_redirection'
							--| example:
							--|    [redirection a.ecf with UUID /= Void ]  ->  [redirection b.ecf with UUID = Void]
							--| then keep previous file+uuid record.
						l_previous := a_previous_redirection
					else
							--| `a_file' does not have any UUID, and no previous redirection has any UUID
							--| example:
							--|    [redirection a.ecf with UUID = Void ]  ->  [redirection b.ecf with UUID = Void]
							--| then do not record the file and uuid.
						l_previous := Void
					end
					if not is_error and is_following_redirection then
							--| `a_file' is a redirection, then follow the redirection and check the ecf at the new location
							--| this will either end with a concrete ecf file, i.e not a redirection, or with an error.
						if attached l_redirection.message as msg then
							retrieve_redirected_configuration (a_file, l_redirection.evaluated_redirection_location, l_previous, l_context)

							is_warning := True
							add_warning (create {CONF_ERROR_MESSAGE_IN_REDIRECTION}.make (a_file, l_redirection.redirection_location, msg))
						else
							retrieve_redirected_configuration (a_file, l_redirection.evaluated_redirection_location, l_previous, l_context)
						end
					end
				elseif attached last_system as l_last_system then
						--| found <system ... />
						--| i.e: no redirection
					l_last_system.set_file_name (a_file)
					l_last_system.set_file_date

						--| if `a_file' is the end of a redirection chain
						--| if there is a UUID mismatch, report error
					if a_previous_redirection /= Void and then a_previous_redirection.uuid /~ l_last_system.uuid then
						if l_last_system.is_generated_uuid then
								--| i.e `a_file' does not set any uuid, so it was internally set to new generated UUID.
							report_error (create {CONF_ERROR_UUID_MISMATCH_IN_REDIRECTION}.make (a_previous_redirection.file, a_file, a_previous_redirection.uuid, Void))
						else
							report_error (create {CONF_ERROR_UUID_MISMATCH_IN_REDIRECTION}.make (a_previous_redirection.file, a_file, a_previous_redirection.uuid, l_last_system.uuid))
						end
					end
				else
						--| `last_system' is Void AND `last_location' is also Void.
						--|
						--| This means that `a_file' does not have
						--|    <redirection ... location="..."/>
						--| and neither
						--|    <system ... location="..."/>
						--| This is not valid, then report the error
					l_callback.set_internal_error
					is_invalid_xml := l_callback.is_invalid_xml
					if attached l_callback.last_error as err then
						report_error (err)
							--| It could be "Tag %"system%" or %"redirection%" not found",
							--| but redirection should be used occasionally, so let's not confuse the user.
						err.set_message ("Tag %"system%" not found")
					else
						reset_error
					end
				end
			end
		ensure
			no_error_implies_last_system_not_void: not is_error implies last_system /= Void
		end

	recursive_retrieve_uuid (a_file: READABLE_STRING_32; a_redirections: detachable ARRAYED_LIST [PATH]; a_previous_redirection: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID])
			-- Retrieve the uuid of the configuration in `a_file' and make it available in `last_uuid',
			-- it might occur during an ecf redirection process.
			-- `a_redirections' is used to keep track of potential cycle in redirection.
			-- `a_previous_redirection' is used to carry the file+uuid of previous redirected file
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
		local
			l_callback: CONF_LOAD_UUID_CALLBACKS
			l_err: CONF_ERROR_UUID
			redir: detachable ARRAYED_LIST [PATH]
			l_previous: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID]
			l_redirected_location: like last_redirected_location
			l_file_parent: PATH
		do
			l_file_parent := (create {PATH}.make_from_string (a_file)).parent -- Directory location containing `a_file`.

			create l_callback.make_with_file (a_file)
			parse_file (a_file, l_callback)
			if attached l_callback.last_redirected_location as l_new_location then
				if attached parent_target as tgt then
					l_redirected_location := conf_redirection_location_for_file (
							factory.new_location_from_full_path (
									l_new_location.as_string_32,
									tgt
								).evaluated_path_relative_to_location (l_file_parent).name,
							a_file
						)
				else
					l_redirected_location := conf_redirection_location_for_file (l_new_location, a_file)
				end
				last_redirected_location := l_redirected_location
			end
			if l_callback.is_error then
				report_error (l_callback.last_error)
			elseif not is_error then
				if attached l_callback.last_uuid as l_new_location_uuid then
						--| `a_file' has a UUID, then let's check if it is already in a redirection chain, and if ever
						--| a UUID was previously set. If this is the case, if UUIDs are not the same
						--| report UUID mismatch error
					last_uuid := l_new_location_uuid
					if
						a_previous_redirection /= Void and then a_previous_redirection.uuid /~ l_new_location_uuid
					then
							--| The previously recorded UUID and the UUID from the `a_file' does not match -> report error
						report_error (create {CONF_ERROR_UUID_MISMATCH_IN_REDIRECTION}.make (a_previous_redirection.file, a_file, a_previous_redirection.uuid, l_new_location_uuid))
					else
						if a_previous_redirection /= Void then
								--| Update previous redirection with new uuid, so that caller gets new data
								--| when the recursive redirection instructions are done
								--| note that `a_previous_redirection.uuid' should already be the same as `l_new_location_uuid'
								--| but let's assign it again, just in case.
							check a_previous_redirection.uuid ~ l_new_location_uuid end
							a_previous_redirection.file := a_file
							l_previous := a_previous_redirection
						else
								--| There was no previous data for redirection
								--| this means, either this is the first redirection in the chain
								--| or the previous redirection did not set the UUID value (which is optional)
							l_previous := [a_file, l_new_location_uuid]
						end
					end
				else
						--| The uuid attribute is not set, which is accepted
					last_uuid := Void
					if a_previous_redirection /= Void then
							--| `a_file' does not have any UUID value
							--| and previous redirection had a UUID value
							--| follow the redirection and keep UUID from `a_previous_redirection'
							--| example:
							--|    [redirection a.ecf with UUID /= Void ]  ->  [redirection b.ecf with UUID = Void]
							--| then keep previous file+uuid record.
						l_previous := a_previous_redirection
					else
							--| `a_file' does not have any UUID, and no previous redirection has any UUID
							--| example:
							--|    [redirection a.ecf with UUID = Void ]  ->  [redirection b.ecf with UUID = Void]
							--| then do not record the file and uuid.
						l_previous := Void
					end
				end
				if not is_error then
					if attached l_callback.last_redirected_location as l_new_location then
							-- Warning: do not reuse `last_redirected_location`,
							--	as it is the first redirection, here we really care about `l_callback.last_redirected_location`.
						if attached parent_target as tgt then
							l_redirected_location := conf_redirection_location_for_file (
									factory.new_location_from_full_path (
											l_new_location.as_string_32,
											tgt
										).evaluated_path_relative_to_location (l_file_parent).name,
									a_file
								)
						else
							l_redirected_location := conf_redirection_location_for_file (l_new_location, a_file)
						end
							--| `a_file' is a redirection
							--| then check the ecf at the `l_new_location'
						redir := a_redirections
						if redir = Void then
							create redir.make (1)
						end
						if is_following_redirection then
							retrieve_redirected_uuid (a_file, l_redirected_location.name, redir, l_previous)
						end
					elseif l_previous /= Void then
						last_uuid := l_previous.uuid
					else
							--| No UUID found
						create l_err
						l_err.set_position (a_file, 1, 1)
						report_error (l_err)
					end
				end
			end
		ensure
			no_error_implies_last_uuid_not_void: not is_error implies last_uuid /= Void
		end

feature {NONE} -- Redirection		

	retrieve_redirected_configuration (a_file: READABLE_STRING_32; a_new_location: READABLE_STRING_GENERAL;
					a_previous_redirection: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID];
					ctx: CONF_LOAD_CONTEXT
				)
			-- Retrieve the configuration in `a_file' and make it available in `last_system',
			-- knowing that `a_file' describes a redirection to `a_new_location'.
			-- `a_redirections' is used to keep track of potential cycle in redirection.
			-- `a_previous_redirection' is used to carry the file+uuid of previous redirected file mainly to check UUID mismatch
			--|   i.e: if we have  old_path/abc.ecf which is a redirection to  new_path/abc.ecf, the UUID of both abc.ecf should be the same
			--|   however the UUID in the redirection is optional, note that the redirection can be a chain, for instance:
			--|			a.ecf -> b.ecf -> c.ecf
			--|			if a.ecf has a UUID, and b.ecf has no UUID and c.ecf has UUID
			--|			the code checks that there is no UUID mismatch, i.e that UUID of a.ecf is the same as UUID of c.ecf
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_new_location_ok: a_new_location /= Void and then not a_new_location.is_empty
			ctx_attached: ctx /= Void
		local
			p: PATH
		do
				--| If a_new_location is an absolute path, use it
				--| otherwise compute the absolute path with a_new_location as relative to parent folder of `a_file'

				-- On linux, replace \ by /
				-- (see `{CONF_LOCATION}.update_path_to_unix')
			p := conf_redirection_location_for_file (a_new_location, a_file)

			if across ctx.redirections as c some p.is_same_file_as (c) end then
					--| `a_new_location' already appears in the redirection chain
					--| this is a cycle in redirection which not allowed.
				report_error (create {CONF_ERROR_CYCLE_IN_REDIRECTION}.make (p.name, ctx.redirections))
			else
					--| Follow the redirection, and record the current redirection node in `a_redirections'
				ctx.record_redirection (p)
				recursive_retrieve_configuration (p.name, ctx, a_previous_redirection)
			end
		end

	retrieve_redirected_uuid (a_file: READABLE_STRING_32; a_new_location: READABLE_STRING_GENERAL; a_redirections: ARRAYED_LIST [PATH]; a_previous_redirection: detachable TUPLE [file: READABLE_STRING_32; uuid: UUID])
			-- Retrieve the uuid of the configuration in `a_file' and make it available in `last_uuid',
			-- knowing that `a_file' describes a redirection to `a_new_location'.
			-- `a_redirections' is used to keep track of potential cycle in redirection.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_new_location_ok: a_new_location /= Void and then not a_new_location.is_empty
			a_redirections_attached: a_redirections /= Void
		local
			p: PATH
		do
				-- If a_new_location is an absolute path, use it
				-- otherwise compute the absolute path with a_new_location as relative to parent folder of `a_file'
			p := (create {PATH}.make_from_string (a_new_location)).absolute_path_in ((create {PATH}.make_from_string (a_file)).parent)

			if across a_redirections as c some p.is_same_file_as (c) end then
					--| `a_new_location' already appears in the redirection chain
					--| this is a cycle in redirection which not allowed.				
				report_error (create {CONF_ERROR_CYCLE_IN_REDIRECTION}.make (p.name, a_redirections))
			else
					--| Follow the redirection until a UUID is set.
				a_redirections.extend (p)
				recursive_retrieve_uuid (p.name, a_redirections, a_previous_redirection)
			end
		end

feature {NONE} -- Implementation

	conf_location_value_to_path (a_path: READABLE_STRING_GENERAL): PATH
			-- Return path created updating `a_path' to Unix by changing all windows separator to Unix one.
		require
			a_path_not_void: a_path /= Void
		local
			s: STRING_32
		do
			if {PLATFORM}.is_windows then
				create Result.make_from_string (a_path)
			else
				create s.make_from_string_general (a_path)
				s.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
				create Result.make_from_string (s)
			end
		end

	conf_redirection_location_for_file (a_new_location: READABLE_STRING_GENERAL; a_file_location: READABLE_STRING_GENERAL): PATH
			-- Resolved redirection location `a_new_location` related to file `a_file_location`.
		do
			Result := conf_location_value_to_path (a_new_location)
			Result := Result.absolute_path_in ((create {PATH}.make_from_string (a_file_location)).parent)
		end

	factory: CONF_PARSE_FACTORY
			-- Factory to create nodes.

	parse_file (a_file: READABLE_STRING_32; a_callback: CONF_LOAD_CALLBACKS)
			-- Parse `a_file' using `a_callbacks'.
		require
			a_file_ok: a_file /= Void
			a_callback_not_void: a_callback /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_parser: detachable XML_PARSER
			l_ns_cb: XML_NAMESPACE_RESOLVER
			l_end_tag_checker: XML_END_TAG_CHECKER
			l_pos: detachable XML_POSITION
			l_retried: BOOLEAN
		do
			if not l_retried then
				reset_error

				if a_file.is_empty then
					report_error (create {CONF_ERROR_FILE}.make (a_file))
				else
					create {XML_STOPPABLE_PARSER} l_parser.make
					a_callback.set_associated_parser (l_parser)
					create l_end_tag_checker.set_next (a_callback)
					l_end_tag_checker.set_associated_parser (l_parser)
					create l_ns_cb.set_next (l_end_tag_checker)
					l_ns_cb.set_associated_parser (l_parser)
					l_parser.set_callbacks (l_ns_cb)

					create l_file.make_with_name (a_file)
					if l_file.exists and then l_file.is_plain then
						l_file.open_read
					end
					if l_file.is_open_read then
						l_parser.parse_from_file (l_file)
						l_file.close
					else
						report_error (create {CONF_ERROR_FILE}.make (a_file))
					end
				end
			else
				if l_parser /= Void then --| not is_error implies l_parser /= Void
						-- In case it is an internal error (Call on Void target, or others...)
						-- we need to properly handle this.
					if attached a_callback.last_error as l_cb_error then
						if attached l_parser.error_position as l_err_pos then
							l_pos := l_err_pos
						else
							l_pos := l_parser.position
						end
						l_cb_error.set_position (l_pos.source_name, l_pos.row, l_pos.column)
						l_cb_error.set_xml_parse_mode
					else
							-- Since no error was retrieved it means that we had an internal
							-- failure. Create an internal error instead.
						a_callback.set_internal_error
					end
				else
					a_callback.set_internal_error
				end
				if attached a_callback.last_error as err then
					report_error (err)
				else
					check is_error_expected: is_error end
				end
			end
				-- add warnings
			is_warning := is_warning or a_callback.is_warning
			if attached last_warnings as l_curr_last_warnings then
				if
					attached a_callback.last_warning as l_last_warnings and then
					not l_last_warnings.is_empty
				then
					l_curr_last_warnings.append (l_last_warnings)
				end
			else
				last_warnings := a_callback.last_warning
			end
		rescue
			l_retried := True
			retry
		end

invariant
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
