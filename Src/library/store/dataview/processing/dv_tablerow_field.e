indexing
	description: "Graphic objects representing a database table attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLEROW_FIELD

inherit
	DV_COMPONENT

	DV_MESSAGES

create
	make_with_code

feature -- Initialization

	make_with_code (code: INTEGER) is
			-- Initialize with `code' to
			-- locate table attribute in the database.
		do
			attribute_code := code
		end

feature -- Access

	attribute_code: INTEGER
			-- Code of the represented attribute in the
			-- database table.
	
	table_description: DB_TABLE_DESCRIPTION
			-- Description of the database table containing
			-- the represented attribute.

	text: STRING is
			-- Field text.
		do
			Result := graphical_value.value
			if Result = Void then
				Result := ""
			end
		ensure
			result_not_void: Result /= Void
		end

	graphical_title: DV_SENSITIVE_STRING
			-- Graphical element holding field title.

	graphical_type: DV_SENSITIVE_STRING
			-- Graphical element holding field type.

	graphical_value: DV_SENSITIVE_STRING
			-- Graphical element holding field value.

feature -- Status report

	can_be_activated: BOOLEAN is
			-- Can the component be activated?
		do
			Result := graphical_value_set and then table_description /= Void
		end
		
	is_activated: BOOLEAN
			-- Is component activated?

	is_boolean: BOOLEAN is
			-- Is the attribute a boolean value?
		do
			Result := type_code = table_description.Boolean_type
		end

	is_character: BOOLEAN is
			-- Is the attribute a character value?
		do
			Result := type_code = table_description.Character_type
		end

	is_double: BOOLEAN is
			-- Is the attribute a double value?
		do
			Result := type_code = table_description.Double_type
		end

	is_datetime: BOOLEAN is
		-- Is the attribute a date & time value?
		do
			Result := type_code = table_description.Date_time_type
		end

	is_integer: BOOLEAN is
			-- Is the attribute an integer value?
		do
			Result := type_code = table_description.Integer_type
		end

	is_real: BOOLEAN is
		-- Is the attribute a date & time value?
		do
			Result := type_code = table_description.Real_type
		end

	is_string: BOOLEAN is
		-- Is the attribute a date & time value?
		do
			Result := type_code = table_description.String_type
		end

	is_date: BOOLEAN
		-- Is the attribute a date only value?

	use_redirection: BOOLEAN is
			-- Is the display a redirection from the attribute? 
		do
			Result := redirector /= Void
		end
	
	has_changed: BOOLEAN
			-- Has the user changed the field content?

	is_cleared: BOOLEAN 
			-- Has the field been cleared?

	graphical_title_set: BOOLEAN is
			-- Is a graphical title set?
		do
			Result := graphical_title /= Void
		end

	graphical_type_set: BOOLEAN is
			-- Is a graphical type set?
		do
			Result := graphical_type /= Void
		end

	graphical_value_set: BOOLEAN is
			-- Is a graphical value set?
		do
			Result := graphical_value /= Void
		end

	can_update: BOOLEAN is
			-- Can value held be updated?
		do
			Result := redirector /= Void implies redirector.can_invert
		end

feature -- Status setting

	set_is_date is
			-- Field must contain a date value.
		require
			is_datetime: is_datetime
		do
			is_date := True
		ensure
			is_datetime: is_datetime
			is_date: is_date
		end

feature -- Basic operations

	set_graphical_title (g_title: DV_SENSITIVE_STRING) is
			-- Set graphical title to `g_title'.
		require
			not_activated: not is_activated
			not_void: g_title /= Void
		do
			if g_title.value = void and then graphical_title_set
					and then graphical_title.value /= Void then
				g_title.set_value (graphical_title.value)
			end
			graphical_title := g_title
		end

	set_graphical_type (g_type: DV_SENSITIVE_STRING) is
			-- Set graphical type to `g_type'.
		require
			not_activated: not is_activated
			not_void: g_type /= Void
		do
			if g_type.value = void and then graphical_type_set
					and then graphical_type.value /= Void then
				g_type.set_value (graphical_type.value)
			end
			graphical_type := g_type
		end

	set_graphical_value (g_value: DV_SENSITIVE_STRING) is
			-- Set graphical value to `g_value'.
		require
			not_activated: not is_activated
			not_void: g_value /= Void
		do
			graphical_value := g_value
		end

	set_title (t: STRING) is
			-- Set component `title' to `t'.
		require
			not_activated: not is_activated
			graphical_title_set: graphical_title_set
		do
			graphical_title.set_value (t)
		end

	set_type (t: STRING) is
			-- Set component `type' to `t'.
		require
			not_activated: not is_activated
			graphical_type_set: graphical_type_set
		do
			graphical_type.set_value (t)
		end

	set_redirector (a_redirector: DV_VALUE_REDIRECTOR) is
			-- Set `redirector' to redirect an integer to the associated string.
		require
			not_activated: not is_activated
		do
			redirector := a_redirector
		end

feature {DV_COMPONENT} -- Status report

	is_update_valid: BOOLEAN
			-- Is value entered by the user valid?

	error_message: STRING
			-- Error message if values entered by the user
			-- are not valid.

feature {DV_COMPONENT} -- Status setting

	enable_has_changed is
			-- Enable `has_changed'.
		require
			is_activated: is_activated
		do
			has_changed := True
		end

