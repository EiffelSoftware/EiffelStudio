indexing
	description: "Smart text field accepting only integer as entry."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class INTEGER_TEXT_FIELD

inherit
	EB_TEXT_FIELD

creation
	make_with_label

feature -- Access

	set_int_value (value: INTEGER) is
		local
			temp: STRING
		do
			create temp.make (0)
			temp.append_integer (value)
			set_text (temp)
		end
	
	same_value (value: INTEGER): BOOLEAN is
		local
			temp: STRING
		do
			create temp.make (0)
			temp.append_integer (value)
			Result := text.is_equal (temp)
		end

	int_value: INTEGER is
		do
			if text.is_integer then
				Result := text.to_integer
			end
		end

end -- class INTEGER_TEXT_FIELD

