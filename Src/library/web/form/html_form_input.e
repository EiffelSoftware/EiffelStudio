class
	HTML_FORM_INPUT

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
			Result := clone (Input_start)
			Result.append (attributes_out)
			Result.append (Tag_end)
			Result.append (NewLine)
		end

	attributes_out: STRING is
		do
			Result := ""
			if has_value (type_value) then
				Result.append (attribute_out (Type, type_value))
			end
			if has_value (name_value) then
				Result.append (attribute_out (Name, name_value))
			end
			if has_value (value_value) then
				Result.append (attribute_out (Value, value_value))
			end
			if has_value (src_value) then
				Result.append (attribute_out (Src, src_value))
			end
			if has_value (size_value) then
				Result.append (attribute_out (Size, size_value))
			end;
			if has_value (maxlength_value) then
				Result.append (attribute_out (Maxlength, maxlength_value))
			end
			if has_value (align_value) then
				Result.append (attribute_out (Align, align_value))
			end;
			if checked_value then
				Result.append (Checked)
			end
		end

    attribute_out (an_attribute, its_value: STRING): STRING is
            -- String representation for the pair 'an_attribute' and 'its_value'
        do
            Result := clone (an_attribute)
			Result.append ("%"")
            Result.append (its_value)
			Result.append ("%"")
        end;

feature -- Wipe out

	wipe_out is
		do
			checked_value := False
			if has_value (type_value) then
				type_value.wipe_out
			end
			if has_value (name_value) then
				name_value.wipe_out
			end
			if has_value (value_value) then
				value_value.wipe_out
			end
			if has_value (src_value) then
				src_value.wipe_out
			end
			if has_value (size_value) then
				size_value.wipe_out
			end
			if has_value (maxlength_value) then
				maxlength_value.wipe_out
			end
			if has_value (align_value) then
				align_value.wipe_out
			end
		end

feature -- Set attributes

	set_checked is
		do
			checked_value := True
		end

	set_type (s: STRING) is
		require
			s /= Void
		do
			type_value := clone (s)
		end

	set_name (s: STRING) is
		require
			s /= Void
		do
			name_value := clone (s)
		end

	set_value (s: STRING) is
		require
			s /= Void
		do
			value_value := clone (s)
		end

	set_file_src, set_image_src (s: STRING) is
		require
			s /= Void
		do
			src_value := clone (s)
		end

	set_size (s: INTEGER) is
		do
			size_value := s.out;
		end

	set_maxlength (s: INTEGER) is
		do
			maxlength_value := s.out
		end

	set_image_align (s: STRING) is
		require
			s /= Void
		do
			align_value := clone (s)
		end

feature {NONE}

	has_value (s: STRING): BOOLEAN is
			-- Has the attribute 's' a value ?
		do
			if s = Void or else s.is_equal ("") then
				Result := False
			else
				Result := True
			end
		end

feature {NONE}

	type_value, name_value, value_value, src_value: STRING
	size_value, maxlength_value, align_value: STRING
	checked_value: BOOLEAN

end -- class HTML_FORM_INPUT


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

