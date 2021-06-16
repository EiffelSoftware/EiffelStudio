note
	description: "Summary description for {ES_PRETTIFY_SUGGESTION_DETECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PRETTIFY_SUGGESTION_DETECTOR

inherit
	SHARED_EIFFEL_PROJECT

	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PREFERENCES

	PROJECT_SESSION_STATISTICS_OBSERVER
		redefine
			on_update
		end


feature -- Installation

	install
		do
			if
				attached {PROJECT_SESSION_STATISTICS_S} (create {SERVICE_CONSUMER [PROJECT_SESSION_STATISTICS_S]}).service as l_stats_service
			then
				l_stats_service.statistics_connection.connect_events (Current)
			end
		end

feature -- Basic operation

	reset
		do
			if
				attached {PROJECT_SESSION_STATISTICS_S} (create {SERVICE_CONSUMER [PROJECT_SESSION_STATISTICS_S]}).service as l_stats_service and then
				attached l_stats_service.project_session_statistics as l_stats
			then
				-- FIXME: reset only for prettify suggestion detection!
--				l_stats.reset_consecutive_successful_compilations
				consecutive_successful_compilations_index_for_last_notification := l_stats.consecutive_successful_compilations
			end
		end

feature -- Event

	on_update (a_service: PROJECT_SESSION_STATISTICS_S)
		local
			n, p: NATURAL_32
		do
			if preferences.development_window_data.is_pretty_printer_notification_enabled and attached a_service.project_session_statistics as l_stats then
				n := l_stats.consecutive_successful_compilations
				p := consecutive_successful_compilations_index_for_last_notification
				if n = 0 or else n < p then
						-- consecutive_successful_compilations was reset
					consecutive_successful_compilations_index_for_last_notification := 0
				else
					if attached (create {SERVICE_CONSUMER [NOTIFICATION_S]}).service as l_notification_service then
						if
							n - p >= preferences.development_window_data.consecutive_successful_compilations_threshold
						then
							if
								attached Window_manager.last_focused_development_window as win and then
								attached win.editors_manager.current_editor as l_editor and then
								suggesting_pretty_printer (l_editor)
							then
								consecutive_successful_compilations_index_for_last_notification := n
								notify_about_pretty_printer (l_editor, l_notification_service)
							end
						end
					end
				end
			end
		end

	consecutive_successful_compilations_index_for_last_notification: NATURAL_32

feature -- Change Element


	disable_session
			-- Disable pretty printer notification for the current session.
		do
			is_disabled := True
		ensure
			is_disabled
		end

	enable_session
			-- Enable pretty printer notification for the current session.
		do
			is_disabled := False
		ensure
			not is_disabled
		end

feature {NONE} -- Implementation		

	notify_about_pretty_printer (a_editor: EB_SMART_EDITOR; a_notification_service: NOTIFICATION_S)
		local
			l_notify: NOTIFICATION_MESSAGE_WITH_ACTIONS
			l_shortcut: MANAGED_SHORTCUT
			l_locale: SHARED_LOCALE
			l_msg: STRING_32
			l_class_name: STRING
		do
			if is_disabled or not preferences.development_window_data.is_pretty_printer_notification_enabled_preference.value  then
		 		-- do nothing
		 	else
				l_class_name := Window_manager.last_focused_development_window.class_name
				create l_locale
				l_shortcut := preferences.editor_data.shortcuts.item ("prettify")
				l_msg := l_locale.locale.formatted_string (l_locale.locale.translation_in_context ("The class $1 can be prettified%NUse: $2", "prettify_notification") , [l_class_name, l_shortcut.display_string])
				create l_notify.make (l_msg, "prettify")
				l_notify.set_title (l_locale.locale.translation_in_context ("Code prettify suggestion", "prettify_notification"))
				l_notify.register_action (agent (i_editor: EB_SMART_EDITOR)
					do
						i_editor.prettify
					end (a_editor), "Apply")
				l_notify.register_action (agent (o: ES_PRETTIFY_SUGGESTION_DETECTOR)
					do
						o.disable_session
					end (Current), "Later")
				l_notify.register_action (agent
					do
						preferences.development_window_data.update_pretty_printer_notification (False)
					end , "Never")

				a_notification_service.notify (l_notify)
			end
		end

	suggesting_pretty_printer (a_editor: EB_SMART_EDITOR): BOOLEAN
		local
			l_show_pretty: E_SHOW_PRETTY
			src,s: STRING_32
			l_diff: DIFF_TEXT
			l_class_i: CLASS_I
			l_modifier: ES_CLASS_LICENSER
		do
				-- Relicense current text editor.
			src := relicense (a_editor.wide_text, a_editor)

				-- Create a string to write prettified text.
			create s.make_empty

				-- Prettify code.
			create l_show_pretty.make_string (a_editor.file_path.name, s)

				-- Relicense prettify code.
			s := relicense (s, a_editor)

				-- Check if formatting is successful.
			if not l_show_pretty.error then
				create l_diff
				src.replace_substring_all ("%R%N", "%N")
				s.replace_substring_all ("%R%N", "%N")
				l_diff.set_text ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (src), {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s))
				l_diff.compute_diff
				if
					attached l_diff.hunks as l_hunks and then
					l_hunks.count >= preferences.development_window_data.pretty_printer_messindex.to_integer_32
				then
					Result := True
				end
			end
		end

	relicense (a_class_text: READABLE_STRING_GENERAL; a_editor: EB_SMART_EDITOR): STRING_32
			-- Relicenser for the class represented in the current editor `a_editor`.
			-- with a given class text `a_class_text`.
		local
			l_class_i: CLASS_I
			l_modifier: ES_CLASS_LICENSER
		do
			Result := a_class_text
			if a_editor.is_interface_usable and then attached {CLASSI_STONE} a_editor.stone as l_class then
					-- We have the class stone
				l_class_i := l_class.class_i
				if l_class_i /= Void then
					create l_modifier
					Result := l_modifier.relicense_text (a_class_text, l_class_i)
				end
			end
		end

	is_disabled: BOOLEAN
			-- Has been prettry printer disabled for this session?
;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
