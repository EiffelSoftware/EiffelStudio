indexing
	description: "Abstract description of an .NET class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_CLASS_AS

inherit
	SHARED_TEXT_ITEMS

create
	make

feature {NONE} -- Initialization

	make (a_consumed: CONSUMED_TYPE; a_flag: BOOLEAN; a_class: CLASS_I) is
		require
			a_consumed_not_void: a_consumed /= Void
			a_classi_not_void: a_class /= Void
		do
			consumed_type := a_consumed
			dotnet_name := a_consumed.dotnet_name
			entities := a_consumed.flat_entities
			is_deferred := a_consumed.is_deferred or a_consumed.is_interface
			is_frozen := a_consumed.is_frozen
			is_expanded := a_consumed.is_expanded
			if a_class /= Void and a_class.compiled_class /= Void then
					-- This is a compiled class so we save the CLASS_C for use in formatting.
				class_c := a_class.compiled_class
				class_i ?= a_class
			else
				class_i ?= a_class
			end
			set_current_class_only (a_flag)
			initialize (a_consumed)
		ensure
			consumed_type_set: consumed_type /= Void
			dotnet_name_set: dotnet_name /= Void
			entities_set: entities /= Void
			deferred_set: is_deferred implies (a_consumed.is_deferred or a_consumed.is_interface)
		end

	initialize (a_consumed: CONSUMED_TYPE) is
			-- Initialize information for Current pertaining to 'a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			create features.make (7)
			set_constructors (a_consumed)
			set_ancestors (a_consumed)
			initialize_feature_categories
		end

	initialize_feature_categories is
			-- Initialize the features by category for formatting.
		local
			l_entity: CONSUMED_ENTITY
			access_features, hidden_access_features,
			query_features, hidden_query_features,
			command_features, hidden_command_features,
			misc_features: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]
		do

					-- Initialize all feature category lists.
			create property_features.make ("Properties", True)
			create property_setting_features.make ("Property Setting", True)
			create events_features.make ("Events", True)
			create access_features.make ("Access", True)
			create query_features.make ("Query", True)
			create command_features.make ("Commands", True)
			create hidden_property_features.make ("Properties", False)
			create hidden_property_setting_features.make ("Property Setting", False)
			create hidden_events_features.make ("Events", False)
			create hidden_access_features.make ("Access", False)
			create hidden_query_features.make ("Query", False)
			create hidden_command_features.make ("Commands", False)

			from
				loop_counter := 1
			until
				loop_counter = entities.count
			loop
				l_entity := entities.item (loop_counter)
				if should_add (l_entity) then
					if l_entity.is_property_or_event then
						initialize_property_or_event (l_entity)
					elseif l_entity.is_field then
						if l_entity.is_public then
							access_features.extend (l_entity)
						else
							hidden_access_features.extend (l_entity)
						end
					elseif l_entity.has_return_value then
						if l_entity.is_public then
							query_features.extend (l_entity)
						else
							hidden_query_features.extend (l_entity)
						end
					elseif not l_entity.has_return_value then
						if l_entity.is_public then
							command_features.extend (l_entity)
						else
							hidden_command_features.extend (l_entity)
						end
					else
						if misc_features = Void then
							create misc_features.make ("Miscellaneous", True)
						end
						misc_features.extend (l_entity)
					end
				end
				loop_counter := loop_counter + 1
			end

					-- Add features to feature category list if not empty.
			add_to_features_list (access_features)
			add_to_features_list (query_features)
			add_to_features_list (command_features)
			add_to_features_list (property_features)
			add_to_features_list (property_setting_features)
			add_to_features_list (events_features)
					-- Non exported feature categories.
			add_to_features_list (hidden_access_features)
			add_to_features_list (hidden_query_features)
			add_to_features_list (hidden_command_features)
			add_to_features_list (hidden_property_features)
			add_to_features_list (hidden_property_setting_features)
			add_to_features_list (hidden_events_features)

			if misc_features /= Void then
				add_to_features_list (misc_features)
			end
		end

	initialize_property_or_event (a_entity: CONSUMED_ENTITY) is
			-- Initialize 'a_entity' for inclusion in corresponding entity list.
		require
			entity_not_void: a_entity /= Void
			entity_valid: a_entity.is_property_or_event
		local
			l_property: CONSUMED_PROPERTY
			l_event: CONSUMED_EVENT
		do
			if a_entity.is_property then
				l_property ?= a_entity
				if l_property /= Void then
					if l_property.is_public then
						if l_property.setter /= Void then
							property_setting_features.extend (l_property.setter)
						end
						if l_property.getter /= Void then
							property_features.extend (l_property.getter)
						end
					else
						if l_property.setter /= Void then
							hidden_property_setting_features.extend (l_property.setter)
						end
						if l_property.getter /= Void then
							hidden_property_features.extend (l_property.getter)
						end
					end
				end
			elseif a_entity.is_event then
				l_event ?= a_entity
				if l_event /= Void then
					if l_event.is_public then
						if l_event.adder /= Void then
							events_features.extend (l_event.adder)
						end
						if l_event.remover /= Void then
							events_features.extend (l_event.remover)
						end
						if l_event.raiser /= Void then
							events_features.extend (l_event.raiser)
						end
					else
						if l_event.adder /= Void then
							hidden_events_features.extend (l_event.adder)
						end
						if l_event.remover /= Void then
							hidden_events_features.extend (l_event.remover)
						end
						if l_event.raiser /= Void then
							hidden_events_features.extend (l_event.raiser)
						end
					end
				end
			end
		end

	set_constructors (a_consumed: CONSUMED_TYPE) is
			-- Set all constrcutor for the .NET class.
		require
			a_consumed_not_void: a_consumed /= Void
		local
			i, nb: INTEGER
			l_constructors: ARRAY [CONSUMED_CONSTRUCTOR]
		do
			l_constructors := a_consumed.constructors
			if l_constructors = Void or else l_constructors.is_empty then
				create constructors.make (0)
			else
				from
					i := 1
					nb := l_constructors.count
					create constructors.make (nb)
				until
					i > nb
				loop
					constructors.extend (l_constructors.item (i))
					i := i + 1
				end
				loop_counter := i
			end
		ensure
			constructors_set: constructors /= Void
		end

	set_ancestors (a_consumed: CONSUMED_TYPE) is
			-- Set all ancestors for the .NET class.
		require
			a_consumed_not_void: a_consumed /= Void
		local
			l_c_parent: CONSUMED_REFERENCED_TYPE
			l_interfaces: ARRAY [CONSUMED_REFERENCED_TYPE]
			i, nb: INTEGER
		do
			l_interfaces := a_consumed.interfaces
			if l_interfaces = Void or else l_interfaces.is_empty then
				if a_consumed.parent /= Void then
					create ancestors.make (1)
					ancestors.extend (a_consumed.parent)
				else
					create ancestors.make (0)
				end
			else
				nb := a_consumed.interfaces.count
				if a_consumed.parent /= Void then
					create ancestors.make (nb + 1)
					ancestors.extend (a_consumed.parent)
				else
					create ancestors.make (nb)
				end
				from
					i := 1
				until
					i > nb
				loop
					l_c_parent := l_interfaces.item (i)
					if l_c_parent /= Void then
						ancestors.extend (l_c_parent)
					end
					i := i + 1
				end
				loop_counter := i
			end
		ensure
			ancestors_set: ancestors /= Void
		end

