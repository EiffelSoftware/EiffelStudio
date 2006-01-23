indexing
	description: 
		"EiffelVision box, implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end
		
	EV_DOCKABLE_TARGET_I
		redefine
			interface
		end

	
feature -- Constants
	
	Default_homogeneous: BOOLEAN is False
	Default_spacing: INTEGER is 0
	Default_border_width: INTEGER is 0

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		deferred
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		deferred
		ensure
			positive_result: Result >= 0
		end

	padding: INTEGER is
			-- Space between children in pixels.
		deferred
		ensure
			positive: Result >= 0
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy available spare space.
		require
			has_child: interface.has (child)
		deferred
		end
	
feature {EV_ANY, EV_ANY_I} -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		deferred
		ensure
			homogeneous_set: is_homogeneous = flag
		end

	set_border_width (value: INTEGER) is
			-- Assign `value' to `border_width'.
		require
			positive_value: value >= 0
		deferred
		ensure
			border_assigned: border_width = value
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		require
			positive_value: value >= 0
		deferred
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill avalible spare space.
		require
			has_child: interface.has (child)
		deferred
		ensure
			flag_assigned: is_item_expanded (child) = flag
		end

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	pointer_offset: INTEGER is
			-- Offset of mouse pointer coordinate matching orientation, into `Current'.
		deferred
		end
		
	docking_dimension_of_current_item: INTEGER is
			-- Dimension of `interface.item' matching orientation of `Current'.
		deferred
		end
		
	docking_dimension_of_current: INTEGER is
			-- Dimension of `Current' matching orientation of `Current'
		deferred
		end

	insertion_position: INTEGER is
			-- `Result' is insertion position in `Current' based on
			-- Current screen pointer.
		local
			curs: CURSOR
			offset: INTEGER
			current_position: INTEGER
			last_position: INTEGER
			temp1, temp2: INTEGER
		do
			Result := -1
			curs := cursor
			offset := pointer_offset
				-- As the current mouse position may have changed since the
				-- motion event was received, we only perform the
				-- following if this is not the case
			if offset >= 0 and offset <= docking_dimension_of_current then
				if offset >= docking_dimension_of_current - border_width or interface.is_empty or (interface.count = 1 and interface.i_th (1) = Insert_label) then
						-- Three cases are handled specially here
						-- If the pointed position is within the far border after all item, of `Current'.
						-- If `Current' is empty.
						-- If `Current' is only containing `Insert_label', meaning when the transport
						-- began, it was empty.
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
						current_position := current_position + docking_dimension_of_current_item
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
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_BOX;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_BOX_I

