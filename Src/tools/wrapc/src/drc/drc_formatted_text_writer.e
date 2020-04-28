indexing

	description:

		""

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class DRC_FORMATTED_TEXT_WRITER

feature

	put_string (a_string: STRING) is
		require
			a_string_not_void: a_string /= Void
		deferred
		end

	begin_emphasis is
		deferred
		end

	end_emphassis is
		deferred
		end

	put_emphasized (a_string: STRING) is
		require
			a_string_not_void: a_string /= Void
		do
			begin_emphasis
			put_string (a_string)
			end_emphassis
		end

	put_link (a_url, a_title: STRING) is
		require
			a_url_not_void: a_url /= Void
			a_title_not_void: a_title /= Void
		deferred
		end

	begin_paragraph is
		deferred
		end

	end_paragraph is
		deferred
		end

	begin_unordered_list is
		deferred
		end

	end_unordered_list is
		deferred
		end

	begin_list_item is
		deferred
		end

	end_list_item is
		deferred
		end

	begin_code is
		deferred
		end

	end_code is
		deferred
		end

	put_code (a_string: STRING) is
		require
			a_string_not_void: a_string /= Void
		do
			begin_code
			put_string (a_string)
			end_code
		end

	put_new_line is
		deferred
		end

end
