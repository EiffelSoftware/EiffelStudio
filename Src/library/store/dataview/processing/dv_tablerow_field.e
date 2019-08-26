note
	description: "Graphic objects representing a database table attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TABLEROW_FIELD

inherit
	DV_COMPONENT

	DV_MESSAGES

	TIME_UTILITY
		export
			{NONE} all
		end

create
	make_with_code

feature -- Initialization

	make_with_code (code: INTEGER)
			-- Initialize with `code' to
			-- locate table attribute in the database.
		do
			attribute_code := code
			create error_message.make_empty
			database_text := ""
		end

feature -- Access

	attribute_code: INTEGER
			-- Code of the represented attribute in the
			-- database table.

	table_description: detachable DB_TABLE_DESCRIPTION
			-- Description of the database table containing
			-- the represented attribute.

	text: STRING_32
			-- Field text.
		do
			if attached graphical_value as l_gv then
				Result := l_gv.value
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	graphical_title: detachable DV_SENSITIVE_STRING
			-- Graphical element holding field title.

	graphical_type: detachable DV_SENSITIVE_STRING
			-- Graphical element holding field type.

	graphical_value: detachable DV_SENSITIVE_STRING
			-- Graphical element holding field value.

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can the component be activated?
		do
			Result := graphical_value_set and then table_description /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

	is_boolean: BOOLEAN
			-- Is the attribute a boolean value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Boolean_type
		end

	is_character: BOOLEAN
			-- Is the attribute a character value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Character_type
		end

	is_double: BOOLEAN
			-- Is the attribute a double value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Double_type
		end

	is_datetime: BOOLEAN
		-- Is the attribute a date & time value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Date_time_type
		end

	is_integer: BOOLEAN
			-- Is the attribute an integer value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Integer_type
		end

	is_real: BOOLEAN
		-- Is the attribute a date & time value?
		do
			Result := attached table_description as l_table and then type_code = l_table.Real_type
		end

	is_string: BOOLEAN
		-- Is the attribute a date & time value?
		do
			Result := attached table_description as l_table and then type_code = l_table.String_type
		end

	is_date: BOOLEAN
		-- Is the attribute a date only value?

	use_redirection: BOOLEAN
			-- Is the display a redirection from the attribute?
		do
			Result := redirector /= Void
		end

	has_changed: BOOLEAN
			-- Has the user changed the field content?

	is_cleared: BOOLEAN
			-- Has the field been cleared?

	graphical_title_set: BOOLEAN
			-- Is a graphical title set?
		do
			Result := graphical_title /= Void
		end

	graphical_type_set: BOOLEAN
			-- Is a graphical type set?
		do
			Result := graphical_type /= Void
		end

	graphical_value_set: BOOLEAN
			-- Is a graphical value set?
		do
			Result := graphical_value /= Void
		end

	can_update: BOOLEAN
			-- Can value held be updated?
		do
			Result := attached redirector as l_redirector implies l_redirector.can_invert
		end

feature -- Status setting

	set_is_date
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

	set_graphical_title (g_title: DV_SENSITIVE_STRING)
			-- Set graphical title to `g_title'.
		require
			not_activated: not is_activated
			not_void: g_title /= Void
		do
			if
				g_title.value = Void and then attached graphical_title as l_gtitle and then
				l_gtitle.value /= Void
			then
				g_title.set_value (l_gtitle.value)
			end
			graphical_title := g_title
		end

	set_graphical_type (g_type: DV_SENSITIVE_STRING)
			-- Set graphical type to `g_type'.
		require
			not_activated: not is_activated
			not_void: g_type /= Void
		do
			if
				g_type.value = Void and then attached graphical_type as l_gtype and then
				l_gtype.value /= Void
			then
				g_type.set_value (l_gtype.value)
			end
			graphical_type := g_type
		end

	set_graphical_value (g_value: DV_SENSITIVE_STRING)
			-- Set graphical value to `g_value'.
		require
			not_activated: not is_activated
			not_void: g_value /= Void
		do
			graphical_value := g_value
		end

	set_title (t: STRING)
			-- Set component `title' to `t'.
		require
			not_activated: not is_activated
			graphical_title_set: graphical_title_set
		do
			if attached graphical_title as l_gtitle then
				l_gtitle.set_value (t)
			end
		end

	set_type (t: STRING)
			-- Set component `type' to `t'.
		require
			not_activated: not is_activated
			graphical_type_set: graphical_type_set
		do
			if attached graphical_type as l_gtype then
				l_gtype.set_value (t)
			end
		end

	set_redirector (a_redirector: DV_VALUE_REDIRECTOR)
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

	enable_has_changed
			-- Enable `has_changed'.
		require
			is_activated: is_activated
		do
			has_changed := True
		end

feature {DV_COMPONENT} -- Basic operations

	set_table_description (table_descr: DB_TABLE_DESCRIPTION)
			-- Set `table_descr' to finish
			-- locating table attribute in the database.
		require
			not_activated: not is_activated
		do
			table_description := table_descr
			type_code := table_descr.type_list.i_th (attribute_code)
		end

	activate
			-- Activate component.
		do
			if attached table_description as l_table then
				if attached graphical_title as l_gtitle and then l_gtitle.value = Void then
					l_gtitle.set_value (l_table.description_list.i_th (attribute_code))
				end
				type_name := l_table.printable_type_table.item
								(l_table.type_list.i_th (attribute_code))
				if attached graphical_type as l_gtype and then l_gtype.value = Void then
					if attached type_name as l_type_name then
						l_gtype.set_value (l_type_name)
					end
				end
				is_activated := True
			end
		end

	clear
			-- Clear displayed text.
		require
			is_activated: is_activated
		do
			has_changed := False
			is_cleared := True
			if attached graphical_value as l_gv then
				l_gv.set_value ("")
			end
			disable_sensitive
		end

	update_tablerow (default_tablerow: DB_TABLE_DESCRIPTION)
			-- Displayed object with user changes. Fields unchanged are taken
			-- from `default_tablerow'.
		require
			is_activated: is_activated
			field_active: not is_cleared
			can_update: can_update
		local
			d: DATE
			dt: DATE_TIME
			l_date_text: STRING
			l_title: READABLE_STRING_GENERAL
		do
			if attached graphical_title as l_gtitle then
				l_title := l_gtitle.value
			else
				l_title := ""
			end
			is_update_valid := True
			if has_changed or else not text.same_string_general (database_text) then
				if is_string then
					if attached redirector as l_redirector then
						if attached {READABLE_STRING_GENERAL} l_redirector.inverted_value (text) as l_string_data then
							default_tablerow.set_attribute (attribute_code, l_string_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						default_tablerow.set_attribute (attribute_code, text)
					end
				elseif is_double then
					if attached redirector as l_redirector then
						if attached {DOUBLE_REF} l_redirector.inverted_value (text) as l_double_data then
							default_tablerow.set_attribute (attribute_code, l_double_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						if text.is_double then
							default_tablerow.set_attribute (attribute_code, text.to_double)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, l_title)
						end
					end
				elseif is_datetime then
					if
						not text.is_empty and then
						text.is_valid_as_string_8
					then
						l_date_text := text.to_string_8
						if is_date then
							create d.make_now
							if d.date_valid_default (l_date_text) then
								create d.make_from_string_default (l_date_text)
								create dt.make_by_date (d)
								default_tablerow.set_attribute (attribute_code, dt)
							else
								is_update_valid := False
								error_message := wrong_date_format (l_title)
								create d.make_now
									-- `database_text' will be updated so if user
									-- doesn't change the value, it won't be changed
									-- in the database: this is the behavior
									-- expected.
								set_text (d.out)
							end
						else
							create dt.make_now
							if dt.date_time_valid (l_date_text, default_format_string) then
								create dt.make_from_string_default (l_date_text)
								default_tablerow.set_attribute (attribute_code, dt)
							else
								is_update_valid := False
								error_message := wrong_datetime_format (l_title)
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
					if attached redirector as l_redirector then
						if attached {INTEGER_REF} l_redirector.inverted_value (text) as l_integer_data then
							default_tablerow.set_attribute (attribute_code, l_integer_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						if text.is_integer then
							default_tablerow.set_attribute (attribute_code, text.to_integer)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, l_title)
						end
					end
				elseif is_real then
					if attached redirector as l_redirector then
						if attached {DOUBLE_REF} l_redirector.inverted_value (text) as l_double_data then
							default_tablerow.set_attribute (attribute_code, l_double_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						if text.is_double then
							default_tablerow.set_attribute (attribute_code, text.to_double)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, l_title)
						end
					end
				elseif is_character then
					if attached redirector as l_redirector then
						if attached {CHARACTER_REF} l_redirector.inverted_value (text) as l_character_data then
							default_tablerow.set_attribute (attribute_code, l_character_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						if text.count = 1 then
							default_tablerow.set_attribute (attribute_code, text.item (1))
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, l_title)
						end
					end
				elseif is_boolean then
					if attached redirector as l_redirector then
						if attached {BOOLEAN_REF} l_redirector.inverted_value (text) as l_boolean_data then
							default_tablerow.set_attribute (attribute_code, l_boolean_data)
						else
							is_update_valid := False
							error_message := retrieve_field_value (type_name, l_title)
						end
					else
						if text.is_boolean then
							default_tablerow.set_attribute (attribute_code, text.to_boolean)
						else
							is_update_valid := False
							error_message := enter_field_value (type_name, l_title)
						end
					end
				else
					is_update_valid := False
					error_message := type_not_recognized (l_title)
				end
			end
		end

	enable_sensitive
			-- Request display sensitive.
		do
			if attached graphical_title as l_gt then
				l_gt.request_sensitive
			end
			if attached graphical_type as l_gtype then
				l_gtype.request_sensitive
			end
			if attached graphical_value as l_gv then
				l_gv.request_sensitive
			end
		end

	disable_sensitive
			-- Request display insensitive.
		do
			if attached graphical_title as l_gt then
				l_gt.request_insensitive
			end
			if attached graphical_type as l_gtype then
				l_gtype.request_insensitive
			end
			if attached graphical_value as l_gv then
				l_gv.request_insensitive
			end
		end

	refresh (table_row: DB_TABLE_DESCRIPTION)
			-- set `text' with value of attribute
			-- with code `attribute_code' of `table_row'.
		require
			is_activated: is_activated
			typing_ok: table_row.Table_code = attribute_code
		do
			if is_date or else is_datetime then
				set_datetime (table_row)
			else
				if attached redirector as l_redirector then
					set_text (l_redirector.redirected_value (table_row.attribute_value (attribute_code)))
				else
					set_text (table_row.printable_attribute (attribute_code))
				end
			end
		end

feature {NONE} -- Implementation

	set_text (s: READABLE_STRING_GENERAL)
			-- Set `s' to displayed text.
			-- Warning: call `enable_has_changed' after
			-- to notify that field has changed.
		require
			is_activated: is_activated
		do
			has_changed := False
			is_cleared := False
			database_text := s.to_string_32
			if attached graphical_value as l_gv then
				l_gv.set_value (s)
			end
			enable_sensitive
		end

	set_datetime (table_row: DB_TABLE_DESCRIPTION)
			-- Set a date or a date & time value.
		do
			if attached {DATE_TIME} table_row.attribute_value (attribute_code) as dt then
				if is_date then
					set_text (dt.date.out)
				else
					set_text (dt.out)
				end
			else
				set_text ("")
			end
		end

	redirector: detachable DV_VALUE_REDIRECTOR
			-- Value redirector.

	database_text: STRING_32
			-- Field content contained in database.

	type_code: INTEGER
			-- Represented field type code.

	type_name: detachable STRING;
			-- Represented field type name.

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

end -- class DV_TABLEROW_FIELD



