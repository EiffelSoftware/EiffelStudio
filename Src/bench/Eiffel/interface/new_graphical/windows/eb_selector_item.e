indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SELECTOR_ITEM

inherit
	EV_LIST_ITEM
		rename
			data as tool
		redefine
			tool
		end

creation
	make_default,
	make_default_with_index

feature -- Initialization

	make_default (par: EV_LIST; a_tool: like tool) is
			-- Initialize
		do
			make (par)
			tool := a_tool
			create tag.make (0)
			set_text (value)
		end

	make_default_with_index (par: EV_LIST; a_tool: like tool; i:INTEGER) is
			-- Initialize
		do
			make_with_index (par, i)
			tool := a_tool
			create tag.make (0)
			set_text (value)
		end

feature -- Access

	tool: EB_TOOL

feature -- Status report

	tag: STRING

	value: STRING is
			-- String to appear in scrollable list box
		local
			c_t: EB_CLASS_TOOL
			f_t: EB_FEATURE_TOOL
			o_t: EB_OBJECT_TOOL
		do
			c_t ?= tool
			f_t ?= tool
			o_t ?= tool

			if c_t /= Void then
--				if c_t.class_text_field.text.empty then
					Result:= clone (tool.title)
--				else
--					Result := clone (tool.icon_name)
--				end
			elseif f_t /= Void then
				Result := clone (tool.title)
				if not Result.empty then
					Result.replace_substring_all ("Feature: ","+ ")
					Result.replace_substring_all ("Class:","from:")
				end
			elseif o_t /= Void then
				Result := clone (tool.title)
				if not Result.empty then
					Result.replace_substring_all ("Feature: ","+ ")
					Result.replace_substring_all ("Class:","from:")
				end
			else
				Result := clone ("? Unknown Tool")
			end

				-- I have to place a check here
			if Result = Void or else Result.empty then
--				Result := clone ("<<>> EL WHAT ??")
			else
				Result.append (tag)
			end
		end

feature -- Status setting

	set_read_only is
		local
			c_t : EB_CLASS_TOOL
		do
			tag := " [READ-ONLY]"
			c_t ?= tool
			if c_t /= Void then
				c_t.set_read_only
			end
		end

feature -- Element change

	update is
			--
		do
			create tag.make (0)
			set_text (value)
		end

	change_tool (a_tool: like tool) is
		do
			tool := a_tool
			update
		end
	
invariant
	tool_non_void: tool /= Void

end -- class EB_SELECTOR_ITEM
