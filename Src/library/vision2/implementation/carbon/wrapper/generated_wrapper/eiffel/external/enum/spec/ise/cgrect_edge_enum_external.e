-- enum wrapper
class CGRECT_EDGE_ENUM_EXTERNAL

feature {ANY}

	is_valid_enum (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid integer code for this enum ?
		do
			Result := a_value = cgrectminxedge or a_value = cgrectminyedge or a_value = cgrectmaxxedge or a_value = cgrectmaxyedge
		end

	 frozen cgrectminxedge: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"CGRectMinXEdge"
		end

	 frozen cgrectminyedge: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"CGRectMinYEdge"
		end

	 frozen cgrectmaxxedge: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"CGRectMaxXEdge"
		end

	 frozen cgrectmaxyedge: INTEGER is
		external
			"C macro use <Carbon/Carbon.h>"
		alias
			"CGRectMaxYEdge"
		end

end
