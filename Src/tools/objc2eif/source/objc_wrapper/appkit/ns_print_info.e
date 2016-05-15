note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PRINT_INFO

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_dictionary_,
	make

feature {NONE} -- Initialization

	make_with_dictionary_ (a_attributes: detachable NS_DICTIONARY)
			-- Initialize `Current'.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			make_with_pointer (objc_init_with_dictionary_(allocate_object, a_attributes__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSPrintInfo Externals

	objc_init_with_dictionary_ (an_item: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item initWithDictionary:$a_attributes];
			 ]"
		end

	objc_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item dictionary];
			 ]"
		end

	objc_set_paper_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setPaperName:$a_name];
			 ]"
		end

	objc_set_paper_size_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setPaperSize:*((NSSize *)$a_size)];
			 ]"
		end

	objc_set_orientation_ (an_item: POINTER; a_orientation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setOrientation:$a_orientation];
			 ]"
		end

	objc_set_scaling_factor_ (an_item: POINTER; a_scaling_factor: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setScalingFactor:$a_scaling_factor];
			 ]"
		end

	objc_paper_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item paperName];
			 ]"
		end

	objc_paper_size (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSPrintInfo *)$an_item paperSize];
			 ]"
		end

	objc_orientation (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item orientation];
			 ]"
		end

	objc_scaling_factor (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item scalingFactor];
			 ]"
		end

	objc_set_left_margin_ (an_item: POINTER; a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setLeftMargin:$a_margin];
			 ]"
		end

	objc_set_right_margin_ (an_item: POINTER; a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setRightMargin:$a_margin];
			 ]"
		end

	objc_set_top_margin_ (an_item: POINTER; a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setTopMargin:$a_margin];
			 ]"
		end

	objc_set_bottom_margin_ (an_item: POINTER; a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setBottomMargin:$a_margin];
			 ]"
		end

	objc_left_margin (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item leftMargin];
			 ]"
		end

	objc_right_margin (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item rightMargin];
			 ]"
		end

	objc_top_margin (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item topMargin];
			 ]"
		end

	objc_bottom_margin (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item bottomMargin];
			 ]"
		end

	objc_set_horizontally_centered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setHorizontallyCentered:$a_flag];
			 ]"
		end

	objc_set_vertically_centered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setVerticallyCentered:$a_flag];
			 ]"
		end

	objc_is_horizontally_centered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item isHorizontallyCentered];
			 ]"
		end

	objc_is_vertically_centered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item isVerticallyCentered];
			 ]"
		end

	objc_set_horizontal_pagination_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setHorizontalPagination:$a_mode];
			 ]"
		end

	objc_set_vertical_pagination_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setVerticalPagination:$a_mode];
			 ]"
		end

	objc_horizontal_pagination (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item horizontalPagination];
			 ]"
		end

	objc_vertical_pagination (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item verticalPagination];
			 ]"
		end

	objc_set_job_disposition_ (an_item: POINTER; a_disposition: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setJobDisposition:$a_disposition];
			 ]"
		end

	objc_job_disposition (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item jobDisposition];
			 ]"
		end

	objc_set_printer_ (an_item: POINTER; a_printer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setPrinter:$a_printer];
			 ]"
		end

	objc_printer (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item printer];
			 ]"
		end

	objc_set_up_print_operation_default_values (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setUpPrintOperationDefaultValues];
			 ]"
		end

	objc_imageable_page_bounds (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSPrintInfo *)$an_item imageablePageBounds];
			 ]"
		end

	objc_localized_paper_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item localizedPaperName];
			 ]"
		end

	objc_print_settings (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPrintInfo *)$an_item printSettings];
			 ]"
		end

--	objc_pm_print_session (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPrintInfo *)$an_item PMPrintSession];
--			 ]"
--		end

--	objc_pm_page_format (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPrintInfo *)$an_item PMPageFormat];
--			 ]"
--		end

--	objc_pm_print_settings (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSPrintInfo *)$an_item PMPrintSettings];
--			 ]"
--		end

	objc_update_from_pm_page_format (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item updateFromPMPageFormat];
			 ]"
		end

	objc_update_from_pm_print_settings (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item updateFromPMPrintSettings];
			 ]"
		end

	objc_set_selection_only_ (an_item: POINTER; a_selection_only: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPrintInfo *)$an_item setSelectionOnly:$a_selection_only];
			 ]"
		end

	objc_is_selection_only (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPrintInfo *)$an_item isSelectionOnly];
			 ]"
		end

feature -- NSPrintInfo

	dictionary: detachable NS_MUTABLE_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_paper_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_paper_name_ (item, a_name__item)
		end

	set_paper_size_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_paper_size_ (item, a_size.item)
		end

	set_orientation_ (a_orientation: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_orientation_ (item, a_orientation)
		end

	set_scaling_factor_ (a_scaling_factor: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_scaling_factor_ (item, a_scaling_factor)
		end

	paper_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_paper_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like paper_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like paper_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	paper_size: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_paper_size (item, Result.item)
		end

	orientation: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_orientation (item)
		end

	scaling_factor: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_scaling_factor (item)
		end

	set_left_margin_ (a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_left_margin_ (item, a_margin)
		end

	set_right_margin_ (a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_right_margin_ (item, a_margin)
		end

	set_top_margin_ (a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_top_margin_ (item, a_margin)
		end

	set_bottom_margin_ (a_margin: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_bottom_margin_ (item, a_margin)
		end

	left_margin: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_left_margin (item)
		end

	right_margin: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_right_margin (item)
		end

	top_margin: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_top_margin (item)
		end

	bottom_margin: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_bottom_margin (item)
		end

	set_horizontally_centered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_horizontally_centered_ (item, a_flag)
		end

	set_vertically_centered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertically_centered_ (item, a_flag)
		end

	is_horizontally_centered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_horizontally_centered (item)
		end

	is_vertically_centered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_vertically_centered (item)
		end

	set_horizontal_pagination_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_horizontal_pagination_ (item, a_mode)
		end

	set_vertical_pagination_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_vertical_pagination_ (item, a_mode)
		end

	horizontal_pagination: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_horizontal_pagination (item)
		end

	vertical_pagination: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_vertical_pagination (item)
		end

	set_job_disposition_ (a_disposition: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_disposition__item: POINTER
		do
			if attached a_disposition as a_disposition_attached then
				a_disposition__item := a_disposition_attached.item
			end
			objc_set_job_disposition_ (item, a_disposition__item)
		end

	job_disposition: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_job_disposition (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like job_disposition} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like job_disposition} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_printer_ (a_printer: detachable NS_PRINTER)
			-- Auto generated Objective-C wrapper.
		local
			a_printer__item: POINTER
		do
			if attached a_printer as a_printer_attached then
				a_printer__item := a_printer_attached.item
			end
			objc_set_printer_ (item, a_printer__item)
		end

	printer: detachable NS_PRINTER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_printer (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like printer} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like printer} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_up_print_operation_default_values
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_up_print_operation_default_values (item)
		end

	imageable_page_bounds: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_imageable_page_bounds (item, Result.item)
		end

	localized_paper_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_paper_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_paper_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_paper_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	print_settings: detachable NS_MUTABLE_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_print_settings (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like print_settings} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like print_settings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	pm_print_session: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_pm_print_session (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like pm_print_session} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like pm_print_session} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	pm_page_format: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_pm_page_format (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like pm_page_format} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like pm_page_format} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	pm_print_settings: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_pm_print_settings (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like pm_print_settings} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like pm_print_settings} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	update_from_pm_page_format
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_from_pm_page_format (item)
		end

	update_from_pm_print_settings
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_update_from_pm_print_settings (item)
		end

	set_selection_only_ (a_selection_only: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_selection_only_ (item, a_selection_only)
		end

	is_selection_only: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_selection_only (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPrintInfo"
		end

end
