class
	HTML_FORM_SELECT_OPTION

inherit
	HTML_FORM_CONSTANTS
		undefine
			out
		end
	ANY
		undefine
			out
		end

create
	make

feature

	make is
		do
		end

feature -- Routines out

	out: STRING is
		do
			Result := clone (Option_start)
			Result.append (attributes_out)
			Result.append (Tag_end)
			Result.append (NewLine)
			Result.append (body_out)
			Result.append (Option_end)
			Result.append (NewLine)
		end;

	attributes_out: STRING is
		do
			Result := ""
			if has_value (value_value) then
				Result.append (attribute_out (Value, value_value))
			end;
			if selected_value then
				Result.append (Selected)
			end
		end

	body_out: STRING is
		do
			Result := comment_value
		end

    attribute_out (an_attribute, its_value: STRING): STRING is
            -- String representation for the pair 'an_attribute' and 'its_value'
        do
            Result := clone (an_attribute)
            Result.append ("%"")
            Result.append (its_value)
            Result.append ("%"")
        end

feature -- Wipe out

	wipe_out is
		do
			if has_value (value_value) then
				value_value.wipe_out
			end
			if has_value (comment_value) then
				comment_value.wipe_out
			end
			selected_value := False
		end

feature -- Set attributes

	set_value (s: STRING) is
		require
			s /= Void
		do
			value_value := clone(s)
		end

	set_selected is
		do
			selected_value := true
		end

	set_text (s: STRING) is
		require
			s /= Void
		do
			comment_value := clone(s)
		end


feature {NONE}

	has_value (s: STRING): BOOLEAN is
			-- Has the attribute 's' a value ?
		do
			if s = Void or else s.is_equal("") then
				Result := False
			else
				Result := True
			end
		end

feature {NONE}

	value_value, comment_value: STRING
	selected_value: BOOLEAN

end -- class HTML_FORM_SELECT_OPTION

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

