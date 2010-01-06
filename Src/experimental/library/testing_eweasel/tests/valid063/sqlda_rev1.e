--|---------------------------------------------------------------
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--|    104 rue Castagnary 75015 Paris FRANCE                    --
--|                   +33-(1)-45-32-58-80                       --
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.
--|---------------------------------------------------------------

indexing

	Date: "$Date$";
	Revision: "$Revision$";
	Product: EiffelStore;
	Database: Oracle

class SQLDA

inherit

	DB_GENERAL;

	SQL_STRUCT;

	EXT_INTERNAL;

	DB_CONST

feature

	count:  INTEGER;
		-- Number of columns in result.

	max_count: INTEGER;
		-- Max number of columns in result for oracle, unused.

feature {NONE} -- Values data

	value: ARRAY[ANY];

	value_size: ARRAY[INTEGER];

	value_type: ARRAY[INTEGER];

	value_indicator: ARRAY[INTEGER];
			-- unused

feature {NONE} -- Select-list items data

	select_name: ARRAY[STRING];

	max_select_size: ARRAY[INTEGER];

	select_size: ARRAY[INTEGER];

feature {NONE} -- Bind indicators data

	indicator_name: ARRAY[INTEGER];
			-- unused

	max_indicator_size: ARRAY[INTEGER];
			-- unused

	indicator_size: ARRAY[INTEGER];
			-- unused

feature {NONE}

	sqldaid: STRING is
		do
		end;

 	sqldabc: INTEGER is
		do
		end;

	sqln: INTEGER is
		do
		end;

	sqld: INTEGER is
		do
		end;

	sqlvar: ARRAY[ANY] is
		do
		end;

