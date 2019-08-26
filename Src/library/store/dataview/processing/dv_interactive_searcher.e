note
	description: "Objects that enable user to perform a database selection%
			%determined at run-time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_INTERACTIVE_SEARCHER

inherit
	DV_SEARCHER
		redefine
			can_be_activated
		end

create
	make

feature -- Initialization

	make
			-- Initialize.
		do
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can component be activated?
		do
			Result := Precursor and then
					control /= Void and then
					column_selector /= Void and then
					value_selector /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic operations

	set_control (a_ctrl: DV_SENSITIVE_CONTROL)
			-- Set `a_ctrl' to trigger a search.
		require
			not_void: a_ctrl /= Void
		do
			control := a_ctrl
			a_ctrl.set_action (agent read)
		end

	set_column_selector (a_col_selector: DV_SENSITIVE_INTEGER)
			-- Set column selector to `a_col_selector'.
		require
			not_void: a_col_selector /= Void
		do
			column_selector := a_col_selector
		end

	set_value_selector (a_val_selector: DV_SENSITIVE_STRING)
			-- Set value selector to `a_val_selector'.
		require
			not_void: a_val_selector /= Void
		do
			value_selector := a_val_selector
		end

	set_qualification_selector (a_qual_selector: DV_SENSITIVE_INTEGER)
			-- Set qualification selector to `a_qual_selector'.
		require
			not_void: a_qual_selector /= Void
		do
			qualification_selector := a_qual_selector
		end

	set_case_selector (a_case_selector: DV_SENSITIVE_CHECK)
			-- Set case selector to `a_case_selector'.
		require
			not_void: a_case_selector /= Void
		do
			case_selector := a_case_selector
		end

	read
			-- Read the database according to qualifying clause.
		require
			is_activated: is_activated
		do
			set_new_search_parameters
			if attached db_table_component as l_comp then
				l_comp.display (refresh)
			end
		end

feature {DV_COMPONENT} -- Basic operations

	activate
			-- Activate component.
		do
			is_activated := True
		end

	refresh: ARRAYED_LIST [DB_TABLE]
			-- Return tablerows corresponding to last database reading, i.e.
			-- table rows may have changed but query is the same.
		local
			database_handler: ABSTRACT_DB_TABLE_MANAGER
		do
			if attached db_table_component as l_comp and attached last_value as l_last_value then
				database_handler := l_comp.database_handler
				database_handler.prepare_select_with_table (table_code)
				database_handler.add_specific_qualifier (last_column, l_last_value, last_qualification, last_case)
				database_handler.load_result
				if database_handler.has_error then
					if attached l_comp.warning_handler as l_warn_handler then
						if attached database_handler.error_message as l_msg then
							l_warn_handler.call ([l_msg])
						else
							l_warn_handler.call (["Unknown error"])
						end
					end
					create Result.make (0)
				elseif attached database_handler.database_result_list as l_result then
					Result := l_result
				else
					create Result.make (0)
						-- We should get an error.
					check False end
				end
			else
				create Result.make (0)
					-- We should get an error.
				check False end
			end
		end

feature {NONE} -- Implementation

	control: detachable DV_SENSITIVE_CONTROL
			-- Triggers the search.

	column_selector: detachable DV_SENSITIVE_INTEGER
			-- Provides the column of the qualifier.

	value_selector: detachable DV_SENSITIVE_STRING
			-- Provides the value of the qualifier.

	qualification_selector: detachable DV_SENSITIVE_INTEGER
			-- Provides the type of qualifier

	case_selector: detachable DV_SENSITIVE_CHECK
			-- Provides the case sensitiveness.

	last_column: INTEGER
			-- Last searched column value.

	last_value: detachable STRING_32
			-- Last searched qualifying value.

	last_qualification: INTEGER
			-- Qualifying type of last search.

	last_case: BOOLEAN
			-- Was last search case sensitive?

	set_new_search_parameters
			-- Set new search parameters from parameters
			-- providers.
		do
			if attached column_selector as l_col_selector then
				last_column := l_col_selector.value
			else
				last_column := 0
			end
			if attached value_selector as l_val_selector then
				last_value := l_val_selector.value
			else
				create last_value.make_empty
			end
			if attached qualification_selector as l_qualification_selector then
				last_qualification := l_qualification_selector.value
			end
			if attached case_selector as l_case_selector then
				last_case := l_case_selector.checked
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class DV_INTERACTIVE_SEARCHER


