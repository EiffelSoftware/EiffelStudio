indexing
	description: "Test of EV_GAUGE."
	date: "$Date$"
	revision: "$Revision$"

class
	GAUGES

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', set up controls and launch.
		do
			default_create
			test_gauges
			launch
		end

	test_gauges is
			-- Initialize controls and display `first_window'.
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create vb
			first_window.extend (vb)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create sb
			vb.extend (sb)
			create pb
			vb.extend (pb)

			create hr
			vb.extend (hr)

			create min_field.make_with_value_range (-1000 |..| 1)
			min_field.set_value (1)
			hb.extend (create {EV_LABEL}.make_with_text ("Min: "))
			hb.extend (min_field)
			create val_field
			hb.extend (create {EV_LABEL}.make_with_text ("Val: "))
			hb.extend (val_field)
			create max_field.make_with_value_range (1 |..| 1000)
			max_field.set_value (100)
			hb.extend (create {EV_LABEL}.make_with_text ("Max: "))
			hb.extend (max_field)

			min_field.change_actions.extend (~on_min_change (?))
			max_field.change_actions.extend (~on_max_change (?))
			sb.change_actions.extend (~on_sb_change (?))
			val_field.change_actions.extend (~on_val_change (?))
			hr.change_actions.extend (~on_hr_change (?))

			val_field.value_range.adapt (min_field.value |..| max_field.value)
			sb.value_range.adapt (min_field.value |..| max_field.value)
			pb.value_range.adapt (min_field.value |..| max_field.value)
			hr.value_range.adapt (min_field.value |..| max_field.value)
			
			first_window.set_maximum_height (250)
			first_window.show
		end

feature -- Implementation

	on_min_change (value: INTEGER) is
			-- Adjust minimums of controls.
		do
			val_field.value_range.adapt (min_field.value |..| val_field.value_range.upper)
			sb.value_range.adapt (min_field.value |..| sb.value_range.upper)
			pb.value_range.adapt (min_field.value |..| pb.value_range.upper)
			hr.value_range.adapt (min_field.value |..| hr.value_range.upper)
		end

	on_max_change (value: INTEGER) is
			-- Adjust maximums of controls.
		do
			val_field.value_range.adapt (val_field.value_range.lower |..| max_field.value)
			sb.value_range.adapt (sb.value_range.lower |..| max_field.value)
			pb.value_range.adapt (pb.value_range.lower |..| max_field.value)
			hr.value_range.adapt (hr.value_range.lower |..| max_field.value)
		end

	on_sb_change (value: INTEGER) is
			-- Value of `sb' changed so update other controls.
		do
			max_field.value_range.adapt (sb.value |..| max_field.value_range.upper)
			min_field.value_range.adapt (min_field.value_range.lower |..| sb.value)
			val_field.set_value (sb.value)
			pb.set_value (sb.value)
			hr.set_value (sb.value)
		end

	on_hr_change (value: INTEGER) is
			-- Value of `hr' changed so update other controls.
		do
			max_field.value_range.adapt (hr.value |..| max_field.value_range.upper)
			min_field.value_range.adapt (min_field.value_range.lower |..| hr.value)
			val_field.set_value (hr.value)
			pb.set_value (hr.value)
			sb.set_value (hr.value)
		end

	on_val_change (value: INTEGER) is
			-- Value of `val_field' changed so update other controls.
		do
			max_field.value_range.adapt (val_field.value |..| max_field.value_range.upper)
			min_field.value_range.adapt (min_field.value_range.lower |..| val_field.value)
			sb.set_value (val_field.value)
			pb.set_value (val_field.value)
			hr.set_value (val_field.value)
		end

	first_window: EV_TITLED_WINDOW is
			-- Window for this sample.
		once
			create Result
			Result.set_title ("Main window")
		end
		
	max_field: EV_SPIN_BUTTON
		-- Contains the maximum allowable value of `sb', `pb' and `hr'.
	min_field: EV_SPIN_BUTTON
		-- Contains the minimu allowable value of `sb', `pb' and `hr'.
	val_field: EV_SPIN_BUTTON

	sb: EV_HORIZONTAL_SCROLL_BAR
		-- Scroll bar for test.
	pb: EV_HORIZONTAL_PROGRESS_BAR
		-- Progress bar for test.
	hr: EV_HORIZONTAL_RANGE
		-- Horizontal range for test.

end -- class DIALOG_TEST
