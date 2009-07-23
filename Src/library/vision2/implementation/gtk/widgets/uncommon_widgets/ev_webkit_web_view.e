indexing
	description: "[
					Eiffel wrapper for WebKitView object
					see: http://webkitgtk.org/reference/webkitgtk-WebKitWebView.html
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEBKIT_WEB_VIEW

feature -- Query

	item: POINTER
			-- WebkitGTK C object

	can_copy_clipboard: BOOLEAN
			-- Can copy clipboard ?
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_copy_clipboard")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_copy_clipboard (l_api, item)
			end
		end

	can_cut_clipboard: BOOLEAN
			-- Can cut clipboard ?
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_cut_clipboard")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_cut_clipboard (l_api, item)
			end
		end

	can_go_back: BOOLEAN
			-- Determines whether web_view has a previous history item.
			--
			-- Returns :TRUE if able to move back, FALSE otherwise
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_go_back")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_go_back (l_api, item)
			end
		end

	can_go_back_or_forward (a_steps: INTEGER): BOOLEAN
			-- Determines whether web_view has a history item of steps. Negative values represent steps backward while positive values represent steps forward.
			--
			-- steps: the number of steps
			-- Returns: TRUE if able to move back or forward the given number of steps, FALSE otherwise
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_go_back_or_forward")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_go_back_or_forward (l_api, item, a_steps)
			end
		end

	can_go_forward: BOOLEAN
			-- Determines whether web_view has a next history item.
			--
			-- Returns: TRUE if able to move forward, FALSE otherwise
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_go_forward")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_go_forward (l_api, item)
			end
		end

	can_paste_clipboard: BOOLEAN
			-- Can paste clipboard?
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_paste_clipboard")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_can_paste_clipboard (l_api, item)
			end
		end

	webkit_web_view_can_show_mime_type (a_mime_type: STRING_GENERAL): BOOLEAN
			-- This functions returns whether or not a MIME type can be displayed using this view.
			--
			-- mime_type: a MIME type
			-- Returns: a gboolean indicating if the MIME type can be displayed
		require
			not_default: item /= default_pointer
			not_void: a_mime_type /= Void and then not a_mime_type.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_can_show_mime_type")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_mime_type)
				Result := c_webkit_web_view_can_show_mime_type (l_api, item, l_gtk_c_string.item)
			end
		end

	get_back_forward_list
			-- Returns a WebKitWebBackForwardList
			--
			-- a_web_view: a WebKitWebView
			-- Returns: the WebKitWebBackForwardList
		do
			check webkit_web_view_get_back_forward_list_not_implemented: False end
		end

	get_copy_target_list
			-- This function returns the list of targets this WebKitWebView can provide for clipboard copying
			-- and as DND source. The targets in the list are added with info values from the WebKitWebViewTargetInfo
			-- enum, using gtk_target_list_add() and gtk_target_list_add_text_targets().
			--
			-- a_web_view: a WebKitWebView
			-- Returns: the GtkTargetList
		do
			check webkit_web_view_get_copy_target_list_not_implemented: False end
		end

	get_custom_encoding: STRING_32
			-- Returns the current encoding of the WebKitWebView, not the default-encoding of WebKitWebSettings.
			--
			-- Returns: a string containing the current custom encoding for web_view, or NULL if there's none set.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
			l_result: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_custom_encoding")
			if l_api /= default_pointer then
				l_result := c_webkit_web_view_get_custom_encoding (l_api, item)
				-- FIXME: who response for free `l_result' ? WebkitGTK or Eiffel?
				create l_gtk_c_string.share_from_pointer (l_result)
				Result := l_gtk_c_string.string
			end
		end

	get_editable: BOOLEAN
			-- Returns whether the user is allowed to edit the document.
			-- Returns TRUE if web_view allows the user to edit the HTML document, FALSE if it doesn't. You can
			-- change web_view's document programmatically regardless of this setting.
			--
			-- Returns: a gboolean indicating the editable state
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_editable")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_get_editable (l_api, item)
			end
		end

	get_encoding: STRING_32
			-- Returns the default encoding of the WebKitWebView.
			--
			-- Returns: the default encoding
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
			l_result: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_encoding")
			if l_api /= default_pointer then
				l_result := c_webkit_web_view_get_encoding (l_api, item)
				-- FIXME: who response for free `l_result' ? WebkitGTK or Eiffel?
				create l_gtk_c_string.share_from_pointer (l_result)
				Result := l_gtk_c_string.string
			end
		end

	get_focused_frame
			-- Returns the frame that has focus or an active text selection.
			--
			-- a_web_kit_view: a WebKitWebView
			-- Returns: The focused WebKitWebFrame or NULL if no frame is focused
		do
			check webkit_web_view_get_focused_frame_not_implemented: False end
		end

	get_full_content_zoom: BOOLEAN
			-- Returns whether the zoom level affects only text or all elements.
			--
			-- Returns: FALSE if only text should be scaled (the default), TRUE if the full content of the
			-- view should be scaled.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_full_content_zoom")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_get_full_content_zoom (l_api, item)
			end
		end

	get_inspector
			-- Obtains the WebKitWebInspector associated with the WebKitWebView. Every WebKitWebView object has
			-- a WebKitWebInspector object attached to it as soon as it is created, so this function will only return
			-- NULL if the argument is not a valid WebKitWebView.
			--
			-- a_web_kit_view: a WebKitWebView
			-- Returns: the WebKitWebInspector instance associated with the WebKitWebView; NULL is only returned if
			-- the argument is not a valid WebKitWebView.
		do
			check webkit_web_view_get_inspector_not_implemented: False end
		end

	get_load_status
			-- Determines the current status of the load.
			--
			-- a_web_kit_view: a WebKitWebView
			-- Returns:
		do
			check webkit_web_view_get_load_status_not_implemented: False end
		end

	get_main_frame
			-- Get main frame
		do
			check webkit_web_view_get_main_frame_not_implemented: False end
		end

	get_paste_target_list
			-- This function returns the list of targets this WebKitWebView can provide for clipboard pasting and as
			-- DND destination. The targets in the list are added with info values from the WebKitWebViewTargetInfo enum,
			-- using gtk_target_list_add() and gtk_target_list_add_text_targets().
			--
			-- a_web_kit_view: a WebKitWebView
			-- Returns: the GtkTargetList
		do
			check webkit_web_view_get_paste_target_list_not_implemented: False end
		end

	get_progress: DOUBLE
			-- Determines the current progress of the load.
			--
			-- Returns :
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_progress")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_get_progress (l_api, item)
			end
		end

	get_settings
			-- Get settings
		do
			check webkit_web_view_get_settings_not_implemented: False end
		end

	get_title: STRING_32
			-- Returns the web_view's document title
			--
			-- Returns: the title of web_view
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
			l_result: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_title")
			if l_api /= default_pointer then
				l_result := c_webkit_web_view_get_title (l_api, item)
				-- FIXME: who response for free `l_result' ? WebkitGTK or Eiffel?
				create l_gtk_c_string.share_from_pointer (l_result)
				Result := l_gtk_c_string.string
			end
		end

	get_transparent: BOOLEAN
			-- Returns whether the WebKitWebView has a transparent background.
			--
			-- Returns: FALSE when the WebKitWebView draws a solid background (the default), otherwise TRUE.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_transparent")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_get_transparent (l_api, item)
			end
		end

	get_uri: STRING_32
			-- Returns the current URI of the contents displayed by the web_view
			--
			-- Returns: the URI of web_view
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
			l_result: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_uri")
			if l_api /= default_pointer then
				l_result := c_webkit_web_view_get_uri (l_api, item)
				-- FIXME: who response for free `l_result' ? WebkitGTK or Eiffel?
				create l_gtk_c_string.share_from_pointer (l_result)
				Result := l_gtk_c_string.string
			end
		end

	get_zoom_level: REAL
			-- Returns the zoom level of web_view, i.e. the factor by which elements in the page are scaled with
			-- respect to their original size. If the "full-content-zoom" property is set to FALSE (the default)
			-- the zoom level changes the text size, or if TRUE, scales all elements in the page.
			--
			-- Returns: the zoom level of web_view
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_get_zoom_level")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_get_zoom_level (l_api, item)
			end
		end

	has_selection: BOOLEAN
			-- Determines whether text was selected.
			--
			-- Returns: TRUE if there is selected text, FALSE if not
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_has_selection")
			if l_api /= default_pointer then
				Result := c_webkit_web_view_has_selection (l_api, item)
			end
		end

	get_window_features
			-- Returns the instance of WebKitWebWindowFeatures held by the given WebKitWebView.
			--
			-- a_web_kit_view: a WebKitWebView
			-- Returns: the WebKitWebWindowFeatures
		do
			check webkit_web_view_get_window_features_not_implemented: False end
		end

