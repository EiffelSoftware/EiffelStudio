indexing
	description: "EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_HOLDER_IMP

inherit
	EV_ANY_I

	EV_ITEM_EVENTS_CONSTANTS_IMP
		rename
			command_count as item_command_count
		end

feature -- Access

	current_widget: EV_WIDGET is
			-- Current widget related to the container
		local
			cwidget: EV_WIDGET_IMP
			citem: EV_SIMPLE_ITEM_IMP
		do
			cwidget ?= Current
			if cwidget /= Void then
				Result ?= cwidget.interface
			else
				citem ?= Current
				if citem /= Void then
					Result := citem.parent_widget
				end
			end
		end

end -- class EV_ITEM_HOLDER_IMP

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
