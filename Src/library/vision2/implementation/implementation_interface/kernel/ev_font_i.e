indexing
	description: "Eiffel Vision font. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "character, face, height, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONT_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_FONT_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	family: INTEGER is
			-- Preferred font category.
		deferred
		end

	weight: INTEGER is
			-- Preferred font thickness.
		deferred
		end

	shape: INTEGER is
			-- Preferred font slant.
		deferred
		end

	height: INTEGER is
			-- Preferred font height measured in screen pixels.
		deferred
		end
		
	height_in_points: INTEGER is
			-- Preferred font height in pixels.
		deferred
		end

	preferred_families: EV_ACTIVE_LIST [STRING]
			-- Preferred user fonts.
			-- `family' will be ignored when not Void.

feature -- Element change

	set_values (a_family, a_weight, a_shape, a_height: INTEGER;
		a_preferred_families: like preferred_families) is
			-- Set `a_family', `a_weight', `a_shape' `a_height' and
			-- `a_preferred_faces' at the same time for speed.
		require
			a_family_valid: valid_family (a_family)
			a_weight_valid: valid_weight (a_weight)
			a_shape_valid: valid_shape (a_shape)
			a_height_bigger_than_zero: a_height > 0
			a_preferred_families_not_void: a_preferred_families /= Void
		do
			preferred_families := a_preferred_families
				-- We must now clear the add actions and remove actions, and re-insert
				-- agents connecting to `update_preferred_faces'. If this is not performed
				-- then when copying a font, an update to `preferred_faces' still uses the
				-- agent of the original list which calls back to the old implementation.
				-- This causes `preferred_families' then to always update based on the old imp.
				-- Julian.
			preferred_families.internal_add_actions.wipe_out
			preferred_families.internal_remove_actions.wipe_out
			preferred_families.internal_add_actions.extend (agent update_preferred_faces)
			preferred_families.internal_remove_actions.extend (agent update_preferred_faces)
			
			
			update_font_face
			set_family (a_family)
			set_weight (a_weight)
			set_shape (a_shape)
			set_height (a_height)
		end
		
	set_family (a_family: INTEGER) is
			-- Set `a_family' as preferred font category.
		require
			a_family_valid: valid_family (a_family)
		deferred
		ensure
			family_assigned: family = a_family
		end

	set_weight (a_weight: INTEGER) is
			-- Set `a_weight' as preferred font thickness.
		require
			a_weight_valid: valid_weight (a_weight)
		deferred
		ensure
			weight_assigned: weight = a_weight
		end

	set_shape (a_shape: INTEGER) is
			-- Set `a_shape' as preferred font slant.
		require
			a_shape_valid: valid_shape (a_shape)
		deferred
		ensure
			shape_assigned: shape = a_shape
		end

	set_height (a_height: INTEGER) is
			-- Set `a_height' as preferred font size.
		require
			a_height_bigger_than_zero: a_height > 0
		deferred
		ensure
			height_assigned: height = a_height
		end
		
	set_height_in_points (a_height: INTEGER) is
			-- Set `a_height_in_points' to `a_height'.
		require
			a_height_bigger_than_zero: a_height > 0
		deferred
		ensure
			height_assigned: height_in_points = a_height
		end

feature -- Status report

	name: STRING is
			-- Face name chosen by toolkit.
		deferred
		end

	ascent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the top of the drawn character. 
		deferred
		end

	descent: INTEGER is
			-- Vertical distance from the origin of the drawing
			-- operation to the bottom of the drawn character. 
		deferred
		end

	width: INTEGER is
			-- Character width of current fixed-width font.
		deferred
		end

	minimum_width: INTEGER is
			-- Width of the smallest character in the font.
		deferred
		end

	maximum_width: INTEGER is
			-- Width of the biggest character in the font.
		deferred
		end

	string_width (a_string: STRING): INTEGER is
			-- Width in pixels of `a_string' in the current font.
		require
			a_string_not_void: a_string /= Void
		deferred
		ensure
			positive: Result >= 0
		end

	horizontal_resolution: INTEGER is
			-- Horizontal resolution of screen for which the font is designed.
		deferred
		end

	vertical_resolution: INTEGER is
			-- Vertical resolution of screen for which the font is designed.
		deferred
		end

	is_proportional: BOOLEAN is
			-- Can characters in the font have different sizes?
		deferred
		end

	string_size (a_string: STRING): TUPLE [INTEGER, INTEGER, INTEGER, INTEGER] is
			-- [width, height, left_offset, right_offset] in pixels of `a_string' in the current font,
			-- taking into account line breaks ('%N').
			-- `width' and `height' correspond to the rectange used to bound `a_string', and
			-- should be used when placing strings next to each as part of a text.
			-- On some fonts, characters may extend outside of the bounds given by `width' and `height',
			-- for example certain italic letters may overhang other letters. Use `left_offset' and
			-- `right_offset' to determine if there is any overhang for `a_string'. a negative `left_offset'
			-- indicates overhang to the left, while a positive `right_offset' indicates an overhang to the right.
			-- To determine the complete bounding rectangle for `a_string' add negative `left_offset'
			-- and positive `right_offset' to `width'.
		require
			a_string_not_void: a_string /= Void
		local
			cur_width, cur_height: INTEGER
			index, n: INTEGER
			s: STRING
			l_height: INTEGER
		
		do
				-- Assign to local, avoiding multiple computations.
			l_height := height
			from
				n := 1
			until
				n > a_string.count
			loop
				index := a_string.index_of ('%N', n)
				if index > 0 then
					s := a_string.substring (n, index - 1)
					n := index + 1
				else
					s := a_string.substring (n, a_string.count)
					n := a_string.count + 1
				end
				cur_width := cur_width.max (string_width (s))
				cur_height := cur_height + l_height
			end
			Result := [cur_width, cur_height, 0, 0]
		end
		
feature {EV_FONT, EV_ANY_I} -- Implementation
		
	copy_font (other: like interface) is
			-- Update `Current' with all attributes of `other'.
		require
			other_not_void: other /= Void
			type_identity: same_type (other)
		do
			set_values (
				other.family,
				other.weight,
				other.shape,
				other.height,
				other.preferred_families.twin
			)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT

	update_font_face is
			-- Update the font face according to `preferred_faces' and `family'.
		deferred
		ensure
			name_not_void: name /= Void
		end
		
	update_preferred_faces (a_face: STRING) is
			-- `preferred_faces' has changed, so update `Current' to reflect this,
			-- possibly selecting a new face name.
		deferred
		end

invariant
	family_valid: is_initialized implies valid_family (family)
	weight_valid: is_initialized implies valid_weight (weight)
	shape_valid: is_initialized implies valid_shape (shape)
	height_bigger_than_zero: is_initialized implies height > 0
	ascent_not_negative: is_initialized implies ascent >= 0
	descent_not_negative: is_initialized implies descent >= 0
	width_of_empty_string_equals_zero: is_initialized implies string_width("") = 0

	--| FIXME  IEK Does not hold true in gtk for all fonts.
	--horizontal_resolution_bigger_than_zero: horizontal_resolution > 0
	--vertical_resolution_bigger_than_zero: vertical_resolution > 0

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




end -- class EV_FONT_I

