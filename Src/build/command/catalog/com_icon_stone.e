
class COM_ICON_STONE 

inherit

	ICON_STONE
		undefine
			stone_cursor, stone
		redefine
			data, set_widget_default
		end

	CMD_STONE

	COMMAND
	
feature 

	set_widget_default is
		do
			initialize_transport
			source.add_activate_action (Current, Void)
		end
			
	data: CMD

feature {NONE}

	execute (arg: ANY) is
		local
			instances_list: CMD_ED_CHOICE_WND
		do
			data.choose_instance
		end

end -- class COM_ICON_STONE
