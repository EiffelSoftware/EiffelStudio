indexing
	description: "Error when name clash in a cluster."
	date: "$Date$"
	revision: "$Revision$"

class
	VSCN

inherit
	CLUSTER_ERROR

feature -- Properties

	first: CLASS_I
			-- First class in conflict

	second: CLASS_I
			-- Second class in conflict with first

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			l_ext: EXTERNAL_CLASS_I
		do
			put_cluster_name (st)
			st.add_string ("First class: ")
			first.append_name (st)
			st.add_new_line
			if first.is_external_class then
				l_ext ?= first
				st.add_string ("In assembly: %"")
				l_ext.assembly.format (st)
			else
				st.add_string ("First file: %"")
				st.add_string (first.file_name)
			end
			st.add_string ("%"")
			st.add_new_line
			st.add_string ("Second class: ")
			second.append_name (st)
			st.add_new_line
			if second.is_external_class then
				l_ext ?= second
				st.add_string ("In assembly: %"")
				l_ext.assembly.format (st)
			else
				st.add_string ("Second file: %"")
				st.add_string (second.file_name)
			end
			st.add_string ("%"")
			st.add_new_line
		end

feature {UNIVERSE_I, CLUSTER_I, CLUST_REN_SD} -- Setting

	set_first (c: CLASS_I) is
			-- Assign `c' to `first'.
		require
			c_not_void: c /= Void
		do
			first := c
		ensure
			first_set: first = c
		end

	set_second (c: CLASS_I) is
			-- Assing `c' to `second'.
		require
			c_not_void: c /= Void
		do
			second := c
		ensure
			second_set: second = c
		end

end -- class VSCN
