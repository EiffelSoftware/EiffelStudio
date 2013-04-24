note
	description: "EiffelV ision horizontal progress bar. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR_IMP

inherit
	EV_HORIZONTAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			interface,
			minimum_height,
			minimum_width
		end

create
	make

feature {NONE} -- Implementation

	setup_binding ( user_pane, progress_bar : POINTER )
			-- setup layout binding
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

	bounds_changed ( options : INTEGER; original_bounds, current_bounds : CGRECT_STRUCT )
			-- Handler for the bounds changed event
		local
			size : CGSIZE_STRUCT
		do
			create size.make_shared ( current_bounds.size )
			if size.height < 20 and then current_style /= {CONTROLS_ANON_ENUMS}.kcontrolsizenormal then
				set_style_small
			elseif size.height >= 20 and then current_style /= {CONTROLS_ANON_ENUMS}.kcontrolsizelarge then
				set_style_large
			end
		end

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		do
			Result := 15 -- Hardcode
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		do
			Result := 150 -- Hardcode
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_PROGRESS_BAR;

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_HORIZONTAL_PROGRESS_BAR_IMP