feature {NONE} -- Access

	consumed_type: CONSUMED_TYPE
			-- .NET consumed type to which current context is applied.

	class_c: CLASS_C
			-- The Eiffel compiled class denoting 'consumed_type.

	class_i: EXTERNAL_CLASS_I
			-- The Eiffel non-compiled class if is not compiled in system.

	dotnet_name: STRING
			-- Full .NET name.

	is_expanded: BOOLEAN
			-- Is Current expanded?

	is_deferred: BOOLEAN
			-- Is Current deferred?

	is_frozen: BOOLEAN
			-- Is Current frozen?

	is_current_class_only: BOOLEAN
			-- Is Current format for the current class only (i.e no inheritance)?

feature -- Status Setting

	set_current_class_only (a_flag: BOOLEAN) is
			-- Set format type to include inherited features.
		do
			is_current_class_only := a_flag
		ensure
			is_current_class_only_set: is_current_class_only = a_flag
		end

feature -- Formatting

	format (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Perform formatting of current using `a_ctxt'.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			a_ctxt.process_filter_item (f_class_declaration, true)
			format_indexes (a_ctxt)
			format_header (a_ctxt)
			format_ancestors (a_ctxt)
			format_constructors (a_ctxt)
			format_features (a_ctxt)
			format_footer (a_ctxt)
		end

feature {NONE} -- Formatting

	format_indexes (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format indexes, i.e. class description.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			l_member_info: MEMBER_INFORMATION
			l_summary: LIST [STRING]
		do
			l_member_info := a_ctxt.assembly_info.find_type (a_ctxt.assembly_name, dotnet_name)
			a_ctxt.process_filter_item (f_indexing, true)
			a_ctxt.process_keyword_text (ti_Indexing_keyword, Void)
			a_ctxt.indent
			a_ctxt.put_new_line
			a_ctxt.set_separator (Void)
			a_ctxt.set_new_line_between_tokens
				-- Full .NET name.
			a_ctxt.add ("description: ")
			a_ctxt.put_string_item ("%"")
			a_ctxt.put_string_item (dotnet_name)
			a_ctxt.put_string_item ("%"")
			a_ctxt.put_new_line

				-- Description of type.
			if l_member_info /= Void then
				a_ctxt.add ("summary: ")
				a_ctxt.put_string_item ("%"")
				l_summary := a_ctxt.parse_summary (l_member_info.summary)
				from
					l_summary.start
				until
					l_summary.after
				loop
					a_ctxt.put_string_item (l_summary.item)
					l_summary.forth
					if l_summary.after then
						a_ctxt.put_string_item ("%"")
						a_ctxt.put_new_line
					else
						a_ctxt.put_new_line
					end
				end
			end

			a_ctxt.process_filter_item (f_indexing, false)
			a_ctxt.exdent
			a_ctxt.put_new_line
		end

	format_header (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format header, ie classname and generics.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			a_ctxt.process_filter_item (f_class_header, true)
			if is_expanded then
				a_ctxt.process_keyword_text (Ti_expanded_keyword, Void)
				a_ctxt.put_space
			end
			if is_deferred then
				a_ctxt.process_keyword_text (Ti_deferred_keyword, Void)
				a_ctxt.put_space
			elseif is_frozen then
				a_ctxt.process_keyword_text (Ti_frozen_keyword, Void)
				a_ctxt.put_space
			end
			a_ctxt.process_keyword_text (ti_Class_keyword, Void)
			a_ctxt.put_space
			a_ctxt.process_keyword_text (ti_Interface_keyword, Void)
			a_ctxt.indent
			a_ctxt.put_new_line
			a_ctxt.put_classi (a_ctxt.class_i)
			format_generics (a_ctxt)
			a_ctxt.process_filter_item (f_class_header, false)
			a_ctxt.exdent
			a_ctxt.put_new_line
		end

	format_footer (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format footer, ie classname and end keyword.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			a_ctxt.put_new_line
			a_ctxt.process_filter_item (f_class_end, true)
			a_ctxt.process_keyword_text (ti_End_keyword, Void)
			a_ctxt.process_comment_text (" -- ", Void)
			a_ctxt.process_comment_text ("class", Void)
			a_ctxt.put_space
			a_ctxt.put_comment_text (a_ctxt.class_i.name)
			a_ctxt.process_filter_item (f_class_end, false)
			a_ctxt.put_new_line
		end

	format_ancestors (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format class ancestors, if short.
		require
			a_ctxt_not_void: a_ctxt /= Void
		do
			if ancestors /= Void and not ancestors.is_empty then
				a_ctxt.process_filter_item (f_inheritance, true)
				a_ctxt.put_new_line
				a_ctxt.process_keyword_text (Ti_inherit_keyword, Void)
				a_ctxt.put_new_line
				a_ctxt.indent
				from
					ancestors.start
				until
					ancestors.after
				loop
					a_ctxt.put_classi (a_ctxt.class_i.type_from_consumed_type (ancestors.item))
					a_ctxt.put_new_line
					ancestors.forth
				end
				a_ctxt.exdent
			end
		end

	format_generics (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format class formal generic parameters, if any.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			generics: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			if
				a_ctxt.class_i.compiled_class /= Void and
				a_ctxt.class_i.compiled_class.generics /= Void
			then
				generics := a_ctxt.class_i.compiled_class.generics
				a_ctxt.format_ast (generics)
			end
		end

	format_constructors (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format constructors.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			f_constructor: CONSUMED_CONSTRUCTOR
		do
			if not constructors.is_empty then
				a_ctxt.process_filter_item (f_creators, true)
				a_ctxt.put_new_line
				a_ctxt.process_keyword_text (Ti_create_keyword, Void)
				a_ctxt.put_new_line
				--a_ctxt.put_new_line
				from
					constructors.start
				until
					constructors.after
				loop
					f_constructor := constructors.item
					a_ctxt.set_separator (ti_comma)
					a_ctxt.indent
					a_ctxt.format_feature (a_ctxt, f_constructor)
					a_ctxt.exdent
					a_ctxt.put_new_line
					constructors.forth
				end
			end
			a_ctxt.process_filter_item (f_creators, false)
		end

	format_features (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR) is
			-- Format all features.
		require
			a_ctxt_not_void: a_ctxt /= Void
		local
			a_category_list: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]
		do
			from
				features.start
			until
				features.after
			loop
				a_category_list := features.item
				if
					a_category_list /= Void and then
					not a_category_list.is_empty and then
					should_display (a_category_list)
				then
					format_feature_header (a_ctxt, a_category_list)
					from
						a_category_list.start
					until
						a_category_list.after
					loop
						a_ctxt.format_feature (a_ctxt, a_category_list.item)
						a_category_list.forth
					end
				end
				features.forth
			end
		end

	format_feature_header (a_ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR; a_header: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]) is
			-- Format feature with category 'a_header'.
		require
			a_ctxt_not_void: a_ctxt /= Void
			has_a_header: a_header /= Void
		do
			a_ctxt.put_new_line
			a_ctxt.process_keyword_text (Ti_feature_keyword, Void)
			a_ctxt.put_space
			if not a_header.is_exported then
				a_ctxt.process_symbol_text (ti_l_curly)
				a_ctxt.add (ti_none_class)
				a_ctxt.process_symbol_text (ti_r_curly)
				a_ctxt.put_space
			end
			a_ctxt.process_comment_text (ti_dashdash, Void)
			a_ctxt.put_space
			a_ctxt.put_comment_text (a_header.name)
			a_ctxt.put_new_line
		end

feature {NONE} -- Implementation

	should_display (a_list: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]): BOOLEAN is
			-- Should any of the items in 'a_list' be displayed in current context?
		do
			if is_current_class_only then
				from
					a_list.start
				until
					a_list.after or Result
				loop
					Result := a_list.item.declared_type.name.is_equal (consumed_type.dotnet_name)
					a_list.forth
				end
			else
				Result := True
			end
		end

	should_add (a_entity: CONSUMED_ENTITY): BOOLEAN is
			-- Should 'a_entity' be added to the features?
		require
			a_entity_not_void: a_entity /= Void
		do
			if is_current_class_only then
				Result := a_entity.declared_type.name.is_equal (consumed_type.dotnet_name)
			else
				Result := True
			end
		end

	add_to_features_list (a_list: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]) is
			-- Add 'a_list' to list of known features.
		require
			a_list_not_void: a_list /= Void
		do
			if not a_list.is_empty then
				features.extend (a_list)
			end
		end

	entities: ARRAY [CONSUMED_ENTITY]
			-- All field, procedure and function implemented/inherited.

	constructors: ARRAYED_LIST [CONSUMED_CONSTRUCTOR]
			-- Class constructors.

	ancestors: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			-- Class ancestors.

	features: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
			-- Class features by category.

	property_setting_features, hidden_property_setting_features,
	property_features, hidden_property_features,
	events_features, hidden_events_features: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]
			-- Property and event feature lists.

	loop_counter: INTEGER
			-- Reusable loop counter

	ctxt: DOTNET_CLASS_TEXT_FORMATTER_DECORATOR
			-- Associated class context.

invariant
	dotnet_name_not_void: dotnet_name /= Void
	constructors_not_void: constructors /= Void
	entities_not_void: entities /= Void
	ancestors_not_void: ancestors /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DOTNET_CLASS_AS
