indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_DESKTOP_EVENT_MANAGER

inherit

	EDK_MESSAGE_MANAGER

	THREAD
		rename
			execute as process_events
		end

create {EDK_DISPLAY}
	make_for_display

feature {NONE} -- Initialization

	make_for_display (a_display: EDK_DISPLAY)
			-- Make `Current' for use with display `a_display'.
		do
			display := a_display
			create type_manager
			create window_list.make (10)
			initialize
		end

feature -- Implementation

	process_events
		do

		end

feature -- Initialization

	display: EDK_DISPLAY
		-- Display to which `Current' is associated with.

	type_manager: EDK_TYPE_MANAGER
		-- Type manager used for registering events and properties.

	native_handle: POINTER
		-- Handle for the message queue.

	initialize
			-- Initialize display and underlying toolkit.
		local
			l_wait_handle: POINTER
		do
			create window_list_read_write_lock.make
			create paint_mutex.make
			if native_wait_handle_internal = default_pointer then
				initialize_callback_marshal (Current, $default_marshaller)
				native_initialize_toolkit
				native_wait_handle_internal := get_native_wait_handle
				initial_clock_tick := get_native_current_time
				l_wait_handle := get_native_wait_handle

				native_handle := {NATIVE_WINDOW}.c_native_create_window (native_application_parent, 0, default_pointer)
					-- Create a native handle for which to send/receive events on.
			end
		end

feature -- Message Handling

	get_message_from_queue (a_message: EDK_MESSAGE)
			-- Update `a_message' with the next EDK message in the queue.
		local
			l_edk_event_found: BOOLEAN
		do
			from
				-- Keep inspecting messages until an EDK message is sent.
			until
				l_edk_event_found
			loop
				native_get_message (a_message.native_message_handle)
				if a_message.native then
						-- Process any native messages.
					process_native_message (a_message)
				else
					l_edk_event_found := True
					a_message.set_time (application_time)
							-- Reset the message window so that it gets dispatched to the appropriate window handle.
					a_message.set_window (window_from_window_handle (a_message.native_message_parameter_1))
					a_message.set_native_message_parameter_1 (default_pointer)
				end
			end
		end

	process_message_from_queue (a_message: EDK_MESSAGE)
			-- Process message `a_message'.
		do
			if a_message.native_id /= 0 then
				native_process_message (a_message.native_message_handle)
			end
			a_message.native_reset_values
			a_message.set_id ({EDK_MESSAGE_IDS}.edk_default)
		end

	put_message_on_queue (a_message: EDK_MESSAGE)
			-- Put EDK message to the message queue
			-- For native messages use `put_native_message'.
		local
			l_success: BOOLEAN
		do
				-- All sent EDK messages have to go through the event manager window queue so we send the message to `native_handle'.
				-- The event window gets encoded in `native_message_parameter_1' and reset in the marshaller.
			l_success := native_put_message (native_handle, a_message.native_id, a_message.native_window_handle, a_message.native_message_parameter_2)
			a_message.native_reset_values
			a_message.set_id ({EDK_MESSAGE_IDS}.edk_default)
		end

