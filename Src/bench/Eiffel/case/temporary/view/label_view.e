class LABEL_VIEW

inherit

	VIEW

feature -- Properties

	x_offset: INTEGER
			-- X distance from label to line

	y_offset: INTEGER
			-- Y distance from label to line

	from_ratio: REAL;
			-- Ratio of total distance going from from_handle_nbr
			-- to to_handle_nbr in comparison to the distance
			-- from the label to the from_handle_nbr

	from_handle_nbr: INTEGER;
			-- Handle number nearest to label from source linkable in the
			-- `supplier' direction

feature -- Update

	update_data (data: LABEL_DATA) is
			-- Update `data' with Current.
		do
			data.set_from_ratio (from_ratio);
			data.set_x_y_offset (x_offset, y_offset)
			data.set_from_handle_nbr (from_handle_nbr)
		end;

	update_from (data: LABEL_DATA) is
			-- Update Current from `data'
		do
			x_offset := data.x_offset;
			y_offset := data.y_offset;
			from_ratio := data.from_ratio;
			from_handle_nbr := data.from_handle_nbr;
		end;

end
