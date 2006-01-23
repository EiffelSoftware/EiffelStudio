indexing
	description: "Implementation of a SQL Statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	names: SQL_statement, query
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_statement.e $"

class
	OCI_STATEMENT

inherit
	OCI_CHILD_HANDLE
		redefine
			free
		end
	
	OCI_DEFINITIONS
		export {NONE} all
		undefine
			is_equal
		end
		
create
	make, make_by_handle

feature -- Access

	sql_text: STRING
			-- Current SQL text

	statement_type: INTEGER is
			-- Type of SQL statement (see OCI_CONST)
		require
			prepared: is_prepared
		do
			Result := stmt_type
		end
		
	function_code: INTEGER is
			-- Function code of the SQL command associated with the statement
		require
			prepared: is_prepared
		do
			Result := int16_attr (Oci_attr_sqlfncode, error_handler)
		end
		
	column_count: INTEGER is
			-- The number of columns in the select-list for the statement
		require
			described: is_described
		do
			Result := column_list.count
		end
	
	column (index: INTEGER): OCI_COLUMN_PARAM is
			-- `index'th column in select-list
		require
			described: is_described
			valid_index: index > 0 and index <= column_count
		do
			Result := column_list @ index
		end
		
	index_of_column (name: STRING): INTEGER is
			-- Index of the column with given name; 0 means not found
		require
			described: is_described
			name_not_empty: name /= Void and name.count /= 0
		local
			i: INTEGER
		do
			from
				i := column_list.lower
			until
				i > column_list.upper or Result /= 0
			loop
				if column_list.item (i).name.is_equal (name) then
					Result := i
				end
				i := i + 1
			end
		end
		
	index_of_variable (name: STRING): INTEGER is
			-- Index of the bind-variable with given name; 0 means not found
		require
			name_not_empty: name /= Void and name.count /= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > binds.count or Result /= 0
			loop
				if (binds @ i).name.is_equal (name) then
					Result := i
				end
				i := i + 1
			end
		end
		
	numbers_as_strings: BOOLEAN
		-- Treat NUMBER columns as strings ?

	dates_as_strings: BOOLEAN
		-- Treat DATE columns as strings ?
		
	auto_fetch_first_row: BOOLEAN
		-- Automatically fetch the first row on `execute' ?
	
	column_value (name: STRING): ANY is
			-- Value of the column `name' in the current row
		require
			is_query: is_prepared and then is_query
			described: is_described
			executed: is_executed
			not_eof: not eof
			row_fetched: rows_fetched > 0
			column_exists: index_of_column (name) > 0
		local
			index: INTEGER
		do
			index := index_of_column (name)
			Result := defines.item (index).value
		end
		
	is_column_defined (name: STRING): BOOLEAN is
			-- Does column `name' exist in select-list and is of a valid type ?
		require
			is_query: is_prepared and then is_query
			described: is_described
			defined: is_defined
		local
			index: INTEGER
			def: OCI_DEFINE
		do
			index := index_of_column (name)
			if index /= 0 then
				def := defines.item (index)
				Result := def /= Void
			else
				Result := False
			end
		end
		
	is_column_null (name: STRING): BOOLEAN is
			-- Is value of the column `name' in the current row NULL ?
		require
			is_query: is_prepared and then is_query
			described: is_described
			executed: is_executed
			not_eof: not eof
			row_fetched: rows_fetched > 0
			column_defined: is_column_defined (name)
		local
			index: INTEGER
		do
			index := index_of_column (name)
			Result := defines.item (index).is_null
		end
		
	variable_value (name: STRING): ANY is
			-- Value of bind-variable `name'
		require
			is_query: is_prepared and then is_query
			variable_exists: index_of_variable (name) > 0
		local
			index: INTEGER
		do
			index := index_of_variable (name)
			Result := (binds @ index).value
		end
		
	row_count: INTEGER is
			-- The number of rows processed so far
		require
			executed: is_executed
		do
			Result := int_attr (Oci_attr_row_count, error_handler)
		end
		
	current_row: ARRAY [ANY] is
			-- Entire current row (the last row fetched) as an ARRAY.
			-- Database NULLs represented as Void.
			-- Note: items get overriden every time a row is fetched (by `execute' or `fetch_next').
		require
			is_query: is_prepared and then is_query
			described: is_described
			executed: is_executed
			not_eof: not eof
			row_fetched: rows_fetched > 0
		do
				-- Make sure `row_data' is filled with actual column values
			if not row_data_filled then
				fill_row_data
			end
			Result := row_data
		ensure
			current_row_exists: Result /= Void
			correct_number_of_items: Result.count = column_count
		end
		
feature -- Status report

	failed: BOOLEAN
		-- Has last operation failed ?

	is_prepared: BOOLEAN
		-- Has statement been prepared?

	is_executed: BOOLEAN
		-- Has statement been executed?
	
	is_described: BOOLEAN
		-- Has statement been described ?
	
	is_defined: BOOLEAN
		-- Has statement been defined ?
	
	eof: BOOLEAN
		-- Has end of data been reached ?
	
	rows_fetched: INTEGER
		-- Number of rows already fetched
	
	num_dml_errors: INTEGER is
			-- The number of errors in the DML operation
		require
			executed: is_executed
			is_dml: is_prepared and then is_dml
		do
			Result := int_attr (Oci_attr_num_dml_errors, error_handler)
		end
		
	parse_error_offset: INTEGER is
			-- The parse error offset for the statement
		require
			prepared: is_prepared
			--? described: is_described
		do
			Result := int16_attr (Oci_attr_parse_error_offset, error_handler)
		end
		
	is_valid: BOOLEAN is
			-- Is `Current' statement of a known type ?
		do
			Result := known_statement_type (statement_type)
		end
		
	is_query: BOOLEAN is
			-- Is `Current' statement a query ?
		do
			Result := is_query_type (statement_type)
		end

	is_dml: BOOLEAN is
			-- Is `Current' statement a DML statement ?
		do
			Result := is_dml_type (statement_type)
		end

	is_ddl: BOOLEAN is
			-- Is `Current' statement a DDL statement ?
		do
			Result := is_ddl_type (statement_type)
		end

	is_pl_sql: BOOLEAN is
			-- Is `Current' statement a PL/SQL statement ?
		do
			Result := is_pl_sql_type (statement_type)
		end

feature -- Status setting

	free is
			-- Free the handle and reset status flags
		do
			Precursor
			column_list := Void
			binds := Void
			defines := Void
			row_data := Void
			rows_fetched := 0
			is_prepared := False
			is_described := False
			is_defined := False
			is_executed := False
			eof := False
			failed := False
		end

feature -- Basic operations

	prepare (text: STRING) is
			-- Prepare a SQL statement
		local
			status: INTEGER_16
			area: WEL_STRING
		do
			is_described := False
			is_defined := False
			is_executed := False
			eof := False
			column_list := Void
			binds := Void
			defines := Void
			if text /= Void then				
				sql_text := text.twin
			end
			create area.make (sql_text)
			status := oci_stmt_prepare (handle, error_handler.handle, area.item, text.count,
					Oci_ntv_syntax, Oci_default)
			failed := status = Oci_error
			error_handler.check_error (status)
			is_prepared := not failed
			if is_prepared then
				stmt_type := int16_attr (Oci_attr_stmt_type, error_handler)
				create binds.make (0)
			end
		ensure
			success_unless_failed: (not failed) implies is_prepared
			not_described: not is_described
			not_defined: not is_defined
			not_executed: not is_executed
			not_eof: not eof
		end

	set_prefetch_rows (rows: INTEGER) is
			-- Set the number of top level rows to be prefetched
		require
			valid_argument: rows > 0
		do
			set_int_attr (Oci_attr_prefetch_rows, rows, error_handler)
		end
		
	declare_string_variable (name: STRING; size: INTEGER) is
			-- Declare a STRING bind-variable
		require
			prepared: is_prepared
			new_variable: index_of_variable (name) = 0
		local
			var: OCI_BIND_STRING
		do
			create var.make (size)
			binds.extend (var)
		ensure
			one_more_variable: binds.count = old binds.count + 1
		end
		
	declare_integer_variable (name: STRING) is
			-- Declare an INTEGER bind-variable
		require
			prepared: is_prepared
			new_variable: index_of_variable (name) = 0
		local
			var: OCI_BIND_INTEGER
		do
			create var.make
			binds.extend (var)
		ensure
			one_more_variable: binds.count = old binds.count + 1
		end
		
	declare_double_variable (name: STRING) is
			-- Declare a DOUBLE bind-variable
		require
			prepared: is_prepared
			new_variable: index_of_variable (name) = 0
		local
			var: OCI_BIND_DOUBLE
		do
			create var.make
			binds.extend (var)
		ensure
			one_more_variable: binds.count = old binds.count + 1
		end
		
	declare_date_time_variable (name: STRING) is
			-- Declare a DATE_TIME bind-variable
		require
			prepared: is_prepared
			new_variable: index_of_variable (name) = 0
		local
			var: OCI_BIND_DATE_TIME
		do
			create var.make
			binds.extend (var)
		ensure
			one_more_variable: binds.count = old binds.count + 1
		end
		
	declare_cursor_variable (name: STRING) is
			-- Declare a CURSOR bind-variable
		require
			prepared: is_prepared
			new_variable: index_of_variable (name) = 0
		local
			var: OCI_BIND_CURSOR
		do
			create var.make
			binds.extend (var)
		ensure
			one_more_variable: binds.count = old binds.count + 1
		end
		
	assign_variable (name: STRING; value: ANY) is
			-- Assign a bind-variable
		require
			prepared: is_prepared
			variable_exists: index_of_variable (name) > 0
		local
			index: INTEGER
		do
			index := index_of_variable (name)
			(binds @ index).set_value (value)
		ensure
			assigned: (value /= Void and (variable_value (name) /= Void and then
				variable_value (name).is_equal (value))) or
				(value = Void and variable_value (name) = Void)
		end
		
	reset_variables is
			-- Reset values of all bind-variables to default values
		require
			prepared: is_prepared
		do
			-- To do
		end

	remove_variables is
			-- Remove all bind-variables
		require
			prepared: is_prepared
		do
			binds.wipe_out
		end
		
	set_numbers_as_strings (value: BOOLEAN) is
			-- Treat NUMBER columns as strings ?
		do
			numbers_as_strings := value
		ensure
			numbers_as_strings = value
		end

	set_dates_as_strings (value: BOOLEAN) is
			-- Treat DATE columns as strings ?
		do
			dates_as_strings := value
		ensure
			dates_as_strings = value
		end

	set_auto_fetch_first_row (value: BOOLEAN) is
			-- Automatically fetch the first row on `execute' ?
		do
			auto_fetch_first_row := value
		ensure
			auto_fetch_first_row = value
		end

	execute (context: OCI_SERVICE_CONTEXT) is
			-- Execute a prepared SQL statement in given `context'
		require
			valid_statement: is_prepared and then is_valid
		local
			iters: INTEGER
			status: INTEGER_16
		do
			row_data_filled := False
			if is_query and then not (is_defined and auto_fetch_first_row) then
					-- Defines haven't been done yet - can't fetch data
				iters := 0
			else
					-- For a query this will force fetching first row; must be 1 for other SQL
				iters := 1
			end
			rows_fetched := 0
			status := oci_stmt_execute (context.handle, handle, error_handler.handle, iters, 0, 
				default_pointer, default_pointer, Oci_default)
			failed := status = Oci_error
			error_handler.check_error (status)
			if not failed then
				is_described := True
				is_executed := True
				eof := status = Oci_no_data or else not is_query
				if is_query then
					build_column_list
					if not is_defined then
						define
						if auto_fetch_first_row then
								-- Try to fetch the first row now
							fetch_next
						end
					else
						if auto_fetch_first_row then
								-- The first row is already fetched by `oci_stmt_execute' above
							rows_fetched := 1
						end
					end
				end
			end
		ensure
			success_unless_failed: (not failed) implies (is_described and is_executed)
			first_row_fetched: (is_query and not failed and auto_fetch_first_row) implies rows_fetched = 1
		end
		
	describe (context: OCI_SERVICE_CONTEXT) is
			-- Describe a prepared SQL statement in given `context' without executing
		require
			valid_statement: is_prepared and then is_valid
		local
			status: INTEGER_16
		do
			row_data_filled := False
			status := oci_stmt_execute (context.handle, handle, error_handler.handle, 1, 0, 
					default_pointer, default_pointer, Oci_describe_only)
			failed := status = Oci_error
			error_handler.check_error (status)
			if not failed then
				is_described := status = Oci_success
				if is_query and is_described then
					build_column_list
				end
			end
		ensure
			success_unless_failed: (not failed) implies is_described
		end
		
	define is
			-- Define output variables based on the column list
		require
			described: is_described
			is_query: is_query
		local
			i: INTEGER
			param: OCI_COLUMN_PARAM
			def: OCI_DEFINE
		do
			create defines.make (1, column_list.upper)
			from
				i := 1
			until
				i > column_list.upper
			loop
				param := column_list @ i
				def := define_column (param)
				if def /= Void then
					def.define_by_pos (Current, error_handler, i)
				end
				defines.put (def, i)
				i := i + 1
			end
			is_defined := True
			create row_data.make (1, column_count)
		ensure
			defined: is_defined
			synchronized_with_column_list: defines /= Void and then 
				(defines.lower = column_list.lower and defines.upper = column_list.upper)
		end
		
	fetch_next is
			-- Fetch next row from a query
		require
			is_query: is_prepared and then is_query
			executed: is_executed
			defined: is_defined
			has_data: not eof
		local
			status: INTEGER_16
		do
			row_data_filled := False
			status := oci_stmt_fetch (handle, error_handler.handle, 1, Oci_fetch_next, Oci_default)
			failed := status = Oci_error
			error_handler.check_error (status)
			eof := status = Oci_no_data
			rows_fetched := rows_fetched + 1
		end
		
	cancel_fetch is
			-- Cancel the cursor
		require
			is_query: is_prepared and then is_query
			executed: is_executed
		local
			status: INTEGER_16
		do
			row_data_filled := False
			status := oci_stmt_fetch (handle, error_handler.handle, 0, Oci_fetch_next, Oci_default)
			failed := status = Oci_error
			error_handler.check_error (status)
		end

feature {OCI_HANDLE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_stmt
		end

feature {NONE} -- Implementation

	stmt_type: INTEGER_16
		-- Statement type

	column_list: ARRAY [OCI_COLUMN_PARAM]
		-- the list of column descriptors for a query
		
	binds: ARRAYED_LIST [OCI_BIND]
		-- bind-variables

	defines: ARRAY [OCI_DEFINE]
		-- define-variables, one per column

	row_data: ARRAY [ANY]
		-- Content of the last row fetched; valid only if `row_data_filled'

	row_data_filled: BOOLEAN
		-- Does `row_data' contain actual field values ?

	build_column_list is
			-- Build the column list (when query is being described)
		require
			is_query: is_prepared and then statement_type = Oci_stmt_select
		local
			param: OCI_COLUMN_PARAM
			i: INTEGER
		do
			create column_list.make (1, int_attr (Oci_attr_param_count, error_handler))
			from
				i := 1
			until
				i > column_list.upper
			loop
				create param.make (Current, i, error_handler)
				column_list.put (param, i)
				i := i + 1
			end
		ensure
			column_list_exists: column_list /= Void
		end
		
	define_column (col: OCI_COLUMN_PARAM): OCI_DEFINE is
			-- Create a define-variable associated with a column `col'; Void if unsupported datatype
		do
			inspect
				col.data_type
			when Sqlt_chr, Sqlt_str, Sqlt_vcs, Sqlt_afc, Sqlt_avc then
				create {OCI_DEFINE_STRING} Result.make (col.data_size)
			when Sqlt_bin then
					-- RAWs are converted to hex strings (2 characters per byte)
				create {OCI_DEFINE_STRING} Result.make (col.data_size * 2)
			when Sqlt_int, Sqlt_uin then
				if numbers_as_strings then
					create {OCI_DEFINE_STRING} Result.make (Max_number_string_length)
				else
					create {OCI_DEFINE_INTEGER} Result.make
				end
			when Sqlt_flt, Sqlt_num, Sqlt_pdn, Sqlt_vnu then
				if numbers_as_strings then
					create {OCI_DEFINE_STRING} Result.make (Max_number_string_length)
				else
					create {OCI_DEFINE_DOUBLE} Result.make
				end
			when Sqlt_dat, Sqlt_date, Sqlt_time, Sqlt_time_tz, Sqlt_timestamp, Sqlt_timestamp_tz,
					Sqlt_timestamp_ltz then
				if dates_as_strings then
					if col.data_type = Sqlt_timestamp_tz then
							-- Allow for additional zone info (e.g. " +10:00")
						create {OCI_DEFINE_STRING} Result.make (Max_date_string_length + 7)
					else
						create {OCI_DEFINE_STRING} Result.make (Max_date_string_length)
					end
				else
					create {OCI_DEFINE_DATE_TIME} Result.make
				end
			when Sqlt_interval_ym then
				create {OCI_DEFINE_STRING} Result.make (Year_to_month_length)
			when Sqlt_interval_ds then
				create {OCI_DEFINE_STRING} Result.make (Day_to_second_length)
			when Sqlt_lng then
				create {OCI_DEFINE_STRING} Result.make (Long_initial_size)
			when Sqlt_lab, Sqlt_osl then
				create {OCI_DEFINE_STRING} Result.make (255)
			when Sqlt_rid, Sqlt_rdd then
				create {OCI_DEFINE_STRING} Result.make (Rowid_length)
			when Sqlt_cur then
					-- Nested query
				create {OCI_DEFINE_CURSOR} Result.make
			else
				Result := Void
			end
		end
		
	fill_row_data is
			-- Fill `current_row' with actual data from the query
		require
			is_query: is_prepared and then is_query
			described: is_described
			executed: is_executed
			not_eof: not eof
			current_row_exists: row_data /= Void
			correct_number_of_items: row_data.count = column_count
		local
			value: ANY
			i: INTEGER
			def: OCI_DEFINE
		do
			from
				i := 1
			until
				i > row_data.upper
			loop
				def := defines.item (i)
				if def /= Void and then not def.is_null then
					value := def.value
				else
					value := Void
				end
				row_data.put (value, i)
				i := i + 1
			end
			row_data_filled := True
		ensure
			filled: row_data_filled
		end
		
	Unknown_statement_type_error: STRING is "Error: Unknown statement type"
	
	Max_number_string_length: INTEGER is 40
		
	Max_date_string_length: INTEGER is 40
	
	Long_initial_size: INTEGER is 32000
	
	Year_to_month_length: INTEGER is 8
	
	Day_to_second_length: INTEGER is 30
		
	Rowid_length: INTEGER is 18
		
	known_statement_type (type: INTEGER): BOOLEAN is
			-- Is `type' a known statement type ?
		do
			Result :=
				type = Oci_stmt_select or 
				type = Oci_stmt_update or
				type = Oci_stmt_delete or
				type = Oci_stmt_insert or
				type = Oci_stmt_create or
				type = Oci_stmt_drop or
				type = Oci_stmt_alter or
				type = Oci_stmt_begin or
				type = Oci_stmt_declare or
					-- Sometimes the statement type is 0.
				type = 0
		end
		
	is_query_type (type: INTEGER): BOOLEAN is
			-- Is `type' a query statement type ?
		do
			Result := type = Oci_stmt_select
		end

	is_dml_type (type: INTEGER): BOOLEAN is
			-- Is `type' a DML statement type ?
		do
			Result :=
				type = Oci_stmt_update or
				type = Oci_stmt_delete or
				type = Oci_stmt_insert
		end

	is_ddl_type (type: INTEGER): BOOLEAN is
			-- Is `type' a DDL statement type ?
		do
			Result :=
				type = Oci_stmt_create or
				type = Oci_stmt_drop or
				type = Oci_stmt_alter
		end

	is_pl_sql_type (type: INTEGER): BOOLEAN is
			-- Is `type' a PL/SQL statement type ?
		do
			Result :=
				type = Oci_stmt_begin or
				type = Oci_stmt_declare
		end

feature {NONE} -- Externals

	oci_stmt_prepare (stmtp: POINTER; errhp: POINTER; stmt: POINTER; stmt_len: INTEGER;
			language: INTEGER; mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, char *, int, int, int): short | %"oci.h%""
		alias
			"OCIStmtPrepare"
		end
		
	oci_stmt_execute (svchp: POINTER; stmtp: POINTER; errhp: POINTER; iters: INTEGER;
			rowoff: INTEGER; snap_in: POINTER; snap_out: POINTER; mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, void *, int, int, void *, void *, int): short | %"oci.h%""
		alias
			"OCIStmtExecute"
		end
		
	oci_stmt_fetch (stmtp: POINTER; errhp: POINTER; nrows: INTEGER; orientation: INTEGER_16; 
			mode: INTEGER): INTEGER_16 is
		external
			"C (void *, void *, int, short, int): short | %"oci.h%""
		alias
			"OCIStmtFetch"
		end
		
invariant
	one_based_column_list: column_list /= Void implies column_list.lower = 1
	column_list_exists_if_described: (is_described and then is_query) implies (column_list /= Void
			and then column_list.count = column_count)
	binds_exist_if_prepared: is_prepared implies binds /= Void
	defines_exist_if_defined: is_defined implies (defines /= Void and then defines.count =
			column_count)
	described_when_executed: is_executed implies is_described
	always_eof_unless_is_query: (is_executed and then not is_query) implies eof
	row_data_filled: row_data_filled implies (row_data /= Void and row_data.count = column_count)

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




end -- class OCI_STATEMENT
