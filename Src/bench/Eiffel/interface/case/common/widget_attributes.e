indexing

	description: "Object to set widget attributes. Attributes%
				 %only include color and fonts.";
	date: "$Date$";
	revision: "$Revision $"

class WIDGET_ATTRIBUTES

inherit
	
	CONSTANTS

creation

	set_dialog--, set_composite

feature -- Setting

	set_dialog (dialog: EV_DIALOG) is
			-- Set the color and font attributes for `dialog' 
			-- and its children.
		local
--			fg_color, bg_color: EV_COLOR;
--			a_font: EV_FONT;
--			widget: WIDGET;
--			primitive: PRIMITIVE;
--			fontable: EV_FONTABLE
		do
--			bg_color := Resources.background_color;
--			fg_color := Resources.foreground_color;
--			a_font := Resources.default_font;
--			if bg_color /= Void or else 
--				fg_color /= Void or else
--				a_font /= Void
--			then
--				if bg_color /= Void then
--					dialog.set_background_color (bg_color)
--				end;
--				if fg_color /= Void then
--					dialog.set_foreground_color (fg_color)
--				end;
--				if a_font /= Void then
--			--		dialog.set_label_font (a_font);
--			--		dialog.set_text_font (a_font);
--			--		dialog.set_button_font (a_font);
--				end;
--			end;
		end;

--	set_composite (composite: COMPOSITE) is
--			-- Set the color and font attributes for `composite' 
--			-- and its descendants.
--		local
--			fg_color, bg_color: EV_COLOR;
--			a_font: EV_FONT;
--			ch: ARRAYED_LIST [WIDGET];
--			widget: WIDGET;
--			primitive: EV_PRIMITIVE;
--			manager: MANAGER;
--			fontable: EV_FONTABLE
--			toggle_b : TOGGLE_B
--			term: EV_DIALOG
--			label : LABEL_IMP
--	            form : FORM
--		do
--			bg_color := Resources.background_color
--			fg_color := Resources.foreground_color
--			a_font := Resources.default_font
--			if bg_color /= Void or else 
--				fg_color /= Void or else
--				a_font /= Void
--			then
--				ch := composite.descendants;
--				ch.extend (composite);
--				from
--					ch.start
--				until
--					ch.after
--				loop
--                    		widget := ch.item;
--					term ?= widget;
--					if fg_color /= Void then
--						primitive ?= widget;
--						if primitive /= Void then
--							primitive.set_foreground_color (fg_color)
--							label ?= ch.item
--							if label /= Void then
--								--label.update
--							end
--						elseif term /= Void then
--							term.set_foreground_color (fg_color)
--						end
--					end;
--					if a_font /= Void then
--						fontable ?= widget;
--						if fontable /= Void then
--							toggle_b ?= fontable
--							--if toggle_b = Void then
--								fontable.set_font (a_font)
--							--end
--						end
--						if term /= Void then
--						--	term.set_button_font (a_font);
--						--	term.set_label_font (a_font);
--						--	term.set_text_font (a_font);
--						end;
--					end;
--					ch.forth
--				end
--			end;
--		end;

end -- class WIDGET_ATTRIBUTES
