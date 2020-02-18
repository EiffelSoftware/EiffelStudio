note
	description: "Handler for reporting obsolete feature calls according to a currently selected policy."
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore: "CA011", "CA011 – too many arguments"

class OBSOLETE_CALL_HANDLER

inherit
	OBSOLETE_CALL_REPORTER [TUPLE [
		obsolete_feature: FEATURE_I
		obsolete_class: CLASS_C
		current_feature: detachable FEATURE_I
		current_class: CLASS_C
		warning_index: NATURAL_8
		location: detachable LOCATION_AS]]

	COMPILER_EXPORTER
	INTERNAL_COMPILER_STRING_EXPORTER
	SHARED_ERROR_HANDLER

feature -- Modification

	install (processor: like process)
			-- Install the obsolete message processor `processor` instead of the default one.
		do
			process_cell.put (processor)
		ensure
			is_installed: process = processor
		end

feature {NONE} -- Report

	report_obsolete_call (obsolete_message: READABLE_STRING_32; clean_message: READABLE_STRING_32; expiration: INTEGER_32; severity: NATURAL_32; context: like context_type)
			-- <Precursor>
		local
			issue: OBS_FEAT_WARN
			warning: OBSOLETE_FEATURE_CALL_OPTION_WARNING
		do
			if context.warning_index /= {CONF_OPTION}.warning_term_index_none then
					-- Report an obsolete warning for this call.
				create issue.make_with_class (context.current_class)
				if attached context.current_feature as current_feature then
					issue.set_feature (current_feature)
				end
				issue.set_obsolete_class (context.obsolete_class)
				issue.set_obsolete_feature (context.obsolete_feature)
				if attached context.location as location then
					issue.set_location (location)
				end
				 if expiration > 0 then
				 	issue.set_expiration (expiration)
				 end
				if severity = obsolete_call_error then
					issue.set_error
				end
				error_handler.insert_warning (issue, context.current_class.is_warning_reported_as_error ({CONF_CONSTANTS}.w_obsolete_feature))
			elseif
					-- Report only obsolete calls that are considered errors.
				severity = obsolete_call_error and then
					-- Avoid reporting obsolete calls more than once.
				error_handler.warning_level < obsolete_warning_level_cell.item
			then
					-- Report that there are obsolete feature calls.
				create warning
				warning.set_associated_class (context.current_class)
				if attached context.location as location then
					warning.set_location (location)
				end
				error_handler.insert_warning (warning, context.current_class.is_warning_reported_as_error ({CONF_CONSTANTS}.w_obsolete_feature))
					-- Record current warning level to avoid further reports.
				obsolete_warning_level_cell.put (error_handler.warning_level)
			end
		end

	obsolete_warning_level_cell: CELL [NATURAL_32]
			-- A cell for least detected warning level with an obsolete call warning.
		local
			l: like {ERROR_HANDLER}.warning_level
		once
				-- Start without any obsolete warnings.
			create Result.put (l.max_value)
				-- Register an agent to clean up obsolete warnings on recompilation.
			error_handler.set_warning_level_actions.extend
				(agent (w: like {ERROR_HANDLER}.warning_level)
						-- Detect if obsolete warning has been discarded at level `w`.
					do
						if w < obsolete_warning_level_cell.item then
								-- Record that no unreported obsolete call warnings are kept in the `error_handler`.
							obsolete_warning_level_cell.put (w.max_value)
						end
					end)
		end

feature {NONE} -- Processing

	process_cell: CELL
		[PROCEDURE [TUPLE [obsolete_message: READABLE_STRING_8; warning_index: like {CONF_OPTION}.warning_term_index_none;
			context: like {OBSOLETE_CALL_HANDLER}.context_type;
			reporter: OBSOLETE_CALL_REPORTER [like {OBSOLETE_CALL_HANDLER}.context_type]]]]
			-- A storage for the value of `process`.
		once
			create Result.put
				(agent (obsolete_message: READABLE_STRING_8; warning_index: like {CONF_OPTION}.warning_term_index_none; context: like context_type; reporter: OBSOLETE_CALL_REPORTER [like context_type])
					local
						stamp: like {OBSOLETE_MESSAGE_PARSER}.date
						clean_message: READABLE_STRING_32
						original_message: READABLE_STRING_32
					do
						stamp := {OBSOLETE_MESSAGE_PARSER}.date (obsolete_message)
						original_message := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (obsolete_message)
						clean_message := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (stamp.message)
						report_obsolete_call (original_message, clean_message, stamp.date.relative_duration (create {DATE}.make_now_utc).days_count, obsolete_call_warning, context)
					end)
		end

	process: PROCEDURE [TUPLE [obsolete_message: READABLE_STRING_8; warning_index: like {CONF_OPTION}.warning_term_index_none; context: like context_type; reporter: OBSOLETE_CALL_REPORTER [like context_type]]]
			-- A procedure to process the osbolete message `obsolete_message` with the flag indicating whether the warning is enabled `is_warning_enabled`
			-- and report it using one of `report_error`, `report_warning` or `report_hint` accordingly.
		do
			Result := process_cell.item
		end

	report (obsolete_feature: FEATURE_I; obsolete_class: CLASS_C; current_feature: detachable FEATURE_I; current_class: CLASS_C; location: detachable LOCATION_AS; warning_index: like {CONF_OPTION}.warning_term_index_none)
			-- Report an obsolete feature call warning or error for `obsolete_feature` from `obsolete_class` in `current_feature` of `currect_class` at `location`.
			-- If `current_feature` is `Void`, then the issue is reported in the class invariant.
			-- The flag `is_warning_enabled` tells if the corresponding warning message is allowed. Otherwise (i.e., when it is disabled or not a warning), it is suppressed.
		require
			{CONF_OPTION}.is_valid_warning_term_index (warning_index)
		do
			if attached obsolete_feature.obsolete_message as m then
				process (m, warning_index, [obsolete_feature, obsolete_class, current_feature, current_class, warning_index, location], Current)
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
