note
	description:
		"EiffelVision vertical separator, Carbon implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
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

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SEPARATOR;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"

end -- class EV_VERTICAL_SEPARATOR_IMP

