indexing

	description: 
		"Text field area for the class name of the class_window.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_WINDOW_NAME 

inherit

	ENTITY_NAME_FIELD
		redefine
			editor_window
		end

	GRAPHICAL_COMPONENT [CLUSTER_DATA]
		rename
			make as make_component
		end

creation
		
	make

feature -- Properties Redefinitions

	editor_window: EC_EDITOR_WINDOW [CLUSTER_DATA]

feature -- Execution (work)

	work is
			-- Popup list of data depending on value
			-- of `text'.
		local
			err_id, tmp: STRING;
			error_messages: like messages
		do
			err_id := "E16"
			error_messages := popup_windows.errors

			if error_messages.has (err_id) then
				tmp := error_messages.item (err_id)
			else
				io.error.putstring ("Can not find error keyword ")
				io.error.putstring (err_id)
				io.error.putstring ("%NPlease contact I.S.E.%N")
				!! tmp.make (0)
			end
		
			popup_with_list (Current, text, System.clusters_with_prefix (text), tmp)
		end

	fill is
		local
			elem : EV_LIST_ITEM

			select_cluster: SELECT_CLUSTER
			name_data: NAME_DATA

			rename_warning: EV_WARNING_DIALOG
			rename_command: RENAME_ENTITY_COMMAND

			cancel_name: CANCEL_NAME_COMMAND

			accelerator: EV_ACCELERATOR
			codes: EV_KEY_CODE
		do
			if names_list /= Void then
				if not names_list.empty then

					!! codes.make
					!! accelerator.make (codes.Key_escape, false, false, false)

					!! cancel_name.make (Current)
					add_accelerator_command (accelerator, cancel_name, Void)

					clear_items
					from
						names_list.start;
					until
						names_list.after
					loop
						name_data := names_list.item	
	
						if name_data /= Void then
							!! elem.make_with_text (Current, name_data.name)
							!! select_cluster.make (name_data.name, editor_window)
							elem.add_select_command (select_cluster, Void)
							names_list.forth
						end
					end
				else
					rename_warning := windows_manager.warning ("Wk", Void, editor_window)
					
					if rename_warning /= Void then

						rename_warning.show_yes_no_buttons

						if editor_window /= Void then
							!! rename_command.make (editor_window.entity, Current)
							rename_warning.add_yes_command (rename_command, Void)
	
							rename_warning.show
						end
					end
				end
			end
		end

feature -- Update

	clear is
		do
		end

	update is
		local
			namable: NAME_DATA
		do
			if editor_window /= Void then
				namable := editor_window.entity

				if namable /= Void then
					observer_management.clear_observer (Current)
					set_text (namable.name)
					observer_management.add_observer (namable, Current)
				end
			end 
		end

end -- class CLASS_WINDOW_NAME
