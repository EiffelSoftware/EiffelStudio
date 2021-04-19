note
	description: "[
		The ecosystem's default implementation for the {ACCESS_CONTROL_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCESS_CONTROL

inherit
	ACCESS_CONTROL_S

	DISPOSABLE_SAFE

	SHARED_ES_CLOUD_SERVICE

	SHARED_NOTIFICATION_SERVICE

	EIFFEL_LAYOUT

	SHARED_LOCALE

	ES_CLOUD_OBSERVER
		redefine
			on_account_signed_in, on_account_signed_out
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create records_table.make_caseless (1)
			if attached cloud as cl then
				cl.es_cloud_connection.connect_events (Current)
			end
		end

feature -- Access

	is_operation_allowed (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL; a_denied_reason: detachable CELL [detachable READABLE_STRING_GENERAL]): BOOLEAN
		local
			ctx: ACCESS_CONTROL_RULE_CONTEXT
			r: like records
			lic: ES_ACCOUNT_LICENSE
		do
			Result := True -- by default
			if attached cloud as l_cloud_service then
				lic := l_cloud_service.active_license
				if attached limitations (lic, issuer, operation) as l_rules then
					if lic /= Void then
						r := records (lic.key)
					else
						r := records (Void)
					end
					create ctx.make (issuer, operation, r)
					across
						l_rules as ic
					until
						not Result
					loop
						ic.item.process (ctx)
						Result := ic.item.is_satisfied
						if not Result and a_denied_reason /= Void then
							a_denied_reason.replace (ic.item.denied_reason (ctx))
						end
					end
					if ctx.is_dirty then
						r.commit
					end
				end
			end
		end

	report_operation_access_not_allowed (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL; a_message: detachable READABLE_STRING_GENERAL)
		local
			m: STRING_32
			msg: NOTIFICATION_MESSAGE_WITH_ACTIONS
			s: STRING_32
		do
			if attached notification_s.service as s_notif then
				create s.make_from_string_general (issuer)
				if operation /= Void then
					s.append_character ('.')
					s.append_string_general (operation)
				end

				m := locale.translation_in_context (locale.formatted_string ("You have exceeded your license usage on %"$1%".", [s]), "access_control")
				if a_message /= Void then
					m.append_character ('%N')
					m.append_string_general (a_message)
				end
				m.append_character ('%N')

				create msg.make (m, "License limitation")
				if attached cloud as l_cloud_service then
					msg.register_action (agent open_account_url (l_cloud_service), "Upgrade")
				end
				s_notif.notify (msg)
			end
		end

feature -- Basic operation

	record_operation (issuer: READABLE_STRING_GENERAL; operation: detachable READABLE_STRING_GENERAL)
		local
			r: like records
		do
			if attached cloud as l_cloud_service then
				if attached l_cloud_service.active_license as lic then
					r := records (lic.key)
				else
					r := records (Void)
				end
				r.put_operation (issuer, operation)
			end
		end

feature {ACCESS_CONTROL_RULE} -- Implementation

	records (a_id: detachable READABLE_STRING_GENERAL): ES_ACCESS_CONTROL_RECORDS
		local
			s: READABLE_STRING_GENERAL
		do
			s := if a_id = Void then "" else a_id end
			Result := records_table [s]
			if Result = Void then
				create Result.make (a_id)
				records_table [s] := Result
			end
		end

	records_table: STRING_TABLE [ES_ACCESS_CONTROL_RECORDS]

	limitations_table: detachable STRING_TABLE [ES_ACCESS_CONTROL_LIMITATIONS]
			-- Indexed by plan name, and then by issuer

	limitations (a_license: detachable ES_ACCOUNT_LICENSE; issuer: READABLE_STRING_GENERAL; operation: READABLE_STRING_GENERAL): detachable LIST [ACCESS_CONTROL_RULE]
			-- Limitation by `operation` for an `issuer` in the context of license `a_license`.
		local
			lim_tb: like limitations_table
			l_plan_name: READABLE_STRING_GENERAL
			lim: ES_ACCESS_CONTROL_LIMITATIONS
		do
			if a_license = Void then
				l_plan_name := ""
			else
				l_plan_name := a_license.plan_name
			end

			lim_tb := limitations_table
			if lim_tb = Void then
				create lim_tb.make_caseless (1)
				limitations_table := lim_tb
			end

			lim := lim_tb [l_plan_name]
			if lim = Void then
				create lim.make (l_plan_name)
				lim_tb [l_plan_name] := lim
				if a_license /= Void and then attached a_license.plan_limitations_string as s_plan_lim then
					populate_limitation (s_plan_lim, lim)
				end
			end
			Result := lim.rules (issuer, operation)
		end

	populate_limitation (a_plan_limitations: READABLE_STRING_8; a_limitations: ES_ACCESS_CONTROL_LIMITATIONS)
		local
			jp: JSON_PARSER
			l_issuer: READABLE_STRING_32
			l_operation: READABLE_STRING_32
			jarr: JSON_ARRAY
			nb, h, m: INTEGER
		do
			create jp.make
			jp.parse_string (a_plan_limitations.to_string_8)
			if jp.is_valid and attached jp.parsed_json_object as j_obj then
				across
					j_obj as issuer_ic
				loop
					if attached {JSON_OBJECT} issuer_ic.item as jo then
						l_issuer := issuer_ic.key.unescaped_string_32
						across
							jo as op_ic
						loop
							l_operation := op_ic.key.unescaped_string_32
							jarr := Void
							if attached {JSON_OBJECT} op_ic.item as j_op then
								create jarr.make (1)
								jarr.extend (j_op)
							elseif attached {JSON_ARRAY} op_ic.item as j_arr then
								jarr := j_arr
							end
							if jarr /= Void then
								across
									jarr as rules_ic
								loop
									if attached {JSON_OBJECT} rules_ic.item as j_rule_obj then
											-- Extract rule!
										if attached j_rule_obj.string_item ("rule") as l_rule_name then
											if l_rule_name.same_caseless_string ("number_of_runs") then
												nb := 0
												h := 0
												m := 0
												if attached j_rule_obj.number_item ("count") as n and then n.is_integer then
													nb := n.integer_64_item.to_integer_32
												end
												if attached j_rule_obj.number_item ("hours") as n and then n.is_integer then
													h := n.integer_64_item.to_integer_32
												end
												if attached j_rule_obj.number_item ("minutes") as n and then n.is_integer then
													m := n.integer_64_item.to_integer_32
												end
												a_limitations.add_rule (l_issuer, l_operation, create {ACCESS_CONTROL_RUNS_PER_PERIOD_RULE}.make (nb, h, m)) -- nb runs per h hours, or m minutes	
											else
													-- Not supported
											end
										else
												-- Ignore
										end
									end
								end
							end
						end
					end
				end
			end
		end

feature -- Events

	on_account_signed_in (acc: ES_ACCOUNT)
		do
		end

	on_account_signed_out (a_previous_acc: detachable ES_ACCOUNT)
		do
			limitations_table.wipe_out
			limitations_table := Void
		end

feature {NONE} -- Implementation

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

	cloud: detachable ES_CLOUD_S
		do
			Result := internal_cloud_service
			if Result = Void then
				Result := es_cloud_s.service
			end
		end

	internal_cloud_service: detachable ES_CLOUD_S

	open_account_url (cld: ES_CLOUD_S)
		local
			l_launcher: ES_CLOUD_URL_LAUNCHER
		do
			create l_launcher.make (cld.view_account_website_url)
			l_launcher.execute
		end


invariant
--	invariant_clause: True

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
