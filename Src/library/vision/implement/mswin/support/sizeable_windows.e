indexing 

	description: "A class for MS-Windows to simulate resizing by children";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class

	SIZEABLE_WINDOWS

feature -- Status report

	fixed_size : BOOLEAN is
			-- Is this widget or it's parents fixed?
		local
			pw : SIZEABLE_WINDOWS
		do
			Result := fixed_size_flag 
			if not Result then
				pw ?= parent 
				Result := pw /= Void and then pw.fixed_size
			end
		end

feature -- Status setting

	allow_recompute_size is
			-- Allow resizing of the children.
		do
			fixed_size_flag := False
	        end

	forbid_recompute_size is
			-- Forbid resizing of the children.
		do
			fixed_size_flag := True
		end

	resize_for_shell is
			-- Resize current widget if the parent is a shell.			
		local
			tw: TOP_IMP
		do
			tw ?= parent
			if tw /= Void and then tw.exists and then not fixed_size_flag then
				set_x_y (0, 0)
				set_size (tw.client_width, tw.client_height)
			end
		end


feature {SIZEABLE_WINDOWS} -- Implementation

	fixed_size_flag: BOOLEAN
			-- Flag to indicate if this widget can have its size changed

	parent: COMPOSITE_IMP is
			-- Parent of this sizeable widget
		deferred
		end

	set_x_y (new_x, new_y: INTEGER) is
			-- Positioning of this sizeable widget
		deferred
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the size of this widget
		deferred
		end
	
end -- SIZEABLE_WINDOWS
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