feature -- Native message handling

	peek_native_message (a_native_message: EDK_MESSAGE)
			-- Query the native message queue updating `a_native_message' with the next available message.
			-- Object will be reset to default values if no message is available.
		local
			l_message_available: BOOLEAN
		do
			l_message_available := native_peek_message (a_native_message.native_message_handle, False)
			if not l_message_available then
				a_native_message.native_reset_values
			end
		end

	get_native_message (a_native_message: EDK_MESSAGE)
			-- Retrieve the next native message from the native message queue updating `a_native_message'
			-- Object will be reset to default values.
		do
			native_get_message (a_native_message.native_message_handle)
		ensure
			a_native_message_native: a_native_message.native
		end

	put_native_message (a_native_message: EDK_MESSAGE)
			-- Puts `a_native_message' on the top of the message queue.
			-- `a_native_message' will be reset to default values when it has been added to the list.
		require
			a_native_message_native: a_native_message.native
		local
			l_success: BOOLEAN
		do
			l_success := native_put_message (a_native_message.native_window_handle, a_native_message.native_id, a_native_message.native_message_parameter_1, a_native_message.native_message_parameter_2)
		end

	process_native_message (a_native_message: EDK_MESSAGE)
			-- Process message `a_native_message' retrieved from the event queue.
		require
			a_native_message_native: a_native_message.native
		do
			native_process_message (a_native_message.native_message_handle)
		end

	wait_for_next_message (a_max_millisecond_wait: NATURAL)
			-- Wait for a maximum `a_max_millisecond_wait' for the next native message.
			-- CPU time of calling thread will be relinquished.
		local
			l_wait_handle: POINTER
		do
			l_wait_handle := native_wait_handle
			native_wait_for_next_message (a_max_millisecond_wait, $native_wait_handle_internal)
		end

	application_time: NATURAL_32
			-- Time in Milliseconds since the application began.
			-- Used for inserting in to events that don't have a native time set.
		do
			Result := get_native_current_time - initial_clock_tick
		end

feature {NATIVE_WINDOW} -- Implementation

	add_window_to_window_list (a_object_id: INTEGER; a_native_window_handle: POINTER)
			-- Add `a_object_id' object id to `window_list' referenced by handle `native_window_handle'
		require
			a_object_id_greater_than_zero: a_object_id > 0
			native_window_handle_valid: a_native_window_handle /= default_pointer
		do
			window_list_read_write_lock.lock
			window_list.put (a_object_id, a_native_window_handle)
			window_list_read_write_lock.unlock
		end

