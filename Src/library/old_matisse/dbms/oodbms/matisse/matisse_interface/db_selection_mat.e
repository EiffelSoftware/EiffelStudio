indexing

    Product: EiffelStore
    Database: Matisse

class DB_SELECTION_MAT

inherit

	MATISSE_CONST
		export {NONE} all
		undefine
			is_equal, out, copy, consistent, setup
		end 

	DB_STATUS_USE
		export {NONE} all
		undefine
			is_equal, out, copy, consistent, setup
		end 

	DB_SELECTION_I
		undefine
			is_equal, out, copy, consistent, setup
		end 

	SQL_SCAN
		export {NONE} all
		end

	HANDLE_STREAM
		export {NONE} all
		undefine
			is_equal, out, copy, consistent, setup
		end 

	MT_DB_STATUS_MAT_EXTERNAL
		export {NONE} all
		undefine
			is_equal, out, copy, consistent, setup
		end 

	HANDLE_USE
		export {NONE} all
	        undefine
			is_equal, out, copy, consistent, setup
		end 
	
creation -- Creation procedure

	make

feature -- Status setting

	set_ht (table: HASH_TABLE [ANY, STRING]) is
 		-- Set `ht' with `table'.
		require else
			table_exists: table /= Void
		do
			ht := table
		ensure then
			ht = table
		end -- set_ht
 
feature -- Status report

	descriptor_available: BOOLEAN is
		-- Is a new cursor descriptor available?
		do
			Result := True
		end -- descriptor
        
feature -- Element change

	query (s: STRING) is
		-- Do nothing : use DB_PROC.
		require else
			argument_exists: s /= Void
			connected: is_connected
			prepare_execute: not immediate_execution
			descriptor_available: descriptor_available
		do
		end -- query

	next is
		-- Move to next row matching execute clause.
		require else
			connected: is_connected
		do
			Last_object.put(Last_stream.item.next_object)
		end -- next

	terminate is
		-- Terminate query.
		require else
			connected: is_connected
			is_ok: is_ok
		do
			Last_stream.item.close
			Last_stream.put(Void)
			Last_object.put(Void)
		end -- terminate

	modify (s: STRING) is
		-- Do nothing.
		do
		end -- modify

	cursor_to_object (object: ANY; cursor: DB_RESULT) is
		-- Effectively load  `object' attributes with
		-- `cursor' fields.
		-- Cursor.data must be an object otherwise nothing is done.
		require else
			cursor_exists: cursor /= Void
			object_exists: object /= Void
		local
			one_object : MT_OBJECT
		do
			one_object ?= cursor.data
		end -- cursor_to_object


end -- class DB_SELECTION_MAT
