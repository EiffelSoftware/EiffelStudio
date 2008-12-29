note
	description: "Objects that enable to rows of a database table."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TYPED_SEARCHER

inherit
	DV_SEARCHER
		redefine
			set_table_code
		end

create
	make

feature -- Initialization

	make
			-- Initialization.
		do
		end

feature -- Access

	Every_row: INTEGER = 0
			-- Every table row are selected.

	Id_selection: INTEGER = 1
			-- Table row is selected by its ID.

	Qualified_selection: INTEGER = 2
			-- Table row is selected with a qualifier.

feature -- Status report

	is_activated: BOOLEAN
			-- Is the component activated?

	behavior_type: INTEGER
			-- Component behavior type: read all table rows,
			-- tablerows selected by ID or by a qualifier.

	valid_behavior_type (behavior: INTEGER): BOOLEAN
			-- Is `behavior' valid?
		do
			Result := behavior >= Every_row and then behavior <= Qualified_selection
		end

feature -- Basic operations

	set_behavior_type (behavior: INTEGER)
			-- Initialization.
		require
			valid_behavior_type: valid_behavior_type (behavior)
		do
			behavior_type := behavior
		end

	set_criterion (code: INTEGER)
			-- Set table attribute `code' as criterion
			-- for database read.
		require
			behavior_is_valid: behavior_type = Qualified_selection
		do
			criterion := code
		end

	set_row_attribute_code (attr_code: INTEGER)
			-- Set `attr_code' as attribute code corresponding to criterion value to
			-- match with the query.
		require
			valid_code: True
			behavior_is_valid: behavior_type = Qualified_selection
		do
			attribute_code := attr_code
		end

	read_from_tablerow (db_table: DB_TABLE)
			-- Extract criterion_value from `db_table' using `attribute_code'
			-- and read database on table with `table_code' with a selection
			-- qualified by `criterion'.
		require
			is_activated: is_activated
			valid_behavior: behavior_type = Id_selection or else behavior_type = Qualified_selection
			user_component_set: user_component_set
		do
			if behavior_type = Id_selection and attribute_code = 0 then
				attribute_code := db_table.table_description.id_code
			end
			last_criterion_value := db_table.table_description.attribute (attribute_code)
			read
		end

	read
			-- Extract criterion_value from `db_table' using `attribute_code'
			-- and read database on table with `table_code' with a selection
			-- qualified by `criterion'.
		require
			is_activated: is_activated
			user_component_set: user_component_set
		do
			db_table_component.display (refresh)
		end

feature {DV_COMPONENT} -- Basic operations

	activate
			-- Activate component.
		do
			is_activated := True
		end

	set_table_code (tcode: INTEGER)
			-- Set `tcode' as code of database table from which table rows
			-- will be selected.
		do
			Precursor  (tcode)
			if behavior_type = Id_selection then
				criterion := tables.description (tcode).id_code
			end
		end

	refresh: ARRAYED_LIST [DB_TABLE]
			-- Read database with same qualifying value as last call of `db_read'.
		local
			database_handler: ABSTRACT_DB_TABLE_MANAGER
		do
			database_handler := db_table_component.database_handler
			database_handler.prepare_select_with_table (table_code)
			if behavior_type = Id_selection or else behavior_type = Qualified_selection then
				database_handler.add_value_qualifier (criterion, last_criterion_value.out)
			end
			database_handler.load_result
			if database_handler.has_error then
				db_table_component.warning_handler.call ([database_handler.error_message])
				create Result.make (0)
			else
				Result := database_handler.database_result_list
			end
		end

	clear
			-- Clear user component.
		require
			is_activated: is_activated
		do
			db_table_component.clear
		end

feature {NONE} -- Implementation

	criterion: INTEGER
			-- Criterion table attribute.

	last_criterion_value: ANY
			-- Last criterion value for database selections set
			-- from `read_from_tablerow'. ANY must represent one of the possible
			-- table row types.
	
	attribute_code: INTEGER;
			-- Code of attribute containing the criterion value to match
			-- for a database selection.
	--|||		-- Code of the table ID attribute if behavior is ID selection.
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_TYPED_SEARCHER





