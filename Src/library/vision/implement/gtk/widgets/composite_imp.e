indexing

	description: 
		"EiffelVision composite, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
--XX deferred class
class
	COMPOSITE_IMP

inherit

	WIDGET_IMP
		redefine
			show, hide, realize, unrealize
		end


feature

	show is
			-- Show all the children and then this widget
		do
			if managed and then children /= Void then
				from children.start
				until children.off
				loop
					if children.item.realized then
						children.item.show
					end
					
					children.forth
				end
			end
			Precursor
		end
	
	hide is
			-- Hide all the children and then this widget
		do
			if managed and then children /= Void then
				from children.start
				until children.off
				loop
					if children.item.realized then
						children.item.hide
					end
					children.forth
				end
			end
			Precursor
		end	
	
	realize is
			-- Realize current widget and children.
		do
			if not realized then
				if children /= Void then
					from children.start
					until children.off
					loop
						children.item.realize
						children.forth
					end
				end	
			end
			Precursor
		end
	
	unrealize is
			-- Unrealize current widget and children.
		do
			if realized then
				if children /= Void then
					from children.start
					until children.off
					loop
						children.item.unrealize
						children.forth
					end
				end	
			end
			Precursor
		end
	
	add_widget (other_widget: WIDGET_IMP) is
			-- Add other_widget into gtk container
		require
			other_widget_valid: other_widget /= Void
		do
			if children = Void then
				!!children.make
			end
			children.extend (other_widget)
			other_widget.set_parent (Current)
			gtk_container_add (widget, other_widget.widget)
		end

	set_border_width (w: INTEGER) is
		require
			width_valid: w >= 0
		do
			gtk_container_border_width (widget, w)
		end

feature -- Measurement

	children_count: INTEGER is
			-- Count of managed children
		do
			Result := children.count
		end;

feature {GTK_WIDGET}
	
	children: LINKED_LIST [WIDGET_IMP]
	

end -- class COMPOSITE_IMP


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