feature

	map_table: ARRAY [INTEGER];

	update_map_table (obj: ANY) is
			-- Update map table according to field names.
		require else
			object_exists: obj /= Void
		local
			g: INTEGER;
			ind, idx: INTEGER;
			searched_name: STRING
		do
			g := field_count (obj);
			if map_table = Void then
				!!map_table.make (1,count)
			elseif map_table.count < count then
				map_table.resize (1,count)
			end;
			from
				ind := 1
			until
				ind > count
			loop
				searched_name := clone (column_name (ind));
				searched_name.to_lower;
				from
					idx := 1
				until
					idx > g or else field_name (idx, obj).is_equal (searched_name) 
				loop
					idx := idx + 1
				end;
				if idx <= g then
					map_table.put (idx, ind)
				else
					db_status.set(200);
					ind := count
				end;
				ind := ind + 1
			end
		end; -- update_map_table

	item (pos: INTEGER): ANY is
			-- Get data at `pos'-th column.
		require else
			pos_in_range: pos > 0 and pos <= count
		local
			r_string: STRING;
			int_ref: INTEGER_REF;
			r_int: INTEGER;
			float_ref: REAL_REF;
			r_float: REAL;
			r_date: ABSOLUTE_DATE;
		do
			r_string := Void; r_date := Void;
			r_string ?= value.item (pos);
			r_date ?= value.item (pos);
			-- Types .. Do they really match ?? (DEBUG)
			if r_string /= Void or r_date /= Void then
				if value_type.item (pos) = 1 then
					Result := r_string
				elseif value_type.item (pos) = 2
						and then is_real_type (r_string) then
					!!float_ref;
					float_ref.set_item (r_string.to_real);
					Result := float_ref
				elseif value_type.item (pos) = 2 then
					!!int_ref;
					int_ref.set_item (r_string.to_integer);
					Result := int_ref
				elseif value_type.item (pos) = 8 then
					Result := r_string
				elseif value_type.item (pos) = 11 then
					Result := r_string
				elseif value_type.item (pos) = 12 then
					Result := r_date
				elseif value_type.item (pos) = 23 then
					Result := r_string
				elseif value_type.item (pos) = 24 then
					Result := r_string
				elseif value_type.item (pos) = 96 then  -- ORACLE Version 7
					Result := r_string
				else
					-- To be changed in the next revision (DEBUG)
					-- sqlda.item: Syntax error, or unknown
					-- data type.
				end
			else
				Result := r_string
			end
		end; -- item

	column_name (pos: INTEGER): STRING is
			-- Name of the `pos'-th column.
		require else
			pos_in_range: pos > 0 and pos <= count
		do
			Result := select_name.item (pos)
		ensure then
			Result = select_name.item (pos)
		end; -- column_name

	clean_spaces (st: STRING): STRING is
			-- Remove leading and trailing blanks of `st'.
		require
			argument_exists: st /= Void
		do
			st.left_adjust;
			-- BUGGY in current implementation of STRING
			if st.count > 1 then
				st.right_adjust
			end;
			Result := st
		end; -- clean_spaces

	fill_in is
			-- Fill Results from Oracle
		local
			ind: INTEGER
		do
			if ora_string = Void then
				!!ora_string.make(selection_string_size)
			end;
			count := ora_get_count;
			max_count := ora_get_max_count;
			if value = Void then
				!!value.make (1,count);
				!!value_size.make (1,count);
				!!value_type.make (1,count);
				!!select_name.make (1,count);
				!!max_select_size.make (1,count);
				!!select_size.make (1,count)
			elseif value.count < count then
				value.resize (1,count);
				value_size.resize (1,count);
				value_type.resize (1,count);
				select_name.resize (1,count);
				max_select_size.resize (1,count);
				select_size.resize (1,count)
			end;

			from
				ind := 0
			until
				ind = count
			loop
				value_size.put (ora_get_value_size (ind),ind+1);
				f_string := select_name.item (ind+1);
				if f_string = Void then
					!!f_string.make (1);
					select_name.put (f_string, ind+1)
				else
					f_string.wipe_out;
				end;
				ora_string.ora_get_select_name (ind);
				f_string.append (ora_string);
				max_select_size.put (ora_get_max_select_size (ind),ind+1);
				select_size.put (ora_get_select_size (ind),ind+1);
				value_type.put (ora_get_value_type (ind),ind+1);
				f_any := value.item (ind+1);
				if value_type.item (ind+1) = 12 then
					if ora_get_month (ind) /= 0 then
						if f_any /= Void and then is_date (f_any) then
							f_date ?= f_any
						else
							!!f_date.make
						end;
						f_date.change_date (ora_get_month(ind), ora_get_day (ind),
								ora_get_year (ind));
						f_date.change_time (ora_get_hour (ind), ora_get_min (ind),
								ora_get_sec(ind));
						f_any := f_date;
					end
				else
					if f_any /= Void and then is_string (f_any) then
						f_string ?= f_any;
						f_string.wipe_out;
					else
						!!f_string.make (1)
					end;
					ora_string.ora_get_value (ind);
					f_string.append (ora_string);
					if f_string.count = 0 and then ora_get_value_type (ind) = 1 then
						f_any := Void;
					else
						f_string := clean_spaces (f_string);
						if f_string.count = 0 then
							f_any := Void;
						else
							f_any := f_string;
						end
					end;
				end;
				value.put (f_any,ind+1);
				ind := ind + 1;
			end;
		end -- fill_in

feature {NONE}

	seq_search: SEQ_STRING is
		once
			!!Result.make (1)
		end; -- seq_search

	is_real_type (str: STRING): BOOLEAN is
			-- is it a real format
		local
			c: CHARACTER;
		do
			io.putstring ("Entering is_real_type with *")
			io.putstring (str);
			io.putstring ("* ("); io.putint (str.count);
			io.putstring (")%N"); 
			seq_search.wipe_out;
			seq_search.append (str);
			c := '.';
			Result := str.count /= 0 and then seq_search.index_of (c, 1) /= 0
			if Result then
				io.putstring ("is_real_type returning True%N")
				io.putstring ("Count is "); io.putint (str.count);
				io.putstring (" and index_of is "); 
				io.putint (seq_search.index_of (c, 1));
				io.new_line;
				io.putstring ("Str is ")
				io.putstring (str);
				io.new_line;
			end
		end; -- is_real_type

	f_any: ANY;
	f_date: ABSOLUTE_DATE;
	f_string, tmp_string: STRING;

	ora_string: ORA_STRING
		-- use to get string from the C interface to oracle `oracle.pc'

feature {NONE} -- External features

	ora_get_count: INTEGER is
		external
			"C"
		end; -- ora_get_count

	ora_get_max_count: INTEGER is
		external
			"C"
		end; -- ora_get_max_count

	ora_get_value_size (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_value_size

	ora_get_value_type (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_value_type

	ora_get_value_indicator (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_value_indicator


	ora_get_max_select_size (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_max_select_size

	ora_get_select_size (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_select_size


	ora_get_indicator_name (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_indicator_name

	ora_get_max_indicator_size (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_max_indicator_size

	ora_get_indicator_size (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_indicator_size


	ora_get_sec (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_sec

	ora_get_min (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_min

	ora_get_hour (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_hour

	ora_get_year (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_year

	ora_get_day (ind: INTEGER): INTEGER is
		external
			"C"
		end; -- ora_get_day

	ora_get_month (ind: INTEGER): INTEGER is
		external
			"C"
		end -- ora_get_month

end -- class SQLDA
