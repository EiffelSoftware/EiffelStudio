note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLLECTION_VIEW_ITEM

inherit
	NS_VIEW_CONTROLLER
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_nib_name__bundle_,
	make

feature -- NSCollectionViewItem

	collection_view: detachable NS_COLLECTION_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_collection_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like collection_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like collection_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selected_ (item, a_flag)
		end

	is_selected: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selected (item)
		end

feature {NONE} -- NSCollectionViewItem Externals

	objc_collection_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSCollectionViewItem *)$an_item collectionView];
			 ]"
		end

	objc_set_selected_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSCollectionViewItem *)$an_item setSelected:$a_flag];
			 ]"
		end

	objc_is_selected (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSCollectionViewItem *)$an_item isSelected];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSCollectionViewItem"
		end

end
