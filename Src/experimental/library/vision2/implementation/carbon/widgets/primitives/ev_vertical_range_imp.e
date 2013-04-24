note
	description: "Eiffel Vision vertical range. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_RANGE_IMP

inherit
	EV_VERTICAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			interface,
			minimum_height,
			minimum_width
		end

create
	make

feature {NONE} -- Layout

	setup_binding ( user_pane, progress_bar : POINTER )
			-- Take a vertical orientation
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ( $progress_bar, &LayoutInfo );
					
					LayoutInfo.position.x.toView = $user_pane;
					LayoutInfo.position.x.kind = kHILayoutPositionCenter;
					LayoutInfo.position.x.offset = 0.0;
					
					LayoutInfo.scale.y.toView = $user_pane;
					LayoutInfo.scale.y.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.y.ratio = 1.0;
					
					HIViewSetLayoutInfo( $progress_bar, &LayoutInfo );
					HIViewApplyLayout( $progress_bar );
				}
			]"
		end

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 37 -- Hardcoded value, same as GTK+
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		local
			err : INTEGER
			y: INTEGER
			rect: RECT_STRUCT
		do
			create rect.make_new_unshared
			err := get_best_control_rect_external ( gauge_ptr, rect.item, $y )
			Result := rect.right - rect.left
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_RANGE;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_VERTICAL_RANGE_IMP

