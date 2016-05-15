note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COLOR_SPACE

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
	make_with_icc_profile_data_,
	make

feature {NONE} -- Initialization

	make_with_icc_profile_data_ (a_icc_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_icc_data__item: POINTER
		do
			if attached a_icc_data as a_icc_data_attached then
				a_icc_data__item := a_icc_data_attached.item
			end
			make_with_pointer (objc_init_with_icc_profile_data_(allocate_object, a_icc_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

--	make_with_color_sync_profile_ (a_prof: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_prof__item: POINTER
--		do
--			if attached a_prof as a_prof_attached then
--				a_prof__item := a_prof_attached.item
--			end
--			make_with_pointer (objc_init_with_color_sync_profile_(allocate_object, a_prof__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_cg_color_space_ (a_cg_color_space: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_cg_color_space__item: POINTER
--		do
--			if attached a_cg_color_space as a_cg_color_space_attached then
--				a_cg_color_space__item := a_cg_color_space_attached.item
--			end
--			make_with_pointer (objc_init_with_cg_color_space_(allocate_object, a_cg_color_space__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSColorSpace Externals

	objc_init_with_icc_profile_data_ (an_item: POINTER; a_icc_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorSpace *)$an_item initWithICCProfileData:$a_icc_data];
			 ]"
		end

	objc_icc_profile_data (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorSpace *)$an_item ICCProfileData];
			 ]"
		end

--	objc_init_with_color_sync_profile_ (an_item: POINTER; a_prof: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSColorSpace *)$an_item initWithColorSyncProfile:];
--			 ]"
--		end

--	objc_color_sync_profile (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSColorSpace *)$an_item colorSyncProfile];
--			 ]"
--		end

--	objc_init_with_cg_color_space_ (an_item: POINTER; a_cg_color_space: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSColorSpace *)$an_item initWithCGColorSpace:];
--			 ]"
--		end

--	objc_cg_color_space (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSColorSpace *)$an_item CGColorSpace];
--			 ]"
--		end

	objc_number_of_color_components (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorSpace *)$an_item numberOfColorComponents];
			 ]"
		end

	objc_color_space_model (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSColorSpace *)$an_item colorSpaceModel];
			 ]"
		end

	objc_localized_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSColorSpace *)$an_item localizedName];
			 ]"
		end

feature -- NSColorSpace

	icc_profile_data: detachable NS_DATA
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_icc_profile_data (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like icc_profile_data} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like icc_profile_data} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	color_sync_profile: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_color_sync_profile (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like color_sync_profile} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like color_sync_profile} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	cg_color_space: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_cg_color_space (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like cg_color_space} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like cg_color_space} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	number_of_color_components: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_color_components (item)
		end

	color_space_model: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_color_space_model (item)
		end

	localized_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSColorSpace"
		end

end
