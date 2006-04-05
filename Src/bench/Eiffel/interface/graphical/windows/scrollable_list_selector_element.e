indexing
	
	description: "This class can be used as a%
		%scrollable_element in scrollable_list."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SCROLLABLE_LIST_SELECTOR_ELEMENT

inherit

	SCROLLABLE_LIST_ELEMENT

create
	make


feature -- Initialization

	make (t_w:TOOL_W) is
		do
			tool:= t_w
			create tag.make(0)
		end

feature {SELECTOR_W} -- Attribute

	tool: TOOL_W

	tag: STRING

feature -- Access

	set_read_only is
		local
			c_w : CLASS_W
		do
			tag := " [READ-ONLY]"
			c_w ?= tool
			if c_w /= Void then
				c_w.set_read_only (True)
			end
		end

	value: STRING is
			-- String to appear in scrollable list box
		local
			t: STRING
			c_w:CLASS_W
			r_w:ROUTINE_W
			o_w:OBJECT_W
		do
			c_w ?= tool
			r_w ?= tool
			o_w ?= tool

			if c_w /= Void then
				if c_w.class_text_field.text.is_empty then
					t:= clone (tool.title)
				else
					t := clone (tool.eb_shell.icon_name)
				end
			elseif r_w /= Void then
				t := clone (tool.title)
				if not t.is_empty then
					t.replace_substring_all ("Feature: ","+ ")
					t.replace_substring_all ("Class:","from:")
				end
			elseif o_w /= Void then
				t := clone (tool.title)
			else
				t := clone ("? Unknown Tool")
			end

			if t.is_empty then
--				t.append ("<<>> EL WHAT ??")
			else
				t.append (tag)
			end

			Result := t
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SCROLLABLE_LIST_SELECTOR_ELEMENT


