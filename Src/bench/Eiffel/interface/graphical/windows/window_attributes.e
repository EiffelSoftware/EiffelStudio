indexing
	description: "Class to set window attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: 	"$Date$";
	revision: 	"$Revision$"

class WINDOW_ATTRIBUTES

inherit
	EB_CONSTANTS

feature -- Setting

	set_composite_attributes (composite: COMPOSITE) is
			-- Set the color and fonts for `composite'.
		local
			children: ARRAYED_LIST [WIDGET];
		do
			from
				children := composite.descendants;
				children.extend (composite);
				children.start
			until
				children.after
			loop
				set_widget_attributes (children.item)
				children.forth
			end
		end

	set_widget_attributes (widget: WIDGET) is
		local
			primitive: PRIMITIVE;
			fontable: FONTABLE;
			manager: MANAGER;
			terminal: TERMINAL_OUI;
			fg_color: COLOR;
			font: FONT
		do
			fg_color := Graphical_resources.foreground_color.actual_value;
			font := Graphical_resources.font.actual_value;
			if fg_color /= Void then
				primitive ?= widget;
				if primitive /= Void then
					primitive.set_foreground_color (fg_color)
				else
					manager ?= widget;
					if manager /= Void then
						manager.set_foreground_color (fg_color)
					end
				end
			end;
			if font /= Void then
				fontable ?= widget;
				if fontable /= Void then
					fontable.set_font (font)
				else
					terminal ?= widget;
					if terminal /= Void then
						terminal.set_button_font (font);
						terminal.set_label_font (font);
						terminal.set_text_font (font)
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class WINDOW_ATTRIBUTES
