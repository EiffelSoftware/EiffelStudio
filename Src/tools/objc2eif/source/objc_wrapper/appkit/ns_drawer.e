note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DRAWER

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_content_size__preferred_edge_,
	make

feature {NONE} -- Initialization

	make_with_content_size__preferred_edge_ (a_content_size: NS_SIZE; a_edge: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_content_size__preferred_edge_(allocate_object, a_content_size.item, a_edge))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSDrawer Externals

	objc_init_with_content_size__preferred_edge_ (an_item: POINTER; a_content_size: POINTER; a_edge: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDrawer *)$an_item initWithContentSize:*((NSSize *)$a_content_size) preferredEdge:$a_edge];
			 ]"
		end

	objc_set_parent_window_ (an_item: POINTER; a_parent: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setParentWindow:$a_parent];
			 ]"
		end

	objc_parent_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDrawer *)$an_item parentWindow];
			 ]"
		end

	objc_set_content_view_ (an_item: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setContentView:$a_view];
			 ]"
		end

	objc_content_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDrawer *)$an_item contentView];
			 ]"
		end

	objc_set_preferred_edge_ (an_item: POINTER; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setPreferredEdge:$a_edge];
			 ]"
		end

	objc_preferred_edge (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDrawer *)$an_item preferredEdge];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSDrawer *)$an_item delegate];
			 ]"
		end

	objc_open (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item open];
			 ]"
		end

	objc_open_on_edge_ (an_item: POINTER; a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item openOnEdge:$a_edge];
			 ]"
		end

	objc_close (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item close];
			 ]"
		end

	objc_open_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item open:$a_sender];
			 ]"
		end

	objc_close_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item close:$a_sender];
			 ]"
		end

	objc_toggle_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item toggle:$a_sender];
			 ]"
		end

	objc_state (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDrawer *)$an_item state];
			 ]"
		end

	objc_edge (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDrawer *)$an_item edge];
			 ]"
		end

	objc_set_content_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setContentSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_content_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSDrawer *)$an_item contentSize];
			 ]"
		end

	objc_set_min_content_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setMinContentSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_min_content_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSDrawer *)$an_item minContentSize];
			 ]"
		end

	objc_set_max_content_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setMaxContentSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_max_content_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSDrawer *)$an_item maxContentSize];
			 ]"
		end

	objc_set_leading_offset_ (an_item: POINTER; a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setLeadingOffset:$a_offset];
			 ]"
		end

	objc_leading_offset (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDrawer *)$an_item leadingOffset];
			 ]"
		end

	objc_set_trailing_offset_ (an_item: POINTER; a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSDrawer *)$an_item setTrailingOffset:$a_offset];
			 ]"
		end

	objc_trailing_offset (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSDrawer *)$an_item trailingOffset];
			 ]"
		end

feature -- NSDrawer

	set_parent_window_ (a_parent: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_parent__item: POINTER
		do
			if attached a_parent as a_parent_attached then
				a_parent__item := a_parent_attached.item
			end
			objc_set_parent_window_ (item, a_parent__item)
		end

	parent_window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_parent_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like parent_window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like parent_window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_content_view_ (a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_set_content_view_ (item, a_view__item)
		end

	content_view: detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_content_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like content_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like content_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_preferred_edge_ (a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_preferred_edge_ (item, a_edge)
		end

	preferred_edge: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_preferred_edge (item)
		end

	set_delegate_ (an_object: detachable NS_DRAWER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_DRAWER_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	open
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_open (item)
		end

	open_on_edge_ (a_edge: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_open_on_edge_ (item, a_edge)
		end

	close
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close (item)
		end

	open_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_open_ (item, a_sender__item)
		end

	close_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_close_ (item, a_sender__item)
		end

	toggle_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_toggle_ (item, a_sender__item)
		end

	state: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_state (item)
		end

	edge: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_edge (item)
		end

	set_content_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_content_size_ (item, a_size.item)
		end

	content_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_content_size (item, Result.item)
		end

	set_min_content_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_min_content_size_ (item, a_size.item)
		end

	min_content_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_min_content_size (item, Result.item)
		end

	set_max_content_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_max_content_size_ (item, a_size.item)
		end

	max_content_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_max_content_size (item, Result.item)
		end

	set_leading_offset_ (a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_leading_offset_ (item, a_offset)
		end

	leading_offset: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_leading_offset (item)
		end

	set_trailing_offset_ (a_offset: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_trailing_offset_ (item, a_offset)
		end

	trailing_offset: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_trailing_offset (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDrawer"
		end

end
