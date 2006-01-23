indexing
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

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := db_table_component /= Void
		end

	table_component_set: BOOLEAN is
			-- Has a table component (where the created rows will be
			-- displayed set?
		do
			Result := db_table_component /= Void
		end

	control_set: BOOLEAN is
			-- Is creation control system set?
		deferred
		end

feature {DV_COMPONENT} -- Access

	db_table_component: DV_TABLE_COMPONENT
			-- Table component where the created table
			-- row will be displayed.

feature {DV_COMPONENT} -- Basic operations

	set_table_component (table_comp: DV_TABLE_COMPONENT) is
			-- Set associated table component.
		require
			not_activated: not is_activated
			component_not_void: table_comp /= Void
		do
			db_table_component := table_comp
		ensure
			table_component_set: table_component_set
		end

	enable_sensitive is
			-- Enable creation.
		require
			control_set: control_set
		deferred
		end

	disable_sensitive is
			-- Disable creation.
		require
			control_set: control_set
		deferred
		end

	refresh: ARRAYED_LIST [DB_TABLE] is
			-- Refresh selection showing created table row.
		require
			is_activated: is_activated
		deferred
		end

	set_calling_fkey_value (calling_fkey_val: ANY) is
			-- Set current calling component table row ID to `calling_fkey_val'.
		require
			is_activated: is_activated
			not_void: calling_fkey_val /= Void
			is_dependent: db_table_component.is_dependent
		do
			calling_fkey_value := calling_fkey_val
		end

feature {NONE} -- Implementation

	calling_fkey_value: ANY;
			-- Current calling component table row ID.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_CREATOR


