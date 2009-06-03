note
	description: "Class which contains the information relative to an html page."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_PAGE

inherit
	ANY
		redefine
			out
		end

create
	make,
	make_from_template,
	make_from_templates

feature -- Initialization

	make
			-- Create an HTML page.
		do
			image := "<HTML>%N</HTML>"
		end

	make_from_template (a_fi_n: STRING)
			-- Create an HTML page from a template whose path name is
			-- 'fi'. The template may contains special symbols/words, which
			-- will allow smart replacing (see feature 'replace').
		require
			path_not_void: a_fi_n /= Void
		do
			create image.make (10)
			image.append ("<html>")
			fill_with_template (image, a_fi_n)
			image.append ("</html>")
		end

feature {NONE} -- Initialization

	make_from_templates (a_templates: ARRAY [STRING])
		require
			a_templates_not_void: a_templates /= Void
		local
			i, nb: INTEGER
		do
			create image.make (10)
			image.append ("<html>")
			from
				i := a_templates.lower
				nb := a_templates.upper
			until
				i > nb
			loop
				fill_with_template (image, a_templates.item (i))
				i := i + 1
			end
			image.append ("</html>")
		end

	fill_with_template (a_buffer, a_fi_n: STRING)
			-- Put content of file `a_fi_n' into `a_buffer'.
		require
			a_buffer_not_void: a_buffer /= Void
			a_fi_n_not_void: a_fi_n /= Void
		local
			fi: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create fi.make_open_read (a_fi_n)
				fi.read_stream (fi.count)
				a_buffer.append_string (fi.last_string)
				fi.close
			else
				image := "<p>Could not read file " + a_fi_n + ".</p>%N"
			end
		ensure
			image_exists: image /= Void
		rescue
			retried := True
			retry
		end

feature -- Basic Operations

	replace_marker (a_marker, s: STRING)
			-- Replace marker 'a_marker' by string 's'
			-- within the template.
			-- Do nothing if it does not exist.
		require
			not_void: a_marker /= Void and s /= Void
		do
			image.replace_substring_all (a_marker,s)
		end

	add_html_code (s: STRING)
			-- Add html code 's'.
		require
			code_exists: s/=Void
		local
			i: INTEGER
			s1: STRING
		do
			i := image.substring_index ("</HTML",1)
			if i = 0 then
				i := image.substring_index ("</html",1)
			end
			check
				found_tag: i>0
			end
			s1 := image.substring (i, i + 6)
			s.append (s1)
			image.replace_substring_all (s1, s)
		end

	insert_hidden_field (name,value: STRING)
				-- Insert hidden field with name 'name' and value 'value'.
			require
				has_form: out.substring_index ("</form>", 1) > 0 or
							out.substring_index ("</FORM>", 1) > 0
			local
				i: INTEGER
			do
				i := image.substring_index ("</form>", 1)
				if i < 1 then
					i := image.substring_index ("</FORM>", 1)
					if i > 0 then
						image.replace_substring_all ("</FORM>", "<INPUT type=hidden name=%""+
								name + "%" value=%"" + value + "%">%N</FORM>")
					end
				else
					image.replace_substring_all ("</form>", "<input type=hidden name=%""+
								name + "%" value=%"" + value + "%">%N</form>")
				end
			end

feature -- Access

	out: STRING
			-- Usable copy of the output.
		do
			Result := image.twin
		end

feature {NONE} -- Implementation

	image: STRING
		-- Image corresponding to Current.

invariant
	page_exists: out /= Void

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




end -- class HTML_PAGE

