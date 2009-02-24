note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_FORM

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
			create action_value.make_empty
			create method_value.make_empty
			create enctype_value.make_empty
		end

feature -- Routines out

	out: STRING
		do
			Result := Form_start.twin
			Result.append (attributes_out)
			Result.append (Tag_end)
			Result.append (NewLine)
			Result.append (body_out)
			Result.append (Form_end)
			Result.append (NewLine)
		end;

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
			end
			if has_value(action_value) then
				Result.append (attribute_out (Action, action_value))
			end
			if has_value(method_value) then
				Result.append (attribute_out (Method, method_value))
			else
				Result.append (attribute_out (Method, Post))
			end
			if has_value (enctype_value) then
				Result.append (attribute_out (Enctype, enctype_value))
			end
		end

    attribute_out (an_attribute, its_value: STRING): STRING
            -- String representation for the pair 'an_attribute' and 'its_value'
        do
            Result := an_attribute.twin
            Result.append ("%"")
            Result.append (its_value)
            Result.append ("%"")
        end;

feature -- Wipe out

	wipe_out
		do
			if has_value (name_value) then
				name_value.wipe_out
			end
			if has_value (action_value) then
				action_value.wipe_out
			end
			if has_value (method_value) then
				method_value.wipe_out
			end
			if has_value (enctype_value) then
				enctype_value.wipe_out
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

	set_action (s: STRING)
		require
			s /= Void
		do
			action_value := s.twin
		end

	set_method (s: STRING)
		require
			s /= Void
		do
			method_value := s.twin
		end

	set_enctype (s: STRING)
		require
			s /= Void
		do
			enctype_value := s.twin
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

	name_value, action_value, method_value, enctype_value: STRING
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




end -- class HTML_FORM

