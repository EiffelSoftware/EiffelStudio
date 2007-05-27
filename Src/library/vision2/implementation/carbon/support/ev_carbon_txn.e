indexing
	description: "EiffelVision Parent Class for EV_TEXT_FIELD_IMP and EV_TEXT_IMP Carbon implementationimplementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CARBON_TXN

inherit
	EV_WIDGET_IMP
		redefine
			dispose
		end
		
	MACTEXTEDITOR_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	
	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CFSTRING_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CFBASE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization
	make (an_interface: EV_ANY)is
			do

			end


feature -- Access

	frozen kTXNSingleLineOnlyMask: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNSingleLineOnlyMask"
	end

	frozen kTXNNoUserIOTag: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNNoUserIOTag"
	end

	frozen kTXNTextData: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNTextData"
	end

	frozen kTXNStartOffset: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNStartOffset"
	end

	frozen kTXNEndOffset: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNEndOffset"
	end

	frozen kTXNUnicodeTextData: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNUnicodeTextData"
	end

	frozen kTXNSystemDefaultEncoding: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kTXNSystemDefaultEncoding"
	end

	get_text_length (obj: POINTER; starto, endo: INTEGER):INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

			"[
				{	Handle h;
					TXNGetData ($obj, $starto, $endo, &h);
					int length = GetHandleSize(h);
					return length/2;
					DisposeHandle (h);
				}
			]"
	end

	get_text (obj, buf_ptr: POINTER; starto, endo: INTEGER) is
	external
		"C inline use <Carbon/Carbon.h>"
	alias

			"[
				{	
					char chr;
					Handle h;
					TXNObject t = HITextViewGetTXNObject($obj);
					TXNGetData (t, $starto, $endo, &h);
					int length = GetHandleSize(h);

					char* buffer=$buf_ptr;
					HLock (h);
						char* p = (char *)*h;
						char* q= (char *)*h;
						int i=0;
						for (; (q <= (p+length)) && ((char) *q!=0); q++)
						{
							buffer[i] = (char) *q;
							i++;
							q++;
						}
					HUnlock (h);
					DisposeHandle (h);
				}
			]"
	end

	text: STRING_32 is
			-- Text displayed in field.
		local
			string_ptr: POINTER
			ret: INTEGER
			c_str: C_STRING

		do

			create c_str.make_empty (get_text_length(entry_widget, kTXNStartOffset, kTXNEndOffset))
			get_text (c_object, c_str.item, kTXNStartOffset, kTXNEndOffset)
			Result := c_str.string
		end

feature -- Status setting

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		local
			a_c_str: C_STRING
			ret: INTEGER
		do
			create a_c_str.make (a_text)
			ret := txnset_data_external (entry_widget, kTXNTextData, a_c_str.item, a_text.count, kTXNStartOffset, kTXNEndOffset)
		end

	append_text (txt: STRING_GENERAL) is
			-- Append `txt' to the end of the text.
		local
			a_c_str: C_STRING
			ret: INTEGER
		do
			create a_c_str.make (txt)
			ret := txnset_data_external (entry_widget, kTXNTextData, a_c_str.item, txt.count, kTXNEndOffset, kTXNEndOffset)
		end

	prepend_text (txt: STRING_GENERAL) is
			-- Prepend `txt' to the end of the text.
		local
			a_c_str: C_STRING
			ret: INTEGER
		do
			create a_c_str.make (txt)
			ret := txnset_data_external (entry_widget, kTXNTextData, a_c_str.item, txt.count, kTXNStartOffset, kTXNStartOffset)
		end

feature -- Status Report

	caret_position: INTEGER is
			-- Current position of the caret.
		local
			starto, endo: INTEGER
		do
			txnget_selection_external (entry_widget, $starto, $endo)
			Result := starto+1
		end
feature --dispose

	dispose is
			-- Called by the Eiffel GC when `Current' is destroyed.
			-- Destroy `c_object'.
		local
			a_widget: EV_WIDGET_IMP
		do
			txndelete_object_external (entry_widget)
			precursor {EV_WIDGET_IMP}
		end


feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		local
			tag, ret, data: INTEGER
		do
			tag := kTXNNoUserIOTag
			 ret := txnget_txnobject_controls_external (entry_widget, 1, $tag, $data)
			Result := (data = 0)
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		local
			starto, endo: INTEGER
		do
			txnget_selection_external (entry_widget, $starto, $endo)
			Result := starto < endo

		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		local
			starto, endo: INTEGER
		do
			txnget_selection_external (entry_widget, $starto, $endo)
			Result := starto+1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		local
			starto, endo: INTEGER
		do
			txnget_selection_external (entry_widget, $starto, $endo)
			Result := endo+1
		end

	clipboard_content: STRING_32 is
			-- `Result' is current clipboard content.
		local
			string_ptr: POINTER
			ret: INTEGER
			c_str: C_STRING
		do
			set_caret_position (1)
			paste (1)
			create c_str.make_empty (get_text_length(entry_widget, kTXNStartOffset, caret_position-1))
			get_text (c_object, c_str.item, kTXNStartOffset, caret_position-1)
			Result := c_str.string
			select_region (kTXNStartOffset+1, caret_position)
			delete_selection
		end

feature -- status settings

	hide_border is
			-- Hide the border of `Current'.
		do
		end

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
			-- kTXNNoUserIOTag
		local
			tag1, tag2, ret: INTEGER
		do
			tag2 := kTXNNoUserIOTag
			if flag then
				tag1 := 0
				ret := txnset_txnobject_controls_external (entry_widget, 0, 1, $tag2, $tag1)
			else
				tag1 := 1
				ret := txnset_txnobject_controls_external (entry_widget, 0, 1, $tag2, $tag1)
			end

		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		local
			ret: INTEGER
		do
			ret := txnset_selection_external (entry_widget, pos-1, pos-1)
		end

feature -- Basic operation

	insert_text (txt: STRING_GENERAL) is
			-- Insert `txt' at the current position.
		local
			a_c_str: C_STRING
			ret: INTEGER
		do
			create a_c_str.make (txt)
			ret := txnset_data_external (entry_widget, kTXNTextData, a_c_str.item, txt.count, selection_start-1, selection_end-1)
		end

	insert_text_at_position (txt: STRING_GENERAL; a_pos: INTEGER) is
			-- Insert `txt' at the current position at position `a_pos'
		local
			a_c_str: C_STRING
			ret: INTEGER
		do
			create a_c_str.make (txt)
			ret := txnset_data_external (entry_widget, kTXNTextData, a_c_str.item, txt.count, a_pos-1, a_pos-1)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between
			-- 'start_pos' and 'end_pos'.
		local
			ret: INTEGER
		do
			ret := txnset_selection_external (entry_widget, start_pos-1, end_pos-1)
		end

	deselect_all is
			-- Unselect the current selection.
		do
		set_caret_position (selection_start)
		end

	delete_selection is
			-- Delete the current selection.
		do
			insert_text("")
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		local
			ret: INTEGER
		do
			ret := txncut_external (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		local
			ret: INTEGER
		do
			ret := txncopy_external (entry_widget)

		end

	paste (index: INTEGER) is
			-- Insert the string which is in the
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing.
		local
			ret: INTEGER
		do
			set_caret_position (1)
			ret := txnpaste_external (entry_widget)
		end


	real_text: STRING_GENERAL

feature {NONE} -- Implementation
	entry_widget: POINTER

invariant
	entry_widget_set: entry_widget /= NULL

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_CARBON_TXN

