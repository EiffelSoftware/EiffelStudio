indexing 

	description: "Simulation of an attachment under Motif";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	ATTACHMENT_WINDOWS

creation
	make

feature -- Initialization

	make (w: WIDGET_IMP) is
			-- Create the attachment for `w'
		require
			widget_not_void: w /= Void
		do
			widget := w
		end
 
feature -- Access

	processed: BOOLEAN
			-- Have we processed this attachment?

	top: WIDGET_IMP
			-- Widget to connect our top edge to

	bottom: WIDGET_IMP
			-- Widget to connect our bottom edge to

	left: WIDGET_IMP
			-- Widget to connect our left side to

	right: WIDGET_IMP
			-- Widget to connect our right side to

	top_position: INTEGER
			-- Offset for top attachment (may be relative)

	bottom_position: INTEGER
			-- Offset for bottom attachment (may be relative)

	left_position: INTEGER
			-- Offset for left attachment (may be relative)

	right_position: INTEGER
			-- Offset for right attachment (may be relative)

	widget: WIDGET_IMP
			-- Is the right attachment relative?

	left_relative: BOOLEAN
			-- Is the left attachment relative?

	right_relative: BOOLEAN
			-- Is the right attachment relative?

	top_relative: BOOLEAN
			-- Is the top attachment relative?

	bottom_relative: BOOLEAN
			-- Is the bottom attachment relative?

feature -- Status setting

	attach_left (w: WIDGET_IMP; pos: INTEGER; relative: BOOLEAN) is
			-- Attach left of this attachment to right of `w' 
			-- separated by `pos' which may be `relative'
		do
			left := w
			left_position := pos
			left_relative := relative
		end

	attach_right (w: WIDGET_IMP; pos: INTEGER; relative: BOOLEAN) is
			-- Attach right of this attachment to left of `w' 
			-- separated by `pos' which may be `relative'
		do
			right := w
			right_position := pos
			right_relative := relative
		end

	attach_top (w: WIDGET_IMP; pos: INTEGER; relative: BOOLEAN) is
			-- Attach top of this attachment to bottom of `w' 
			-- separated by `pos' which may be `relative'
		do
			top := w
			top_position := pos
			top_relative := relative
		end

	attach_bottom (w: WIDGET_IMP; pos: INTEGER; relative: BOOLEAN) is
			-- Attach bottom of this attachment to top of `w' 
			-- separated by `pos' which may be `relative'
		do
			bottom := w
			bottom_position := pos
			bottom_relative := relative
		end

	reset is
			-- This widget is not processed
		do
			processed := false
		end

	height (f: FORM_IMP) : INTEGER is
			-- Height of this attachment on form `f'
		 do
			if not processed then
				private_height := 0
				if top /= Void and top /= f and not top_relative then
					private_height := f.form_child_list.find_widget (top).height (f)
				end
				if bottom /= Void and bottom /= f and not bottom_relative then
					private_height := private_height + f.form_child_list.find_widget (bottom).height (f) 
				end
				if not bottom_relative then private_height := private_height + bottom_position end
				if not top_relative then private_height := private_height + top_position end
				private_height := private_height + widget.form_height
				if top_relative then
					private_height := (f.fraction_base * private_height) // (f.fraction_base - top_position)
				end
				if bottom_relative then
					private_height := (f.fraction_base * private_height) // bottom_position 
				end
				processed := true
			end 
			Result := private_height
		 end

	private_height : INTEGER
			-- Height of this attachment in context of form

	width (f: FORM_IMP) : INTEGER is
			-- Width of the attachment on form `f'
		 do
			if not processed then
				private_width := 0
				if left /= Void and left /= f and not left_relative then
					private_width := f.form_child_list.find_widget (left).width (f)
				end
				if right /= Void and right /= f and not right_relative then
					private_width := private_width + f.form_child_list.find_widget (right).width (f)
				end
				if not left_relative then private_width := private_width + left_position end
				if not right_relative then private_width := private_width + right_position end
				private_width := private_width + widget.form_width
				if left_relative then
					private_width := (f.fraction_base * private_width) // (f.fraction_base - left_position)
				end
				if right_relative then
					private_height := (f.fraction_base * private_width) // right_position 
				end
				processed := true
			end 
			Result := private_width
		 end

	private_width : INTEGER
			-- Width of attachment in context of form

	process (form : FORM_IMP) is
			-- Position this attachment
		do
			processed := true
			if left = Void and then right = Void and then top = Void and then bottom = Void then
				widget.set_x_y (0,0)
			else
				if left /= Void then
					process_left (form)
				end
				if top /= Void then
					process_top (form)
				end 
				if right /= Void then
					if right = form then
						if left = Void then
							process_right_form_no_left (form)
						elseif left = form then
							process_right_form_left_form (form)
						elseif form.form_child_list.find_widget (left).processed then
							process_right_form_left_widget (form)
						else
							processed := false
						end
					elseif form.form_child_list.find_widget (right).processed then
						-- right MUST be a widget
						if left = Void then
							process_right_widget_no_left (form)
						elseif left = form then
							process_right_widget_left_form (form)
						elseif form.form_child_list.find_widget (left).processed then
							process_right_widget_left_widget 
						else
							processed := false
						end
					else
						processed := false
					end
				end
				if bottom /= Void then
					if bottom = form then
						if top = Void then
							process_bottom_form_no_top (form)
						elseif top = form then
							process_bottom_form_top_form (form)
						elseif form.form_child_list.find_widget (top).processed then
							process_bottom_form_top_widget (form)
						else
							processed := false
						end
					elseif form.form_child_list.find_widget (bottom).processed then
						-- bottom MUST be a widget
						if top = Void then
							process_bottom_widget_no_top (form)
						elseif top = form then
							process_bottom_widget_top_form (form)
						elseif form.form_child_list.find_widget (top).processed then
							process_bottom_widget_top_widget 
						else
							processed := false
						end
					else
						processed := false
					end
				end
			end
		end

	process_left (form: FORM_IMP) is
			-- Process attachment on left side
		require
			left_exists: left /= Void
		do
			if left_position = 0 then
				if left = form then 
					widget.set_x (0)
				elseif form.form_child_list.find_widget (left).processed then
					widget.set_x (left.x + left.form_width)
				else
					processed := false
				end 
			else -- the position is not 0 
				if left_relative then
					widget.set_x ((form.form_width * left_position) // form.fraction_base)
				else
					if left = form then
						widget.set_x (left_position)
					else
						widget.set_x (left.x + left.form_width + left_position)
					end
				end
			end
		end

	process_top (form: FORM_IMP) is
			-- Process attachment on top edge
		require
			top_exists: top /= Void
		do
			if top_position = 0 then
				if top = form then
					widget.set_y (0)
				elseif form.form_child_list.find_widget (top).processed then
					widget.set_y (top.y + top.form_height)
				else
					processed := false
				end
			else
				if top_relative then
					widget.set_y ((form.form_height * top_position) // form.fraction_base)
				else
					if top = form then
						widget.set_y (top_position)
					else
						widget.set_y (top.y + top.form_height + top_position)
					end
				end
			end 
		end

	process_right_widget_no_left (form: FORM_IMP) is
			-- Process right attachment to another widget with no left attachment
		require
			right_not_void: right /= Void
			left_constraint: left = Void
		do
			widget.set_x ((0).max(right.x - right_position - widget.form_width))
		end

	process_right_widget_left_form (form: FORM_IMP) is
			-- Process right attachment to another widget when the left attachment is `form'
		require
			right_not_void: right /= Void
			left_constraint: left = form
		do
			if left_relative then
				widget.set_form_width ( (0).max (right.x - right_position - widget.x))
			else
				widget.set_form_width ( (0).max (right.x - left_position - right_position))
			end
		end

	process_right_widget_left_widget is
			-- Process right attachment to another widget when the left attachment is a widget
		require
			right_not_void: right /= Void
			left_constraint: left /= Void 
		do
			widget.set_form_width ( (0).max (right.x - right_position - left_position - left.form_width - left.x))
		end

	process_right_form_no_left (form: FORM_IMP) is
			-- Process right attachment to `form' with no left attachment
		require
			right_not_void: right /= Void
			left_constraint: left = Void
		do
			if right_relative then
				widget.set_x ((0).max ((form.form_width * right_position) // form.fraction_base - widget.form_width))
			else
				widget.set_x ((0).max (form.form_width - right_position - widget.form_width))
			end
		end

	process_right_form_left_form (form: FORM_IMP) is
			-- Process right attachment to `form' with left also being `form'
		require
			right_not_void: right /= Void
			left_constraint: left = form
		do
			if right_relative then
				if left_relative then
					widget.set_form_width ( (0).max ((form.form_width * right_position) // form.fraction_base)  - widget.x)
				else
					widget.set_form_width ( (0).max (((form.form_width * right_position) // form.fraction_base) - left_position))
				end
			else
				if left_relative then
					widget.set_form_width ( (0).max (form.form_width - widget.x - right_position))
				else
					widget.set_form_width ( (0).max (form.form_width - left_position - right_position ))
				end
			end
		end

	process_right_form_left_widget (form: FORM_IMP) is
			-- Process right attachment to `form' with left being a widget
		require
			right_not_void: right /= Void
			left_constraint: left /= Void
			left_processed: form.form_child_list.find_widget (left).processed
		do
			if right_relative then
				widget.set_form_width ( (0).max ((form.form_width * right_position ) // form.fraction_base - left.x - left.form_width - left_position))
			else
				widget.set_form_width ( (0).max (form.form_width - right_position - left_position - left.form_width - left.x))
			end
		end

	process_bottom_widget_no_top (form: FORM_IMP) is
			-- Process bottom attachment to another widget with no top attachment
		require
			bottom_not_void: bottom /= Void
			top_constraint: top = Void
		do
			widget.set_y ((0).max (bottom.y - bottom_position - widget.form_height))
		end

	process_bottom_widget_top_form (form: FORM_IMP) is
			-- Process bottom attachment to another widget with top attached to `form'
		require
			bottom_not_void: bottom /= Void
			top_constraint: top = form
		do
			if top_relative then
				widget.set_form_height ( (0).max (bottom.y - bottom_position - widget.y))
			else
				widget.set_form_height ( (0).max (bottom.y - top_position - bottom_position))
			end
		end

	process_bottom_widget_top_widget is
			-- Process bottom attachment to another widget with top attached to another widget
		require
			bottom_not_void: bottom /= Void
			top_constraint: top /= Void 
		do
			widget.set_form_height ( (0).max (bottom.y - bottom_position - top_position - top.form_height - top.y))
		end

	process_bottom_form_no_top (form: FORM_IMP) is
			-- Process bottom attachment to `form' with no top attachment
		require
			bottom_not_void: bottom /= Void
			top_constraint: top = Void
		do
			if bottom_relative then
				widget.set_y ((0).max ((form.form_height * bottom_position) // form.fraction_base - widget.form_height))
			else
				widget.set_y ((0).max (form.form_height - bottom_position - widget.form_height))
			end
		end

	process_bottom_form_top_form (form: FORM_IMP) is
			-- Process bottom attachment to `form' with top attached to `form'
		require
			bottom_not_void: bottom /= Void
			top_constraint: top = form
		do
			if bottom_relative then
				if top_relative then
					widget.set_form_height ( (0).max (((form.form_height * bottom_position) // form.fraction_base)  - widget.y))
				else
					widget.set_form_height ( (0).max (((form.form_height * bottom_position) // form.fraction_base) - top_position))
				end
			else
				if top_relative then
					widget.set_form_height ( (0).max (form.form_height - widget.y - bottom_position))
				else
					widget.set_form_height ( (0).max (form.form_height - top_position - bottom_position ))
				end
			end
		end

	process_bottom_form_top_widget (form: FORM_IMP) is
			-- Process bottom attachment to `form' with top attached to another widget
		require
			bottom_not_void: bottom /= Void
			top_constraint: top /= Void
			top_processed: form.form_child_list.find_widget (top).processed
		do
			if bottom_relative then
				widget.set_form_height ( (0).max ((form.form_height * bottom_position ) // form.fraction_base - top.y - top.form_height - top_position))
			else
				widget.set_form_height ( (0).max (form.form_height - bottom_position - top_position - top.form_height - top.y))
			end
		end

end -- class ATTACHMENT_WINDOWS
 


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

