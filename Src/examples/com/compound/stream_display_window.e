indexing
	description: "Window that displays the content of a stream"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	STREAM_DISPLAY_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_size
		end

create
	make

feature {NONE} -- Initialization

	make (str: ECOM_STREAM) is
			-- Display `stream' content.
		require
			non_void_stream: str /= Void
		do
			stream := str
			make_top (title)
			setup_edit
			show
		ensure
			stream_set: stream = str
		end

feature -- Access

	stream: ECOM_STREAM
			-- Displayed stream

	Title: STRING is
			-- Window title
		do
			Result := stream.name
		end

feature -- Basic Operations

	setup_edit is
			-- Rich edit initialization.
		local
			retried: BOOLEAN
			mess_box: WEL_MSG_BOX
			buffer, displayed_text: STRING
			a: ANY
			p: POINTER_REF
		do
			create buffer.make (Buffer_size)
			create rich_edit.make (Current, "", 0, 0, width, height, Rich_edit_id)
			from
				create p
				a := buffer.to_c
				p.set_item ($a)
				stream.read (p.item, Buffer_size - 1) -- Need one character to put `%U' at end of string
			until
				stream.end_of_stream
			loop
				(p + Buffer_size).memory_copy ($Null_character, 1) -- Add ending numm character before conversion
				create displayed_text.make_from_c (p.item)
				rich_edit.insert_text (displayed_text)
				stream.read (p.item, Buffer_size - 1)
			end
			rich_edit.set_read_only
		rescue
			create mess_box.make
			mess_box.error_message_box (Current, "Cannot read stream", "Read Error")
			retried := True
			retry
		end

feature {NONE} -- Message Processing

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			rich_edit.set_width (a_width)
			rich_edit.set_height (a_height)
		end
	
feature {NONE} -- Implementation

	rich_edit: WEL_RICH_EDIT
			-- Rich edit used to display stream content

	Rich_edit_id: INTEGER is -1
			-- Rich edit id

	Buffer_size: INTEGER is 10
			-- Size of buffer used to read stream

	Null_character: CHARACTER is
			-- Null character
		do
			Result := '%U'
		end

invariant
	non_void_stream: stream /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class STREAM_DISPLAY_WINDOW

