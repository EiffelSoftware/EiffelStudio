note
	description: "Objects that enable to create a%
			%database table row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_CREATOR

inherit
	DV_COMPONENT

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		do
			Result := db_table_component /= Void
		end

	table_component_set: BOOLEAN
			-- Has a table component (where the created rows will be
			-- displayed set?
		do
			Result := db_table_component /= Void
		end

	control_set: BOOLEAN
			-- Is creation control system set?
		deferred
		end

feature {DV_COMPONENT} -- Access

	db_table_component: detachable DV_TABLE_COMPONENT
			-- Table component where the created table
			-- row will be displayed.

feature {DV_COMPONENT} -- Basic operations

	set_table_component (table_comp: DV_TABLE_COMPONENT)
			-- Set associated table component.
		require
			not_activated: not is_activated
			component_not_void: table_comp /= Void
		do
			db_table_component := table_comp
		ensure
			table_component_set: table_component_set
		end

	enable_sensitive
			-- Enable creation.
		require
			control_set: control_set
		deferred
		end

	disable_sensitive
			-- Disable creation.
		require
			control_set: control_set
		deferred
		end

	refresh: ARRAYED_LIST [DB_TABLE]
			-- Refresh selection showing created table row.
		require
			is_activated: is_activated
		deferred
		end

	set_calling_fkey_value (calling_fkey_val: ANY)
			-- Set current calling component table row ID to `calling_fkey_val'.
		require
			is_activated: is_activated
			not_void: calling_fkey_val /= Void
			is_dependent: attached db_table_component as l_comp and then l_comp.is_dependent
		do
			calling_fkey_value := calling_fkey_val
		end

feature {NONE} -- Implementation

	calling_fkey_value: detachable ANY;
			-- Current calling component table row ID.

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_CREATOR


