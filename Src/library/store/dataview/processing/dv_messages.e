indexing
	description: "Objects that stores default messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_MESSAGES

feature -- Creation

	creation_done (table_name: STRING): STRING is
			-- Table row creation on `table_name' successful message.
		do
			Result := "Database creation on table " + table_name + " done."
		end

	creation_confirmation (table_name: STRING): STRING is
			-- Table row creation on `table_name' confirmation message.
		do
			Result := "Do you really want to create the " + table_name + " row?"
		end

feature -- Selection

	tablerows_selected (count: INTEGER): STRING is
			-- Database selection carried out message. `count' table rows
			-- have been selected.
		local
			plural: STRING
		do
			if count > 1 then
				plural := "s"
			else
				plural := ""
			end
			Result := count.out + " table row" + plural + " selected."
		end

feature -- Update

	update_done (table_name: STRING): STRING is
			-- Table row update on `table_name' successful message.
		do
			Result := "Database update on table " + table_name + " done."
		end

feature -- Deletion

	deletion_done (table_name: STRING): STRING is
			-- Table row deletion on `table_name' successful message.
		do
			Result := "Database deletion on table " + table_name + " done."
		end

	deletion_confirmation (table_name: STRING): STRING is
			-- Table row deletion on `table_name' confirmation message.
		do
			Result := "Do you really want to delete selected " + table_name + " row %Nfrom the database?"
		end

feature --

	retrieve_field_value (type, name: STRING): STRING is
			-- Value of field with `name' and `type' retrieval failure message.
		do
			Result := "Cannot retrieve " + type + " value for field '"
					+ name + "'."
		end
					
	enter_field_value (type, name: STRING): STRING is
			-- Value of field with `name' and `type' not valid message.
		do
			Result := "Please enter a " + type + " value for field '"
					+ name + "'."
		end

	type_not_recognized (name: STRING): STRING is
			-- Type of field with `name' not recognized message.
		do					
			Result := "Field '" + name + "' type not recognized."
		end

	wrong_date_format (name: STRING): STRING is
			-- Wrong date type format for field with `name' message.
		do
			Result := "Date format not valid for field: '"
					+ name + "'.%NPlease see sample in field to make sure %
					%to enter a valid date. Please 'Refresh' to restore original value."
		end

	wrong_datetime_format (name: STRING): STRING is
			-- Wrong date & time type format for field with `name' message.
		do
			Result := "Date & time format not valid for field: '"
					+ name + "'.%NPlease see sample in field to make sure %
					%to enter a valid date & time. Please 'Refresh' to restore original value."
		end

feature -- Window to select foreign key values for creation

	selection_window_title (table_name: STRING): STRING is
			-- Selection window title.
		do
			Result := "Select a related " + table_name + " row:"
		end

	Undetermined_table_name: STRING is
			-- Undetermined table name (use for `selection_window_title').
		do
			Result := "table"
		end

feature -- Combo box

	Empty_combo_item_label: STRING is
			-- Label for an empty combo item value.
		do
			Result := "(Empty)"
		end 

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





end -- class DV_MESSAGES


