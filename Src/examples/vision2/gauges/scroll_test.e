indexing
	description: "Test of scrollable_area."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLL_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			test_scrollable_area
		end

	test_scrollable_area is
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
			create vb
			first_window.extend (vb)
			create hb
			vb.extend (hb)
			create sb
			vb.extend (sb)
			create pb
			pb.enable_segmentation
			vb.extend (pb)
			create min_label.make_with_text ("Min: ")
			hb.extend (min_label)
			create val_label.make_with_text ("Val: ")
			hb.extend (val_label)
			create max_label.make_with_text ("Max: ")
			hb.extend (max_label)
			sb.change_actions.extend (~on_change)
		end

	max_label: EV_LABEL
	min_label: EV_LABEL
	val_label: EV_LABEL

	sb: EV_VERTICAL_SCROLL_BAR
	pb: EV_VERTICAL_PROGRESS_BAR

	on_change is
			-- Scrollbar changes.
		do
			min_label.set_text ("Min: " + sb.minimum.out)
			val_label.set_text ("Val: " + sb.value.out)
			max_label.set_text ("Max: " + sb.maximum.out)
			pb.set_value (sb.value)
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
			Result.set_title ("Main window")
			Result.show
			Result.set_size (300, 300)
		end

end -- class DIALOG_TEST
