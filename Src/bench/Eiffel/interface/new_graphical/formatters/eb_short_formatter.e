indexing
	description: "Command to display the short version of a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHORT_FORMATTER

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

creation
	make
	
feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_contract, 1)
			Result.put (Pixmaps.Icon_format_contract, 2)
		end
 
	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showshort
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
			Result := Interface_names.l_Short
		end

	post_fix: STRING is "sho"
			-- String symbol of the command, used as an extension when saving.

	consumed_type: CONSUMED_TYPE
			-- The .NET consumed undergoing formatting.

	class_i: EXTERNAL_CLASS_I
			-- Class currently associated with `Current'.

	formatted_text: STRUCTURED_TEXT
			-- Text representing `class_i'.

feature {NONE} -- Implementation

	class_cmd: E_SHOW_FLAT
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
				set_is_with_breakable
				if not is_dotnet_mode then			
					formatted_text := short_context_text (associated_class)
				else
					set_is_without_breakable
					if class_i /= Void then
						formatted_text := short_dotnet_text (consumed_type, class_i)
					elseif associated_class /= Void then
						formatted_text := short_dotnet_text (consumed_type, associated_class.lace_class)
					end
				end
				if formatted_text = Void then
					last_was_error := True
				else
					last_was_error := False
				end
				if has_breakpoints then
					editor.show_breakpoints
				else
					editor.hide_breakpoints
				end
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

feature -- Status setting

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			a_stone: CLASSC_STONE
			l_reader: EIFFEL_XML_DESERIALIZER
		do
			if new_stone /= Void and new_stone.class_i.is_external_class then
				set_dotnet_mode (True)
				create l_reader
				a_stone ?= new_stone
				if a_stone /= Void then
					-- Is compiled .NET type.
					consumed_type ?= l_reader.new_object_from_file (a_stone.class_i.file_name)
					set_class (a_stone.e_class)
					class_i := Void
				else
					-- Is not compiled .NET type/
					consumed_type ?= l_reader.new_object_from_file (new_stone.file_name)
					set_classi (new_stone.class_i)					
					associated_class := Void
				end
			else
				set_dotnet_mode (False)
				Precursor {EB_CLASS_TEXT_FORMATTER} (new_stone)
			end
		end

	set_classi (a_class: CLASS_I) is
			-- Associate current formatter with `a_class'.
		require
			a_class_not_void: a_class /= Void
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

end -- class EB_SHORT_FORMATTER
