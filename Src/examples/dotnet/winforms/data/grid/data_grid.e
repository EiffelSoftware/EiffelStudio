indexing
	description: "Root class for dataset sample application."
	note: "Translated from Microsoft .NET Framework SDK documentation"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_GRID

create
	make

feature -- Initialization

	make is
		local
			point: DRAWING_POINT
			size: DRAWING_SIZE
			dresult: WINFORMS_DIALOG_RESULT
		do		
			create main_win.make_winforms_form
			size.make_drawing_size_1 (550, 450)
			main_win.set_Client_Size (size)
			create my_grid.make_winforms_data_grid
			point.make_drawing_point (10,10)
			size.make_drawing_size_1 (500, 400)
			my_grid.set_location (point)
			my_grid.set_size (size)
			my_grid.set_caption_text (("Microsoft .NET Data_Grid").to_cil)
			main_win.get_controls.add(my_grid)
			main_win.set_text (("Eiffel Grid Example").to_cil)         
			connect_to_data
			my_grid.set_data_binding(data_set, ("Suppliers").to_cil)
			dresult := main_win.show_dialog
		end

feature -- Access

	main_win: WINFORMS_FORM
			-- Main window.

feature {NONE} -- Implementation

	data_set: DATA_DATA_SET 
	my_grid: WINFORMS_DATA_GRID 

	connect_to_data is
		local
			connection_string: STRING
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
		do
				-- Create the Connection_String and create a DATA_SQL_CONNECTION.
				-- Change the data source value to the name of your computer.
			create connection_string.make(0)
			connection_string.append ("server=(local)\NetSDK;Trusted_Connection=yes;database=northwind")
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

end -- class APPLICATION
