indexing
	description: "Error window which specify an error to the user.";
	date: "$Date$";
	revision: "$Revision $"

class ERROR_WINDOW

inherit

	LINE_MESSAGE;
	EC_COMMAND;
	OUTPUT_WINDOW
		redefine
			clear_window, display, put_indent, process_indentation
		end

creation

	init

feature {NONE} -- Initialization

	init is
			-- Initialize Current.
		do
			if messages = Void then end;
		end;

feature -- Properties

	--calling_widget: COMPOSITE
	--		-- Current parent widget

	external_title: STRING
			-- Title that may be provided by clients

	is_popped_up: BOOLEAN is
			-- Is Current popped up?
		do
--			Result := error_d /= Void and then
--					error_d.is_popped_up
		end

feature -- Setting

	--set_calling_widget (widget: like calling_widget) is
	--		-- Set the current parent widget
	--	do
		--	clear_window
		--	calling_widget := widget
	--	end

	set_external_title (et: like external_title) is
			-- Set `external_title' to `et'
		require
			et_exists: et /= Void
		do
			external_title := et
		ensure
			external_title_set: external_title = et
		end

feature -- Display

	popup_message (msg: STRING) is
			-- Popup with message `msg'
		do
			put_string (msg)
			display
		end

	popup_message_with_key (key, extra: STRING) is
			-- Popup message with key `key' and additional string `extra'
		require
			file_implies_not_empty: extra /= Void implies not extra.empty
		local
			tmp: STRING
		do
-- 			if not messages.empty then
-- 				if messages.has (key) then
-- 					!! tmp.make (0);
-- 					tmp.append (messages.item (key));
-- 							-- Replace \ with new line character
-- 					tmp.replace_substring_all ("\", "%N");
-- 					if extra /= Void then
-- 							-- Replace %X with extra
-- 						tmp.replace_substring_all ("%%X", extra)
-- 					end;
-- 					put_string (tmp)
-- 				else
-- 					put_string (" ")
-- 					io.error.putstring ("Can not find error keyword ");
-- 					io.error.putstring (key);
-- 					io.error.putstring ("%NPlease Contact I.S.E");
-- 					io.error.new_line;
-- 				end;
-- 			end;
-- 			display
-- 		ensure
-- 			valid_error_d: error_d /= Void;
		end;

	popdown is
			-- Popdown error dialog.
			-- Destroy it.
		do
		--	if error_d /= Void then		
		--		error_d.destroy;
		--		error_d := Void
		--	end
		--ensure then
		--	void_error_d: error_d = Void
		end;

feature -- Output

	clear_window is
			-- Clear the internal structures of window.
		do
			internal_message.head (0)
			external_title := Void
		ensure then
			internal_message_empty: internal_message.empty
			no_external_title: external_title = Void
		end

	display is
			-- Display the contents of window.
		do
		--	make
		--	error_d.popup
		--	error_d.raise
		end

	new_line is
			-- Put a new line at current position.
		do
			put_char ('%N')
		end

	put_char (c: CHARACTER) is
			-- Put a character `c' at current position.
		do
			internal_message.extend (c)
		end

	put_indent (nbr_of_tabs: INTEGER) is
			-- Put indent of `nbr_of_tabs'.
		local
			tab_str: STRING
		do
			!! tab_str.make (nbr_of_tabs * Resources.tab_length)
			tab_str.fill_character (' ')
			put_string (tab_str)
		end

	put_string (s: STRING) is
			-- Put string `s' at current position.
		do
			internal_message.append (s)
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popdown error dialog.
			--| Actually done in `work'
		do
		end;

feature {TEXT_ITEM} -- Text processing

	process_indentation (text: INDENT_TEXT) is
			-- Process indentation `text'
		do
			put_indent (text.indent_depth)
		end

feature {NAMER_WINDOW, ENTITY_NAME_FIELD} -- Implementation

	messages: HASH_TABLE [STRING, STRING] is
			-- Error messages hashed on error keys.
		once
			!! Result.make (20);
			read_messages_in (Environment.errors_file)
		end;

feature {NONE} -- Implementation 

	--error_d: ERROR_D;
	--		-- Error dialog to display error messages

	internal_message: STRING is
			-- Message to display (may be in construction)
		once
			!! Result.make (0)
		end

	make is
			-- Initialize current
	--	require
	--		error_d_is_void: error_d = Void
	--	local
	--		dial_att: WIDGET_ATTRIBUTES
	--		x1, y1: INTEGER			
		do
	--		!! error_d.make (Widget_names.error_window, calling_widget);
	--		if external_title /= Void then
	--			error_d.set_title (external_title)
	--		else
	--			error_d.set_title (Widget_names.error_window);
	--		end
	--		error_d.set_message (internal_message)
	--		x1 := calling_widget.real_x + calling_widget.width // 2 - error_d.width //2
	--		y1 := calling_widget.real_y + calling_widget.height // 2 - error_d.height //2
	--		error_d.add_ok_action (Current, Void);
	--		error_d.hide_cancel_button;
	--		error_d.hide_help_button;
	--		error_d.set_action ("<Unmap>", Current, Void);
	--		error_d.set_ok_label (Widget_names.ok);
	--	--	!! dial_att.set_dialog (error_d);
	--		error_d.set_x_y (x1, y1)
	--		error_d.set_exclusive_grab
	--		error_d.realize;
		end 

end -- class ERROR_WINDOW
