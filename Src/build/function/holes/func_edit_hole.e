indexing
	description: "General class for function editor hole."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

deferred class FUNC_EDIT_HOLE 

inherit
	EB_BUTTON

	REMOVABLE

feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; ed: like function_editor) is
		do
			function_editor := ed
			make (par)
			set_callbacks
		end

	function_editor: FUNC_EDITOR

	set_callbacks is 
		deferred
		end

	full_symbol: EV_PIXMAP is
		deferred
		end

feature -- Access

	remove_yourself is
		local
			wipe_out_cmd: FUNC_WIPE_OUT
			arg: EV_ARGUMENT1 [BUILD_FUNCTION]
		do
			create wipe_out_cmd
			create arg.make (function_editor.edited_function)
			wipe_out_cmd.execute (arg, Void)
		end

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_pixmap (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_pixmap (full_symbol)
			end
		end

end -- class FUNC_EDIT_HOLE

