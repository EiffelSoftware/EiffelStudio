indexing
	description: "Bar on which are displayed command buttons."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_EXEC_BAR

creation
	make

feature -- Initialization

	make(window: EC_TOOL)  is
			-- Initialize
		require
			window_exists: window /= Void
		local
			h1: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			caller ?= window
			check
				caller_exists: caller /= Void
			end
			!! h1.make ( window.global_container )
			h1.set_expand(FALSE)
			!! gene_b.make_with_text(h1,"Generate")
			gene_b.set_vertical_resize(FALSE)
			gene_b.set_horizontal_resize(FALSE)
			!! com.make(caller~generate)
			gene_b.add_click_command(com, Void)
			!! cancel_b.make_with_text(h1,"Cancel")
			cancel_b.set_horizontal_resize(FALSE)
			cancel_b.set_vertical_resize(FALSE)
			!! com.make(caller~cancel)
			cancel_b.add_click_command(com, Void)
		ensure
			caller_exists: caller /= Void	
		end

feature -- Implementation

	caller : REPORT_WINDOW

	cancel_b,gene_b: EV_BUTTON

invariant
	caller_exists: caller /= Void

end -- class REPORT_EXEC_BAR
