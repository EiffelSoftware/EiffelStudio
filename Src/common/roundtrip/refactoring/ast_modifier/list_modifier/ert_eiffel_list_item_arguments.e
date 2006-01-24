indexing
	description: "EIFFEL_LIST modification arguments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EIFFEL_LIST_ITEM_ARGUMENTS

feature -- Access		

	separator: STRING
			-- Separator used to separate items.
			-- Empty if no separator is needed.

	has_separator: BOOLEAN is
			-- Do we deal with separators?
		do
			Result := separator /= Void and then not separator.is_empty
		end

	leading_text: STRING
			-- Leading text to be added before every prepended/appended item

	trailing_text: STRING
			-- Trailing text to be added after every prepended/appended item

feature -- Setting

	set_separator (a_separator: STRING) is
			-- Set `separator' with `a_separator'.
			-- If `a_separator' is Void or empty, separators will not be processed.
		do
			if a_separator = Void then
				create separator.make (0)
			else
				separator := a_separator.twin
			end
		ensure
			separator_set: (a_separator = Void implies separator.is_empty) and
						   (a_separator /= Void implies separator.is_equal (a_separator))
		end

	set_leading_text (a_text: STRING) is
			-- Set `leading_text' with `a_text'.
		do
			if a_text = Void then
				leading_text := ""
			else
				leading_text := a_text.twin
			end
		ensure
			leading_text_set: (a_text = Void implies leading_text.is_empty) and (a_text /= Void implies leading_text.is_equal (a_text))
		end

	set_trailing_text (a_text: STRING) is
			-- Set `trailing_text' with `a_text'.
		do
			if a_text = Void then
				trailing_text := ""
			else
				trailing_text := a_text.twin
			end
		ensure
			trailing_text_set: (a_text = Void implies trailing_text.is_empty) and (a_text /= Void implies trailing_text.is_equal (a_text))
		end

	set_arguments (a_separator, a_leading_text, a_trailing_text: STRING) is
			-- Setup arguments.
		do
			set_separator (a_separator)
			set_leading_text (a_leading_text)
			set_trailing_text (a_trailing_text)
		end

end
