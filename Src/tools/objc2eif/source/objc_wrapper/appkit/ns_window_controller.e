note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW_CONTROLLER

inherit
	NS_RESPONDER
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_window_,
	make_with_window_nib_name_,
	make_with_window_nib_name__owner_,
	make_with_window_nib_path__owner_,
	make

feature {NONE} -- Initialization

	make_with_window_ (a_window: detachable NS_WINDOW)
			-- Initialize `Current'.
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			make_with_pointer (objc_init_with_window_(allocate_object, a_window__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_window_nib_name_ (a_window_nib_name: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_window_nib_name__item: POINTER
		do
			if attached a_window_nib_name as a_window_nib_name_attached then
				a_window_nib_name__item := a_window_nib_name_attached.item
			end
			make_with_pointer (objc_init_with_window_nib_name_(allocate_object, a_window_nib_name__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_window_nib_name__owner_ (a_window_nib_name: detachable NS_STRING; a_owner: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_window_nib_name__item: POINTER
			a_owner__item: POINTER
		do
			if attached a_window_nib_name as a_window_nib_name_attached then
				a_window_nib_name__item := a_window_nib_name_attached.item
			end
			if attached a_owner as a_owner_attached then
				a_owner__item := a_owner_attached.item
			end
			make_with_pointer (objc_init_with_window_nib_name__owner_(allocate_object, a_window_nib_name__item, a_owner__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_window_nib_path__owner_ (a_window_nib_path: detachable NS_STRING; a_owner: detachable NS_OBJECT)
			-- Initialize `Current'.
		local
			a_window_nib_path__item: POINTER
			a_owner__item: POINTER
		do
			if attached a_window_nib_path as a_window_nib_path_attached then
				a_window_nib_path__item := a_window_nib_path_attached.item
			end
			if attached a_owner as a_owner_attached then
				a_owner__item := a_owner_attached.item
			end
			make_with_pointer (objc_init_with_window_nib_path__owner_(allocate_object, a_window_nib_path__item, a_owner__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSWindowController Externals

	objc_init_with_window_ (an_item: POINTER; a_window: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item initWithWindow:$a_window];
			 ]"
		end

	objc_init_with_window_nib_name_ (an_item: POINTER; a_window_nib_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item initWithWindowNibName:$a_window_nib_name];
			 ]"
		end

	objc_init_with_window_nib_name__owner_ (an_item: POINTER; a_window_nib_name: POINTER; a_owner: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item initWithWindowNibName:$a_window_nib_name owner:$a_owner];
			 ]"
		end

	objc_init_with_window_nib_path__owner_ (an_item: POINTER; a_window_nib_path: POINTER; a_owner: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item initWithWindowNibPath:$a_window_nib_path owner:$a_owner];
			 ]"
		end

	objc_window_nib_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item windowNibName];
			 ]"
		end

	objc_window_nib_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item windowNibPath];
			 ]"
		end

	objc_owner (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item owner];
			 ]"
		end

	objc_set_window_frame_autosave_name_ (an_item: POINTER; a_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setWindowFrameAutosaveName:$a_name];
			 ]"
		end

	objc_window_frame_autosave_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item windowFrameAutosaveName];
			 ]"
		end

	objc_set_should_cascade_windows_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setShouldCascadeWindows:$a_flag];
			 ]"
		end

	objc_should_cascade_windows (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindowController *)$an_item shouldCascadeWindows];
			 ]"
		end

	objc_document (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item document];
			 ]"
		end

	objc_set_document_ (an_item: POINTER; a_document: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setDocument:$a_document];
			 ]"
		end

	objc_set_document_edited_ (an_item: POINTER; a_dirty_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setDocumentEdited:$a_dirty_flag];
			 ]"
		end

	objc_set_should_close_document_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setShouldCloseDocument:$a_flag];
			 ]"
		end

	objc_should_close_document (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindowController *)$an_item shouldCloseDocument];
			 ]"
		end

	objc_set_window_ (an_item: POINTER; a_window: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item setWindow:$a_window];
			 ]"
		end

	objc_window (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item window];
			 ]"
		end

	objc_synchronize_window_title_with_document_name (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item synchronizeWindowTitleWithDocumentName];
			 ]"
		end

	objc_window_title_for_document_display_name_ (an_item: POINTER; a_display_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSWindowController *)$an_item windowTitleForDocumentDisplayName:$a_display_name];
			 ]"
		end

	objc_close (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item close];
			 ]"
		end

	objc_show_window_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item showWindow:$a_sender];
			 ]"
		end

	objc_is_window_loaded (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSWindowController *)$an_item isWindowLoaded];
			 ]"
		end

	objc_window_will_load (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item windowWillLoad];
			 ]"
		end

	objc_window_did_load (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item windowDidLoad];
			 ]"
		end

	objc_load_window (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSWindowController *)$an_item loadWindow];
			 ]"
		end

feature -- NSWindowController

	window_nib_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_nib_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_nib_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_nib_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	window_nib_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_nib_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_nib_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_nib_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	owner: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_owner (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like owner} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like owner} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_window_frame_autosave_name_ (a_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			objc_set_window_frame_autosave_name_ (item, a_name__item)
		end

	window_frame_autosave_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window_frame_autosave_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_frame_autosave_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_frame_autosave_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_should_cascade_windows_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_cascade_windows_ (item, a_flag)
		end

	should_cascade_windows: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_cascade_windows (item)
		end

	document: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_document (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like document} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like document} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_document_ (a_document: detachable NS_DOCUMENT)
			-- Auto generated Objective-C wrapper.
		local
			a_document__item: POINTER
		do
			if attached a_document as a_document_attached then
				a_document__item := a_document_attached.item
			end
			objc_set_document_ (item, a_document__item)
		end

	set_document_edited_ (a_dirty_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_document_edited_ (item, a_dirty_flag)
		end

	set_should_close_document_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_should_close_document_ (item, a_flag)
		end

	should_close_document: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_should_close_document (item)
		end

	set_window_ (a_window: detachable NS_WINDOW)
			-- Auto generated Objective-C wrapper.
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			objc_set_window_ (item, a_window__item)
		end

	window: detachable NS_WINDOW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_window (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	synchronize_window_title_with_document_name
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_synchronize_window_title_with_document_name (item)
		end

	window_title_for_document_display_name_ (a_display_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_display_name__item: POINTER
		do
			if attached a_display_name as a_display_name_attached then
				a_display_name__item := a_display_name_attached.item
			end
			result_pointer := objc_window_title_for_document_display_name_ (item, a_display_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like window_title_for_document_display_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like window_title_for_document_display_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	close
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_close (item)
		end

	show_window_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_show_window_ (item, a_sender__item)
		end

	is_window_loaded: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_window_loaded (item)
		end

	window_will_load
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_window_will_load (item)
		end

	window_did_load
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_window_did_load (item)
		end

	load_window
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_load_window (item)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSWindowController"
		end

end
