indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FORM_IMP

inherit
	BULLETIN_IMP
		export
			{WIDGET_IMP, ATTACHMENT_LIST_WINDOWS}
				children,
				children_list
		redefine
			show, make, realize_current, set_size,
			set_width, set_height, child_has_resized,
			realize, class_name,
			set_enclosing_size,
			resize_for_shell
		end

	FORM_I

creation
	make

feature -- Initialization

	make (a_form: FORM; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a form.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			check
				parent_exists: parent /= Void
			end
			initialize
			managed := man
		end

feature -- Status setting

	child_has_resized is
			-- Child has been resized
		do
			if not updating then
				if realized then
					set_enclosing_size
				end
				update_all
			end
		end

	show is
			-- Show current form.
		do
			update_all
			{BULLETIN_IMP} Precursor
		end

	set_enclosing_size is
			-- Set the enclosing size of the form
		local
			h, w: INTEGER
		do
			if not fixed_size_flag and not updating then
				h := form_child_list.height (Current)
				w := form_child_list.width (Current)
				if h > height or else w > width then
					set_size (w, h)
				end
			end
		end

	set_size (new_width, new_height : INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				{BULLETIN_IMP} Precursor (new_width, new_height)
				if not updating then
					update_all
				end
			end
		end 

	set_width (new_width : INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				{BULLETIN_IMP} Precursor (new_width)
				if not updating then
					update_all
				end
			end
		end 

	set_height (new_height : INTEGER) is
			-- Set height to `new_height'.
		do
			if private_attributes.height /= new_height then
				{BULLETIN_IMP} Precursor (new_height)
				if not updating then
					update_all
				end
			end
		end 

	realize is
			-- Realize current form and children.
		local
			h, w: INTEGER
		do
			if not realized then
				realize_current
				updating := true
				realize_children
				updating := false
				h := form_child_list.height (Current)
				if h > height then
					set_form_height (h)
				end			
				w := form_child_list.width (Current)
				if w > width then
					set_form_width (w)
				end
				resize_for_shell
				if not managed then
					wel_hide
				elseif parent.shown then
					shown := true
				end
			end
			update_all
			set_enclosing_size
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end			
		end

	realize_current is
			-- Realize current form.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height)
			end
		end

feature	-- Implementation

	initialize is
			-- Initialize the current form
		do
			fraction_base := 100
			!!form_child_list.make
		end

	fraction_base: INTEGER
			-- Value used to compute child position with
			-- position attachment

	attach_bottom (a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		local
			a_childw : WIDGET_IMP
		do
			a_childw ?= a_child
			form_child_list.attach_bottom (a_childw, Current, bottom_offset, false)
			if realized then 
				update_all
			end
		end

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_bottom (a_childw, Current, a_position, true)
			if realized then 
				update_all
			end
		end

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; bottom_offset: INTEGER)  is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		local
			a_childw, a_widgetw : WIDGET_IMP
		do
			a_childw  ?= a_child
			a_widgetw ?= a_widget
			form_child_list.attach_bottom (a_childw, a_widgetw, bottom_offset, false);
			a_childw  ?= a_widget
			form_child_list.add (a_childw)
			if realized then 
				update_all
			end
		end

	attach_left (a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_left (a_childw, Current, left_offset, false)
			if realized then 
				update_all
			end
		end

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_left (a_childw, Current, a_position, true)
			if realized then
				update_all
			end
		end

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		local
			a_childw, a_widgetw : WIDGET_IMP
		do
			a_childw  ?= a_child
			a_widgetw ?= a_widget
			form_child_list.attach_left (a_childw, a_widgetw, left_offset, false)
			a_childw  ?= a_widget
			form_child_list.add (a_childw)
			if realized then 
				update_all
			end
		end

	attach_right (a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of current form
			-- with `right_offset' spaces between each other.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_right (a_childw, Current, right_offset, false)
			if realized then 
				update_all
			end
		end

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_right (a_childw, Current, a_position, true)
			if realized then 
				update_all
			end
		end

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `right_offset' spaces between each other.
		local
			a_childw, a_widgetw : WIDGET_IMP
		do
			a_childw  ?= a_child
			a_widgetw ?= a_widget
			form_child_list.attach_right (a_childw, a_widgetw, right_offset, false)
			a_childw  ?= a_widget
			form_child_list.add (a_childw)
			if realized then 
				update_all
			end
		end

	attach_top (a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of current form
			-- with `top_offset' spaces between each other.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_top (a_childw, Current, top_offset, false)
			if realized then 
				update_all
			end
		end

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
				-- Attach top side of `a_child' to a position that is
				-- relative to top side of current form and is a fraction
				-- of the height of current form. This fraction is the value
				-- of `a_position' divided by the value of `fraction_base'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_top (a_childw, Current, a_position, true)
			if realized then 
				update_all
			end
		end

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		local
			a_childw, a_widgetw : WIDGET_IMP
		do
			a_childw  ?= a_child
			a_widgetw ?= a_widget
			form_child_list.attach_top (a_childw, a_widgetw, top_offset, false)
			a_childw  ?= a_widget
			form_child_list.add (a_childw)
			if realized then 
				update_all
			end
		end

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_right (a_childw, Void, 0, false)
			if realized then 
				update_all
			end
		end

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_left (a_childw, Void, 0, false)
			if realized then 
				update_all
			end
		end

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_bottom (a_childw, Void, 0, false)
			if realized then 
				update_all
			end
		end

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		local
			a_childw : WIDGET_IMP
		do
			a_childw  ?= a_child
			form_child_list.attach_top (a_childw, Void, 0, false)
			if realized then 
				update_all
			end
		end

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		do
			fraction_base := a_value
		end

feature -- Implementation

	resize_for_shell is
			-- Resize current widget if the parent is a shell.			
		local
			tw: TOP_IMP
		do
			tw ?= parent
			if tw /= Void and then tw.exists and then not fixed_size_flag then
				if tw.client_width < width or tw.client_height < height then
					if tw.client_width < width then
						tw.set_form_width (width)
					end
					if tw.client_height < height then
						tw.set_form_height (height)
					end
				else
					set_x_y (0, 0)
					set_size (tw.client_width, tw.client_height)
				end
			end
		end

	form_child_list: ATTACHMENT_LIST_WINDOWS
			-- Children of this widget

	update_all is
			-- Update all the attachments.
		require
			not_updating: not updating
		local
			fw: FORM_IMP
			rcw: ROW_COLUMN_IMP
			c: CURSOR
		do
			updating := true
			form_child_list.clear_all
			form_child_list.process (Current)
			updating := false
			from
				c := form_child_list.cursor
				form_child_list.start
			until
				form_child_list.after
			loop
				fw ?= form_child_list.item.widget
				if fw /= Void then
					fw.update_all
				else
					rcw ?= form_child_list.item.widget
					if rcw /= Void then
						if not rcw.mapping then
							rcw.map_widgets (rcw.width, rcw.height)
						end
					end
				end
				form_child_list.forth
			end
			form_child_list.go_to (c)
		end

	updating : BOOLEAN
		-- Are we currently updating this form?

feature {NONE} -- Implementation

	class_name: STRING is
		once
			Result := "EvisionForm"
		end

invariant
	form_child_list_not_void: form_child_list /= Void

end  -- class FORM_IMP


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

