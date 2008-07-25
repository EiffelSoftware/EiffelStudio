indexing
	description: "[
		Objects representing a {ES_TBT_GRID} layout for eiffel tests.
		
		See {ES_TBT_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT

inherit
	ES_TBT_GRID_LAYOUT [EIFFEL_TEST_I]

create
	make

feature {NONE} -- Initialization

	make (a_project: like project)
			-- Initialize `Current'
			--
			-- `a_project': Project used to retrieve class and feature instances
		do
			project := a_project
		ensure
			project_set: project = a_project
		end

feature -- Access

	project: !E_PROJECT
			-- <Precursor>

feature -- Factory

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_eitem: EB_GRID_EDITOR_TOKEN_ITEM
		do
			token_writer.new_line
			l_class := class_of_name (a_item.class_name)
			if l_class /= Void then
				if l_class.is_compiled then
					l_feature := l_class.compiled_class.feature_with_name (a_item.name)
					if l_feature /= Void then
						token_writer.add_feature (l_feature, a_item.name)
					end
				end
				if token_writer.last_line.empty then
					token_writer.add_classi (l_class, a_item.name)
				end
			else
				token_writer.add (a_item.name)
			end
			create l_eitem
			l_eitem.set_text_with_tokens (token_writer.last_line.content)
			l_eitem.set_pixmap (pixmaps.icon_pixmaps.feature_routine_icon)
			a_row.set_item (1, l_eitem)
		end

end
