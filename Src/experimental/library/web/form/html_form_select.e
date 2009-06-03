note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_FORM_SELECT

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

	make
		do
			create options.make
			create name_value.make_empty
			create size_value.make_empty
		end

feature -- Routines out

	out: STRING
		do
			Result := Select_start.twin
			Result.append (attributes_out)
			Result.append (Tag_end)
			Result.append (NewLine)
			Result.append (body_out)
			Result.append (Select_end)
			Result.append (NewLine)
		end

	body_out: STRING
		do
			Result := ""
			from
				options.start
			until
				options.after
			loop
				Result.append (options.item)
				Result.append (NewLine)
				options.forth
			end
		end

	attributes_out: STRING
		do
			Result := ""
			if has_value (name_value) then
				Result.append (attribute_out (Name, name_value))
			end;
			if has_value(size_value) then
				Result.append (attribute_out (Size, size_value))
			end
			if multiple_value then
				Result.append (Multiple)
			end
		end;

    attribute_out (an_attribute, its_value: STRING): STRING
            -- String representation for the pair 'an_attribute' and 'its_value'
        do
            Result := an_attribute.twin
            Result.append ("%"")
            Result.append (its_value)
            Result.append ("%"")
        end

feature -- Wipe out

	wipe_out
		do
			multiple_value := False
			if has_value (name_value) then
				name_value.wipe_out
			end
			if has_value (size_value) then
				size_value.wipe_out
			end
			options.wipe_out
		end

feature -- Add new options

	add_option (an_option: STRING)
		require
			an_option /= Void
		do
			options.extend (an_option.twin)
		end

feature -- Set attributes

	set_name (s: STRING)
		require
			s /= Void
		do
			name_value := s.twin
		end

	set_size (n: INTEGER)
		do
			size_value := n.out
		end

	set_multiple_selection
		do
			multiple_value := True
		end

feature {NONE}

	has_value (s: detachable STRING): BOOLEAN
			-- Has the attribute 's' a value ?
		do
			Result := s /= Void and then not s.is_empty
		ensure
			definition: Result = (s /= Void and then not s.is_empty)
		end

feature {NONE}

	name_value, size_value: STRING
	multiple_value: BOOLEAN
	options: LINKED_LIST [STRING];

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HTML_FORM_SELECT

