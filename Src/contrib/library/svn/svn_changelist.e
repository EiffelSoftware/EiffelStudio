note
	description: "Summary description for {SVN_CHANGELIST}."
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_CHANGELIST

inherit
	ITERABLE [READABLE_STRING_32]

create
	make,
	make_with_name,
	make_with_path

convert
	make_with_name ({READABLE_STRING_GENERAL, READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8, READABLE_STRING_32, STRING_32, IMMUTABLE_STRING_32}) ,
	make_with_path ({PATH}) ,
	as_command_line_arguments: {STRING_32}

feature {NONE} -- Initialization	

	make_with_name (a_name: READABLE_STRING_GENERAL)
		do
			make
			extend (a_name)
		end

	make_with_path (a_path: PATH)
		do
			make_with_name (a_path.name)
		end

	make
		do
			create {ARRAYED_LIST [READABLE_STRING_32]} items.make (1)
		end

feature -- Access

	items: LIST [READABLE_STRING_32]
			-- Elements of current changelist.

	new_cursor: INDEXABLE_ITERATION_CURSOR [READABLE_STRING_32]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Element change

	extend_path (p: PATH)
		do
			extend (p.name)
		end

	extend (a_name: READABLE_STRING_GENERAL)
		do
			items.force (create {IMMUTABLE_STRING_32}.make_from_string_general (a_name))
		end

feature -- Conversion

	as_command_line_arguments: STRING_32
		do
			create Result.make (10)
			append_as_command_line_arguments_to (Result)
		end

	append_as_command_line_arguments_to (a_output: STRING_32)
		local
			i: READABLE_STRING_GENERAL
		do
			a_output.append_character (' ')
			across
				items as ic
			loop
				i := ic.item
				if i.has (' ') or i.has ('%T') then
					a_output.append_string_general ("%"")
					a_output.append_string_general (ic.item)
					a_output.append_string_general ("%"")
				else
					a_output.append_string_general (ic.item)
				end
				a_output.append_character (' ')
			end
		end

note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