feature {EDK_OBJECT_I} -- Implementation

	window_from_window_handle (a_native_window_handle: POINTER): detachable NATIVE_WINDOW
			-- Return EDK Window from its native handle.
		require
			a_native_window_handle_valid: a_native_window_handle /= default_pointer
		local
			l_object_id: INTEGER
		do
			window_list_read_write_lock.lock
			l_object_id := window_list.item (a_native_window_handle)
			window_list_read_write_lock.unlock

			if l_object_id > 0 then
				Result ?= eif_id_object (l_object_id)
			end
		end

	eif_id_object (an_id: INTEGER): IDENTIFIED is
			-- Object associated with `an_id'
		external
			"C | %"eif_object_id.h%""
		end

feature {NONE} -- Implementation

	initial_clock_tick: NATURAL_32
		-- Clock tick at which application began.
		-- This is set in `initialize'.

	get_native_current_time: NATURAL_32
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return GetTickCount();
				#endif
			]"
		end

	window_list: HASH_TABLE [INTEGER, POINTER]
		-- List of Window object id's referenced from their native handle.

	window_list_read_write_lock: MUTEX
		-- Read/Write lock for `window_list'.

	paint_mutex: MUTEX
		-- Mutex used for WM_PAINT messages.

--	helper_window: EDK_WINDOW
--		-- Hidden Helper Window used for a variety of services.

	default_marshaller (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): POINTER
			-- Callback used by the toolkit to interact with marshal object.
		local
			l_native_window: detachable NATIVE_WINDOW
			l_native_rectangle: NATIVE_RECTANGLE
			l_native_brush: NATIVE_BRUSH
			l_native_pen: NATIVE_PEN
			l_graphics_context: NATIVE_DRAWABLE_CONTEXT
			l_drawable_routines: DRAWABLE_ROUTINES
			l_paint_lock: BOOLEAN
			l_current_clock_tick: NATURAL_32
			l_integer_16_1, l_integer_16_2: INTEGER_16
			l_edk_event_type: NATURAL_16
			l_native_message: EDK_MESSAGE
			l_pass_to_native_toolkit: BOOLEAN
			l_adjusted_message: NATURAL_16
			l_user_message: BOOLEAN
			l_edk_message: BOOLEAN
			l_success: BOOLEAN
			l_object_id: INTEGER
		do
				-- Set the application time and compare with the event time.
			l_current_clock_tick := application_time
			l_edk_event_type := {EDK_MESSAGE_IDS}.edk_default

				-- Check if message is generated by EDK.
			l_edk_message := message_type & 0xFFFFC000 = 0x00008000

			l_adjusted_message := message_type.to_natural_16

			if l_edk_message then
				l_user_message := l_adjusted_message & 0xA000 = 0xA000
					-- Wipe out any set user flag or event meta flags.
				l_adjusted_message := l_adjusted_message & 0x81FF
			end

			if l_edk_message then
				if l_user_message then
						-- A message has been explicit sent by the user to a window.
					inspect
						l_adjusted_message
					when {EDK_MESSAGE_IDS}.edk_window_map then
						native_show_window (window_handle)
					else
					end
				else
					-- Process message has been called on a generated EDK message, for now do nothing.
				end
			else
					-- A message has been sent by the underlying toolkit.
				inspect
					native_toolkit_id
				when win32_api then
					inspect
						l_adjusted_message
					when {EDK_MESSAGE_IDS}.WM_MOUSEMOVE then
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_mouse_move
					when {EDK_MESSAGE_IDS}.WM_LBUTTONDOWN then
						print ("WM_LBUTTONDOWN%N")
					when {EDK_MESSAGE_IDS}.WM_LBUTTONUP then
					when {EDK_MESSAGE_IDS}.WM_MBUTTONDOWN then
					when {EDK_MESSAGE_IDS}.WM_MBUTTONUP then
					when {EDK_MESSAGE_IDS}.WM_RBUTTONDOWN then
					when {EDK_MESSAGE_IDS}.WM_RBUTTONUP then



					when {EDK_MESSAGE_IDS}.WM_CREATE then
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_create
						l_object_id := native_object_id_from_create_parameter (window_handle, message_parameter_1, message_parameter_2)
						if l_object_id > 0 then
							add_window_to_window_list (l_object_id, window_handle)
						end
					when {EDK_MESSAGE_IDS}.WM_DESTROY then
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_destroy
					when {EDK_MESSAGE_IDS}.WM_PAINT then
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_expose
						l_native_window := window_from_window_handle (window_handle)
						if l_native_window /= Void then
							l_graphics_context := l_native_window.drawable_context
							l_graphics_context.initialize_for_expose (l_native_window)
							l_native_window.default_event_handler (create {EDK_MESSAGE})
							l_graphics_context.reset_from_expose (l_native_window)
						end
					when {EDK_MESSAGE_IDS}.WM_ERASEBKGND then
						Result := Result + 1
					when {EDK_MESSAGE_IDS}.WM_WINDOWPOSCHANGED then
						print ("Windows WM_WINDOWPOSCHANGED Event%N")
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_resize
						l_integer_16_1 := native_window_x_position (window_handle, 0, message_parameter_1, message_parameter_2)
						l_integer_16_2 := native_window_y_position (window_handle, 0, message_parameter_1, message_parameter_2)
					when {EDK_MESSAGE_IDS}.WM_WINDOWPOSCHANGING then
						print ("Windows WM_WINDOWPOSCHANGING Event%N")
						-- For now do nothing
						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_resize
					when {EDK_MESSAGE_IDS}.WM_SIZE then
--						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_resize
--						l_integer_16_1 := message_parameter_2.to_integer_32.to_integer_16
--						l_integer_16_2 := (message_parameter_2.to_integer_32 & 0xFFFF0000 |>> 0xF0).to_integer_16
					when {EDK_MESSAGE_IDS}.WM_MOVE then
--						l_edk_event_type := {EDK_MESSAGE_IDS}.edk_window_move
--						l_integer_16_1 := message_parameter_2.to_integer_32.to_integer_16
--						l_integer_16_2 := (message_parameter_2.to_integer_32 & 0xFFFF0000 |>> 0xF0).to_integer_16
					when {EDK_MESSAGE_IDS}.WM_SIZING then

					when {EDK_MESSAGE_IDS}.WM_MOVING then


					when {EDK_MESSAGE_IDS}.WM_ENTERSIZEMOVE then


					when {EDK_MESSAGE_IDS}.WM_EXITSIZEMOVE then

					when {EDK_MESSAGE_IDS}.WM_KEYDOWN then
						print ("WM_KEYDOWN message%N")

					when {EDK_MESSAGE_IDS}.WM_KEYUP then
						print ("WM_KEYUP message%N")
					else
						l_pass_to_native_toolkit := True
					end
				when
					gdk_api
				then
					inspect
						l_adjusted_message
					when 1 then

					else

					end
				when
					carbon_api
				then
					inspect
						l_adjusted_message
					when 1 then

					else

					end
				end
				if l_pass_to_native_toolkit then
					Result := native_default_window_procedure (window_handle, message_type, message_parameter_1, message_parameter_2)
				else
							-- We have an EDK event generated by the underlying toolkit so we propagate it the the display.
					l_success := native_put_message (native_handle, l_edk_event_type, window_handle, message_parameter_2)
				end
			end

		end

feature {NONE} -- Implementation

	win32_api: NATURAL_8 = 1
	gdk_api: NATURAL_8 = 2
	carbon_api: NATURAL_8 = 3
		-- Toolkit API ID's

	native_toolkit_id: NATURAL_8
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
						// Underlying toolkit is WIN32 API
					return 1;
				#endif
				// Return 2 for gdk
				
				// Return 3 for Carbon
			]"
		end

	native_initialize_toolkit
			-- Initialize Underlying toolkit.
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
				
					// Register 'EDK_Window' class
	  				WNDCLASSEX  wcl;

					ZeroMemory (&wcl, sizeof (WNDCLASSEX));
					wcl.cbSize  = sizeof (WNDCLASSEX);
					wcl.hInstance  = eif_hInstance;
					wcl.lpszClassName = "EDK_Window";
					wcl.lpfnWndProc = (WNDPROC) intermediary_event_callback;
					wcl.hIcon  = LoadIcon (NULL, IDI_APPLICATION);
					wcl.hIconSm = LoadIcon (NULL, IDI_APPLICATION);
					wcl.hCursor = LoadCursor (NULL, IDC_ARROW);
					wcl.style = CS_DBLCLKS; // CS_HREDRAW | CS_VREDRAW |

					RegisterClassEx(&wcl);
				#endif
			]"
		end

	native_wait_handle: POINTER
			-- Return the native wait handle used for waiting for messages.
		do
			if native_wait_handle_internal = default_pointer then
				initialize
			end
			Result := native_wait_handle_internal
		end

	native_wait_handle_internal: POINTER
		-- Handle for native event waiting.

	get_native_wait_handle: POINTER
			-- Retrieve the native wait handle for `Current'.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					HANDLE hCurrentProcess, hDuplicateProcess;
					BOOL bSuccess;
					hCurrentProcess = GetCurrentProcess();
					bSuccess = DuplicateHandle (hCurrentProcess, hCurrentProcess, hCurrentProcess, &hDuplicateProcess, 0, 0, DUPLICATE_SAME_ACCESS);
					if (bSuccess)
						return hDuplicateProcess;
					else
						return NULL;
				#endif
			]"
		end

	native_wait_for_next_message (a_max_millisecond_wait: NATURAL; a_native_wait_handle: TYPED_POINTER [POINTER])
			-- Wait for a maximum `a_max_millisecond_wait' for the next native message.
			-- CPU time of calling thread will be relinquished.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					int funcresult =  MsgWaitForMultipleObjects(
						(DWORD) 1,
						(const HANDLE *) $a_native_wait_handle,
						0,
						(DWORD) $a_max_millisecond_wait,
						(DWORD) (QS_ALLINPUT | QS_ALLPOSTMESSAGE));
				#endif
			]"
		end

	native_get_message (a_message_handle: POINTER)
			-- Update `a_message_handle' with current message from native queue.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					GetMessage ((MSG*) $a_message_handle, NULL, 0, 0);
				#endif
			]"
		end

	native_peek_message (a_message_handle: POINTER; a_remove_from_queue: BOOLEAN): BOOLEAN
			-- Update `a_message_handle' with current message from native queue.
			-- Return True if `a_message_handle' has been updated.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					UINT RemoveFromQueue;
					if ((UINT) $a_remove_from_queue)
					{
						RemoveFromQueue = PM_REMOVE;
					}
					else
					{
						RemoveFromQueue = PM_NOREMOVE;
					}
					return PeekMessage ((MSG*) $a_message_handle, NULL, 0, 0, RemoveFromQueue);
				#endif
			]"
		end

	native_put_message (a_window_handle: POINTER; a_message: NATURAL_32; a_message_parameter_1, a_message_parameter_2: POINTER): BOOLEAN
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					return PostMessage ((HWND) $a_window_handle, (UINT) $a_message, (WPARAM) $a_message_parameter_1, (LPARAM) $a_message_parameter_2);
				#endif
			]"
		end

	native_process_message (a_message_handle: POINTER)
			-- Process `a_message_handle' in native message queue.
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					TranslateMessage ((MSG*) $a_message_handle);
					DispatchMessage ((MSG*) $a_message_handle);
				#endif
			]"
		end

	native_default_window_procedure (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): POINTER is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return DefWindowProc ((HWND) $window_handle, (UINT) $message_type, (WPARAM) $message_parameter_1, (LPARAM) $message_parameter_2)
				#endif
			]"
		end

	frozen native_show_window (a_window_handle: POINTER)
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					ShowWindow((HWND) $a_window_handle, SW_SHOW);
				#endif
			]"
		end

	frozen native_window_x_position (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): INTEGER_16 is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return ((WINDOWPOS*)$message_parameter_2)->x;
				#endif
			]"
		end

	frozen native_window_y_position (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): INTEGER_16 is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return ((WINDOWPOS*)$message_parameter_2)->y;
				#endif
			]"
		end

	frozen native_window_width (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): INTEGER_16 is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return ((WINDOWPOS*)$message_parameter_2)->x;
				#endif
			]"
		end

	frozen native_window_height (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): INTEGER_16 is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return ((WINDOWPOS*)$message_parameter_2)->y;
				#endif
			]"
		end

	frozen native_window_flags (window_handle: POINTER; message_type: NATURAL; message_parameter_1, message_parameter_2: POINTER): INTEGER_16 is
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return ((WINDOWPOS*)$message_parameter_2)->flags;
				#endif
			]"
		end

	frozen native_object_id_from_create_parameter (a_window_handle, a_message_parameter_1, a_message_parameter_2: POINTER): INTEGER
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					CREATESTRUCT* lCreateStruct;
					lCreateStruct = (CREATESTRUCT*) $a_message_parameter_2;
					return (EIF_INTEGER) (lCreateStruct->lpCreateParams);
				#endif
			]"
		end

	frozen native_application_parent : POINTER
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
					return HWND_MESSAGE;
				#endif
			]"
		end

	initialize_callback_marshal (a_marshal: like Current; a_callback: POINTER)
			-- Set C Callback marshal and event callback function.
		external
			"C inline use <edk.h>"
		alias
			"[
				callback_marshal = eif_adopt ($a_marshal);
				event_callback = (EVENT_CALLBACK) $a_callback;
			]"
		end

end