feature -- Command

	new
			-- Create a new webkit web view object
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_new")
			if l_api /= default_pointer then
				item := c_webkit_web_view_new (l_api)
			end
		end

	load_uri (a_uri: STRING_GENERAL)
			-- Requests loading of the specified URI string.
			--
			-- a_uri: an URI string 						
		require
			not_default: item /= default_pointer
			not_void: a_uri /= Void and then not a_uri.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_load_uri")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_uri)
				c_webkit_web_view_load_uri (l_api, item, l_gtk_c_string.item)
			end
		end

	copy_clipboard
			-- Copies the current selection inside the web_view to the clipboard.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_copy_clipboard")
			if l_api /= default_pointer then
				c_webkit_web_view_copy_clipboard (l_api, item)
			end
		end

	cut_clipboard
			-- Cuts the current selection inside the web_view to the clipboard.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_cut_clipboard")
			if l_api /= default_pointer then
				c_webkit_web_view_cut_clipboard (l_api, item)
			end
		end

	delete_selection
			-- Deletes the current selection inside the web_view.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_delete_selection")
			if l_api /= default_pointer then
				c_webkit_web_view_delete_selection (l_api, item)
			end
		end

	execute_script (a_script: STRING_GENERAL)
			-- Execute script
		require
			not_default: item /= default_pointer
			not_void: a_script /= Void and then not a_script.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_execute_script")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_script)
				c_webkit_web_view_execute_script (l_api, item, l_gtk_c_string.item)
			end
		end

	go_back: BOOLEAN
			-- Loads the previous history item.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_go_back")
			if l_api /= default_pointer then
				c_webkit_web_view_go_back (l_api, item)
			end
		end

	go_back_or_forward (a_steps: INTEGER): BOOLEAN
			-- Loads the history item that is the number of steps away from the current item. Negative values
			-- represent steps backward while positive values represent steps forward.
			--
			-- a_steps: the number of steps
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_go_back_or_forward")
			if l_api /= default_pointer then
				c_webkit_web_view_go_back_or_forward (l_api, item, a_steps)
			end
		end

	go_forward: BOOLEAN
			-- Loads the next history item.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_go_forward")
			if l_api /= default_pointer then
				c_webkit_web_view_go_forward (l_api, item)
			end
		end

	go_to_back_forward_item
			-- Go to the specified WebKitWebHistoryItem
			--
			-- a_web_kit_view: a WebKitWebView
			-- a_item: a WebKitWebHistoryItem*
			-- Returns: TRUE if loading of item is successful, FALSE if not
		do
			check webkit_web_view_go_to_back_forward_item_not_implemented: False end
		end

	load_html_string (a_content: STRING_GENERAL; a_base_uri: STRING_GENERAL)
			-- Load HTML string
		require
			not_void: a_content /= Void and then not a_content.is_empty
			not_void: a_base_uri /= Void and then not a_base_uri.is_empty -- FIXME: maybe can be void? No document, need test
		local
			l_api: POINTER
			l_gtk_c_string, l_gtk_c_string_2: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_load_html_string")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_content)
				create l_gtk_c_string_2.set_with_eiffel_string (a_base_uri)
				c_webkit_web_view_load_html_string (l_api, item, l_gtk_c_string.item, l_gtk_c_string_2.item)
			end
		end

	load_request
			-- Requests loading of the specified asynchronous client request.
			-- Creates a provisional data source that will transition to a committed data source once any data has been received.
			-- Use webkit_web_view_stop_loading() to stop the load.
			--
			-- a_request: a WebKitNetworkRequest
		do
			check webkit_web_view_load_request_not_implemented: False end
		end

	load_string (a_content, a_mime_type, a_encoding, a_base_uri: STRING_GENERAL)
			-- Load string
		require
			not_default: item /= default_pointer
			not_void: a_content /= Void and then not a_content.is_empty
			not_void: a_mime_type /= Void and then not a_mime_type.is_empty -- FIXME: maybe can be void? No document, need test
			not_void: a_encoding /= Void and then not a_encoding.is_empty -- FIXME: maybe can be void? No document, need test
			not_void: a_base_uri /= Void and then not a_base_uri.is_empty -- FIXME: maybe can be void? No document, need test			
		local
			l_api: POINTER
			l_gtk_c_string, l_gtk_c_string_2, l_gtk_c_string_3, l_gtk_c_string_4: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_load_string")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_content)
				create l_gtk_c_string_2.set_with_eiffel_string (a_mime_type)
				create l_gtk_c_string_3.set_with_eiffel_string (a_encoding)
				create l_gtk_c_string_4.set_with_eiffel_string (a_base_uri)
				c_webkit_web_view_load_string (l_api, item, l_gtk_c_string.item, l_gtk_c_string_2.item, l_gtk_c_string_3.item, l_gtk_c_string_4.item)
			end
		end

	mark_text_matches (a_string: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_limit: INTEGER): NATURAL
			-- Attempts to highlight all occurances of string inside web_view.
			--
			-- a_string: a string to look for
			-- a_case_sensitive: whether to respect the case of text
			-- a_limit: the maximum number of strings to look for or 0 for all
			-- Returns: the number of strings highlighted
		require
			not_default: item /= default_pointer
			not_void: a_string /= Void and then not a_string.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_load_string")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_string)
				Result := c_webkit_web_view_mark_text_matches (l_api, item, l_gtk_c_string.item, a_case_sensitive, a_limit)
			end
		end

	move_cursor
			-- Move the cursor in view as described by step and count.
			--
			-- a_web_kit_view: a WebKitWebView
			-- a_step: a GtkMovementStep
			-- a_count: integer describing the direction of the movement. 1 for forward, -1 for backwards.
		do
			check webkit_web_view_move_cursor_not_implemented: False end
		end

	paste_clipboard
			-- Pastes the current contents of the clipboard to the web_view.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_paste_clipboard")
			if l_api /= default_pointer then
				c_webkit_web_view_paste_clipboard (l_api, item)
			end
		end

	reload
			-- Reload
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_reload")
			if l_api /= default_pointer then
				c_webkit_web_view_reload (l_api, item)
			end
		end

	reload_bypass_cache
			-- Reloads the web_view without using any cached data.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_reload_bypass_cache")
			if l_api /= default_pointer then
				c_webkit_web_view_reload_bypass_cache (l_api, item)
			end
		end

	search_text (a_text: STRING_GENERAL; a_case_sensitive, a_forward, a_wrap: BOOLEAN): BOOLEAN
			-- Looks for a specified string inside web_view.
			--
			-- a_text: a string to look for
			-- a_case_sensitive: whether to respect the case of text
			-- a_forward: whether to find forward or not
			-- a_wrap: whether to continue looking at the beginning after reaching the end
			-- Returns: TRUE on success or FALSE on failure
		require
			not_default: item /= default_pointer
			not_void: a_text /= Void and then not a_text.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_search_text")
			if l_api /= default_pointer then
				create l_gtk_c_string.set_with_eiffel_string (a_text)
				Result := c_webkit_web_view_search_text (l_api, item, l_gtk_c_string.item, a_case_sensitive, a_forward, a_wrap)
			end
		end

	select_all
			-- Attempts to select everything inside the web_view.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_select_all")
			if l_api /= default_pointer then
				c_webkit_web_view_select_all (l_api, item)
			end
		end

	set_custom_encoding (a_encoding: STRING_GENERAL)
			-- Sets the current WebKitWebView encoding, without modifying the default one, and reloads the page.
			--
			-- a_encoding: the new encoding, or NULL to restore the default encoding
		require
			not_default: item /= default_pointer
			valid: a_encoding /= Void implies not a_encoding.is_empty
		local
			l_api: POINTER
			l_gtk_c_string: EV_GTK_C_STRING
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_custom_encoding")
			if l_api /= default_pointer then
				if a_encoding /= Void then
					create l_gtk_c_string.set_with_eiffel_string (a_encoding)
					c_webkit_web_view_set_custom_encoding (l_api, item, l_gtk_c_string.item)
				else
					c_webkit_web_view_set_custom_encoding (l_api, item, default_pointer)
				end
			end
		end

	set_editable (a_flag: BOOLEAN)
			-- Sets whether web_view allows the user to edit its HTML document.
			--
			-- If flag is TRUE, web_view allows the user to edit the document. If flag is FALSE, an element in web_view's document can
			-- only be edited if the CONTENTEDITABLE attribute has been set on the element or one of its parent elements. You can change
			-- web_view's document programmatically regardless of this setting. By default a WebKitWebView is not editable.
			--
			-- Normally, an HTML document is not editable unless the elements within the document are editable. This function provides
			-- a low-level way to make the contents of a WebKitWebView editable without altering the document or DOM structure.
			--
			-- flag: a gboolean indicating the editable state
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_editable")
			if l_api /= default_pointer then
				c_webkit_web_view_set_editable (l_api, item, a_flag)
			end
		end

	set_full_content_zoom (a_full_content_zoom: BOOLEAN)
			-- Sets whether the zoom level affects only text or all elements.
			--
			-- a_full_content_zoom: FALSE if only text should be scaled (the default), TRUE if the full content of the view should
			-- be scaled.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_full_content_zoom")
			if l_api /= default_pointer then
				c_webkit_web_view_set_full_content_zoom (l_api, item, a_full_content_zoom)
			end
		end

	set_highlight_text_matches (a_highlight: BOOLEAN)
			-- Highlights text matches previously marked by webkit_web_view_mark_text_matches.
			--
			-- a_highlight: whether to highlight text matches
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_highlight_text_matches")
			if l_api /= default_pointer then
				c_webkit_web_view_set_highlight_text_matches (l_api, item, a_highlight)
			end
		end

	set_maintains_back_forward_list (a_flag: BOOLEAN)
			-- Set the view to maintain a back or forward list of history items.
			--
			-- a_flag: to tell the view to maintain a back or forward list
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_maintains_back_forward_list")
			if l_api /= default_pointer then
				c_webkit_web_view_set_maintains_back_forward_list (l_api, item, a_flag)
			end
		end

	set_settings
			--
		do
			check webkit_web_view_set_settings_not_implemented: False end
		end

	set_transparent (a_flag: BOOLEAN)
			-- Sets whether the WebKitWebView has a transparent background.
			-- Pass FALSE to have the WebKitWebView draw a solid background (the default), otherwise TRUE.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_transparent")
			if l_api /= default_pointer then
				c_webkit_web_view_set_transparent (l_api, item, a_flag)
			end
		end

	set_zoom_level (a_zoom_level: REAL)
			-- Sets the zoom level of web_view, i.e. the factor by which elements in the page are scaled
			-- with respect to their original size. If the "full-content-zoom" property is set to FALSE (the default)
			-- the zoom level changes the text size, or if TRUE, scales all elements in the page.
			--
			-- a_zoom_level: the new zoom level
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_set_zoom_level")
			if l_api /= default_pointer then
				c_webkit_web_view_set_zoom_level (l_api, item, a_zoom_level)
			end
		end

	stop_loading
			-- Stop loading
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_stop_loading")
			if l_api /= default_pointer then
				c_webkit_web_view_stop_loading (l_api, item)
			end
		end

	unmark_text_matches
			-- Removes highlighting previously set by webkit_web_view_mark_text_matches.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_unmark_text_matches")
			if l_api /= default_pointer then
				c_webkit_web_view_unmark_text_matches (l_api, item)

			end
		end

	zoom_in
			-- Increases the zoom level of web_view. The current zoom level is incremented by the
			-- value of the "zoom-step" property of the WebKitWebSettings associated with web_view.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_zoom_in")
			if l_api /= default_pointer then
				c_webkit_web_view_zoom_in (l_api, item)
			end
		end

	zoom_out
			-- Decreases the zoom level of web_view. The current zoom level is decremented by the
			-- value of the "zoom-step" property of the WebKitWebSettings associated with web_view.
		require
			not_default: item /= default_pointer
		local
			l_api: POINTER
		do
			l_api := api_loader.api_pointer ("webkit_web_view_zoom_out")
			if l_api /= default_pointer then
				c_webkit_web_view_zoom_out (l_api, item)
			end
		end

