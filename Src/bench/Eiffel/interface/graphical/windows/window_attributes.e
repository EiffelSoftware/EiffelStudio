indexing
	description: "Class to set window attributes.";
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

end -- class WINDOW_ATTRIBUTES
