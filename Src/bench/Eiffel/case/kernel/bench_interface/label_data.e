class LABEL_DATA

inherit

	STRING
		rename
			make as old_make
		end;
	DATA
		undefine
			is_equal, out, copy, consistent, setup
		end

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Initialize Current string and
			-- ratios.
		do
			--x_offset := Resources.link_x_offset;
			--y_offset := Resources.link_y_offset;
			old_make (n);
			from_ratio := Initial_from_ratio   
			from_handle_nbr := 1
		ensure
			from_ratio_set: from_ratio = Initial_from_ratio 
			from_handle_set: from_handle_nbr = 1
		end;

feature -- Properties

	x_offset: INTEGER
			-- X distance from label to line

	y_offset: INTEGER
			-- Y distance from label to line

	initial_from_ratio: REAL is 0.70; 
			-- Initial value of `from_ratio', at creation
			--| Used to avoid equality problems between constant 0.70 
			--| (considered as a DOUBLE) and a REAL variable with that 
			--| value...

	from_ratio: REAL;
			-- Ratio of total distance going from from_handle_nbr
			-- to to_handle_nbr in comparison to the distance
			-- from the label to the from_handle_nbr
			--| Handle starts from source entity unlike
			--| break points exclude extremeties

	maximal_ratio: REAL is 1.0;
			--| Used to avoid equality problems between constant 0.70 
			--| (considered as a DOUBLE) and a REAL variable with that 
			--| value...

	to_ratio: REAL is
			-- Ratio of total distance going from from_handle_nbr
			-- to to_handle_nbr in comparison to the distance
			-- from the label to the to_handle_nbr
		do
			Result := maximal_ratio - from_ratio
		ensure
			Result = maximal_ratio - from_ratio
		end;

	to_handle_nbr: INTEGER is
			-- Handle number nearest to label in the
			-- `supplier' direction	
		do
			Result := from_handle_nbr + 1
		ensure
			Result = from_handle_nbr + 1
		end;

	from_handle_nbr: INTEGER
			-- Handle number minus 1 nearest to label in the
			-- `supplier' direction	

feature -- Access

	stone_type: INTEGER is
		do
		end;

feature -- Setting

	set_x_y_offset (x, y: like x_offset) is
			-- Set x and y offset to
			-- `x' and `y'.
		do
			x_offset := x;
			y_offset := y;
		ensure
			x_offset = x;
			y_offset = y;
		end;

	set_from_ratio (r: like from_ratio) is
			-- Set from_ration to `r'.
		require
			valid_r: r >= 0 and then r <= maximal_ratio
		do
			from_ratio := r
		ensure
			from_ratio = r
		end;

	set_from_handle_nbr (n: like from_handle_nbr) is
			-- Set from_handle_nbr to `n'.
		require
			valid_n: n > 0
		do
			from_handle_nbr := n
		ensure
			from_handle_nbr = n
		end;

feature -- Element change

	increment_handle_nbr is
			-- Increment from_handle_nbr
		require
			has_label: not empty
		do
			from_handle_nbr := from_handle_nbr + 1
		ensure
			from_handle_nbr = old from_handle_nbr + 1
		end;

	decrement_handle_nbr is
			-- Increment from_handle_nbr
		require
			valid_from_handle_nbr: from_handle_nbr > 1;
			has_label: not empty
		do
			from_handle_nbr := from_handle_nbr - 1
		ensure
			from_handle_nbr = old from_handle_nbr - 1
		end;

feature -- Update

	update_from (st: STRING) is
			-- Update Current from `st'.
		do
			wipe_out;
			append (st)
		end;

	update_from_view (view: LABEL_VIEW) is
			-- Update Current from view `view'.
		require
			valid_view: view /= Void
		do
		end;

	parse is
			-- Parse Current text to remove
			-- excess spaces 
		local
			value: STRING;
		do
			!! value.make (count);	
			if not empty then
				value.append (Current);
				value.replace_substring_all (" ", "")
				value.replace_substring_all (",", ", ")
			end
		end;

	words: LINKED_LIST [STRING] is
			-- Words as a linked list
		do
			Result := parse_label_string (Current)
		end;

feature -- Output

	focus: STRING is
		do
			Result := clone (Current)
		end;

	string_value: STRING is
			-- String value of Current (used for storage)
		do
			!! Result.make (count);	
			Result.append (Current)
		end;

	output_value: STRING is
			-- Displayed value (for workarea and printing)
		do
			!! Result.make (count);
			if not empty then
				Result.append (Current);
				Result.replace_substring_all ("%%N", " ")
				Result.replace_substring_all ("%%n", " ")
			end
		end;

feature -- Storage

	storage_info: LABEL_VIEW is
			-- Associated storage information
		do
			!! Result;
			Result.update_from (Current)
		end

feature {NONE} -- Implementation

	parse_label_string (a_label: STRING): LINKED_LIST [STRING] is
			-- Parse `a_label' and place words in the Result
		local
			word: STRING;
					-- Current word parsed
			i: INTEGER;
			separator: CHARACTER
		do
			!! Result.make;
			separator := ',';
			from
				i := 1;
				!! word.make (0);
			until
				i > a_label.count
			loop
				if a_label.item (i) = separator then
					word.extend (a_label.item (i))
					Result.put_right (word);
					Result.forth;
					if i < a_label.count and
						a_label.item (i + 1) = ' '
					then
						i := i + 1
					end;
					!! word.make (0);
				elseif (a_label.item (i) = '%%') and then
					(i + 1 <= a_label.count) and then
					((a_label.item (i + 1) = 'N') or else
					(a_label.item (i + 1) = 'n'))
				then
						-- found %N
					i := i + 1
					Result.put_right (word);
					Result.forth;
					!! word.make (0);
				else
					word.extend (a_label.item (i))
				end;
				i := i + 1
			end;
			if word /= Void and then not word.empty then
				Result.put_right (word)
			end
		end;

invariant

	valid_to_ratio: to_ratio >= 0 and then to_ratio <= maximal_ratio;
	valid_from_ratio: from_ratio >= 0 and then from_ratio <= maximal_ratio;

	-- valid_ratios: from_ratio + to_ratio = maximal_ratio;
	--%%%% fixme: seems to be a problem in frozen mode. Violated
	--%%%% when it is ok.

	valid_to_handle_nbr: to_handle_nbr >= 2;
	valid_from_handle_nbr: to_handle_nbr >= 1;

end
