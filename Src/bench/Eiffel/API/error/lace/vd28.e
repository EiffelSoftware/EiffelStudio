indexing
	description: "Error when two clusters have the same path."
	date: "$Date$"
	revision: "$Revision$"

class
	VD28

inherit
	CLUSTER_ERROR

feature -- Property

	second_cluster_name: STRING

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build error message.
		do
			put_cluster_path (st)
			st.add_string ("First cluster: ")
			st.add_string (cluster.cluster_name)
			st.add_new_line
			st.add_string ("Second cluster: ")
			st.add_string (second_cluster_name)
			st.add_new_line
		end

feature {CLUSTER_SD, UNIVERSE_I, ACE_SD} -- Setting

	set_second_cluster_name (s: STRING) is
			-- Set `second_cluster_name' with `s'.
		require
			s_not_void: s /= Void
		do
			second_cluster_name := s
		ensure
			second_cluster_name_set: second_cluster_name = s
		end

end -- class VD28
