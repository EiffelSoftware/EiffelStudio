indexing

	description: "Text field found in editor window.";
	date: "$Date$";
	revision: "$Revision $"

deferred class ENTITY_NAME_FIELD

inherit

	EV_COMMAND
		rename
			--work as command_work
		end;
	EV_COMBO_BOX
		rename
			make as tf_make
		end;
	FOCUS_LINE
		rename 
			focus_label as focus_obsolete
			--set_focus as set_focus_line
		end;
	ONCES

feature -- Properties

	editor_window: EC_EDITOR_WINDOW [NAME_DATA]
			-- Associated editor window

	--focus_label: FOCUS_LABEL_I is
	--		-- Label where focus_string is displayed
	--	local
	--		ti:TOOLTIP_INITIALIZER
	--	do
	--		-- PascalfResult := editor_window.focus_label
	--		--ti ?= top
	--		check
	--			ti/=Void
	--		end
	--		--Result := ti.label
	--	end;
	
	focus_obsolete: EV_LABEL
feature {NONE} -- Implementation

	make (id: STRING; a_parent: EV_CONTAINER; ed: like editor_window) is
		do
			tf_make (a_parent)		
			add_activate_command (Current, Void)
			editor_window := ed;

		--	set_focus (Current, id);
		--	focus_string := id
		--	initialize_focus
		end;

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			--if Windows.main_graph_window.project_initialized then
				work
			--end
		end
	
	work is
		deferred
		end;

feature {ENTITY_LIST_WINDOW} -- Implementation

	continue_after_selection (item_selected: NAME_DATA) is
			-- Actions performed after selection.
		require
			valid_selection: item_selected /= Void;
		do
			editor_window.set_entity (item_selected)
		end;


popup_with_list (cal: ENTITY_NAME_FIELD; search_text: STRING;
			l: LINKED_LIST [NAME_DATA];
			no_item_found_string: STRING) is
		require
			valid_search_text: search_text /= Void;
			valid_cal: cal /= Void;
			valid_l: l /= Void;
			valid_no_item_found_string: no_item_found_string /= Void
		local
			enti : ENTITY_NAME_FIELD
		do
			names_list := l;
			no_items_found := clone (no_item_found_string);
			if search_text.empty or else (search_text.item (search_text.count) = '*') or else l.empty
			then
				fill;
			else
				continue_after_selection (l.i_th (1));
			end
		end


	fill is
		deferred
		end

	names_list: LINKED_LIST [NAME_DATA]

	no_items_found: STRING


end -- class ENTITY_NAME_FIELD
