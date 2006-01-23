indexing
	description: "Dialog that appear at center screen, allow user to manage zones through pick and drop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ZONE_MANAGEMENT_DIALOG

inherit
	SD_ZONE_MANAGEMENT_DIALOG_IMP

create
	make,
	make_with_notebook

feature {NONE}  -- Initlization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			-- Close issues
			close.drop_actions.extend (agent on_close)
			close.drop_actions.set_veto_pebble_function (agent on_veto_close)

			close_others.drop_actions.extend (agent on_close_others)
			close_others.drop_actions.set_veto_pebble_function (agent on_veto_close_others)

			close_all.drop_actions.extend (agent on_close_all)
			close_all.drop_actions.set_veto_pebble_function (agent on_veto_close_all)

			-- Shape issues
			move.drop_actions.extend (agent on_move)
			move.drop_actions.set_veto_pebble_function (agent on_veto_move)

			size.drop_actions.extend (agent on_size)
			size.drop_actions.set_veto_pebble_function (agent on_veto_size)

			max.drop_actions.extend (agent on_max)
			max.drop_actions.set_veto_pebble_function (agent on_veto_max)

			-- Others
			new_editor.drop_actions.extend (agent on_new_editor)
			new_editor.drop_actions.set_veto_pebble_function (agent on_veto_new_editor)

			set_size (200, 100)
		end

	make (a_content: SD_CONTENT) is
			--
		require
			not_void: a_content /= Void
		local
			l_env: EV_ENVIRONMENT
		do
			default_create
			internal_content := a_content
			drop_actions.extend (agent on_drop)

			create l_env
			l_env.application.cancel_actions.extend (agent on_drop)
			l_env.application.drop_actions.extend (agent on_drop)
		ensure
			set: internal_content = a_content
		end

	make_with_notebook (a_notebook: SD_NOTEBOOK) is
			--
		require
			not_void: a_notebook /= Void
		do
			make (a_notebook.selected_item)
			internal_notebook := a_notebook
		ensure
			set: internal_notebook = a_notebook
		end

	on_drop (a_tab: SD_CONTENT) is
			--
		do
			destroy
		end

feature {NONE}  -- Close issues

	on_close (a_content: SD_CONTENT) is
			--
		do
			a_content.close_request_actions.call ([])
		end

	on_veto_close (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Close")
		end

	on_close_others (a_content: SD_CONTENT) is
			--
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_notebook.contents
			l_contents.prune_all (a_content)
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.close_request_actions.call ([])
				l_contents.forth
			end
		end

	on_veto_close_others (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Close All but This")
		end

	on_close_all (a_content: SD_CONTENT) is
			--
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_notebook.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.close_request_actions.call ([])
				l_contents.forth
			end
		end

	on_veto_close_all (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Close All")
		end

feature {NONE} -- Shape and position

	on_move (a_content: SD_CONTENT) is
			--
		do
		end

	on_veto_move (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Move")
		end

	on_size (a_content: SD_CONTENT) is
			--
		do
		end

	on_veto_size (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Size")
		end

	on_max (a_content: SD_CONTENT) is
			--
		do
		end

	on_veto_max (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("Maximize")
		end

feature {NONE}  -- Others

	on_new_editor (a_content: SD_CONTENT) is
			--
		do
		end

	on_veto_new_editor (a_content: SD_CONTENT): BOOLEAN is
			--
		do
			Result := True
			info.set_text ("New Editor")
		end

feature {NONE}  -- Implementation

	internal_content: SD_CONTENT
			-- Content which user will drop.

	internal_notebook: SD_NOTEBOOK;
			-- Notebook caller is in.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
