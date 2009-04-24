note
	description: "[
		An environment service for access certain properties and variables held by the environment.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENVIRONMENT

inherit
	ENVIRONMENT_S
		redefine
			is_set
		end

	DISPOSABLE_SAFE

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the environment service
		do
			create table.make (13)
			table.compare_objects
			build_table
		end

	build_table
			-- Builds the defaults for the variable table.
		do
				-- Add the starting environment variables to the list of known variables.
			table.merge (execution_environment.starting_environment_variables)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				table.wipe_out
			end
		ensure then
			table_is_empty: a_explicit implies table.is_empty
		end

feature -- Access

	variables: LINEAR [READABLE_STRING_8]
			-- <Precursor>
		do
			if attached internal_variables as l_result then
				Result := l_result
			else
				create {ARRAYED_LIST [READABLE_STRING_8]} Result.make_from_array (table.current_keys)
				internal_variables := Result
			end
		end

	variable (a_name: READABLE_STRING_GENERAL): detachable STRING assign set_variable
			-- <Precursor>
		local
			l_name: STRING
			l_table: like table
		do
			l_name := a_name.as_string_8
			l_table := table
			if l_table.has (l_name) then
				Result := l_table.item (l_name)
			else
				Result := execution_environment.get (l_name)
			end
			if (not attached Result) and then is_eiffel_layout_defined then
				Result := eiffel_layout.get_environment (l_name)
			end
		end

feature {NONE} -- Access

	table: HASH_TABLE [STRING, STRING]
			-- Table of variables.

feature -- Element change

	set_variable (a_value: detachable STRING; a_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_changed: BOOLEAN
			l_name: STRING
		do
			l_name := a_name.as_string_8
			l_changed := set_variable_internal (a_value, l_name)

				-- Publish events.
			if l_changed and then (attached internal_value_changed_event as l_events) then
				l_events.publish ([Current, l_name])
			end
		end

	set_environment_variable (a_value: detachable STRING; a_name: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_changed: BOOLEAN
			l_name: STRING
		do
			l_name := a_name.as_string_8
			l_changed := set_variable_internal (a_value, l_name)

			if l_changed then
					-- Set the environment variable.
				if attached a_value then
					execution_environment.put (a_value, l_name)
				else
					execution_environment.put (once "", l_name)
				end

					-- Publish events.
				if (attached internal_value_changed_event as l_events) then
					l_events.publish ([Current, l_name])
				end
			end
		end

feature {NONE} -- Element change

	set_variable_internal (a_value: detachable STRING; a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Sets a variable in the Current environment but will not publish any events.
			--
			-- `a_value': An associated value to bind to a given variable name.
			-- `a_name' : The name of the variable to set.
			-- `Result' : True if a change took place; False otherwise.
		require
			is_interface_usable: is_interface_usable
			not_a_value_is_empty: a_value /= Void and then not a_value.is_empty
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_old_value: like variable
			l_name: STRING
		do
			l_name := a_name.as_string_8
			l_old_value := variable (l_name)

			if a_value /~ l_old_value then
				if attached a_value then
						-- Set the variable
					if l_name = a_name then
							-- Same reference, twin value
						l_name := l_name.twin
					end
					table.force (a_value.twin, l_name)
				else
						-- Clean the variable
					table.remove (l_name)
				end

					-- Indicate a change
				Result := True
			end
		ensure
			change_made: (a_value /~ old variable (a_name)) implies Result
		end

feature -- Status report

	is_set (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		local
			l_name: STRING
			l_value: detachable STRING
		do
			l_name := a_name.as_string_8
			Result := table.has (l_name)
			if not Result then
				l_value := execution_environment.get (l_name)
				if l_value = Void and then is_eiffel_layout_defined then
					l_value := eiffel_layout.get_environment (l_name)
				end
				Result := attached l_value
			end
		end

feature -- Query

	expand_string (a_string: READABLE_STRING_8; a_keep: BOOLEAN): STRING
			-- <Precursor>
		do
			Result := expander.expand_string (a_string, table, True, a_keep)
		end

feature {NONE} -- Helpers

	expander: STRING_TABLE_EXPANDER
			-- String expander for evaluating expansion.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	execution_environment: EXECUTION_ENVIRONMENT
			-- Shared access to the execution environment
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Events

	value_changed_event: EVENT_TYPE [TUPLE [sender: ENVIRONMENT_S; name: READABLE_STRING_8]]
			-- <Precursor>
		do
			if attached internal_value_changed_event as l_result then
				Result := l_result
			else
				create Result
				auto_dispose (Result)
			end
		end

feature -- Events: Connection point

	frozen environment_connection: EVENT_CONNECTION [ENVIRONMENT_OBSERVER, ENVIRONMENT_S]
			-- <Precursor>
		do
			if attached internal_environment_connection as l_result then
				Result := l_result
			else
				create Result.make (
					agent (ia_observer: ENVIRONMENT_OBSERVER): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := << [value_changed_event, agent ia_observer.on_environment_value_changed] >>
						end)
				auto_dispose (Result)
				internal_environment_connection := Result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_variables: detachable like variables
			-- Cached version of `variables'.
			-- Note: Do not use directly!

	internal_value_changed_event: detachable like value_changed_event
			-- Cached version of `value_changed_event'.
			-- Note: Do not use directly!

	internal_environment_connection: detachable like environment_connection
			-- Cached version of `environment_connection'.
			-- Note: Do not use directly!

invariant
	table_attached: table /= Void
	table_compare_objects: table.object_comparison

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
