indexing
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
	make_from_template

feature -- Initialization

	make is
			-- Create an HTML page.
		do
			image := "<HTML>%N</HTML>"
		end

	make_from_template(fi_n: STRING) is
			-- Create an HTML page from a template whose path name is
			-- 'fi'. The template may contains special symbols/words, which
			-- will allow smart replacing (see feature 'replace').
		require
			path_not_void: fi_n /= Void
		local
			fi: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create fi.make_open_read (fi_n)
				fi.read_stream (fi.count)
				image := fi.last_string.twin
				fi.close
			else
				image := "<HTML>Could not read file " + fi_n + ".</HTML>"
			end
		ensure
			image_exists: image /= Void
		rescue
			retried := True
			retry
		end

feature -- Basic Operations

	replace_marker (a_marker, s: STRING) is
			-- Replace marker 'a_marker' by string 's' 
			-- within the template.
			-- Do nothing if it does not exist.
		require
			not_void: a_marker /= Void and s /= Void
		do
			image.replace_substring_all (a_marker,s)
		end

	add_html_code (s: STRING) is
			-- Add html code 's'.
		require
			code_exists: s/=Void
		local
			i: INTEGER
			s1: STRING
		do
			i := image.substring_index ("</HTML",1)
			if i=0 then
				i := image.substring_index ("</html",1)
			end
			check
				found_tag: i>0
			end
			s1 := image.substring (i, i + 6)
			s.append (s1)
			image.replace_substring_all (s1, s)
		end 

	insert_hidden_field (name,value: STRING) is
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

	out: STRING is
			-- Usable copy of the output.
		do
			if image /= Void then
				Result := image.twin
			end
		end

feature {NONE} -- Implementation

	image: STRING
		-- Image corresponding to Current.
	
invariant
	page_exists: out /= Void

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




end -- class HTML_PAGE

