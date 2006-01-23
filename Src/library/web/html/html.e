indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML

inherit
	ANY
		undefine
			out
		end

create
	make

feature

	make is
		do
			create options.make
		end

feature -- Routines out

	out: STRING is
		do
			Result := "<HTML"
			Result.append (attributes_out)
			Result.append (">")
			Result.append ("%N")
			Result.append (head_out)
			Result.append ("%N")
			Result.append (body_out)
			Result.append ("%N</HTML>")
		end;

	body_out: STRING is
		do
			Result := ""
			Result.append ("%N<BODY")
			Result.append (body_attributes_out)
			Result.append (">")
			from
				options.start
			until
				options.after
			loop
				Result.append (options.item)
				Result.append ("%N")
				options.forth
			end;
			Result.append ("%N</BODY>")
		end;

	attributes_out, body_attributes_out: STRING is
		do
			Result := ""
		end

	head_out: STRING is
		do 
			Result := ""
			Result.append ("<HEAD><TITLE>")
			if has_value (title_value) then
				Result.append (title_value)
			end
			Result.append ("</TITLE></HEAD>")
			Result.append ("%N")
		end;

feature -- Wipe out

	wipe_out is
		do
			options.wipe_out
		end

feature -- Set 

	set_title (s: STRING) is
		do
			if s /= Void then
				title_value := s.twin
			else
				title_value := Void
			end
		end

feature -- Add new options

	add_option (an_option: STRING) is
		require
			an_option /= Void
		do
			options.extend (an_option.twin)
		end

feature {NONE}
 
    has_value(s: STRING): BOOLEAN is
            -- Has the attribute 's' a value ?
        do
            if s = Void or else s.is_equal ("") then
                Result := False
            else
                Result := True
            end
        end

feature {NONE}

	title_value: STRING
	options: LINKED_LIST [STRING];

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




end -- class HTML

