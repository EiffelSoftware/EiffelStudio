note
	description:
		"EiffelVision horizontal separator, Carbon implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	setup_binding ( user_pane, progress_bar : POINTER )
			-- Take a horizontal orientation
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ( $progress_bar, &LayoutInfo );
					
					LayoutInfo.position.y.toView = $user_pane;
					LayoutInfo.position.y.kind = kHILayoutPositionCenter;
					LayoutInfo.position.y.offset = 0.0;
					
					LayoutInfo.scale.x.toView = $user_pane;
					LayoutInfo.scale.x.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.x.ratio = 1.0;
					
					HIViewSetLayoutInfo( $progress_bar, &LayoutInfo );
					HIViewApplyLayout( $progress_bar );
				}
			]"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"

end -- class EV_HORIZONTAL_SEPARATOR_IMP

