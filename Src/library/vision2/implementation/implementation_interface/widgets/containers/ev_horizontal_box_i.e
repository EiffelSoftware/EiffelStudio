indexing
	description: 
		"EiffelVision horizontal box. Implementation interface."
	status: "See notice at end of class"
	id: "container, horizontal, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_HORIZONTAL_BOX_I
	
inherit
	EV_BOX_I
		redefine
			interface
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	insertion_position: INTEGER is
			-- `Result' is insertion position in `Current' based on
			-- Current screen pointer.
		local
			curs: CURSOR
			offset: INTEGER
			current_pos: INTEGER
			current_widget_height: INTEGER
			next_position: INTEGER
			current_position: INTEGER
			last_position: INTEGER
			temp1, temp2: INTEGER
		do
			Result := -1
			curs := cursor
			offset := internal_screen.pointer_position.x - screen_x
				-- As the current mouse position may have changed since the
				-- motion event was received, we only perform the
				-- following if this is not the case
			if offset >= 0 and offset <= width then
			if offset >= width - border_width then
							Result := interface.count + 1
						elseif offset < border_width then
							Result := 1
				else
				from
					interface.start
					last_position := border_width
				until
					Result /= -1
				loop
					current_position := current_position + interface.item.width
					if interface.index = 1 then
						current_position := current_position + border_width
					else
						current_position := current_position + interface.padding_width
					end
						if offset >= last_position and then offset <= current_position then
							temp1 := (current_position - last_position) // 2
							temp2 := last_position + temp1 + (interface.padding_width // 2)
							if offset > temp2 then
								Result := interface.index + 1
							else
								Result := interface.index
							end
						end
						
					last_position := current_position
					interface.forth
				end 
				go_to (curs)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_BOX

end -- class EV_HORIZONTAL_BOX_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

