indexing
	description: "Formatter to display the XML text a class with no analysis, flat short."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOTNET_FLAT_SHORT_FORMATTER

inherit
	EB_CLASS_TEXT_FORMATTER
		redefine
			set_stone,
			generate_text,
			class_cmd,
			editable,
			formatted_text,
			make,
			set_accelerator
		end
		
	EB_SHARED_FORMAT_TABLES
		undefine
			feature_clause_order
		end

creation
	make

feature -- Initialization

	make (a_manager: like manager) is
			-- Create a formatter associated with `a_manager'.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (a_manager)
			create_class_cmd
			create formatted_text.make
		end

feature -- Properties

	consumed_type: CONSUMED_TYPE
			-- The .NET consumed undergoing formatting.

	class_i: EXTERNAL_CLASS_I
			-- Class currently associated with `Current'.

	formatted_text: STRUCTURED_TEXT
			-- Text representing `class_i'.

	class_cmd: E_SHOW_FLAT
			-- Just needed for compatibility, do not use.

feature -- Status setting

	set_accelerator (accel: EV_ACCELERATOR) is
			-- Changes the accelerator.
		do
			Precursor {EB_CLASS_TEXT_FORMATTER} (accel)
			accelerator.actions.put_front (~invalidate)
		end

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate `Current' with class contained in `new_stone'.
		local
			a_stone: CLASSC_STONE
			l_reader: EIFFEL_XML_DESERIALIZER
		do
			if new_stone /= Void and new_stone.class_i.is_external_class then
				create l_reader
				a_stone ?= new_stone
				if a_stone /= Void then
					-- Is compiled
					consumed_type ?= l_reader.new_object_from_file (a_stone.class_i.file_name)
					set_class (a_stone.e_class)
					class_i := Void
				else
					-- Is not compiled
					consumed_type ?= l_reader.new_object_from_file (new_stone.file_name)
					set_classi (new_stone.class_i)
					associated_class := Void
				end
			else
				class_i := Void
				if selected then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					editor.clear_window
					display_header
				end
			end
		end

	set_classi (a_class: CLASS_I) is
			-- Associate current formatter with non-compiled `a_class'.
		do		
			class_i ?= a_class
			if a_class = Void then
				class_cmd := Void
			else
				create_class_cmd
			end
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		end

feature {NONE} -- Gui Properties

	editable: BOOLEAN is False
			-- The generated text cannot be edited.

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
			Result := Interface_names.m_Showdotnetfs
		end

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.L_dotnetFlatshort
		end

	post_fix: STRING is "dnfs"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	generate_text is
		local
			retried: BOOLEAN
		do
			if not retried then
				set_is_without_breakable
				if class_i /= Void then
					formatted_text := flatshort_dotnet_text (consumed_type, class_i)
				elseif associated_class /= Void then
					formatted_text := flatshort_dotnet_text (consumed_type, associated_class.lace_class)
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

	create_class_cmd is
			-- Create `class_cmd'.
		require else
			True
		do
			create class_cmd.do_nothing
		end

invariant
	has_formatted_text: formatted_text /= Void

end -- class EB_DOTNET_FLAT_SHORT_FORMATTER
