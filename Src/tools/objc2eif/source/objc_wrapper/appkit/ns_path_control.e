note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PATH_CONTROL

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSPathControl

	url: detachable NS_URL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_url (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like url} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like url} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_ur_l_ (a_url: detachable NS_URL)
			-- Auto generated Objective-C wrapper.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			objc_set_ur_l_ (item, a_url__item)
		end

	double_action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_double_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_double_action_ (a_action: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			objc_set_double_action_ (item, a_action__item)
		end

	path_style: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_path_style (item)
		end

	set_path_style_ (a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_path_style_ (item, a_style)
		end

	clicked_path_component_cell: detachable NS_PATH_COMPONENT_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_clicked_path_component_cell (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like clicked_path_component_cell} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like clicked_path_component_cell} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	path_component_cells: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_path_component_cells (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_component_cells} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_component_cells} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_path_component_cells_ (a_cells: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_cells__item: POINTER
		do
			if attached a_cells as a_cells_attached then
				a_cells__item := a_cells_attached.item
			end
			objc_set_path_component_cells_ (item, a_cells__item)
		end

	set_background_color_ (a_color: detachable NS_COLOR)
			-- Auto generated Objective-C wrapper.
		local
			a_color__item: POINTER
		do
			if attached a_color as a_color_attached then
				a_color__item := a_color_attached.item
			end
			objc_set_background_color_ (item, a_color__item)
		end

	background_color: detachable NS_COLOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_background_color (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like background_color} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like background_color} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	delegate: detachable NS_PATH_CONTROL_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_PATH_CONTROL_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	set_dragging_source_operation_mask__for_local_ (a_mask: NATURAL_64; a_is_local: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dragging_source_operation_mask__for_local_ (item, a_mask, a_is_local)
		end

feature {NONE} -- NSPathControl Externals

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item URL];
			 ]"
		end

	objc_set_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setURL:$a_url];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item doubleAction];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setDoubleAction:$a_action];
			 ]"
		end

	objc_path_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPathControl *)$an_item pathStyle];
			 ]"
		end

	objc_set_path_style_ (an_item: POINTER; a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setPathStyle:$a_style];
			 ]"
		end

	objc_clicked_path_component_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item clickedPathComponentCell];
			 ]"
		end

	objc_path_component_cells (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item pathComponentCells];
			 ]"
		end

	objc_set_path_component_cells_ (an_item: POINTER; a_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setPathComponentCells:$a_cells];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item backgroundColor];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathControl *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_set_dragging_source_operation_mask__for_local_ (an_item: POINTER; a_mask: NATURAL_64; a_is_local: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathControl *)$an_item setDraggingSourceOperationMask:$a_mask forLocal:$a_is_local];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPathControl"
		end

end
