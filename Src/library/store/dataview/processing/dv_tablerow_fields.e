indexing
	description: "Fields representing part of%
			%the content of a table row."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLEROW_FIELDS

inherit
	DV_COMPONENT

	DB_TABLES_ACCESS_USE

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create field_list.make (1)
		end

feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := table_description /= void
		end
		
	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic Operations

	add_field, extend (ta_field: DV_TABLEROW_FIELD) is
			-- Add `field' to structure.
		require
			not_void: ta_field /= Void
			not_activated: not is_activated
		do
			field_list.extend (ta_field)
		end

feature {DV_COMPONENT} -- Access

	table_description: DB_TABLE_DESCRIPTION
			-- Description of table represented by component.

	updated_tablerow: DB_TABLE is
			-- Updated table row if `is_update_valid'.	
		require
			is_activated: is_activated
			is_update_valid: is_update_valid
		do
			Result := new_tablerow
		ensure
			result_not_void: Result /= Void
		end

feature {DV_COMPONENT} --  Status report

	is_update_valid: BOOLEAN
			-- Are values entered by the user valid?

	error_message: STRING
			-- Error message if values entered by the user
			-- are not valid.

feature {DV_COMPONENT} -- Basic operations

	set_table_description (td: DB_TABLE_DESCRIPTION) is
			-- Set represented table description to `td'.
		require
			not_void: td /= Void
			not_activated: not is_activated
		do
			table_description := td
		end

	activate is
			-- Activate component.
		do
			from
				field_list.start
			until
				field_list.after
			loop
				field_list.item.set_table_description (table_description)
				field_list.item.activate
				field_list.forth
			end
			is_activated := True
		end

	refresh (table_descr: DB_TABLE_DESCRIPTION) is
			-- Refresh fields with values of `tr'.
		require
			is_activated: is_activated
 		do
			from 
				field_list.start
			until
				field_list.after
			loop
				field_list.item.refresh (table_descr)
				field_list.forth
			end
		end

	clear is
			-- Clear fields and make them insensitive.
		require
			is_activated: is_activated
		do
			from 
				field_list.start
			until
				field_list.after
			loop
				field_list.item.clear
				field_list.forth
			end
		end

	enable_sensitive is
			-- Make structure sensitive.
		do
			from 
				field_list.start
			until
				field_list.after
			loop
				field_list.item.enable_sensitive
				field_list.forth
			end
		end

	disable_sensitive is
			-- Make structure insensitive.
		do
			from 
				field_list.start
			until
				field_list.after
			loop
				field_list.item.disable_sensitive
				field_list.forth
			end
		end

	update_tablerow (default_tablerow: DB_TABLE) is
			-- Displayed object with user changes. Fields unchanged are taken
			-- from `default_tablerow'.
		require
			is_activated: is_activated
		local
			is_val: BOOLEAN
			td: DB_TABLE_DESCRIPTION
		do
			new_tablerow := clone (default_tablerow)
			td := new_tablerow.table_description
			from
				is_val := True
				field_list.start
			until
				not is_val or else field_list.after
			loop
				field_list.item.update_tablerow (td)
				is_val := field_list.item.is_update_valid
				if is_val then
					field_list.forth
				end
			end
			is_update_valid := is_val
			if not is_val then
				error_message := field_list.item.error_message
			end
		end

feature {NONE} -- Implementation

	field_list: ARRAYED_LIST [DV_TABLEROW_FIELD]
			-- List containing table row fields.

	new_tablerow: DB_TABLE;
			-- Updated tablerow.

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_TABLEROW_FIELDS
