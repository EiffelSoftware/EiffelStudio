class COMP_CLI_SUP_VIEW_R336

inherit

	COMP_CLI_SUP_VIEW
		redefine
			label_view, set_label_view,
			label, set_label
		end

creation

	make

feature -- Property

	label: STRING;
			-- Label of cli sup data

	label_view: LABEL_VIEW
		-- Label view

	set_label_view (l: like label_view) is
			-- Set `l' to label_view.
		do
			label_view := l
		end;

	set_label (l: like label) is
			-- Set `l' to label_view.
		do
			label := l
		end;

end
