indexing
	description	: "Object to share image lists among all vision2 controls"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_SHARED_IMAGE_LIST_IMP

inherit
	WEL_ILC_CONSTANTS
		export {NONE}
			all
		end

feature -- Access

	get_imagelist_with_size (a_width: INTEGER; a_height: INTEGER): EV_IMAGE_LIST_IMP is
			-- Retrieve an imagelist for trees and lists with size equal to `a_width'x`a_height'.
			-- Call `destroy_imagelist' when the result of this function is no more needed.
		do
			Result := get_specific_imagelist_with_size (classic_imagelists, a_width, a_height)
		end

	destroy_imagelist (an_imagelist: EV_IMAGE_LIST_IMP) is
			-- Destroy `an_imagelist' if it not referened in another control.
		do
			destroy_specific_imagelist (classic_imagelists, an_imagelist)
		end

	get_toolbar_default_imagelist_with_size (a_width: INTEGER; a_height: INTEGER): EV_IMAGE_LIST_IMP is
			-- Retrieve a "default" imagelist for toolbar with size equal to `a_width'x`a_height'.
		do
			Result := get_specific_imagelist_with_size (toolbar_default_imagelists, a_width, a_height)
		end

	destroy_toolbar_default_imagelist (an_imagelist: EV_IMAGE_LIST_IMP) is
			-- Destroy `an_imagelist' if it not referened in another control.
		do
			destroy_specific_imagelist (toolbar_default_imagelists, an_imagelist)
		end

	get_toolbar_hot_imagelist_with_size (a_width: INTEGER; a_height: INTEGER): EV_IMAGE_LIST_IMP is
			-- Retrieve a "hot" imagelist for toolbar with size equal to `a_width'x`a_height'.
		do
			Result := get_specific_imagelist_with_size (toolbar_hot_imagelists, a_width, a_height)
		end

	destroy_toolbar_hot_imagelist (an_imagelist: EV_IMAGE_LIST_IMP) is
			-- Destroy `an_imagelist' if it not referened in another control.
		do
			destroy_specific_imagelist (toolbar_hot_imagelists, an_imagelist)
		end

feature {NONE} -- Implementation

	get_specific_imagelist_with_size (imagelists: like toolbar_default_imagelists; a_width: INTEGER; a_height: INTEGER): EV_IMAGE_LIST_IMP is
			-- Retrieve a imagelist with size equal to `a_width'x`a_height' from `imagelists'.
		local
			imagelists_item: EV_IMAGE_LIST_IMP
		do
			from
				imagelists.start
			until
				Result /= Void or imagelists.after
			loop
				imagelists_item := imagelists.item
				if (imagelists_item.bitmaps_width = a_width) and 
				   (imagelists_item.bitmaps_width = a_width)
				then
					Result := imagelists_item

						-- Increment the number of reference for the client.
					Result.increment_reference
				end
				imagelists.forth
			end

				-- Not found
			if Result = Void then
				create Result.make_with_size (a_width, a_height)
				Result.enable_reference_tracking
				imagelists.extend (Result)
			end
		end

	destroy_specific_imagelist (imagelists: like toolbar_default_imagelists; an_imagelist: EV_IMAGE_LIST_IMP) is
			-- Destroy `an_imagelist' if it not referened in another control.
		do
				-- Check that this imageList belongs to us!
			check
				referenced_imagelist:
					imagelists.has (an_imagelist)
			end
		
				-- Decrement the number of references.
			an_imagelist.decrement_reference			

			if an_imagelist.references_count = 1 then 
				-- means that only the array is referencing the imagelist, so we can
				-- destroy it.
				imagelists.prune_all (an_imagelist)
				an_imagelist.decrement_reference
				check
					imagelist_do_not_exist_anymore: not an_imagelist.exists
				end
			end
		end

	classic_imagelists: ARRAYED_LIST [EV_IMAGE_LIST_IMP] is
			-- List of all image lists for lists and trees used in this program.
		once
			create Result.make(2)
		end

	toolbar_default_imagelists: ARRAYED_LIST [EV_IMAGE_LIST_IMP] is
			-- List of all "default" image lists for toolbars used in this program.
		once
			create Result.make(2)
		end

	toolbar_hot_imagelists: ARRAYED_LIST [EV_IMAGE_LIST_IMP] is
			-- List of all "hot" image lists for toolbars used in this program.
		once
			create Result.make(2)
		end

end -- class EV_SHARED_IMAGE_LIST_IMP
