class CLI_SUP_VIEW_R336

inherit

	CLI_SUP_VIEW
		redefine
			label_view, set_label_view
		end

creation

	make

feature -- Property

	label_view: LABEL_VIEW
		-- Label view

	set_label_view (l: like label_view) is
			-- Set `l' to label_view.
		do
			label_view := l
		end;

end
