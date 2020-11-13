note
	description: "Summary description for {ACCESS_CONTROL_RUNS_PER_PERIOD_RULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_CONTROL_RUNS_PER_PERIOD_RULE

inherit
	ACCESS_CONTROL_RULE

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_runs_count: INTEGER; a_hours_count, a_minutes_count: INTEGER)
		do
			runs_count := a_runs_count
			hours_count := a_hours_count
			minutes_count := a_minutes_count
			is_satisfied := True -- Default
		end

feature -- Access

	runs_count: INTEGER

	hours_count,
	minutes_count: INTEGER

feature -- Access

	is_satisfied: BOOLEAN
			-- Set by `process`

	last_date: detachable DATE_TIME

	denied_reason (ctx: ACCESS_CONTROL_RULE_CONTEXT): detachable STRING_32
		local
			d: INTEGER
			dt: DATE_TIME
			secs: INTEGER_64
			l_days,
			l_hours,
			l_mins: INTEGER_64
		do
			if hours_count > 0 then
				if hours_count \\ 24 = 0 then
					d := hours_count // 24
					Result := locale.formatted_string (locale.plural_translation_in_context ("Limited to $1 runs per day", "Limited to $1 runs in $2 days", "access_control", d), [runs_count, d])
				else
					Result := locale.formatted_string (locale.plural_translation_in_context ("Limited to $1 runs per hour", "Limited to $1 runs in $2 hours", "access_control", hours_count), [runs_count, hours_count])
				end
			elseif minutes_count > 0 then
				Result := locale.formatted_string (locale.plural_translation_in_context ("Limited to $1 runs per minute", "Limited to $1 runs in $2 minutes", "access_control", minutes_count), [runs_count, minutes_count])
			else
				Result := locale.formatted_string (locale.translation_in_context ("Limited to $1 runs", "access_control"), [runs_count])
			end

			dt := last_date
			if dt /= Void then
				dt := dt.twin
				if hours_count > 0 then
					dt.hour_add (hours_count)
				end
				if minutes_count > 0 then
					dt.minute_add (minutes_count)
				end
				secs := dt.relative_duration (ctx.date).seconds_count
				l_days := secs // (60 * 60 * 24)
				if l_days = 0 then
					l_hours := secs // (60 * 60)
					l_mins := (secs \\ (60 * 60)) // 60
				end
				Result.append ("%NTry again in ")
				if l_days > 0 then
					Result.append (l_days.out + " days")
				else
					Result.append (l_hours.out + " hours and " + l_mins.out + " minutes")
				end
			end
		end

	process (ctx: ACCESS_CONTROL_RULE_CONTEXT)
			-- Clean structure and set `is_satisfied`.
		local
			dt: DATE_TIME
			nb: INTEGER
		do
			is_satisfied := True
			last_date := Void
			if attached ctx.records.issuer_items (ctx.issuer) as lst then
				if lst.count >= runs_count then
					from
						dt := ctx.date.twin
						if hours_count > 0 then
							dt.hour_add (- hours_count)
						end
						if minutes_count > 0 then
							dt.minute_add (- minutes_count)
						end
						nb := 0
						lst.finish
					until
						lst.off
					loop
						if ctx.operation.is_case_insensitive_equal (lst.item.operation) then
							if lst.item.date >= dt then
								nb := nb + 1
								is_satisfied := nb < runs_count
								last_date := lst.item.date
								lst.back
							else
								lst.remove
								ctx.set_is_dirty (True)
							end
						else
							lst.back
						end
					end
				end
			end
		end

note
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
