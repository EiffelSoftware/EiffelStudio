indexing

	description: 
		"Text tag used to mark a difference.";
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
			highlighted_image := clone (text)
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

end -- class DIFFERENCE_TEXT_ITEM
