indexing
	description: "Objects that represent EiffelVision2 header items. Implementation Interface"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HEADER_ITEM_I

inherit
	EV_ITEM_I
		redefine
			interface
		end
		
	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

feature -- Access

	width: INTEGER is
			-- `Result' is width of `Current' used
			-- while parented.
		deferred
		ensure
			Result_non_negative: Result >= 0
		end

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		require
			width_non_negative: a_width >= 0
		deferred
		ensure
			width_set: width = a_width
		end
		
	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		require
			parent_not_void: parent /= Void
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_HEADER_ITEM_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
