indexing

	description: 
		"Text tag used to mark a difference."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class DIFFERENCE_TEXT_ITEM

inherit

	TEXT_ITEM
	SHARED_TEXT_ITEMS

create

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize Current with image `text'.
		require
			valid_text: text /= Void
		do
			normal_image := text;
			highlighted_image := text.twin
			check
				first_is_space: highlighted_image.item (1) = ' '
			end
			highlighted_image.put ('>', 1)
			unset_is_current
		end;

feature -- Properties

	has_empty_image: BOOLEAN is
			-- Is Current text item image the empty string?
		do
			Result := (image = Empty_image)
		end

	image: STRING;
			-- Text representation of Current

	is_current: BOOLEAN is
			-- Is the class diff to which Current text item is associated
			-- the currently processed diff? I.e., is Current the normal
			-- symbol, or the "highlighted" one?
		do
			Result := (image = highlighted_image)
		end

	is_merged: BOOLEAN is
			-- Has the class diff to which Current text item is associated
			-- been merged?
		do
			Result := (image = ti_No_diff.image)
		end

feature -- Settings

	restore_image is
			-- Reset Current text item image as it was before
			-- last `set_empty_image'.
		do
			if previous_image /= Void then
				image := previous_image
			end
		end

	set_empty_image is
			-- Set Current text item image to the empty string.
			-- Save the previous image (may be restored with
			-- `restore_image').
		do
			if not has_empty_image then
				previous_image := image 
				image := Empty_image
			end
		ensure
			empty: has_empty_image
		end

	set_is_merged is
			-- The class diff to which Current text item is associated
			-- has been merged. There is no difference to point at
			-- any more.
		do
			image := ti_No_diff.image
		end

	set_is_current is
			-- The class diff to which Current text item is associated
			-- has become the currently processed diff; thus Current
			-- symbol must be "highlighted".
		do
			image := highlighted_image
		end

	unset_is_current is
			-- The class diff to which Current text item is associated
			-- is not the currently processed diff any more; thus Current
			-- symbol must not be "highlighted".
		do
			image := normal_image
		end

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_difference_text_item (Current)
		end

feature {NONE} -- Implementation properties

	highlighted_image, normal_image, previous_image: like image

	empty_image: STRING is "";

invariant
	highlighted_image_exists: highlighted_image /= Void
	normal_image_exists: normal_image /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DIFFERENCE_TEXT_ITEM
