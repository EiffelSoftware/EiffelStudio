
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class CUST_IC_DESIGN

feature

	design_no: INTEGER
	design_name: STRING
	date_recd: DATE
	date_valid: DATE
	date_modified: DATE
	revision_no: INTEGER
	cust_acct_no: INTEGER
	est_design_size_x: REAL
	est_design_size_y: REAL
	design_size_x: REAL
	design_size_y: REAL
	center_x: REAL
	center_y: REAL

feature
	set_design_no (d: INTEGER) is
		do
			design_no := d;
		end
	
feature
	
	display is
		do
			io.new_line;
			io.putstring ("Design number: "); io.putint (design_no.item);
			io.new_line;
			io.putstring ("Design name: "); io.putstring (design_name);
			io.new_line;
			io.putstring ("Dates:  "); 
			show_date(date_recd);
			io.putstring (" (received) ");
			show_date(date_valid);
			io.putstring (" (valid) ");
			show_date(date_modified);
			io.putstring (" (modified) ");
			io.new_line;
			io.putstring ("Sizes:  "); io.putreal (est_design_size_x.item);
			io.putstring (" by "); io.putreal (est_design_size_y.item);
			io.putstring (" (estimated) ");
			io.putreal (design_size_x.item);
			io.putstring (" by "); io.putreal (design_size_y.item);
			io.putstring (" (actual) ");
			io.new_line;
			io.putstring ("Center:  ("); io.putreal (center_x.item);
			io.putstring (","); io.putreal (center_y.item);
			io.putstring (")");
			io.new_line;
		end
			
	show_date (d: DATE) is
		do
			if d /= Void then
				io.putstring (d.out);
			else
				io.putstring ("<null>");
			end
		end
end




