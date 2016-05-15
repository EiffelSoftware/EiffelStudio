note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PATH_CELL

inherit
	NS_ACTION_CELL
		redefine
			wrapper_objc_class_name
		end

	NS_OPEN_SAVE_PANEL_DELEGATE_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_text_cell_,
	make_image_cell_,
	make

feature -- NSPathCell

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

	allowed_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_allowed_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like allowed_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like allowed_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_allowed_types_ (a_allowed_types: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_allowed_types__item: POINTER
		do
			if attached a_allowed_types as a_allowed_types_attached then
				a_allowed_types__item := a_allowed_types_attached.item
			end
			objc_set_allowed_types_ (item, a_allowed_types__item)
		end

	delegate: detachable NS_PATH_CELL_DELEGATE_PROTOCOL
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

	set_delegate_ (a_value: detachable NS_PATH_CELL_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_delegate_ (item, a_value__item)
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

	rect_of_path_component_cell__with_frame__in_view_ (a_cell: detachable NS_PATH_COMPONENT_CELL; a_frame: NS_RECT; a_view: detachable NS_VIEW): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
			a_view__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			create Result.make
			objc_rect_of_path_component_cell__with_frame__in_view_ (item, Result.item, a_cell__item, a_frame.item, a_view__item)
		end

	path_component_cell_at_point__with_frame__in_view_ (a_point: NS_POINT; a_frame: NS_RECT; a_view: detachable NS_VIEW): detachable NS_PATH_COMPONENT_CELL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_view__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			result_pointer := objc_path_component_cell_at_point__with_frame__in_view_ (item, a_point.item, a_frame.item, a_view__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like path_component_cell_at_point__with_frame__in_view_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like path_component_cell_at_point__with_frame__in_view_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
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

	mouse_entered__with_frame__in_view_ (a_event: detachable NS_EVENT; a_frame: NS_RECT; a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
			a_view__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_mouse_entered__with_frame__in_view_ (item, a_event__item, a_frame.item, a_view__item)
		end

	mouse_exited__with_frame__in_view_ (a_event: detachable NS_EVENT; a_frame: NS_RECT; a_view: detachable NS_VIEW)
			-- Auto generated Objective-C wrapper.
		local
			a_event__item: POINTER
			a_view__item: POINTER
		do
			if attached a_event as a_event_attached then
				a_event__item := a_event_attached.item
			end
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			objc_mouse_exited__with_frame__in_view_ (item, a_event__item, a_frame.item, a_view__item)
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

	set_placeholder_string_ (a_string: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_string_ (item, a_string__item)
		end

	placeholder_string: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_placeholder_attributed_string_ (a_string: detachable NS_ATTRIBUTED_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			objc_set_placeholder_attributed_string_ (item, a_string__item)
		end

	placeholder_attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_placeholder_attributed_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like placeholder_attributed_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like placeholder_attributed_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPathCell Externals

	objc_path_style (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPathCell *)$an_item pathStyle];
			 ]"
		end

	objc_set_path_style_ (an_item: POINTER; a_style: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setPathStyle:$a_style];
			 ]"
		end

	objc_url (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item URL];
			 ]"
		end

	objc_set_ur_l_ (an_item: POINTER; a_url: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setURL:$a_url];
			 ]"
		end

	objc_allowed_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item allowedTypes];
			 ]"
		end

	objc_set_allowed_types_ (an_item: POINTER; a_allowed_types: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setAllowedTypes:$a_allowed_types];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setDelegate:$a_value];
			 ]"
		end

	objc_path_component_cells (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item pathComponentCells];
			 ]"
		end

	objc_set_path_component_cells_ (an_item: POINTER; a_cells: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setPathComponentCells:$a_cells];
			 ]"
		end

	objc_rect_of_path_component_cell__with_frame__in_view_ (an_item: POINTER; result_pointer: POINTER; a_cell: POINTER; a_frame: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSPathCell *)$an_item rectOfPathComponentCell:$a_cell withFrame:*((NSRect *)$a_frame) inView:$a_view];
			 ]"
		end

	objc_path_component_cell_at_point__with_frame__in_view_ (an_item: POINTER; a_point: POINTER; a_frame: POINTER; a_view: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item pathComponentCellAtPoint:*((NSPoint *)$a_point) withFrame:*((NSRect *)$a_frame) inView:$a_view];
			 ]"
		end

	objc_clicked_path_component_cell (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item clickedPathComponentCell];
			 ]"
		end

	objc_mouse_entered__with_frame__in_view_ (an_item: POINTER; a_event: POINTER; a_frame: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item mouseEntered:$a_event withFrame:*((NSRect *)$a_frame) inView:$a_view];
			 ]"
		end

	objc_mouse_exited__with_frame__in_view_ (an_item: POINTER; a_event: POINTER; a_frame: POINTER; a_view: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item mouseExited:$a_event withFrame:*((NSRect *)$a_frame) inView:$a_view];
			 ]"
		end

	objc_double_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item doubleAction];
			 ]"
		end

	objc_set_double_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setDoubleAction:$a_action];
			 ]"
		end

	objc_set_background_color_ (an_item: POINTER; a_color: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setBackgroundColor:$a_color];
			 ]"
		end

	objc_background_color (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item backgroundColor];
			 ]"
		end

	objc_set_placeholder_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setPlaceholderString:$a_string];
			 ]"
		end

	objc_placeholder_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item placeholderString];
			 ]"
		end

	objc_set_placeholder_attributed_string_ (an_item: POINTER; a_string: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPathCell *)$an_item setPlaceholderAttributedString:$a_string];
			 ]"
		end

	objc_placeholder_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPathCell *)$an_item placeholderAttributedString];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPathCell"
		end

end
