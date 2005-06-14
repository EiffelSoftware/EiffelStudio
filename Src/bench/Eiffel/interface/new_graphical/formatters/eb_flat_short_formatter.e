indexing
	description: "Command to display the flat/short version of a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FLAT_SHORT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			class_cmd,
			generate_text,
			set_stone,
			is_dotnet_formatter,
			formatted_text
		end

	EB_SHARED_FORMAT_TABLES

create
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_interface, 1)
			Result.put (Pixmaps.Icon_format_interface, 2)
		end
 
	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showfs
		end
 
 	is_dotnet_formatter: BOOLEAN is
 			-- Is Current able to format .NET XML types?
 		do
 			Result := True
 		end
 
feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Flatshort
		end

	post_fix: STRING is "fs"
			-- String symbol of the command, used as an extension when saving.

	consumed_type: CONSUMED_TYPE
			-- The .NET consumed undergoing formatting.

	class_i: EXTERNAL_CLASS_I
			-- Class currently associated with `Current'.

	formatted_text: STRUCTURED_TEXT
			-- Text representing `class_i'.

feature {NONE} -- Implementation

	class_cmd: E_SHOW_FS
			-- Class command that can generate the information. Not used.

	create_class_cmd is
			-- Create `class_cmd'.
		require else
			associated_class_non_void: associated_class /= Void
		do
			create class_cmd.do_nothing
		end

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_without_breakable
				if not is_dotnet_mode then
					if associated_class /= Void then
						formatted_text := flatshort_context_text (associated_class)
					end
				else
					if class_i /= Void then
						formatted_text := flatshort_dotnet_text (consumed_type, class_i)
					elseif associated_class /= Void then
						formatted_text := flatshort_dotnet_text (consumed_type, associated_class.lace_class)
					end
				end
				
				if formatted_text = Void then
					last_was_error := True
				else
					last_was_error := False
				end
				if has_breakpoints then
					editor.enable_has_breakable_slots
				else
					editor.disable_has_breakable_slots
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	has_breakpoints: BOOLEAN is False
			-- Should `Current' display breakpoints?

	line_numbers_allowed: BOOLEAN is False
		-- Does it make sense to show line numbers in Current?

feature -- Status setting

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			a_stone: CLASSC_STONE
			l_ext_class: EXTERNAL_CLASS_I
		do
			if new_stone /= Void and new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				a_stone ?= new_stone
				if a_stone /= Void then
					-- Is compiled
					if consumed_types.has (a_stone.class_i.name) then
						consumed_type := consumed_types.item (a_stone.class_i.name)
					else
						l_ext_class ?= a_stone.class_i
						check
							l_ext_class_not_void: l_ext_class /= Void
						end
						consumed_type := l_ext_class.external_consumed_type
						if consumed_type /= Void then
							consumed_types.put (consumed_type, a_stone.class_i.name)	
						end
					end
					set_class (a_stone.e_class)
					class_i := Void
				else
						-- Is not compiled
					l_ext_class ?= new_stone.class_i
					check
						l_ext_class_not_void: l_ext_class /= Void
					end
					consumed_type := l_ext_class.external_consumed_type
					set_classi (new_stone.class_i)
					associated_class := Void
				end
			else
				set_dotnet_mode (False)
				Precursor {EB_CLASS_TEXT_FORMATTER} (new_stone)
			end
		end

	set_classi (a_class: CLASS_I) is
			-- Associate current formatter with non-compiled `a_class'.
		do		
			class_i ?= a_class
			class_cmd := Void
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		end

end -- class EB_FLAT_SHORT_FORMATTER

