note
	description: "[
					Wrapper class for GInputStream
					http://developer.gnome.org/gio/unstable/GInputStream.html
																											]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_G_INPUT_STREAM

inherit
	DISPOSABLE

create
	new_from_data

feature {NONE} --Initilization

	new_from_data (a_data: POINTER; a_size: INTEGER_32)
			-- Creation method
		local
			l_pixel_buffer: POINTER
		do
			l_pixel_buffer := c_g_memory_input_stream_new_from_data (a_data, a_size)
			check created: l_pixel_buffer /= default_pointer end
			create internal_item.share_from_pointer (l_pixel_buffer, c_size)
		end

feature -- Query

	item: POINTER
			-- C item
		do
			Result := internal_item.item
		end

	is_closed: BOOLEAN
			-- Checks if an input stream is closed.
		local
			l_result: INTEGER
			l_item: like item
		do
			l_item := item
			if l_item /= default_pointer then
				l_result := c_g_input_stream_is_closed (l_item)
			else
				check should_not_happen: False end
			end

			Result := (l_result /= 0)
		end

feature -- Command

	dispose
			-- <Precursor>
		local
			l_item: like item
			l_error: POINTER
			l_result: INTEGER
		do
			l_item := item
			if l_item /= default_pointer then
				l_result := c_g_input_stream_close (l_item, default_pointer, $l_error)
			else
				check should_not_happen: False end
			end
			check success: l_result /= 0 end
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- C item

feature {NONE} -- Externals

	c_size: INTEGER
			-- Size of G_INPUT_STREAM
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION > 1 && GTK_MINOR_VERSION > 13
					return sizeof (GInputStream);
				#endif
			}
			]"
		end

	c_g_memory_input_stream_new_from_data (a_data: POINTER; a_size: INTEGER_32): POINTER
			-- Creates a new GMemoryInputStream with data in memory of a given size.
			-- a_data: input data. [array length=len][element-type guint8]
			-- a_len:	length of the data, may be -1 if data is a nul-terminated string
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION > 1 && GTK_MINOR_VERSION > 13
					return g_memory_input_stream_new_from_data ((const void *)$a_data, (gssize)$a_size, NULL);
				#endif					
			}
			]"
		end

	c_g_input_stream_close (a_input_stream: POINTER; a_cancellable: POINTER; a_error: TYPED_POINTER[POINTER]): INTEGER
			-- Closes the stream, releasing resources related to it.
			-- a_stream :	A GInputStream.
			-- a_cancellable :	optional GCancellable object, NULL to ignore. [allow-none]
			-- a_error:	location to store the error occurring, or NULL to ignore
			-- Returns:	TRUE on success, FALSE (0) on failure
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION > 1 && GTK_MINOR_VERSION > 13
					return g_input_stream_close ((GInputStream *)$a_input_stream, (GCancellable *)$a_cancellable, (GError **)$a_error);
				#endif
			}
			]"
		end

	c_g_input_stream_is_closed (a_input_stream: POINTER): INTEGER
			-- Checks if an input stream is closed.
			-- stream:	input stream.
			-- Returns: TRUE if the stream is closed.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			{
				#if GTK_MAJOR_VERSION > 1 && GTK_MINOR_VERSION > 13
					return g_input_stream_is_closed ((GInputStream *)$a_input_stream);
				#endif
			}
			]"
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
