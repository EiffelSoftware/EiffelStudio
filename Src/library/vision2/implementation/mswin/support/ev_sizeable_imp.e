indexing 

	description: "A class for MS-Windows to simulate resizing by children";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class

	EV_SIZEABLE_IMP

feature -- Status report

	fixed_size : BOOLEAN is
			-- Is this widget or it's parents fixed?
		local
			pw : EV_SIZEABLE_IMP
		do
			Result := fixed_size_flag 
			if not Result then
				pw ?= parent_imp 
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
			-- Resize current widget if the parent is a
			-- shell.
		local
			tw: EV_CONTAINER_IMP
		do
			tw ?= parent_imp
			if tw /= Void and then not tw.destroyed and then not fixed_size_flag then
				set_x_y (0, 0)
				set_size (tw.client_width, tw.client_height)
			end
		end


feature {EV_SIZEABLE_IMP} -- Implementation

	fixed_size_flag: BOOLEAN
			-- Flag to indicate if this widget can have
			-- its size changed

	parent_imp: EV_CONTAINER_IMP is
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
	
end -- EV_SIZEABLE_IMP
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

