indexing
	description: "Implementation of EB_PANEL_LIST for the EiffelBench Preference Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PANEL_LIST_IMP

inherit
	EB_PANEL_LIST
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- initialize the panel list
		local
			p : EB_ENTRY_PANEL
		do
			Precursor (a_tool)
			
			Create {EB_GENERAL_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_TOOL_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_PROJECT_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_DEBUGGER_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_EXPLAIN_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_SYSTEM_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_CLASS_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_FEATURE_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_OBJECT_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_PROFILE_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)
			Create {EB_GRAPHICAL_ENTRY_PANEL} p.make (void, tool)
			add_preference_panel (p)

-- for use if a panel is not implemented yet but has to be shown
--			Create {EB_VOID_ENTRY_PANEL} p.make (void, tool)
--			add_preference_panel (p)

		end

feature -- Constants

	number_of_tree_items: INTEGER is 11

	tree_parent : ARRAY [INTEGER] is 
		once
			Result := <<0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0>>
		end

	tree_names : ARRAY [STRING] is
		once
			Result := <<"General", "Tools", "Project", "Debugger",
					"Explain", "System", "Class", "Feature",
					"Object", "Profile", "Editor">>
		end


end -- class EB_PANEL_LIST_IMP
