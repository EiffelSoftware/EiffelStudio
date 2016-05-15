note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_IMAGE_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	image_did_not_draw__in_rect_ (a_sender: detachable NS_OBJECT; a_rect: NS_RECT): detachable NS_IMAGE
			-- Auto generated Objective-C wrapper.
		require
			has_image_did_not_draw__in_rect_: has_image_did_not_draw__in_rect_
		local
			result_pointer: POINTER
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			result_pointer := objc_image_did_not_draw__in_rect_ (item, a_sender__item, a_rect.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like image_did_not_draw__in_rect_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like image_did_not_draw__in_rect_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	image__will_load_representation_ (a_image: detachable NS_IMAGE; a_rep: detachable NS_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		require
			has_image__will_load_representation_: has_image__will_load_representation_
		local
			a_image__item: POINTER
			a_rep__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_rep as a_rep_attached then
				a_rep__item := a_rep_attached.item
			end
			objc_image__will_load_representation_ (item, a_image__item, a_rep__item)
		end

	image__did_load_representation_header_ (a_image: detachable NS_IMAGE; a_rep: detachable NS_IMAGE_REP)
			-- Auto generated Objective-C wrapper.
		require
			has_image__did_load_representation_header_: has_image__did_load_representation_header_
		local
			a_image__item: POINTER
			a_rep__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_rep as a_rep_attached then
				a_rep__item := a_rep_attached.item
			end
			objc_image__did_load_representation_header_ (item, a_image__item, a_rep__item)
		end

	image__did_load_part_of_representation__with_valid_rows_ (a_image: detachable NS_IMAGE; a_rep: detachable NS_IMAGE_REP; a_rows: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		require
			has_image__did_load_part_of_representation__with_valid_rows_: has_image__did_load_part_of_representation__with_valid_rows_
		local
			a_image__item: POINTER
			a_rep__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_rep as a_rep_attached then
				a_rep__item := a_rep_attached.item
			end
			objc_image__did_load_part_of_representation__with_valid_rows_ (item, a_image__item, a_rep__item, a_rows)
		end

	image__did_load_representation__with_status_ (a_image: detachable NS_IMAGE; a_rep: detachable NS_IMAGE_REP; a_status: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		require
			has_image__did_load_representation__with_status_: has_image__did_load_representation__with_status_
		local
			a_image__item: POINTER
			a_rep__item: POINTER
		do
			if attached a_image as a_image_attached then
				a_image__item := a_image_attached.item
			end
			if attached a_rep as a_rep_attached then
				a_rep__item := a_rep_attached.item
			end
			objc_image__did_load_representation__with_status_ (item, a_image__item, a_rep__item, a_status)
		end

feature -- Status Report

	has_image_did_not_draw__in_rect_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_image_did_not_draw__in_rect_ (item)
		end

	has_image__will_load_representation_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_image__will_load_representation_ (item)
		end

	has_image__did_load_representation_header_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_image__did_load_representation_header_ (item)
		end

	has_image__did_load_part_of_representation__with_valid_rows_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_image__did_load_part_of_representation__with_valid_rows_ (item)
		end

	has_image__did_load_representation__with_status_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_image__did_load_representation__with_status_ (item)
		end

feature -- Status Report Externals

	objc_has_image_did_not_draw__in_rect_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(imageDidNotDraw:inRect:)];
			 ]"
		end

	objc_has_image__will_load_representation_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(image:willLoadRepresentation:)];
			 ]"
		end

	objc_has_image__did_load_representation_header_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(image:didLoadRepresentationHeader:)];
			 ]"
		end

	objc_has_image__did_load_part_of_representation__with_valid_rows_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(image:didLoadPartOfRepresentation:withValidRows:)];
			 ]"
		end

	objc_has_image__did_load_representation__with_status_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(image:didLoadRepresentation:withStatus:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_image_did_not_draw__in_rect_ (an_item: POINTER; a_sender: POINTER; a_rect: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSImageDelegate>)$an_item imageDidNotDraw:$a_sender inRect:*((NSRect *)$a_rect)];
			 ]"
		end

	objc_image__will_load_representation_ (an_item: POINTER; a_image: POINTER; a_rep: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSImageDelegate>)$an_item image:$a_image willLoadRepresentation:$a_rep];
			 ]"
		end

	objc_image__did_load_representation_header_ (an_item: POINTER; a_image: POINTER; a_rep: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSImageDelegate>)$an_item image:$a_image didLoadRepresentationHeader:$a_rep];
			 ]"
		end

	objc_image__did_load_part_of_representation__with_valid_rows_ (an_item: POINTER; a_image: POINTER; a_rep: POINTER; a_rows: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSImageDelegate>)$an_item image:$a_image didLoadPartOfRepresentation:$a_rep withValidRows:$a_rows];
			 ]"
		end

	objc_image__did_load_representation__with_status_ (an_item: POINTER; a_image: POINTER; a_rep: POINTER; a_status: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSImageDelegate>)$an_item image:$a_image didLoadRepresentation:$a_rep withStatus:$a_status];
			 ]"
		end

end
