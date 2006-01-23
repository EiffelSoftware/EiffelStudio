indexing
	description: "Root class for Winforms Data Grid demo."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	note: "Translated from Microsoft .NET Framework SDK documentation"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_GRID

create
	make

feature -- Initialization

	make is
			-- Initialize
		local
			handler: EVENT_HANDLER
		do
			create main_window.make
			set_geometry (main_window, 0, 0, 630, 440, "Data Grid demo")

			create lb_server.make
			lb_server.set_parent (main_window)
			set_geometry (lb_server, 5, 7, 80, 23, "SQL Server")
			create tb_server.make
			tb_server.set_parent (main_window)
			set_geometry (tb_server, 90, 5, 160, 25, "(local)\VSDotNet")

			create lb_database.make
			lb_database.set_parent (main_window)
			set_geometry (lb_database, 255, 7, 30, 23, "DB")
			create tb_database.make
			tb_database.set_parent (main_window)
			set_geometry (tb_database, 290, 5, 160, 25, "Northwind")

			create bn_populate.make
			bn_populate.set_parent (main_window)
			set_geometry (bn_populate, 455, 3, 120, 25, "Populate grid")
			create handler.make (Current, $populate_grid)
			bn_populate.add_click (handler)

			create data_grid.make
			set_geometry (data_grid, 5, 35, 620, 400, Void)
			data_grid.set_caption_text ("This is DataGrid's caption text")
			main_window.controls.add (data_grid)

			create handler.make (Current, $on_resize)
			main_window.add_resize (handler)
			main_window.show
			on_resize (Void, Void)

			{WINFORMS_APPLICATION}.run_form (main_window)
		end

feature -- Access

	main_window: WINFORMS_FORM
			-- Main window.

	lb_server: WINFORMS_LABEL
			-- "server" label.

	tb_server: WINFORMS_TEXT_BOX
			-- "server" textbox.

	lb_database: WINFORMS_LABEL
			-- "db" label.

	tb_database: WINFORMS_TEXT_BOX
			-- "db" textbox.

	bn_populate: WINFORMS_BUTTON
			-- Button initiating grid population.

	data_grid: WINFORMS_DATA_GRID
			-- Data grid

feature -- Actions

	populate_grid (sender: SYSTEM_OBJECT; event_args: EVENT_ARGS) is
			-- Populate data grid from DB.
		do
			do_populate
			data_grid.set_data_binding(data_set, "Suppliers")
		end

	on_resize (sender: SYSTEM_OBJECT; event_args: EVENT_ARGS) is
			-- Close current application.
		do
			set_geometry (data_grid, 0, 0, main_window.width-20, main_window.height-70, Void)
		end

feature {NONE} -- Implementation

	data_set: DATA_DATA_SET
			-- ADO.NET data set

	do_populate is
			-- Populate grid.
		local
			northwind_connection: DATA_SQL_CONNECTION
			suppliers_adapter: DATA_SQL_DATA_ADAPTER
			products_adapter: DATA_SQL_DATA_ADAPTER
			data_relation: DATA_DATA_RELATION
			data_column_1: DATA_DATA_COLUMN
			data_column_2: DATA_DATA_COLUMN
			command_on_suppliers: DATA_SQL_COMMAND
			command_on_products: DATA_SQL_COMMAND
			a_mapping: DATA_DATA_TABLE_MAPPING
			count: INTEGER
			connection_string: STRING
		do
				-- create a DATA_SQL_CONNECTION from the given connection string.
				-- Change the data source value to the name of your computer.
			connection_string := "server="
			connection_string.append (tb_server.text)
			connection_string.append (";Trusted_Connection=yes;database=")
			connection_string.append (tb_database.text)
			create northwind_connection.make (connection_string)

				-- Create a DATA_SQL_DATA_ADAPTER for the Suppliers table.
			create suppliers_adapter.make
			
				-- A table mapping tells the adapter what to call the table.
			a_mapping := suppliers_adapter.table_mappings.add ("Table", "Suppliers")

			northwind_connection.open
			create command_on_suppliers.make ("SELECT * FROM Suppliers", northwind_connection)

			command_on_suppliers.set_command_type ({DATA_COMMAND_TYPE}.Text)
			suppliers_adapter.set_select_command (command_on_suppliers)

			io.put_string ("The connection is open.%N")

			create data_set.make ("Customers")
			count := suppliers_adapter.fill_data_set (data_set)

				-- Create a second DATA_SQL_DATA_ADAPTER and DATA_SQL_COMMAND to get
				-- the Products table, a child table of Suppliers.

			create products_adapter.make
			a_mapping := products_adapter.table_mappings.add ("Table", "Products")

			create command_on_products.make ("SELECT * FROM Products", northwind_connection)

			products_adapter.set_select_command (command_on_products)
			count := products_adapter.fill_data_set (data_set)
			northwind_connection.close

			io.put_string ("The connection is closed.%N")

				-- You must create a DATA_DATA_RELATION to link the two tables.
				-- Get the parent and child columns of the two tables.

			data_column_1 := data_set.tables.item ("Suppliers").columns.item ("SupplierID")
			data_column_2 := data_set.tables.item ("Products").columns.item ("SupplierID")

			create data_relation.make ("suppliers2products", data_column_1, data_column_2)
			data_set.relations.add (data_relation)
		end

	set_geometry (a_control: WINFORMS_CONTROL; a_x, a_y, a_w, a_h: INTEGER; a_text: STRING) is
			-- Initialize main window's geometry
		local
			l_point: DRAWING_POINT
			l_size: DRAWING_SIZE
		do
			if a_x >0  then
				l_point.make (a_x, a_y)
				a_control.set_location (l_point)
			end
			if a_w >0  then
				l_size.make (a_w, a_h)
				a_control.set_size (l_size)
			end
			if a_text /= Void then
				a_control.set_text (a_text)
			end
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


end -- class DATA_GRID
