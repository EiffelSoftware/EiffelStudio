class
	HTML_TABLE

inherit
	HTML_TABLE_CONSTANTS
		rename
			Width as Table_Width
		undefine
			is_equal, copy, consistent, setup, out
		end;
	ARRAY2[STRING]
		rename
			make as array2_make
		undefine
			out
		end;

creation
	make

feature

	make(nb_row, nb_col: INTEGER) is
			-- Create a table
		do
			array2_make(nb_row, nb_col);
			set_row(1);
			set_col(1);
		end;

feature -- Inputs in the table

	put_row(a_row: ARRAY[STRING]) is
			-- Put a row (of STRING) in the table in the current row
		require
			a_row /= Void;
			row_value <= height
		local
			n: INTEGER;
		do
			from
				n := a_row.lower;
			until
				n > a_row.upper
			loop
				if a_row.item(n) /= Void then
					put(a_row.item(n), row_value, n - a_row.lower + 1);
				end;
				n := n +1;
			end;
		end;

	put_col(a_row: ARRAY[STRING]) is
			-- Put a col (of STRING) in the table in the current col
		require
			a_row /= Void;
			col_value <= width
		local
			n: INTEGER;
		do
			from
				n := a_row.lower;
			until
				n > a_row.upper
			loop
				if a_row.item(n) /= Void then
					put(a_row.item(n), n - a_row.lower + 1, col_value);
				end;
				n := n +1;
			end;
		end;

	add_row(a_row: ARRAY[STRING]) is
			-- Add a row in the table and update the current row
		require
			a_row /= Void;
			row_value <= height
		do
			put_row(a_row);
			set_row(row_value+1);
		end;

	add_col(a_row: ARRAY[STRING]) is
			-- Add a col in the table and update the current col
		require
			a_row /= Void;
			col_value <= width
		do
			put_col(a_row);
			set_col(col_value+1);
		end;

feature -- Routines out: provide STRING representations 

	out: STRING is
			-- Provide a STRING representation for the current table
		do
			Result := clone(Table_start);
			Result.append(attributes_out);
			Result.append(Tag_end);
			Result.append(NewLine);
			Result.append(caption_out);
			Result.append(body_out);
			Result.append(Table_end);
		end;

	body_out: STRING is 
		local
			row, col: INTEGER;
		do
			Result := "";
			from
				row_value := 1;
				row := row_value;
			until
				row > height
			loop
				Result.append(Row_start);
				Result.append(row_attributes_out(row, col));
					-- Warning 'row_value' has changed
				Result.append(Tag_end);
				Result.append(NewLine);
				from
					col_value := 1;
					col := col_value;
				until
					col > width
				loop
					Result.append(Col_start);
					Result.append(col_attributes_out(row, col));
						-- Warning 'col_value' has changed
					Result.append(Tag_end);
					if is_text(item(row, col)) then
						Result.append(item(row, col));
					end;
					Result.append(Col_end);
					Result.append(NewLine);
					col := col_value;
				end;
				Result.append(Row_end);
				Result.append(NewLine);
				row := row_value;
			end;
		end;

	col_attributes_out(row, col: INTEGER): STRING is
			-- String representation for the attributes
			-- of the cell '(row, col)'
			-- Modify 'col_value'
		require
			row <= height;
			col <= width
		local
			cs: INTEGER;
		do
			cs := get_Colspan(row, col);
			if cs > 1 then
				Result := clone(Colspan);
				Result.append(cs.out);
			else
				Result := "";
			end;
		end;

	row_attributes_out(row, col: INTEGER): STRING is
			-- String representation for the attributes
			-- of the row 'row'
			-- Modify 'row_value'
		require
			row <= height;
		do
			row_value := row_value + 1;
			Result := "";
		end;

	attributes_out: STRING is
			-- String representation for the attributes
			-- of the table
		do
			if border_value > 0 then
				Result := clone(Border);
				Result.append(border_value.out);
			else
				Result := "";
			end;
		end;

	caption_attributes_out: STRING is
			-- String representation for the attributes
			-- of the caption
		do
			if caption_attributes /= Void then
				Result := caption_attributes;
			else
				Result := "";
			end;
		end;

	caption_out: STRING is
			-- String representation for the caption
		do
			if (caption /= Void) and then (not caption.is_equal("")) then
				Result := clone(Caption_start);
				Result.append(caption_attributes_out);
				Result.append(Tag_end);
				Result.append(caption);
				Result.append(Caption_end);
				Result.append(NewLine);
			else
				Result := "";
			end;
		end;

	attribute_out(an_attribute, its_value: STRING): STRING is
			-- String representation for the pair 'an_attribute' and 'its_value'
		do
			Result := clone(an_attribute);
			Result.append("%"");
			Result.append(its_value);
			Result.append("%"");
		end;

feature -- Attributes

	caption: STRING;

	border_value: INTEGER;
	row_value: INTEGER;
	col_value: INTEGER;

feature -- Set attributes

	set_caption(s: STRING) is
			-- Set the caption element
		do
			if s /= Void then
				caption := s;
			end;
		end;

	set_caption_to_top is
			-- Set the caption to be displayed on the top of the table
		do
			caption_attributes := attribute_out(Align, Top);
		end;

	set_caption_to_bottom is
			-- Set the caption to be displayed on the bottom of the table
		do
			caption_attributes := attribute_out(Align, Bottom);
		end;

	set_border(n: INTEGER) is
			-- Set the attribute 'BORDER' of the table to 'n'
		do
			border_value := n;
		end;

	set_row(n: INTEGER) is
			-- Set the current working value for row to 'n'
		do
			row_value := n;
		end;
	
	set_col(n: INTEGER) is
			-- Set the current working value for col to 'n'
		do
			col_value := n;
		end;
	

feature {NONE}

	caption_attributes: STRING;

	is_text(s: STRING): BOOLEAN is
			-- Is 's' simple text or key word?
		do
			if (s /= Void) and then not
			(s.is_equal(Colspan) or s.is_equal(Rowspan)) then
				Result := true;
			end;
		end;

	get_Colspan(row, col: INTEGER): INTEGER is
			-- Number of Colspan for the cell 'row, col'
			-- in the row 'row' (number of Colspan >= 1)
			-- Modify 'col_value'
		require
			row <= height;
			col <= width
		do
			from
				col_value := col + 1;
			until
				(row > height) or else
				(col_value > width) or else 
				(item(row, col_value) = Void) or else 
				(not item(row, col_value).is_equal(Colspan))
			loop
				col_value := col_value + 1;
			end;
			Result := col_value - col;
		end;

	get_Rowspan(row, col: INTEGER): INTEGER is
			-- Number of Rowspan for the cell 'row, col'
			-- in the col  'col' (number of Rowspan >= 1)
			-- Modify 'row_value'
		require
			row <= height;
			col <= width
		do
			from
				row_value := row + 1;
			until
				(col > width) or else 
				(row_value > height) or else 
				(item(row_value, col) = Void) or else 
				(not item(row_value, col).is_equal(Rowspan))
			loop
				row_value := row_value + 1;
			end;
			Result := row_value - row;
		end;

end -- class HTML_TABLE



--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

