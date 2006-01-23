indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_FORM_TEXTAREA

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
			Result := TextArea_start.twin
			Result.append (attributes_out)
			Result.append (Tag_end)
			Result.append (NewLine)
			Result.append (body_out)
			Result.append (TextArea_end)
			Result.append (NewLine)
		end

	attributes_out: STRING is
		do
			Result := ""
			if has_value (name_value) then
				Result.append (attribute_out (Name, name_value))
			end
			if has_value (rows_value) then
				Result.append (attribute_out (Rows, rows_value))
			end
			if has_value (cols_value) then
				Result.append (attribute_out (Cols, cols_value))
			end
			if has_value (wrap_value) then
				Result.append (attribute_out (Wrap, wrap_value))
			end
		end

	body_out: STRING is
		do
			if has_value (value_value) then
				Result := value_value
			else
				Result := ""
			end
		end

    attribute_out (an_attribute, its_value: STRING): STRING is
            -- String representation for the pair 'an_attribute' and 'its_value'
        do
            Result := an_attribute.twin
            Result.append ("%"")
            Result.append (its_value)
            Result.append ("%"")
        end;


feature -- Wipe out

	wipe_out is
		do
			if has_value (name_value) then
				name_value.wipe_out
			end
			if has_value (rows_value) then
				rows_value.wipe_out
			end
			if has_value (cols_value) then
				cols_value.wipe_out
			end
			if has_value (wrap_value) then
				wrap_value.wipe_out
			end
			if has_value (value_value) then
				value_value.wipe_out
			end
		end

feature -- Set attributes

	set_text (s: STRING) is
		require
			s /= Void
		do
			value_value := s.twin
		end

	set_name (s: STRING) is
		require
			s /= Void
		do
			name_value := s.twin
		end

	set_rows (n: INTEGER) is
		do
			rows_value := n.out
		end

	set_cols (n: INTEGER) is
		do
			cols_value := n.out
		end

	set_wrap (s: STRING) is
		require
			s /= Void
		do
			wrap_value := s.twin
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

	name_value, value_value, rows_value, cols_value, wrap_value: STRING;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HTML_FORM_TEXTAREA

