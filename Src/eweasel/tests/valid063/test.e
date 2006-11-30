
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

inherit
	ORACLE_APPL;
	ACTION
		redefine
			execute
		end
	INTERNAL;
	ARGUMENTS;
	MEMORY;

creation
	make
feature

	make is
		local
			session_control: DB_CONTROL;
			designs: LINKED_LIST [DB_RESULT]
		do
			collection_off;
			set_access_rights("", "");
			set_base;
			!!session_control.make;
			session_control.connect;
			if not session_control.is_connected then
				session_control.raise_error;
			else
				io.putstring ("Connected%N");
			end
			!!selection.make;
			!!designs.make;
			!!cust_ic_design;
			selection.object_convert (cust_ic_design);
			selection.set_action (Current);
			selection.set_map_name (40000, "design_no");
			selection.query ("select design_no, design_name, date_recd, date_valid, date_modified, revision_no, cust_acct_no, est_design_size_x, est_design_size_y, design_size_x, design_size_y, center_x, center_y from cust_ic_%
				%designs where design_no >= :design_no");
			if is_ok then
				selection.load_result;
				if is_ok then
					io.putstring ("Number of records is ");
					io.putint (designs.count); io.new_line;
				else
					session_control.raise_error;
					session_control.reset;
				end
			else
				session_control.raise_error;
				session_control.reset;
			end
			session_control.rollback;
			if not session_control.is_ok then
				session_control.raise_error;
				session_control.reset;
			end	
			session_control.commit;
			if not session_control.is_ok then
				session_control.raise_error;
				session_control.reset;
			end	
			session_control.disconnect;
			if not session_control.is_ok then
				session_control.raise_error;
				session_control.reset;
			end	
		end;

	selection: DB_SELECTION;
	
	cust_ic_design: CUST_IC_DESIGN;
	
	execute is
		local
			r_int: INTEGER_REF
			obj: ANY;
		do
			selection.cursor_to_object;
			!!tuple.copy (selection.cursor);
			obj := tuple.item (1);
			show_type ("Point1", obj);
			r_int ?= obj;
			show_type ("Point2", obj);
			if r_int /= Void then
				show_type ("Point3", obj);
				io.putint (r_int.item);
			else
				show_type ("Point4", obj);
				die (1);
			end
			io.new_line;
			cust_ic_design.display;
			if cust_ic_design.design_no = 40116 then
				dummy;
			end
			cust_ic_design.set_design_no (-47);
			-- !!tuple.copy (selection.cursor);
			-- r_int ?= tuple.item (1);
			-- if r_int /= Void then
				-- io.putint (r_int.item); io.new_line;
			-- end
		end
			
	tuple: DB_TUPLE
	
	show_type (label: STRING; obj: ANY) is
		do
			io.putstring (label);
			io.putstring (": dynamic type is ");
			io.putstring (class_name (obj));
			io.putstring (" (");
			io.putint (dynamic_type (obj));
			io.putstring (")%N");
		end
	
	dummy is
		do
		end
end




