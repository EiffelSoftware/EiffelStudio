indexing 
	description:
		"Base class for bar graph gauges that display progress of a process.%N%
		%See EV_HORIZONTAL_PROGRESS_BAR and EV_VERTICAL_PROGRESS_BAR"
	status: "See notice at end of class"
	keywords: "status, progress, bar"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR

inherit
	EV_GAUGE
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_segmented
		ensure
			bridge_ok: Result = implementation.is_segmented
		end

feature -- Status setting

	enable_segmentation is
			-- Divide display of bar into segments.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_segmentation
		ensure
			is_segmented: is_segmented
		end

	disable_segmentation is
			-- Display continuous bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_segmentation
		ensure
			not_is_segmented: not is_segmented
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GAUGE} and is_segmented
		end

feature {NONE} -- Implementation

	implementation: EV_PROGRESS_BAR_I
			-- Responsible for interaction with native graphics toolkit.

end -- class EV_PROGRESS_BAR

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
