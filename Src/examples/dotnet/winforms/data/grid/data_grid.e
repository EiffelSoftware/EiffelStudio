indexing
	description: "Root class for Winforms Data Grid demo."
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
			size: DRAWING_SIZE
			handler: EVENT_HANDLER
		do
			create main_window.make_winforms_form
			set_geometry (main_window,0,0,630,440,"Data Grid demo")

			create lb_server.make_winforms_label
			lb_server.set_parent (main_window)
			set_geometry (lb_server,5,7,80,23,"SQL Server")
			create tb_server.make_winforms_text_box
			tb_server.set_parent (main_window)
			set_geometry (tb_server,90,5,160,25,"(local)\VSDotNet")

			create lb_database.make_winforms_label
			lb_database.set_parent (main_window)
			set_geometry (lb_database,255,7,30,23,"DB")
			create tb_database.make_winforms_text_box
			tb_database.set_parent (main_window)
			set_geometry (tb_database,290,5,160,25,"Northwind")

			create bn_populate.make_winforms_button
			bn_populate.set_parent (main_window)
			set_geometry (bn_populate,455,3,120,25,"Populate grid")
			create handler.make_event_handler (Current,$populate_grid)
			bn_populate.add_click (handler)

			create data_grid.make_winforms_data_grid
			set_geometry (data_grid,5,35,620,400,Void)
			data_grid.set_caption_text (("This is DataGrid's caption text").to_cil)
			main_window.get_controls.add (data_grid)

			create handler.make_event_handler (Current,$on_resize)
			main_window.add_resize (handler)
			main_window.show
			on_resize (Void,Void)

			feature {WINFORMS_APPLICATION}.run_form (main_window)
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
			data_grid.set_data_binding(data_set,("Suppliers").to_cil)
		end

	on_resize (sender: SYSTEM_OBJECT; event_args: EVENT_ARGS) is
			-- Close current application.
		do
			set_geometry (data_grid,0,0,main_window.get_width-20,main_window.get_height-70,Void)
		end

feature {NONE} -- Implementation

	data_set: DATA_DATA_SET

	do_populate is
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
			append_cil (connection_string,tb_server.get_text)
			connection_string.append (";Trusted_Connection=yes;database=")
			append_cil (connection_string,tb_database.get_text)
			create northwind_connection.make_data_sql_connection_1 (connection_string.to_cil)

				-- Create a DATA_SQL_DATA_ADAPTER for the Suppliers table.
			create suppliers_adapter.make_data_sql_data_adapter

				-- A table mapping tells the adapter what to call the table.
			a_mapping := suppliers_adapter.get_table_mappings.add_string2(("Table").to_cil,
				("Suppliers").to_cil)

			northwind_connection.open
			create command_on_suppliers.make_data_sql_command_2(("SELECT * FROM Suppliers").to_cil,
				northwind_connection)

			command_on_suppliers.set_command_type (feature {DATA_COMMAND_TYPE}.Text)
			suppliers_adapter.set_select_command (command_on_suppliers)

			feature {SYSTEM_CONSOLE}.write_string(("The connection is open.").to_cil)
			feature {SYSTEM_CONSOLE}.write_line
			create data_set.make_data_data_set_1(("Customers").to_cil)
			count := suppliers_adapter.fill_data_set (data_set)

				-- Create a second DATA_SQL_DATA_ADAPTER and DATA_SQL_COMMAND to get
				-- the Products table, a child table of Suppliers.

			create products_adapter.make_data_sql_data_adapter
			a_mapping := products_adapter.get_table_mappings.add_string2 (("Table").to_cil,
				("Products").to_cil)

			create command_on_products.make_data_sql_command_2(("SELECT * FROM Products").to_cil,
				northwind_connection)

			products_adapter.set_select_command (command_on_products)
			count := products_adapter.fill_data_set (data_set)
			northwind_connection.Close

			feature {SYSTEM_CONSOLE}.write_string(("The connection is closed.").to_cil)
			feature {SYSTEM_CONSOLE}.write_line

				-- You must create a DATA_DATA_RELATION to link the two tables.
				-- Get the parent and child columns of the two tables.

			data_column_1 := data_set.get_tables.get_item(
				("Suppliers").to_cil).get_columns.get_item_string(("SupplierID").to_cil)
			data_column_2 := data_set.get_tables.get_item(
				("Products").to_cil).get_columns.get_item_string(("SupplierID").to_cil)

			create data_relation.make (("suppliers2products").to_cil, data_column_1, data_column_2)
			data_set.get_relations.add(data_relation)
		end

	set_geometry (a_control: WINFORMS_CONTROL; a_x, a_y, a_w, a_h: INTEGER; a_text: STRING) is
		local
			l_point: DRAWING_POINT
			l_size: DRAWING_SIZE
		do
			if a_x >0  then
				l_point.make_drawing_point (a_x, a_y)
				a_control.set_location (l_point)
			end
			if a_w >0  then
				l_size.make_drawing_size_1 (a_w, a_h)
				a_control.set_size (l_size)
			end
			if a_text /= Void then
				a_control.set_text (a_text.to_cil)
			end
		end

	append_cil (a_string: STRING; a_system_string: SYSTEM_STRING) is
		local
			s: STRING
		do
			create s.make_from_cil (a_system_string)
			a_string.append (s)
		end

end -- class DATA_GRID
