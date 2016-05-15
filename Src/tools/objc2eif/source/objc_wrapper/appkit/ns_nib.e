note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NIB

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_contents_of_ur_l_,
	make_with_nib_named__bundle_,
	make

feature {NONE} -- Initialization

	make_with_contents_of_ur_l_ (a_nib_file_url: detachable NS_URL)
			-- Initialize `Current'.
		local
			a_nib_file_url__item: POINTER
		do
			if attached a_nib_file_url as a_nib_file_url_attached then
				a_nib_file_url__item := a_nib_file_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l_(allocate_object, a_nib_file_url__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_nib_named__bundle_ (a_nib_name: detachable NS_STRING; a_bundle: detachable NS_BUNDLE)
			-- Initialize `Current'.
		local
			a_nib_name__item: POINTER
			a_bundle__item: POINTER
		do
			if attached a_nib_name as a_nib_name_attached then
				a_nib_name__item := a_nib_name_attached.item
			end
			if attached a_bundle as a_bundle_attached then
				a_bundle__item := a_bundle_attached.item
			end
			make_with_pointer (objc_init_with_nib_named__bundle_(allocate_object, a_nib_name__item, a_bundle__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSNib Externals

	objc_init_with_contents_of_ur_l_ (an_item: POINTER; a_nib_file_url: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNib *)$an_item initWithContentsOfURL:$a_nib_file_url];
			 ]"
		end

	objc_init_with_nib_named__bundle_ (an_item: POINTER; a_nib_name: POINTER; a_bundle: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNib *)$an_item initWithNibNamed:$a_nib_name bundle:$a_bundle];
			 ]"
		end

	objc_instantiate_nib_with_external_name_table_ (an_item: POINTER; a_external_name_table: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSNib *)$an_item instantiateNibWithExternalNameTable:$a_external_name_table];
			 ]"
		end

--	objc_instantiate_nib_with_owner__top_level_objects_ (an_item: POINTER; a_owner: POINTER; a_top_level_objects: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSNib *)$an_item instantiateNibWithOwner:$a_owner topLevelObjects:];
--			 ]"
--		end

feature -- NSNib

	instantiate_nib_with_external_name_table_ (a_external_name_table: detachable NS_DICTIONARY): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_external_name_table__item: POINTER
		do
			if attached a_external_name_table as a_external_name_table_attached then
				a_external_name_table__item := a_external_name_table_attached.item
			end
			Result := objc_instantiate_nib_with_external_name_table_ (item, a_external_name_table__item)
		end

--	instantiate_nib_with_owner__top_level_objects_ (a_owner: detachable NS_OBJECT; a_top_level_objects: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_owner__item: POINTER
--			a_top_level_objects__item: POINTER
--		do
--			if attached a_owner as a_owner_attached then
--				a_owner__item := a_owner_attached.item
--			end
--			if attached a_top_level_objects as a_top_level_objects_attached then
--				a_top_level_objects__item := a_top_level_objects_attached.item
--			end
--			Result := objc_instantiate_nib_with_owner__top_level_objects_ (item, a_owner__item, a_top_level_objects__item)
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNib"
		end

end
