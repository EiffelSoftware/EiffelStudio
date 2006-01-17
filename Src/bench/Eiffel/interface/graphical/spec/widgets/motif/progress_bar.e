indexing

	description: 
		"Progres bar for compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class PROGRESS_BAR

inherit

	EB_CONSTANTS;
	MEL_ROW_COLUMN
		rename
			make as old_make
		end;

create

	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE) is
		do
			old_make (a_name, a_parent, True);
			--set_spacing (2);
			set_spacing (0);
			create_labels;
			set_horizontal;
			set_num_columns (1);
			set_margin_height (1);
			set_margin_width (1);
		--	set_entry_border (1);
			set_entry_border (0);
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
			array: ARRAY [MEL_LABEL];
			c, i: INTEGER;
			last_per, shown_per: INTEGER;
		do
			array := labels;
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
			array: ARRAY [MEL_LABEL];
			i: INTEGER;
			cur_unit: INTEGER
		do
			if a_percentage /= last_percentage then
				array := labels;
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
			array: ARRAY [MEL_LABEL];
			i: INTEGER;
			cur_units: INTEGER
		do
			if a_percentage >= last_percentage then
				increase_percentage (a_percentage)
			else
					-- Percentage decreased
				array := labels;
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

	labels: ARRAY [MEL_LABEL]
			-- Array of labels in bar

	create_labels is
			-- Create the labels for in the progress bar.
		local
			array: ARRAY [MEL_LABEL];
			mel_label: MEL_LABEL;
			color_x: COLOR_IMP;
			t, i: INTEGER
		do
			color_x ?= 
				Graphical_resources.progress_bar_color.actual_value.implementation;
			color_x.allocate_pixel;
			create array.make (1, Total_units);
			from
				i := 1;
				t := Total_units;
			until
				i > t
			loop
				create mel_label.make ("", Current, True);
				mel_label.set_margin_height (0);
				mel_label.set_margin_width (0);
				mel_label.set_background_color (color_x);
				mel_label.set_size (12, 15);
				mel_label.forbid_recompute_size;
				array.put (mel_label, i);
				i := i + 1
			end
			labels := array
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class PROGRESS_BAR