feature {DV_COMPONENT} -- Basic operations

	set_table_description (table_descr: DB_TABLE_DESCRIPTION) is
			-- Set `table_descr' to finish
			-- locating table attribute in the database.
		require
			not_activated: not is_activated
		do
			table_description := table_descr
			type_code := table_description.type_list.i_th (attribute_code)
		end

	activate is
			-- Activate component.
		do
			if graphical_title_set and then graphical_title.value = Void then
				graphical_title.set_value (table_description.description_list.i_th (attribute_code))
			end
			type_name := table_description.printable_type_table.item
							(table_description.type_list.i_th (attribute_code))
			if graphical_type_set and then graphical_type.value = Void then
				graphical_type.set_value (type_name)
			end
			is_activated := True
		end

	clear is
			-- Clear displayed text.
		require
			is_activated: is_activated
		do
			has_changed := False
			is_cleared := True
			graphical_value.set_value ("")
			disable_sensitive
		end

	update_tablerow (default_tablerow: DB_TABLE_DESCRIPTION) is
			-- Displayed object with user changes. Fields unchanged are taken
			-- from `default_tablerow'.
		require
			is_activated: is_activated
			field_active: not is_cleared
			can_update: can_update
		local
			d: DATE
			dt: DATE_TIME
			double_data: DOUBLE_REF
			string_data: STRING
			integer_data: INTEGER_REF
			boolean_data: BOOLEAN_REF
			character_data: CHARACTER_REF
		do
			is_update_valid := True
			if has_changed or else not text.is_equal (database_text) then
				if is_string then
					if redirector /= Void then
						string_data ?= redirector.inverted_value (text)
						if string_data /= Void then
							default_tablerow.set_attribute (attribute_code, string_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						default_tablerow.set_attribute (attribute_code, text)
					end
				elseif is_double then
					if redirector /= Void then
						double_data ?= redirector.inverted_value (text)
						if double_data /= Void then
							default_tablerow.set_attribute (attribute_code, double_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						if text.is_double then
							default_tablerow.set_attribute (attribute_code, text.to_double)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, graphical_title.value)
						end
					end
				elseif is_datetime then
					if not text.is_empty then
						if is_date then
							create d.make_now
							if d.date_valid_default (text) then
								create d.make_from_string_default (text)
								create dt.make_by_date (d)
								default_tablerow.set_attribute (attribute_code, dt)
							else
								is_update_valid := False
								error_message := wrong_date_format (graphical_title.value)
								create d.make_now
									-- `database_text' will be updated so if user
									-- doesn't change the value, it won't be changed
									-- in the database: this is the behavior
									-- expected.
								set_text (d.out)
							end
						else
							create dt.make_now
							if dt.date_time_valid (text, dt.default_format_string) then
								create dt.make_from_string_default (text)
								default_tablerow.set_attribute (attribute_code, dt)
							else
								is_update_valid := False
								error_message := wrong_datetime_format (graphical_title.value)
								create dt.make_now
									-- `database_text' will be updated so if user
									-- doesn't change the value, it won't be changed
									-- in the database: this is the behavior
									-- expected.
								set_text (dt.out)
								enable_has_changed
							end
						end
					else
						default_tablerow.set_attribute (attribute_code, Void)
					end
				elseif is_integer then
					if redirector /= Void then
						integer_data ?= redirector.inverted_value (text)
						if integer_data /= Void then
							default_tablerow.set_attribute (attribute_code, integer_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						if text.is_integer then
							default_tablerow.set_attribute (attribute_code, text.to_integer)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, graphical_title.value)
						end
					end
				elseif is_real then
					if redirector /= Void then
						double_data ?= redirector.inverted_value (text)
						if double_data /= Void then
							default_tablerow.set_attribute (attribute_code, double_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						if text.is_double then
							default_tablerow.set_attribute (attribute_code, text.to_double)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, graphical_title.value)
						end
					end
				elseif is_character then
					if redirector /= Void then
						character_data ?= redirector.inverted_value (text)
						if character_data /= Void then
							default_tablerow.set_attribute (attribute_code, character_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						if text.count = 1 then
							default_tablerow.set_attribute (attribute_code, text.item (1))
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, graphical_title.value)
						end
					end
				elseif is_boolean then
					if redirector /= Void then
						boolean_data ?= redirector.inverted_value (text)
						if boolean_data /= Void then
							default_tablerow.set_attribute (attribute_code, boolean_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, graphical_title.value)
						end
					else
						if text.is_boolean then
							default_tablerow.set_attribute (attribute_code, text.to_boolean)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, graphical_title.value)
						end
					end
				else
					is_update_valid := False
					error_message := type_not_recognized (graphical_title.value)
				end
			end
		end

	enable_sensitive is
			-- Request display sensitive.
		do
			if graphical_title /= void then
				graphical_title.request_sensitive
			end
			if graphical_type /= void then
				graphical_type.request_sensitive
			end
			graphical_value.request_sensitive
		end

	disable_sensitive is
			-- Request display insensitive.
		do
			if graphical_title /= void then
				graphical_title.request_insensitive
			end
			if graphical_type /= void then
				graphical_type.request_insensitive
			end
			graphical_value.request_insensitive
		end

	refresh (table_row: DB_TABLE_DESCRIPTION) is
			-- set `text' with value of attribute 
			-- with code `attribute_code' of `table_row'.
		require
			is_activated: is_activated
			typing_ok: table_row.Table_code = attribute_code
		do
			if is_date or else is_datetime then
				set_datetime (table_row)
			else
				if redirector /= Void then
					set_text (redirector.redirected_value (table_row.attribute (attribute_code)))
				else
					set_text (table_row.printable_attribute (attribute_code))
				end
			end
		end

feature {NONE} -- Implementation

	set_text (s: STRING) is
			-- Set `s' to displayed text.
			-- Warning: call `enable_has_changed' after
			-- to notify that field has changed.
		require
			is_activated: is_activated
		do
			has_changed := False
			is_cleared := False
			database_text := s
			graphical_value.set_value (s)
			enable_sensitive
		end

	set_datetime (table_row: DB_TABLE_DESCRIPTION) is
			-- Set a date or a date & time value.
		local
			dt: DATE_TIME
		do
			dt ?= table_row.attribute (attribute_code)
			if dt /= Void then
				if is_date then
					set_text (dt.date.out)
				else
					set_text (dt.out)
				end
			else
				set_text ("")
			end
		end

	redirector: DV_VALUE_REDIRECTOR
			-- Value redirector.

	database_text: STRING
			-- Field content contained in database.

	type_code: INTEGER
			-- Represented field type code.
	
	type_name: STRING;
			-- Represented field type name.

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

end -- class DV_TABLEROW_FIELD



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

