indexing

	description: 
		"Progres bar for compilation.";
	date: "$Date$";
	revision: "$Revision $"

class PROGRESS_BAR

inherit

	GRAPHICAL_CONSTANTS;
	MEL_ROW_COLUMN
		rename
			make as old_make
		end;

creation

	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
		do
			old_make (a_name, a_parent, True);
			set_spacing (0);
			create_buttons;
			set_horizontal (True);
			set_num_columns (1);
			set_margin_height (0);
			set_margin_width (0);
			set_entry_border (1);
		end;

feature -- Access

	last_percentage: INTEGER;
			-- Last recorded percentage displayed

	last_percentage_units: INTEGER;
			-- Last recorded percentage units

feature -- Status setting

	reset_percentage is
			-- Reset `last_percentage' to 0.
		local
			array: ARRAY [MEL_PUSH_BUTTON];
			c, i: INTEGER;
			last_per, shown_per: INTEGER;
		do
			array := buttons;
			from
				c := array.count;
				i := 1
			until
				i > c
			loop
				array.item (i).hide;
				i := i + 1
			end;
			last_percentage := 0;
			last_percentage_units := 0
		end;

	increase_percentage (a_percentage: INTEGER) is
			-- Increase the percentage bar to `a_percentage'.
		require
			valid_percentage: a_percentage >= 0 and then 
								a_percentage <= 100;
			previous_percentage_higher: a_percentage >= last_percentage
		local
			array: ARRAY [MEL_PUSH_BUTTON];
			i: INTEGER;
			cur_unit: INTEGER
		do
			if a_percentage /= last_percentage then
				array := buttons;
				cur_unit := a_percentage // Step_unit;
				from
					i := last_percentage_units + 1
				until
					i > cur_unit
				loop
					array.item (i).show;
					i := i + 1
				end;
				last_percentage := a_percentage;
				last_percentage_units := cur_unit
			end;
		end;

	update_percentage (a_percentage: INTEGER) is
            -- Update the percentage bar to `a_percentage'. 
        require
            valid_percentage: a_percentage >= 0 and then
                                a_percentage <= 100;
        local
			array: ARRAY [MEL_PUSH_BUTTON];
			i: INTEGER;
			cur_units: INTEGER
		do
			if a_percentage >= last_percentage then
				increase_percentage (a_percentage)
			else
					-- Percentage decreased
				array := buttons;
				cur_units := a_percentage // Step_unit + 1;
				from
					i := last_percentage_units;
				until
					i < cur_units
				loop
					array.item (i).hide;
					i := i - 1
				end;
				last_percentage := a_percentage;
				last_percentage_units := cur_units - 1
			end;
		end;

feature {NONE} -- Implementation

	Total_units: INTEGER is
			-- Total number of units
		do
			Result := 100 // Step_unit
		end;

	Step_unit: INTEGER is 5
			-- Number of percent unit per step in bar

	buttons: ARRAY [MEL_PUSH_BUTTON]
			-- Array of push buttons in bar

	create_buttons is
			-- Create the buttons for in the progress bar.
		local
			array: ARRAY [MEL_PUSH_BUTTON];
			mel_button: MEL_PUSH_BUTTON;
			color_x: COLOR_X;
			t, i: INTEGER
		do
			color_x ?= g_Progress_bar_color.implementation;
			color_x.allocate_pixel;
			!! array.make (1, Total_units);
			from
				i := 1;
				t := Total_units;
			until
				i > t
			loop
				!! mel_button.make ("", Current, True);
				mel_button.set_background_color (color_x);
				mel_button.set_size (15, 25);
				mel_button.set_recomputing_size_allowed (False);
				array.put (mel_button, i);
				i := i + 1
			end
			buttons := array
		end;

end -- class PROGRESS_BAR
