class ATTRIBUTE_BUTTON

inherit

	FORMAT_BUTTON
		redefine
			set_form_number,
			valid_form_nbr
		end

creation

	make

feature 

	form_number: INTEGER;

	symbol: PIXMAP is
		once
			Result := Pixmaps.attribute_pixmap
		end;

	selected_symbol: PIXMAP is
		once
			Result := Pixmaps.selected_attribute_pixmap
		end;

	focus_string: STRING is 
		do
			Result := Focus_labels.attribute_label
		end;

	set_form_number (nbr: INTEGER) is
		do
			form_number := nbr
		end;

	valid_form_nbr (nbr: INTEGER): BOOLEAN is
		do
			Result := 
				nbr = Context_const.label_text_att_form_nbr or else
				nbr = Context_const.perm_wind_att_form_nbr or else
				nbr = Context_const.separator_att_form_nbr or else
				nbr = Context_const.text_att_form_nbr or else
				nbr = Context_const.scale_att_form_nbr or else
				nbr = Context_const.pict_color_att_form_nbr or else
				nbr = Context_const.arrow_b_att_form_nbr or else
				nbr = Context_const.scroll_l_att_form_nbr or else
				nbr = Context_const.text_field_att_form_nbr or else
				nbr = Context_const.temp_wind_att_form_nbr or else
                nbr = Context_const.toggle_att_form_nbr or else
				nbr = Context_const.drawing_box_att_form_nbr
		end;

end
