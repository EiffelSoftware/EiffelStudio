indexing

	description:

		""

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class DRC_XHTML_WRITER

inherit
	
	DRC_FORMATTED_TEXT_WRITER

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_xhtml_writer: like xhtml_writer) is
			-- Create new Doctor C XHTML writer
		require
			a_xhtml_writer_not_void: a_xhtml_writer /= Void
		do
			xhtml_writer := a_xhtml_writer
		ensure
			xhtml_writer_set: xhtml_writer = a_xhtml_writer
		end

feature {ANY} -- Basic Queries

	xhtml_writer: EPX_XHTML_WRITER
	
feature

	put_string (a_string: STRING) is
		do
			xhtml_writer.puts (a_string)
		end

	begin_emphasis is
		do
			b_b
		end

	end_emphassis is
		do
			e_b
		end

	put_link (a_url, a_title: STRING) is
		local
			javascript_url: STRING
		do
			javascript_url := STRING_.make_empty
			javascript_url.append_string ("JavaScript: explain ('")
			javascript_url.append_string (a_url)
			javascript_url.append_string ("')")
			xhtml_writer.a (javascript_url, a_title)
		end

	begin_paragraph is
		do
			xhtml_writer.b_p
		end

	end_paragraph is
		do
			xhtml_writer.e_p
		end

	begin_unordered_list is
		do
			b_ul
		end

	end_unordered_list is
		do
			e_ul
		end

	begin_list_item is
		do
			b_li
		end

	end_list_item is
		do
			e_li
		end

	begin_code is
		do
			b_code
		end

	end_code is
		do
			e_code
		end
	
	put_new_line is
		do
			xhtml_writer.br
		end

feature {NONE} -- Implementation

	b_b is
			-- Begin bold font
		do
			xhtml_writer.start_tag ("b")
		end

	e_b is
			-- End bold font
		require
			valid_stop: xhtml_writer.is_started ("b")
		do
			xhtml_writer.stop_tag
		end
	
	b_code is
		do
			xhtml_writer.start_tag ("code")
		end

	e_code is
		require
			valid_stop: xhtml_writer.is_started ("code")
		do
			xhtml_writer.stop_tag
		end
	
	b_i is
			-- Begin italic font
		do
			xhtml_writer.start_tag ("i")
		end

	e_i is
			-- End italic font
		require
			valid_stop: xhtml_writer.is_started ("i")
		do
			xhtml_writer.stop_tag
		end

	b_ul is
			-- Begin unordered list
		do
			xhtml_writer.start_tag ("ul")
		end

	e_ul is
			-- End unordered list
		require
			valid_stop: xhtml_writer.is_started ("ul")
		do
			xhtml_writer.stop_tag
		end

	b_li is
			-- Begin list item
		do
			xhtml_writer.start_tag ("li")
		end

	e_li is
			-- End list item
		require
			valid_stop: xhtml_writer.is_started ("li")
		do
			xhtml_writer.stop_tag
		end
	
invariant

	xhtml_writer_not_void: xhtml_writer /= Void
	
end
