indexing
	description: "[
					Enumeration the type of point in a GraphicsPath object.
					Please see MSDN:
					http://msdn.microsoft.com/en-us/library/3ch9cxht(VS.71).aspx
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_PATH_POINT_TYPE

feature -- Enumeration

	Start: INTEGER is 0
			-- Specifies the starting point of a GraphicsPath.

	Line: INTEGER is 1
			-- Specifies a line segment.

	Bezier: INTEGER is 3
			-- Specifies a default Bezier curve.

	Bezier3: INTEGER is 3
			-- Specifies a cubic Bezier curve.

	PathTypeMask: INTEGER is 7
			-- Specifies a mask point.

	DashMode: INTEGER is 0x10
			-- Specifies that the corresponding segment is dashed.

	PathMarker: INTEGER is 0x20
			-- Specifies a path marker.

	CloseSubpath: INTEGER is 0x80
			-- Specifies the ending point of a subpath.

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN is
			-- If `a_int' valid?
		do
			Result := a_int = Start
				or a_int = Line
				or a_int = Bezier
				or a_int = Bezier3
				or a_int = Pathtypemask
				or a_int = Dashmode
				or a_int = Pathmarker
				or a_int = Closesubpath
		end

	is_valid_array (a_array: ARRAYED_LIST [INTEGER]): BOOLEAN is
			-- If all items in `a_array' valid?
		require
			not_void: a_array /= Void
		do
			from
				Result := True
				a_array.start
			until
				a_array.after or not Result
			loop
				Result := is_valid (a_array.item)
				a_array.forth
			end
		end

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

end