feature {NONE} -- Query externals

	c_webkit_web_view_can_copy_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Can copy clipboard ?
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_can_cut_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Can cut clipboard ?
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_can_go_back (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Determines whether web_view has a previous history item.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_can_go_back_or_forward (a_api: POINTER; a_web_kit_web_view: POINTER; a_steps: INTEGER): BOOLEAN
			-- Determines whether web_view has a history item of steps. Negative values represent steps backward while positive values represent steps forward.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *, gint)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view,
															(gint) $a_steps);
			]"
		end

	c_webkit_web_view_can_go_forward (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Determines whether web_view has a next history item.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_can_paste_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Can paste clipboard?
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_can_show_mime_type (a_api: POINTER; a_web_kit_web_view: POINTER; a_mime_type: POINTER): BOOLEAN
			-- This functions returns whether or not a MIME type can be displayed using this view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *, const gchar *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view,
															(const gchar *) $a_mime_type);
			]"
		end

	c_webkit_web_view_get_custom_encoding (a_api: POINTER; a_web_kit_web_view: POINTER): POINTER
			-- Returns the current encoding of the WebKitWebView, not the default-encoding of WebKitWebSettings.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (const gchar *, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_editable (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Returns whether the user is allowed to edit the document.
			-- Returns TRUE if web_view allows the user to edit the HTML document, FALSE if it doesn't. You can
			-- change web_view's document programmatically regardless of this setting.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_encoding (a_api: POINTER; a_web_kit_web_view: POINTER): POINTER
			-- Returns the default encoding of the WebKitWebView.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (const gchar *, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_full_content_zoom (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Returns whether the zoom level affects only text or all elements.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_progress (a_api: POINTER; a_web_kit_web_view: POINTER): DOUBLE
			-- Determines the current progress of the load.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gdouble, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_title (a_api: POINTER; a_web_kit_web_view: POINTER): POINTER
			-- Returns the web_view's document title
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (const gchar *, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_transparent (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Returns whether the WebKitWebView has a transparent background
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_uri (a_api: POINTER; a_web_kit_web_view: POINTER): POINTER
			-- Returns the current URI of the contents displayed by the web_view
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (const gchar *, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_get_zoom_level (a_api: POINTER; a_web_kit_web_view: POINTER): DOUBLE
			-- Returns the zoom level of web_view, i.e. the factor by which elements in the page are scaled with
			-- respect to their original size. If the "full-content-zoom" property is set to FALSE (the default)
			-- the zoom level changes the text size, or if TRUE, scales all elements in the page.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gfloat, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

	c_webkit_web_view_has_selection (a_api: POINTER; a_web_kit_web_view: POINTER): BOOLEAN
			-- Determines whether text was selected.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (gboolean, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			]"
		end

feature {NONE} -- Command externals

	c_webkit_web_view_new (a_api: POINTER): POINTER
			-- Create a new webkit web view object
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return (FUNCTION_CAST (GtkWidget *, ()) $a_api) ();
			]"
		end

	c_webkit_web_view_load_uri (a_api: POINTER; a_web_kit_web_view: POINTER; a_uri: POINTER)
			-- Requests loading of the specified URI string.			
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_uri);
			}
			]"
		end

	c_webkit_web_view_copy_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Copies the current selection inside the web_view to the clipboard.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_cut_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Cuts the current selection inside the web_view to the clipboard.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_delete_selection (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Deletes the current selection inside the web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_execute_script (a_api: POINTER; a_web_kit_web_view: POINTER; a_script: POINTER)
			-- Execute a_script
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_script);
			}
			]"
		end

	c_webkit_web_view_go_back (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Loads the previous history item.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_go_back_or_forward (a_api: POINTER; a_web_kit_web_view: POINTER; a_steps: INTEGER)
			-- Loads the history item that is the number of steps away from the current item. Negative values
			-- represent steps backward while positive values represent steps forward.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, gint)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view,
															(gint) $a_steps);
			}
			]"
		end

	c_webkit_web_view_go_forward (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Loads the next history item.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_load_html_string (a_api: POINTER; a_web_kit_web_view: POINTER; a_content: POINTER; a_base_uri: POINTER)
			-- Load HTML
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_content,
													(const gchar *) $a_base_uri);
			}
			]"
		end

	c_webkit_web_view_load_string (a_api: POINTER; a_web_kit_web_view: POINTER; a_content, a_mime_type, a_encoding, a_base_uri: POINTER)
			-- Load string
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *, const gchar *, const gchar *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_content,
													(const gchar *) $a_mime_type,
													(const gchar *) $a_encoding,
													(const gchar *) $a_base_uri);
			}
			]"
		end

	c_webkit_web_view_mark_text_matches (a_api: POINTER; a_web_kit_web_view: POINTER; a_content: POINTER; a_case_sensitive: BOOLEAN; a_limit: INTEGER): NATURAL
			-- Load string
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return
				(FUNCTION_CAST (guint, (WebKitWebView *, const gchar *, gboolean, guint)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_content,
													(gboolean) $a_case_sensitive,
													(guint) $a_limit);
			]"
		end

	c_webkit_web_view_paste_clipboard (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Pastes the current contents of the clipboard to the web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_reload (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Reload
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_reload_bypass_cache (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Reloads the web_view without using any cached data.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_search_text (a_api: POINTER; a_web_kit_web_view: POINTER; a_text: POINTER; a_case_sensitive, a_forward, a_wrap: BOOLEAN): BOOLEAN
			-- Looks for a specified string inside web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
				return
				(FUNCTION_CAST (gboolean, (WebKitWebView *, const gchar *, gboolean, gboolean, gboolean)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view,
															(const gchar *) $a_text,
															(gboolean) $a_case_sensitive,
															(gboolean) $a_forward,
															(gboolean) $a_wrap);

			]"
		end

	c_webkit_web_view_select_all (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Attempts to select everything inside the web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_set_custom_encoding (a_api: POINTER; a_web_kit_web_view: POINTER; a_encoding: POINTER)
			-- Sets the current WebKitWebView encoding, without modifying the default one, and reloads the page.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(const gchar *) $a_encoding);
			}
			]"
		end

	c_webkit_web_view_set_editable (a_api: POINTER; a_web_kit_web_view: POINTER; a_flag: BOOLEAN)
			-- Sets whether web_view allows the user to edit its HTML document.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gboolean) $a_flag);
			}
			]"
		end

	c_webkit_web_view_set_full_content_zoom (a_api: POINTER; a_web_kit_web_view: POINTER; a_full_content_zoom: BOOLEAN)
			-- Sets whether the zoom level affects only text or all elements.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gboolean) $a_full_content_zoom);
			}
			]"
		end

	c_webkit_web_view_set_highlight_text_matches (a_api: POINTER; a_web_kit_web_view: POINTER; a_highlight: BOOLEAN)
			-- Highlights text matches previously marked by webkit_web_view_mark_text_matches.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gboolean) $a_highlight);
			}
			]"
		end

	c_webkit_web_view_set_maintains_back_forward_list (a_api: POINTER; a_web_kit_web_view: POINTER; a_flag: BOOLEAN)
			-- Highlights text matches previously marked by webkit_web_view_mark_text_matches.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gboolean) $a_flag);
			}
			]"
		end

	c_webkit_web_view_set_transparent (a_api: POINTER; a_web_kit_web_view: POINTER; a_flag: BOOLEAN)
			-- Sets whether the WebKitWebView has a transparent background.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, const gchar *)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gboolean) $a_flag);
			}
			]"
		end

	c_webkit_web_view_set_zoom_level (a_api: POINTER; a_web_kit_web_view: POINTER; a_zoom_level: REAL)
			-- Sets the zoom level of web_view, i.e. the factor by which elements in the page are scaled with
			-- respect to their original size. If the "full-content-zoom" property is set to FALSE (the default)
			-- the zoom level changes the text size, or if TRUE, scales all elements in the page.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *, gfloat)) $a_api)
													((WebKitWebView *) $a_web_kit_web_view,
													(gfloat) $a_zoom_level);
			}
			]"
		end

	c_webkit_web_view_stop_loading (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Stop loading
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_unmark_text_matches (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Removes highlighting previously set by webkit_web_view_mark_text_matches.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_zoom_in (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Increases the zoom level of web_view. The current zoom level is incremented by the
			-- value of the "zoom-step" property of the WebKitWebSettings associated with web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

	c_webkit_web_view_zoom_out (a_api: POINTER; a_web_kit_web_view: POINTER)
			-- Decreases the zoom level of web_view. The current zoom level is decremented by the
			-- value of the "zoom-step" property of the WebKitWebSettings associated with web_view.
		external
			"C inline use <webkit/webkit.h>"
		alias
			"[
			{
				(FUNCTION_CAST (void, (WebKitWebView *)) $a_api)
															((WebKitWebView *) $a_web_kit_web_view);
			}
			]"
		end

feature {NONE} -- Implementation

	api_loader: DYNAMIC_MODULE
			-- API dynamic loader
		once
			create Result.make_with_version ("libwebkit-1.0", "2")
		ensure
			not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WEBKIT_WEB_VIEW

