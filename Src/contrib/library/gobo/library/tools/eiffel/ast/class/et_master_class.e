note

	description:
	"[
		Eiffel master classes. A master class not only gives access to
		the class with a given name that will be taken into account
		from a given universe (using its query 'actual_class') but also
		to other classes with the same name in the universe that are not
		taken into account because of the name clash.

		Note that there is at most one such object per class name in a given universe.
		For incrementality purposes, we should only keep reference to objects of
		type ET_MASTER_CLASS and not directly to objects of type ET_CLASS. Otherwise
		we will get corrupted information when classes are moved from one library to
		another for example. We can still get access to the actual class object with
		the given name when viewed from the surrounding universe using `actual_class'.
	]"
	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_MASTER_CLASS

inherit

	ET_NAMED_CLASS
		redefine
			name,
			intrinsic_class,
			actual_intrinsic_class,
			unignorable_actual_class,
			set_marked
		end

	ET_CLASS_TYPE
		rename
			make as make_type,
			actual_parameters as formal_parameters
		undefine
			upper_name, lower_name
		redefine
			name, process,
			formal_parameters,
			append_to_string,
			debug_output,
			append_unaliased_to_string,
			is_named_type,
			is_valid_context
		end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	ET_IMPORTED_AGENT_ROUTINES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_name: like name; a_universe: like universe)
			-- Create a new adpated class named `a_name' in `a_universe'.
		require
			a_name_not_void: a_name /= Void
			a_universe_not_void: a_universe /= Void
		do
			name := a_name
			universe := a_universe
			named_base_class := Current
			other_local_override_classes := tokens.empty_classes
			other_local_non_override_classes := tokens.empty_classes
			other_local_ignored_classes := tokens.empty_classes
			other_imported_classes := tokens.empty_master_classes
			other_overriding_classes := tokens.empty_master_classes
			intrinsic_class := tokens.unknown_class
		ensure
			name_set: name = a_name
			universe_set: universe = a_universe
		end

feature -- Access

	name: ET_CLASS_NAME
			-- Name of class

	actual_class: ET_CLASS
			-- Actual class
		do
			if mapped_class /= Void then
				Result := mapped_class.actual_class
			elseif first_overriding_class /= Void then
				Result := first_overriding_class.actual_class
			else
				Result := intrinsic_class.actual_class
			end
		end

	unignorable_actual_class: ET_CLASS
			-- Actual class, not taking into account the
			-- ignored status of classes
		do
			if mapped_class /= Void then
				Result := mapped_class.unignorable_actual_class
			elseif first_overriding_class /= Void then
				Result := first_overriding_class.unignorable_actual_class
			elseif first_local_override_class /= Void then
				Result := first_local_override_class
			elseif first_local_ignored_class /= Void and then (first_local_ignored_class.is_in_override_group or first_local_non_override_class = Void) then
				Result := first_local_ignored_class
			else
				Result := intrinsic_class.unignorable_actual_class
			end
		end

	actual_intrinsic_class: ET_CLASS
			-- Actual class, not taking into account (recursively) the
			-- fact that a class may be overridden by classes declared
			-- in override groups of other universes
		do
			if mapped_class /= Void then
				Result := mapped_class.actual_intrinsic_class
			else
				Result := intrinsic_class.actual_intrinsic_class
			end
		end

	intrinsic_class: ET_NAMED_CLASS
			-- Class being used, taking into account only non-ignored classes
			-- declared locally in `universe' or imported from universes it depends
			-- on, but not taking into account overriding classes from other
			-- universes
			--
			-- If the class named `name' is declared locally in `universe',
			-- then it will be of type ET_CLASS. If it's imported from another
			-- universe then it will be of type ET_MASTER_CLASS. So we need
			-- to use `actual_class' to have access to the actual class object.
			--
			-- In case of conflict, `intrinsic_class' will be one of the override
			-- classes declared locally in `universe'. If no such classes,
			-- then it will be one of the other classes declared locally in
			-- `universe'. If no such classes, then it will be one of the
			-- classes imported from other universes. If no such classes, then
			-- it will be the unknown class.

	first_local_class: ET_CLASS
			-- First class, if any, declared in an override group of `universe';
			-- If no such class, then first class, if any, declared in a non-override
			-- group of `universe'; If no such class, then first class, if any,
			-- declared in a group of `universe' which has been explicitly ignored
		do
			Result := first_local_override_class
			if Result = Void then
				Result := first_local_non_override_class
			end
			if Result = Void then
				Result := first_local_ignored_class
			end
		ensure
			definition_if_override: first_local_override_class /= Void implies Result = first_local_override_class
			definition_if_not_override: (first_local_override_class = Void and first_local_non_override_class /= Void) implies Result = first_local_non_override_class
			definition_if_ignored: (first_local_override_class = Void and first_local_non_override_class = Void) implies Result = first_local_ignored_class
		end

	first_local_override_class: ET_CLASS
			-- First class, if any, declared in an override group of `universe'
			--
			-- If more than one such class, the other classes are stored in
			-- `other_local_override_classes'.

	other_local_override_classes: DS_ARRAYED_LIST [ET_CLASS]
			-- Other classes, if any, declared in an override group of `universe'
			--
			-- The first such class, if any, is stored in `first_local_override_class'.

	first_local_non_override_class: ET_CLASS
			-- First class, if any, declared in a non-override group of `universe'
			--
			-- If more than one such class, the other classes are stored in
			-- `other_local_non_override_classes'.

	other_local_non_override_classes: DS_ARRAYED_LIST [ET_CLASS]
			-- Other classes, if any, declared in a non-override group of `universe'
			--
			-- The first such class, if any, is stored in `first_local_non_override_class'.

	first_local_ignored_class: ET_CLASS
			-- First class, if any, declared in a group of `universe', which has been explicitly ignored
			--
			-- If more than one such class, the other classes are stored in
			-- `other_local_ignored_classes'.

	other_local_ignored_classes: DS_ARRAYED_LIST [ET_CLASS]
			-- Other classes, if any, declared in a group of `universe', which has been explicitly ignored
			--
			-- The first such class, if any, is stored in `first_local_ignored_class'.

	first_imported_class: ET_MASTER_CLASS
			-- First class, if any, imported from a universe other than `universe'
			--
			-- If more than one such class, the other classes are stored in
			-- `other_imported_classes'.
			--
			-- Classes declared in a group of universes other than `universe'
			-- are not considered as override even if their groups are override
			-- groups. In other words classes lose their override status when
			-- imported from other universes. Therefore it is valid to override
			-- them in `universe' but they will not be able to override other
			-- classes in `universe'.

	other_imported_classes: DS_ARRAYED_LIST [ET_MASTER_CLASS]
			-- Other classes, if any, imported from universes other than `universe'
			--
			-- The first such class, if any, is stored in `first_imported_class'.

	first_overriding_class: ET_MASTER_CLASS
			-- First class, if any, in universes other than `universe' which
			-- overrides current class
			--
			-- If more than one such class, the other classes are stored in
			-- `other_overriding_classes'.
			--
			-- This is a class that is declared in an override group of a universe
			-- other than `universe' and which overrides current class in that other
			-- universe. Therefore if at some point there is no class named `name'
			-- in `universe', the class `first_overriding_class' will not be accessible
			-- from `universe' anymore even if it still exists in its respective
			-- universe.
			--
			-- Note that classes declared in override groups of `universe' appear
			-- either in `first_local_override_class' or `other_local_override_classes'.
			-- Not in `first_overriding_class' or `other_overriding_classes'.
			--
			-- In order to know in which universe an overriding class 'c' overrides
			-- current class, just query 'c.universe'. According to the explanation
			-- above, we have 'c.universe /= universe'. Also note that current class
			-- will be listed in 'c.first_imported_class' or 'c.other_imported_classes'.

	other_overriding_classes: DS_ARRAYED_LIST [ET_MASTER_CLASS]
			-- Other classes, if any, in universes other than `universe' which override
			-- current class
			--
			-- The first such class, if any, is stored in `first_overriding_class'.
			--
			-- It is not valid to have more than one class in universes other than
			-- `universe' which override current class. Indeed, we would have no way
			-- to decide which class to use if current class was overridden by two
			-- different classes. If such case occurs (i.e. `other_overriding_class'
			-- contains at least one class), a validity error is reported and
			-- `first_overriding_class' will be used by default.

	mapped_class: ET_MASTER_CLASS
			-- Class that is also known under the name `name' in `universe'.
			-- For example class "CHARACTER_8" is also known under the name "CHARACTER"
			-- when "CHARACTER" is mapped to "CHARACTER_8".

	classes_in_group (a_group: ET_GROUP): DS_ARRAYED_LIST [ET_CLASS]
			-- Classes among local (ignored or not), imported and overriding classes
			-- that are declared in `a_group'
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (1)
			if a_group.is_override then
				if a_group.universe = universe then
					local_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group (a_group))
				else
					overriding_classes_do_if (agent {ET_MASTER_CLASS}.local_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group (a_group)), agent {ET_MASTER_CLASS}.is_in_universe (a_group.universe))
				end
			else
				if a_group.universe = universe then
					local_non_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group (a_group))
				else
					imported_classes_do_if (agent {ET_MASTER_CLASS}.local_non_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group (a_group)), agent {ET_MASTER_CLASS}.is_in_universe (a_group.universe))
				end
			end
			local_ignored_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group (a_group))
		ensure
			in_group: Result.for_all (agent {ET_CLASS}.is_in_group (a_group))
		end

	classes_in_group_recursive (a_group: ET_GROUP): DS_ARRAYED_LIST [ET_CLASS]
			-- Classes among local (ignored or not), imported and overriding classes
			-- that are declared in `a_group' or recursively in one of its subgroups
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (1)
			if a_group.is_override then
				if a_group.universe = universe then
					local_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group_recursive (a_group))
				else
					overriding_classes_do_if (agent {ET_MASTER_CLASS}.local_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group_recursive (a_group)), agent {ET_MASTER_CLASS}.is_in_universe (a_group.universe))
				end
			else
				if a_group.universe = universe then
					local_non_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group_recursive (a_group))
				else
					imported_classes_do_if (agent {ET_MASTER_CLASS}.local_non_override_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group_recursive (a_group)), agent {ET_MASTER_CLASS}.is_in_universe (a_group.universe))
				end
			end
			local_ignored_classes_do_if (agent Result.force_last, agent {ET_CLASS}.is_in_group_recursive (a_group))
		ensure
			in_group: Result.for_all (agent {ET_CLASS}.is_in_group_recursive (a_group))
		end

	universe: ET_UNIVERSE
			-- Universe to which current class belongs

	formal_parameters: ET_FORMAL_PARAMETER_LIST
			-- Formal generic parameters
		do
			Result := actual_class.formal_parameters
		end

	first_non_override_overridden_class: ET_CLASS
			-- First class other than `actual_class' that is not in an override group;
			-- Void if no such class
		local
			l_actual_class: ET_CLASS
			l_class: ET_CLASS
		do
			l_actual_class := actual_class
			l_class := first_local_non_override_class
			if l_class /= Void and l_class /= l_actual_class then
				Result := l_class
			elseif not other_local_non_override_classes.is_empty then
				Result := other_local_non_override_classes.first
			elseif attached first_imported_class as l_imported_class then
				Result := l_imported_class.first_local_non_override_class
			end
		end

	first_unignorable_non_override_overridden_class: ET_CLASS
			-- First class other than `unignorable_actual_class' that is not in an override group;
			-- Void if no such class
			--
			-- Note that this routine does not take into account the ignored status of classes.
		local
			l_imported_class: ET_MASTER_CLASS
			l_class: ET_CLASS
			l_other_classes: DS_ARRAYED_LIST [ET_CLASS]
			i, nb: INTEGER
			l_actual_class: ET_CLASS
		do
			l_actual_class := unignorable_actual_class
			l_class := first_local_non_override_class
			if l_class /= Void and l_class /= l_actual_class then
				Result := l_class
			elseif not other_local_non_override_classes.is_empty then
				Result := other_local_non_override_classes.first
			else
				l_class := first_local_ignored_class
				if l_class /= Void and l_class /= l_actual_class and not l_class.is_in_override_group then
					Result := l_class
				else
					l_other_classes := other_local_ignored_classes
					nb := l_other_classes.count
					from i := 1 until i > nb loop
						l_class := l_other_classes.item (i)
						if l_class /= l_actual_class and not l_class.is_in_override_group then
							Result := l_class
							i := nb + 1
						end
						i := i + 1
					end
				end
				if Result = Void then
					l_imported_class := first_imported_class
					if l_imported_class /= Void then
						Result := l_imported_class.first_local_non_override_class
					end
				end
			end
		end

feature -- Status report

	is_override (a_universe: ET_UNIVERSE): BOOLEAN
			-- Is current class considered as an override class in `a_universe'?
			-- This means that current class has been declared in an override
			-- group and that group is part of `a_universe'.
		do
			if universe = a_universe then
				Result := intrinsic_class.is_override (a_universe)
			end
		end

	is_modified: BOOLEAN
			-- Is current class referring to a different Eiffel class?
			--
			-- It could be because the class has been removed, or it
			-- has been moved to a different universe. This is also
			-- the case if it is newly overridden, not overridden any
			-- more, or its overriding class is not the same.

	is_declared_locally: BOOLEAN
			-- Has `intrinsic_class' been declared in `universe'?
		do
			Result := intrinsic_class.universe = universe
		ensure
			definition: Result = (intrinsic_class.universe = universe)
		end

	is_mapped: BOOLEAN
			-- Is current class the mapping of another class in `universe'?
			-- For example class "CHARACTER" can actually be mapped to "CHARACTER_8".
		do
			Result := mapped_class /= Void
		ensure
			definition: Result = (mapped_class /= Void)
		end

	is_in_universe (a_universe: ET_UNIVERSE): BOOLEAN
			-- Does current class belong to `a_universe'?
		require
			a_universe_not_void: a_universe /= Void
		do
			Result := (universe = a_universe)
		ensure
			definition: Result = (universe = a_universe)
		end

	has_name_clash: BOOLEAN
			-- Is there two intrinsic classes with the same name?
			-- Ignored classes are not taken into account.
			-- Intrinsic classes means that classes in universes other than `universe'
			-- which overrides current class are not taken into account.
			--
			-- Note that some name clashes may be valid when a class is declared
			-- in an override group and the other is not.
		local
			nb: INTEGER
		do
			if mapped_class /= Void then
				nb := nb + 1
			end
			if first_local_override_class /= Void then
				nb := nb + 1
			end
			if other_local_override_classes /= Void then
				nb := nb + other_local_override_classes.count
			end
			if first_local_non_override_class /= Void then
				nb := nb + 1
			end
			if other_local_non_override_classes /= Void then
				nb := nb + other_local_non_override_classes.count
			end
			if first_imported_class /= Void then
				nb := nb + 1
			end
			if other_imported_classes /= Void then
				nb := nb + other_imported_classes.count
			end
			Result := (nb >= 2)
		end

	has_unignorable_name_clash: BOOLEAN
			-- Is there two intrinsic classes with the same name?
			-- Ignored classes are taken into account.
			-- Intrinsic classes means that classes in universes other than `universe'
			-- which overrides current class are not taken into account.
			--
			-- Note that some name clashes may be valid when a class is declared
			-- in an override group and the other is not.
		local
			nb: INTEGER
		do
			if mapped_class /= Void then
				nb := nb + 1
			end
			if first_local_override_class /= Void then
				nb := nb + 1
			end
			if other_local_override_classes /= Void then
				nb := nb + other_local_override_classes.count
			end
			if first_local_non_override_class /= Void then
				nb := nb + 1
			end
			if other_local_non_override_classes /= Void then
				nb := nb + other_local_non_override_classes.count
			end
			if first_local_ignored_class /= Void then
				nb := nb + 1
			end
			if other_local_ignored_classes /= Void then
				nb := nb + other_local_ignored_classes.count
			end
			if first_imported_class /= Void then
				nb := nb + 1
			end
			if other_imported_classes /= Void then
				nb := nb + other_imported_classes.count
			end
			Result := (nb >= 2)
		end

	has_invalid_name_clash: BOOLEAN
			-- Is there two intrinsic classes with the same name resulting
			-- in an invalid name clash?
			-- Ignored classes are not taken into account.
			-- Intrinsic classes means that classes in universes other than `universe'
			-- which overrides current class are not taken into account.
			--
			-- Note that some name clashes may be valid when a class is declared
			-- in an override group and the other is not.
		local
			nb: INTEGER
		do
			if mapped_class /= Void then
				Result := has_name_clash
			elseif first_local_override_class /= Void then
				Result := other_local_override_classes /= Void and then not other_local_override_classes.is_empty
			else
				if first_local_non_override_class /= Void then
					nb := nb + 1
				end
				if other_local_non_override_classes /= Void then
					nb := nb + other_local_non_override_classes.count
				end
				if first_imported_class /= Void then
					nb := nb + 1
				end
				if other_imported_classes /= Void then
					nb := nb + other_imported_classes.count
				end
				Result := (nb >= 2)
			end
		end

	has_local_class (a_class: ET_CLASS): BOOLEAN
			-- Is `a_class' one of the classes that have been declared in a group of `universe'?
			-- This means that `a_class' is one of the classes in `first_local_override_class',
			-- `other_local_override_classes', `first_local_non_override_class',
			-- `other_local_non_override_classes', `first_local_ignored_class'
			-- or `other_local_ignored_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			Result := has_local_override_class (a_class) or else has_local_non_override_class (a_class) or else has_local_ignored_class (a_class)
		ensure
			definition: Result = (has_local_override_class (a_class) or has_local_non_override_class (a_class) or has_local_ignored_class (a_class))
		end

	has_local_override_class (a_class: ET_CLASS): BOOLEAN
			-- Is `a_class' one of the classes that have been declared in an override group of `universe'?
			-- This means that `a_class' is one of the classes in `first_local_override_class'
			-- or `other_local_override_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_override_class = a_class then
				Result := True
			elseif other_local_override_classes /= Void then
				Result := other_local_override_classes.has (a_class)
			end
		end

	has_local_non_override_class (a_class: ET_CLASS): BOOLEAN
			-- Is `a_class' one of the classes that have been declared in a non-override group of `universe'?
			-- This means that `a_class' is one of the classes in `first_local_non_override_class'
			-- or `other_local_non_override_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_non_override_class = a_class then
				Result := True
			elseif other_local_non_override_classes /= Void then
				Result := other_local_non_override_classes.has (a_class)
			end
		end

	has_local_ignored_class (a_class: ET_CLASS): BOOLEAN
			-- Is `a_class' one of the ignored classes that have been declared in a  group of `universe'?
			-- This means that `a_class' is one of the classes in `first_local_ignored_class'
			-- or `other_local_ignored_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_ignored_class = a_class then
				Result := True
			elseif other_local_ignored_classes /= Void then
				Result := other_local_ignored_classes.has (a_class)
			end
		end

	has_imported_class (a_class: ET_MASTER_CLASS): BOOLEAN
			-- Is `a_class' one of the classes that have been imported from a universe other than `universe'?
			-- This means that `a_class' is one of the classes in `first_imported_class'
			-- or `other_imported_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			if first_imported_class = a_class then
				Result := True
			elseif other_imported_classes /= Void then
				Result := other_imported_classes.has (a_class)
			end
		end

	has_overriding_class (a_class: ET_MASTER_CLASS): BOOLEAN
			-- Is `a_class' one of the classes that have been declared in universes
			-- other than `universe' and which override current class?
			-- This means that `a_class' is one of the classes in `first_overriding_class'
			-- or `other_overriding_classes'?
		require
			a_class_not_void: a_class /= Void
		do
			if first_overriding_class = a_class then
				Result := True
			elseif other_overriding_classes /= Void then
				Result := other_overriding_classes.has (a_class)
			end
		end

	is_named_type: BOOLEAN = True
			-- Is current type only made up of named types?

feature -- Status setting

	set_modified (b: BOOLEAN)
			-- Set `is_modified' to `b'.
		do
			is_modified := b
		ensure
			modified_set: is_modified = b
		end

feature -- Preparsing status

	is_preparsed: BOOLEAN
			-- Has current class been preparsed (i.e. its group is already
			-- known but the class has not necessarily been parsed yet)?
		do
			Result := actual_class.is_preparsed
		end

feature -- Parsing status

	is_parsed: BOOLEAN
			-- Has current class been parsed?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.is_parsed
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.is_parsed
				else
					Result := intrinsic_class.is_parsed
				end
			end
		end

	has_syntax_error: BOOLEAN
			-- Has a fatal syntax error been detected?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.has_syntax_error
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.has_syntax_error
				else
					Result := intrinsic_class.has_syntax_error
				end
			end
		end

feature -- Ancestor building status

	ancestors_built: BOOLEAN
			-- Have `ancestors' been built?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.ancestors_built
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.ancestors_built
				else
					Result := intrinsic_class.ancestors_built
				end
			end
		end

	has_ancestors_error: BOOLEAN
			-- Has a fatal error occurred when building `ancestors'?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.has_ancestors_error
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.has_ancestors_error
				else
					Result := intrinsic_class.has_ancestors_error
				end
			end
		end

feature -- Feature flattening status

	features_flattened: BOOLEAN
			-- Have features been flattened?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.features_flattened
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.features_flattened
				else
					Result := intrinsic_class.features_flattened
				end
			end
		end

	has_flattening_error: BOOLEAN
			-- Has a fatal error occurred during feature flattening?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.has_flattening_error
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.has_flattening_error
				else
					Result := intrinsic_class.has_flattening_error
				end
			end
		end

feature -- Interface checking status

	interface_checked: BOOLEAN
			-- Has the interface of current class been checked?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.interface_checked
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.interface_checked
				else
					Result := intrinsic_class.interface_checked
				end
			end
		end

	has_interface_error: BOOLEAN
			-- Has a fatal error occurred during interface checking?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.has_interface_error
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.has_interface_error
				else
					Result := intrinsic_class.has_interface_error
				end
			end
		end

feature -- Implementation checking status

	implementation_checked: BOOLEAN
			-- Has the implementation of current class been checked?
			-- Immediate and redefined (and possibly inherited when in flat mode)
			-- features and invariant have been checked.
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.implementation_checked
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.implementation_checked
				else
					Result := intrinsic_class.implementation_checked
				end
			end
		end

	has_implementation_error: BOOLEAN
			-- Has a fatal error occurred during implementation checking?
		do
			if not is_modified then
				if mapped_class /= Void then
					Result := mapped_class.has_implementation_error
				elseif first_overriding_class /= Void then
					Result := first_overriding_class.has_implementation_error
				else
					Result := intrinsic_class.has_implementation_error
				end
			end
		end

feature -- Element change

	add_first_local_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_ignored_class' if `a_class' is ignored,
			-- to `first_local_override_class' if `a_class' is in an override group,
			-- to `first_local_non_override_class' otherwise.
			-- If there was already such class, move it to `other_local_ignored_classes',
			-- `other_local_override_classes' or to `other_local_non_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_class' and `add_last_local_class'
			-- is that here we try to set `intrinsic_class' to `a_class' if possible.
			-- This will happen if `a_class' is in an override group or if there was no
			-- `first_local_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if a_class.is_ignored then
				add_first_local_ignored_class (a_class)
			elseif a_class.is_in_override_group then
				add_first_local_override_class (a_class)
			else
				add_first_local_non_override_class (a_class)
			end
		ensure
			a_class_added_first_if_ignored: a_class.is_ignored implies first_local_ignored_class = a_class
			a_class_added_first_if_override: (not a_class.is_ignored and a_class.is_in_override_group) implies first_local_override_class = a_class
			a_class_added_first_if_not_override: (not a_class.is_ignored and not a_class.is_in_override_group) implies first_local_non_override_class = a_class
		end

	add_last_local_class (a_class: ET_CLASS)
			-- If `a_class' is_ignored, then add it to `first_local_ignored_class' if no such class
			-- or to `other_local_ignored_classes' otherwise.
			-- Otherwise, if `a_class' is in an override group, then add it to `first_local_override_class'
			-- if no such class, or add it to `other_local_override_classes' otherwise.
			-- Otherwise if `a_class' is not in an override group, then add it to `first_local_non_override_class'
			-- if no such class, or add it to `other_local_non_override_classes' otherwise.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_class' and `add_last_local_class' is
			-- that here we try to avoid having to modify `intrinsic_class'. It will be modified,
			-- and hence set to `a_class', only if `a_class' is in an override group and there was
			-- no `first_local_override_class', or if there was no `first_local_override_class'
			-- and no `first_local_non_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if a_class.is_ignored then
				add_last_local_ignored_class (a_class)
			elseif a_class.is_in_override_group then
				add_last_local_override_class (a_class)
			else
				add_last_local_non_override_class (a_class)
			end
		ensure
			a_class_added_first_if_ignored: a_class.is_ignored implies ((old first_local_ignored_class = Void) implies (first_local_ignored_class = a_class))
			a_class_added_last_if_ignored: a_class.is_ignored implies ((old first_local_ignored_class /= Void) implies (not other_local_ignored_classes.is_empty and then other_local_ignored_classes.last = a_class))
			a_class_added_first_if_override: (not a_class.is_ignored and a_class.is_in_override_group) implies ((old first_local_override_class = Void) implies (first_local_override_class = a_class))
			a_class_added_last_if_override: (not a_class.is_ignored and a_class.is_in_override_group) implies ((old first_local_override_class /= Void) implies (not other_local_override_classes.is_empty and then other_local_override_classes.last = a_class))
			a_class_added_first_if_not_override: (not a_class.is_ignored and not a_class.is_in_override_group) implies ((old first_local_non_override_class = Void) implies (first_local_non_override_class = a_class))
			a_class_added_last_if_not_override: (not a_class.is_ignored and not a_class.is_in_override_group) implies ((old first_local_non_override_class /= Void) implies (not other_local_non_override_classes.is_empty and then other_local_non_override_classes.last = a_class))
		end

	add_first_local_override_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_override_class'. If there was
			-- already such class, move it to `other_local_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_override_class' and
			-- `add_last_local_override_class' is that here we are sure that
			-- `intrinsic_class' will be set to `a_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_override_class /= Void then
				if other_local_override_classes = tokens.empty_classes then
					create other_local_override_classes.make (2)
				end
				other_local_override_classes.force_first (first_local_override_class)
			end
			first_local_override_class := a_class
			update_intrinsic_class
		ensure
			a_class_added_first: first_local_override_class = a_class
		end

	add_last_local_override_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_override_class', if there was
			-- no such class, otherwise add it to `other_local_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_override_class' and
			-- `add_last_local_override_class' is that here we try to avoid
			-- having to modify `intrinsic_class'. It will be modified, and hence
			-- set to `a_class', only if there was no `first_local_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_override_class = Void then
				first_local_override_class := a_class
			else
				if other_local_override_classes = tokens.empty_classes then
					create other_local_override_classes.make (2)
				end
				other_local_override_classes.force_last (a_class)
			end
			update_intrinsic_class
		ensure
			a_class_added_first: (old first_local_override_class = Void) implies (first_local_override_class = a_class)
			a_class_added_last: (old first_local_override_class /= Void) implies (not other_local_override_classes.is_empty and then other_local_override_classes.last = a_class)
		end

	add_first_local_non_override_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_non_override_class'.
			-- If there was already such class, move it to `other_local_non_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_non_override_class' and
			-- `add_last_local_non_override_class' is that here we try to set
			-- `intrinsic_class' to `a_class' if possible. This will happen
			-- if there was no `first_local_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_non_override_class /= Void then
				if other_local_non_override_classes = tokens.empty_classes then
					create other_local_non_override_classes.make (2)
				end
				other_local_non_override_classes.force_first (first_local_non_override_class)
			end
			first_local_non_override_class := a_class
			update_intrinsic_class
		ensure
			a_class_added_first: first_local_non_override_class = a_class
		end

	add_last_local_non_override_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_non_override_class', if there was
			-- no such class, otherwise add it to `other_local_non_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_local_non_override_class' and
			-- `add_last_local_non_override_class' is that here we try to avoid
			-- having to modify `intrinsic_class'. It will be modified, and hence
			-- set to `a_class', only if there was no `first_local_override_class'
			-- and no `first_local_non_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_non_override_class = Void then
				first_local_non_override_class := a_class
			else
				if other_local_non_override_classes = tokens.empty_classes then
					create other_local_non_override_classes.make (2)
				end
				other_local_non_override_classes.force_last (a_class)
			end
			update_intrinsic_class
		ensure
			a_class_added_first: (old first_local_non_override_class = Void) implies (first_local_non_override_class = a_class)
			a_class_added_last: (old first_local_non_override_class /= Void) implies (not other_local_non_override_classes.is_empty and then other_local_non_override_classes.last = a_class)
		end

	add_first_local_ignored_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_ignored_class'.
			-- If there was already such class, move it to `other_local_ignored_classes'.
			-- Note that `intrinsic_class' and `is_modified' will not be affected.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_ignored_class /= Void then
				if other_local_ignored_classes = tokens.empty_classes then
					create other_local_ignored_classes.make (2)
				end
				other_local_ignored_classes.force_first (first_local_ignored_class)
			end
			first_local_ignored_class := a_class
		ensure
			a_class_added_first: first_local_ignored_class = a_class
		end

	add_last_local_ignored_class (a_class: ET_CLASS)
			-- Add `a_class' to `first_local_ignored_class', if there was
			-- no such class, otherwise add it to `other_local_ignored_classes'.
			-- Note that `intrinsic_class' and `is_modified' will not be affected.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_local_ignored_class = Void then
				first_local_ignored_class := a_class
			else
				if other_local_ignored_classes = tokens.empty_classes then
					create other_local_ignored_classes.make (2)
				end
				other_local_ignored_classes.force_last (a_class)
			end
		ensure
			a_class_added_first: (old first_local_ignored_class = Void) implies (first_local_ignored_class = a_class)
			a_class_added_last: (old first_local_ignored_class /= Void) implies (not other_local_ignored_classes.is_empty and then other_local_ignored_classes.last = a_class)
		end

	add_first_imported_class (a_class: ET_MASTER_CLASS)
			-- Add `a_class' to `first_imported_class'.
			-- If there was already such class, move it to `other_imported_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_imported_class' and
			-- `add_last_imported_class' is that here we try to set
			-- `intrinsic_class' to `a_class' if possible. This will happen
			-- if there was no `first_local_override_class' and no
			-- `first_local_non_override_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_imported_class /= Void then
				if other_imported_classes = tokens.empty_master_classes then
					create other_imported_classes.make (2)
				end
				other_imported_classes.force_first (first_imported_class)
			end
			first_imported_class := a_class
			if intrinsic_class.is_override (universe) then
				mark_overridden (a_class)
			end
			update_intrinsic_class
		ensure
			a_class_added_first: first_imported_class = a_class
		end

	add_last_imported_class (a_class: ET_MASTER_CLASS)
			-- Add `a_class' to `first_imported_class', if there was
			-- no such class, otherwise add it to `other_imported_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
			--
			-- The difference between `add_first_imported_class' and
			-- `add_last_imported_class' is that here we try to avoid
			-- having to modify `intrinsic_class'. It will be modified, and hence
			-- set to `a_class', only if there was no `first_local_override_class',
			-- no `first_local_non_override_class' and no `first_imported_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_imported_class = Void then
				first_imported_class := a_class
			else
				if other_imported_classes = tokens.empty_master_classes then
					create other_imported_classes.make (2)
				end
				other_imported_classes.force_last (a_class)
			end
			if intrinsic_class.is_override (universe) then
				mark_overridden (a_class)
			end
			update_intrinsic_class
		ensure
			a_class_added_first: (old first_imported_class = Void) implies (first_imported_class = a_class)
			a_class_added_last: (old first_imported_class /= Void) implies (not other_imported_classes.is_empty and then other_imported_classes.last = a_class)
		end

	add_first_overriding_class (a_class: ET_MASTER_CLASS)
			-- Add `a_class' to `first_overriding_class'.
			-- If there was already such class, move it to `other_overriding_classes'.
			-- Update `is_modified' accordingly.
			--
			-- The difference between `add_first_overriding_class' and
			-- `add_last_overriding_class' is that here we are sure that
			-- `actual_class' will be set to `a_class.actual_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_overriding_class /= Void then
				if other_overriding_classes = tokens.empty_master_classes then
					create other_overriding_classes.make (2)
				end
				other_overriding_classes.force_first (first_overriding_class)
			end
			first_overriding_class := a_class
			is_modified := True
			set_marked (is_marked)
		ensure
			a_class_added_first: first_overriding_class = a_class
		end

	add_last_overriding_class (a_class: ET_MASTER_CLASS)
			-- Add `a_class' to `first_overriding_class', if there was
			-- no such class, otherwise add it to `other_overriding_classes'.
			-- Update `is_modified' accordingly.
			--
			-- The difference between `add_first_overriding_class' and
			-- `add_last_overriding_class' is that here we try to avoid
			-- having to modify `actual_class'. It will be modified, and hence
			-- set to `a_class.actual_class', only if there was no
			-- `first_overriding_class'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if first_overriding_class = Void then
				first_overriding_class := a_class
				is_modified := True
				set_marked (is_marked)
			else
				if other_overriding_classes = tokens.empty_master_classes then
					create other_overriding_classes.make (2)
				end
				other_overriding_classes.force_last (a_class)
			end
		ensure
			a_class_added_first: (old first_overriding_class = Void) implies (first_overriding_class = a_class)
			a_class_added_last: (old first_overriding_class /= Void) implies (not other_overriding_classes.is_empty and then other_overriding_classes.last = a_class)
		end

	remove_local_class (a_class: ET_CLASS)
			-- Remove `a_class' from `first_local_override_class', `other_local_override_classes',
			-- `first_local_non_override_class', `other_local_non_override_classes'.
			-- `first_local_ignored_class' and `other_local_ignored_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
		require
			a_class_not_void: a_class /= Void
		do
			remove_local_override_class (a_class)
			remove_local_non_override_class (a_class)
			remove_local_ignored_class (a_class)
		ensure
			a_class_removed: not has_local_class (a_class)
		end

	remove_local_override_class (a_class: ET_CLASS)
			-- Remove `a_class' from `first_local_override_class' and `other_local_override_classes'.
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_override_class = a_class then
				other_local_override_classes.delete (a_class)
				if not other_local_override_classes.is_empty then
					first_local_override_class := other_local_override_classes.first
					other_local_override_classes.remove_first
				else
					first_local_override_class := Void
				end
				update_intrinsic_class
			else
				other_local_override_classes.delete (a_class)
			end
		ensure
			a_class_removed: not has_local_override_class (a_class)
		end

	remove_local_non_override_class (a_class: ET_CLASS)
			-- Remove `a_class' from `first_local_non_override_class' and `other_local_non_override_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_non_override_class = a_class then
				other_local_non_override_classes.delete (a_class)
				if not other_local_non_override_classes.is_empty then
					first_local_non_override_class := other_local_non_override_classes.first
					other_local_non_override_classes.remove_first
				else
					first_local_non_override_class := Void
				end
				update_intrinsic_class
			else
				other_local_non_override_classes.delete (a_class)
			end
		ensure
			a_class_removed: not has_local_non_override_class (a_class)
		end

	remove_local_ignored_class (a_class: ET_CLASS)
			-- Remove `a_class' from `first_local_ignored_class' and `other_local_ignored_classes'.
			-- Note that `intrinsic_class' and `is_modified' will not be affected.
		require
			a_class_not_void: a_class /= Void
		do
			if first_local_ignored_class = a_class then
				other_local_ignored_classes.delete (a_class)
				if not other_local_ignored_classes.is_empty then
					first_local_ignored_class := other_local_ignored_classes.first
					other_local_ignored_classes.remove_first
				else
					first_local_ignored_class := Void
				end
			else
				other_local_ignored_classes.delete (a_class)
			end
		ensure
			a_class_removed: not has_local_ignored_class (a_class)
		end

	remove_unknown_local_classes
			-- Remove classes from `first_local_override_class', `other_local_override_classes',
			-- `first_local_non_override_class', `other_local_non_override_classes',
			-- `first_local_ignored_class' and `other_local_ignored_classes',
			-- that do not exist anymore in `universe' (i.e. they are marked as 'is_unknown').
			-- Update `intrinsic_class' and `is_modified' accordingly.
		local
			l_other_classes: DS_ARRAYED_LIST [ET_CLASS]
			i, nb: INTEGER
		do
			l_other_classes := other_local_override_classes
			nb := l_other_classes.count
			from i := 1 until i > nb loop
				if l_other_classes.item (i).is_unknown then
					l_other_classes.remove (i)
					nb := nb - 1
				else
					i := i + 1
				end
			end
			l_other_classes := other_local_non_override_classes
			nb := l_other_classes.count
			from i := 1 until i > nb loop
				if l_other_classes.item (i).is_unknown then
					l_other_classes.remove (i)
					nb := nb - 1
				else
					i := i + 1
				end
			end
			l_other_classes := other_local_ignored_classes
			nb := l_other_classes.count
			from i := 1 until i > nb loop
				if l_other_classes.item (i).is_unknown then
					l_other_classes.remove (i)
					nb := nb - 1
				else
					i := i + 1
				end
			end
			if first_local_override_class /= Void and then first_local_override_class.is_unknown then
				remove_local_override_class (first_local_override_class)
			end
			if first_local_non_override_class /= Void and then first_local_non_override_class.is_unknown then
				remove_local_non_override_class (first_local_non_override_class)
			end
			if first_local_ignored_class /= Void and then first_local_ignored_class.is_unknown then
				remove_local_ignored_class (first_local_ignored_class)
			end
		end

	remove_imported_class (a_class: ET_MASTER_CLASS)
			-- Remove `a_class' from `first_imported_class' and `other_imported_classes'.
			-- Update `intrinsic_class' and `is_modified' accordingly.
		require
			a_class_not_void: a_class /= Void
		do
			if first_imported_class = a_class then
				other_imported_classes.delete (a_class)
				if not other_imported_classes.is_empty then
					first_imported_class := other_imported_classes.first
					other_imported_classes.remove_first
				else
					first_imported_class := Void
				end
				update_intrinsic_class
			else
				other_imported_classes.delete (a_class)
			end
		ensure
			a_class_removed: not has_imported_class (a_class)
		end

	remove_unknown_imported_classes
			-- Remove classes from `first_imported_class' and `other_imported_classes'
			-- that do not exist anymore in the universe where they had been declared.
			-- Update `intrinsic_class' and `is_modified' accordingly.
		local
			l_class: ET_MASTER_CLASS
			l_other_classes: DS_ARRAYED_LIST [ET_MASTER_CLASS]
			i, nb: INTEGER
		do
			l_other_classes := other_imported_classes
			nb := l_other_classes.count
			from i := 1 until i > nb loop
				l_class := l_other_classes.item (i)
				if not l_class.is_declared_locally then
						-- This class does not exist anymore in the
						-- universe where it had been declared.
					l_other_classes.remove (i)
					nb := nb - 1
				else
					i := i + 1
				end
			end
			l_class := first_imported_class
			if l_class /= Void and then not l_class.is_declared_locally then
					-- This class does not exist anymore in the
					-- universe where it had been declared.
				remove_imported_class (l_class)
			end
		end

	remove_all_intrinsic_classes
			-- Remove all intrinsic classes.
			-- Update `intrinsic_class' and `is_modified' accordingly.
		do
			first_local_override_class := Void
			other_local_override_classes.wipe_out
			first_local_non_override_class := Void
			other_local_non_override_classes.wipe_out
			first_local_ignored_class := Void
			other_local_ignored_classes.wipe_out
			first_imported_class := Void
			other_imported_classes.wipe_out
			first_overriding_class := Void
			other_overriding_classes.wipe_out
			update_intrinsic_class
		ensure
			all_intrinsic_classes_removed: intrinsic_class = tokens.unknown_class
		end

	remove_overriding_class (a_class: ET_MASTER_CLASS)
			-- Remove `a_class' from `first_overriding_class' and `other_overriding_classes'.
			-- Update `is_modified' accordingly.
		require
			a_class_not_void: a_class /= Void
		do
			if first_overriding_class = a_class then
				other_overriding_classes.delete (a_class)
				if not other_overriding_classes.is_empty then
					first_overriding_class := other_overriding_classes.first
					other_overriding_classes.remove_first
				else
					first_overriding_class := Void
				end
				is_modified := True
				set_marked (is_marked)
			else
				other_overriding_classes.delete (a_class)
			end
		ensure
			a_class_removed: not has_overriding_class (a_class)
		end

	remove_all_overriding_classes
			-- Remove all classes from `first_overriding_class' and `other_overriding_classes'.
			-- Update `is_modified' accordingly.
		do
			if first_overriding_class /= Void then
				first_overriding_class := Void
				other_overriding_classes.wipe_out
				is_modified := True
				set_marked (is_marked)
			end
		ensure
			all_overriding_classes_removed: first_overriding_class = Void
		end

	set_mapped_class (a_class: like mapped_class)
			-- Set `mapped_class' to `a_class'.
		do
			mapped_class := a_class
			is_modified := True
			set_marked (is_marked)
		ensure
			mapped_class_set: mapped_class = a_class
		end

feature {NONE} -- Element change

	update_intrinsic_class
			-- Set `intrinsic_class' to `first_local_override_class'.
			-- If no such class, then set it to `first_local_non_override_class'.
			-- If no such class, then set it to `first_imported_class'.
			-- If no such class, then it will be the unknown class.
			--
			-- Update `is_modified' accordingly.
		local
			l_new_intrinsic_class: like intrinsic_class
		do
			if first_local_override_class /= Void then
				l_new_intrinsic_class := first_local_override_class
			elseif first_local_non_override_class /= Void then
				l_new_intrinsic_class := first_local_non_override_class
			elseif first_imported_class /= Void then
				l_new_intrinsic_class := first_imported_class
			else
				l_new_intrinsic_class := tokens.unknown_class
			end
			set_intrinsic_class (l_new_intrinsic_class)
		end

	set_intrinsic_class (a_class: like intrinsic_class)
			-- Set `intrinsic_class' to `a_class'.
			--
			-- Update `is_modified' accordingly.
		require
			a_class_not_void: a_class /= Void
		local
			l_old_intrinsic_class: ET_NAMED_CLASS
		do
			if intrinsic_class /= a_class then
				l_old_intrinsic_class := intrinsic_class
				intrinsic_class := a_class
				if attached {ET_CLASS} l_old_intrinsic_class as l_old_class and then (l_old_class.is_unknown and l_old_class /= tokens.unknown_class) then
						-- This class has probably been removed from the universe.
						-- We don't know whether it was an override class or not,
						-- so make as if it was an override class just in case.
					if first_imported_class /= Void then
						unmark_overridden (first_imported_class)
						other_imported_classes.do_all (agent unmark_overridden)
					end
				end
				if l_old_intrinsic_class.is_override (universe) then
					if not a_class.is_override (universe) then
						if first_imported_class /= Void then
							unmark_overridden (first_imported_class)
							other_imported_classes.do_all (agent unmark_overridden)
						end
					end
				elseif a_class.is_override (universe) then
					if first_imported_class /= Void then
						mark_overridden (first_imported_class)
						other_imported_classes.do_all (agent mark_overridden)
					end
				end
				if first_overriding_class = Void then
					is_modified := True
					set_marked (is_marked)
				end
			end
		ensure
			intrinsic_class_set: intrinsic_class = a_class
		end

	mark_overridden (a_class: ET_MASTER_CLASS)
			-- Indicate that `a_class' is being overridden by `Current'.
		require
			a_class_not_void: a_class /= Void
--			no_cycle: no cycle in graph of master classes
		do
			if a_class.universe /= universe then
				a_class.add_last_overriding_class (Current)
			end
		end

	unmark_overridden (a_class: ET_MASTER_CLASS)
			-- Indicate that `a_class' is not being overridden by `Current' anymore.
		require
			a_class_not_void: a_class /= Void
		do
			a_class.remove_overriding_class (Current)
		end

feature -- Iteration

	local_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in groups of `universe'.
			-- These classes can be found in `first_local_override_class',
			-- `other_local_override_classes', `first_local_non_override_class',
			-- `other_local_non_override_classes', `first_local_ignored_class'
			-- and `other_local_ignored_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			local_override_classes_do_all (a_action)
			local_non_override_classes_do_all (a_action)
			local_ignored_classes_do_all (a_action)
		end

	local_override_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in override groups of `universe'.
			-- These classes can be found in `first_local_override_class' and
			-- `other_local_override_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			if first_local_override_class /= Void then
				a_action.call ([first_local_override_class])
				other_local_override_classes.do_all (a_action)
			end
		end

	local_non_override_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in non-override groups of `universe'.
			-- These classes can be found in `first_local_non_override_class' and
			-- `other_local_non_override_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			if first_local_non_override_class /= Void then
				a_action.call ([first_local_non_override_class])
				other_local_non_override_classes.do_all (a_action)
			end
		end

	local_ignored_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every ignored class declared in groups of `universe'.
			-- These classes can be found in `first_local_ignored_class' and
			-- `other_local_ignored_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			if first_local_ignored_class /= Void then
				a_action.call ([first_local_ignored_class])
				other_local_ignored_classes.do_all (a_action)
			end
		end

	local_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_CLASS], BOOLEAN])
			-- Apply `a_action' to every class declared in groups of `universe'
			-- that satisfies `a_test'.
			-- These classes can be found in `first_local_override_class',
			-- `other_local_override_classes', `first_local_non_override_class',
			-- `other_local_non_override_classes', `first_local_ignored_class'
			-- and `other_local_ignored_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			local_override_classes_do_if (a_action, a_test)
			local_non_override_classes_do_if (a_action, a_test)
			local_ignored_classes_do_if (a_action, a_test)
		end

	local_override_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_CLASS], BOOLEAN])
			-- Apply `a_action' to every class declared in override groups of `universe'
			-- that satisfies `a_test'.
			-- These classes can be found in `first_local_override_class' and
			-- `other_local_override_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			if first_local_override_class /= Void then
				if a_test.item ([first_local_override_class]) then
					a_action.call ([first_local_override_class])
				end
				other_local_override_classes.do_if (a_action, a_test)
			end
		end

	local_non_override_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_CLASS], BOOLEAN])
			-- Apply `a_action' to every class declared in non-override groups of `universe'
			-- that satisfies `a_test'.
			-- These classes can be found in `first_local_non_override_class' and
			-- `other_local_non_override_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			if first_local_non_override_class /= Void then
				if a_test.item ([first_local_non_override_class]) then
					a_action.call ([first_local_non_override_class])
				end
				other_local_non_override_classes.do_if (a_action, a_test)
			end
		end

	local_ignored_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_CLASS], BOOLEAN])
			-- Apply `a_action' to every ignored class declared in groups of `universe'
			-- that satisfies `a_test'.
			-- These classes can be found in `first_local_ignored_class' and
			-- `other_local_ignored_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			if first_local_ignored_class /= Void then
				if a_test.item ([first_local_ignored_class]) then
					a_action.call ([first_local_ignored_class])
				end
				other_local_ignored_classes.do_if (a_action, a_test)
			end
		end

	local_classes_do_unless_actual (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in groups of `universe'
			-- unless this class is the `actual_class'.
			-- These classes can be found in `first_local_override_class',
			-- `other_local_override_classes', `first_local_non_override_class'
			-- and `other_local_non_override_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			local_override_classes_do_unless_actual (a_action)
			local_non_override_classes_do_unless_actual (a_action)
				-- Note that the actual class cannot be ignored.
			local_ignored_classes_do_all (a_action)
		end

	local_override_classes_do_unless_actual (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in override groups of `universe'
			-- unless this class is the `actual_class'.
			-- These classes can be found in `first_local_override_class' and
			-- `other_local_override_classes'.
		require
			a_action_not_void: a_action /= Void
		local
			l_actual_class: ET_CLASS
		do
			if first_local_override_class /= Void then
				l_actual_class := actual_class
				if first_local_override_class /= l_actual_class then
					a_action.call ([first_local_override_class])
				end
					-- Note that the actual class, if a local override class,
					-- will be `first_local_override_class'. It will never be
					-- stored in `other_local_override_classes'.
				other_local_override_classes.do_all (a_action)
			end
		end

	local_non_override_classes_do_unless_actual (a_action: PROCEDURE [ANY, TUPLE [ET_CLASS]])
			-- Apply `a_action' to every class declared in non-override groups of `universe'
			-- unless this class is the `actual_class'.
			-- These classes can be found in `first_local_non_override_class' and
			-- `other_local_non_override_classes'.
		require
			a_action_not_void: a_action /= Void
		local
			l_actual_class: ET_CLASS
		do
			if first_local_non_override_class /= Void then
				l_actual_class := actual_class
				if first_local_non_override_class /= l_actual_class then
					a_action.call ([first_local_non_override_class])
				end
					-- Note that the actual class, if a local override class,
					-- will be `first_local_override_class'. It will never be
					-- stored in `other_local_override_classes'.
				other_local_non_override_classes.do_all (a_action)
			end
		end

	imported_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_MASTER_CLASS]])
			-- Apply `a_action' to every class imported from a universe other than `universe'.
			-- These classes can be found in `first_imported_class' and
			-- `other_imported_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			if first_imported_class /= Void then
				a_action.call ([first_imported_class])
				other_imported_classes.do_all (a_action)
			end
		end

	imported_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_MASTER_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_MASTER_CLASS], BOOLEAN])
			-- Apply `a_action' to every class imported from a universe other than `universe'
			-- that satisfies `a_test'.
			-- These classes can be found in `first_imported_class' and
			-- `other_imported_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			if first_imported_class /= Void then
				if a_test.item ([first_imported_class]) then
					a_action.call ([first_imported_class])
				end
				other_imported_classes.do_if (a_action, a_test)
			end
		end

	overriding_classes_do_all (a_action: PROCEDURE [ANY, TUPLE [ET_MASTER_CLASS]])
			-- Apply `a_action' to every class in universes other than `universe' which
			-- overrides current class.
			-- These classes can be found in `first_overriding_class' and
			-- `other_overriding_classes'.
		require
			a_action_not_void: a_action /= Void
		do
			if first_overriding_class /= Void then
				a_action.call ([first_overriding_class])
				other_overriding_classes.do_all (a_action)
			end
		end

	overriding_classes_do_if (a_action: PROCEDURE [ANY, TUPLE [ET_MASTER_CLASS]]; a_test: FUNCTION [ANY, TUPLE [ET_MASTER_CLASS], BOOLEAN])
			-- Apply `a_action' to every class in universes other than `universe' which
			-- overrides current class and satisfies `a_test'.
			-- These classes can be found in `first_overriding_class' and
			-- `other_overriding_classes'.
		require
			a_action_not_void: a_action /= Void
			a_test_not_void: a_test /= Void
		do
			if first_overriding_class /= Void then
				if a_test.item ([first_overriding_class]) then
					a_action.call ([first_overriding_class])
				end
				other_overriding_classes.do_if (a_action, a_test)
			end
		end

feature -- Initialization

	reset_local_modified_classes
			-- Reset appropriately classes that have been declared in groups of `universe'
			-- (i.e. classes that can be found in `first_local_override_class', `other_local_override_classes',
			-- `first_local_non_override_class', `other_local_non_override_classes',
			-- `first_local_ignored_class' and `other_local_ignored_classes'), that
			-- have been modified and possibly removed (either their old files do not exist anymore,
			-- or they have been modified and may contain another class) so that they will be
			-- (pre)parsed again. Only classes declared locally in `universe' are taken into account.
			-- Update `is_modified' accordingly.
			--
			-- Note that this routine may modify classes to unknown classes.
			-- So it is recommended to call `remove_unknown_local_classes' after
			-- this call.
			--
			-- Note that if a file contains two classes and is modified between
			-- the time we check the first class and the second class then the
			-- re(pre)parse will give inconsistent results and will need to be
			-- rerun again.
			--
			-- The queries `current_system.preparse_*_mode' govern the way
			-- preparsing works. Read the header comments of these features
			-- for more details.
		do
			local_override_classes_do_all (agent reset_local_modified_class)
			if not current_system.preparse_override_mode then
				local_non_override_classes_do_all (agent reset_local_modified_class)
				local_ignored_classes_do_all (agent reset_local_modified_class)
			else
				local_ignored_classes_do_if (agent reset_local_modified_class, agent {ET_CLASS}.is_in_override_group)
			end
		end

feature {NONE} -- Initialization

	reset_local_modified_class (a_class: ET_CLASS)
			-- Reset `a_class' appropriately if it has been modified and possibly removed (either
			-- its old file does not exist anymore, or it has been modified and may contain another
			-- class) so that it will be (pre)parsed again.
			-- Update `is_modified' accordingly.
			--
			-- Note that this routine may modify `a_class' to an unknown class.
			-- So it is recommended to call `remove_unknown_local_classes' after
			-- this call.
			--
			-- Note that if a file contains two classes and is modified between
			-- the time we check the first class and the second class then the
			-- re(pre)parse will give inconsistent results and will need to be
			-- rerun again.
			--
			-- The queries `current_system.preparse_*_mode' govern the way
			-- preparsing works. Read the header comments of these features
			-- for more details.
		require
			a_class_not_void: a_class /= Void
		local
			l_cluster: ET_CLUSTER
			l_override_mode: BOOLEAN
			l_readonly_mode: BOOLEAN
			l_shallow_mode: BOOLEAN
			l_time_stamp: INTEGER
			l_actual_class: ET_CLASS
		do
			l_override_mode := current_system.preparse_override_mode
			l_readonly_mode := current_system.preparse_readonly_mode
			l_shallow_mode := current_system.preparse_shallow_mode
			l_actual_class := actual_class
			if a_class /= l_actual_class then
				a_class.reset_after_parsed_and_errors
			end
			if a_class.is_preparsed then
				if a_class.is_in_cluster then
					l_cluster := a_class.group.cluster
					if l_override_mode and then not l_cluster.is_override then
							-- This class does not belong to an override cluster.
							-- Just skip it.
					elseif not l_readonly_mode and then l_cluster.is_read_only then
							-- This class belongs to an read-only cluster (i.e. a cluster
							-- which is not traversed again during incremental compilation).
							-- Just skip this class.
					elseif l_cluster.is_abstract then
							-- The class belongs to a cluster which is marked as abstract.
							-- This means that the class of this cluster are ignored.
							-- So we have to get rid of this class.
						a_class.reset
						is_modified := is_modified or (l_actual_class = a_class)
					elseif not file_system.file_exists (a_class.filename) then
							-- The file does not exist anymore.
							-- So we have to get rid of this class.
						a_class.reset
						is_modified := is_modified or (l_actual_class = a_class)
					elseif not l_shallow_mode or else a_class.is_parsed then
							-- With the "shallow" algorithm the time-stamp is only set when
							-- parsing the class. Hence the test above.
						l_time_stamp := a_class.time_stamp
						if l_time_stamp < 0 or else file_system.file_time_stamp (a_class.filename) /= l_time_stamp then
								-- The time-stamp of the file has changed or was never recorded.
								-- The file may have been modified.
							if l_shallow_mode then
									-- Force parsing again.
									-- No need to preparse again because the name of the file has not changed.
								a_class.reset_after_preparsed
							else
									-- Force preparsing again because this file may not contain this class anymore.
								a_class.reset
							end
							is_modified := is_modified or (l_actual_class = a_class)
						else
								-- The time-stamp of the file has not changed.
								-- Just skip this class.
						end
					elseif l_shallow_mode then
							-- The class is not marked as parsed. It has only been
							-- preparsed using the "shallow" algorithm (i.e. the
							-- file is named "classname.e").
							-- We already know that the file still exists.
							-- Just skip this class.
					end
				elseif a_class.is_in_dotnet_assembly then
						-- This class belongs to a .NET assembly.
						-- Just skip it.
				else
						-- This class does not belong to a cluster.
						-- Just skip it.
				end
			else
					-- This class is not preparsed. We can just
					-- get rid of it since it belongs to no group.
				if a_class.is_parsed then
						-- When reporting VTCT errors on a class, `is_parsed'
						-- is set to True even if it was not preparsed
						-- (and hence not actually parsed).
					a_class.reset_parsed
				end
			end
		end

feature -- System

	set_marked (b: BOOLEAN)
			-- Set `is_marked' to `b'.
		local
			l_class: ET_CLASS
		do
			is_marked := b
			if b then
				l_class := actual_class
				if not l_class.is_unknown then
					l_class.set_marked (True)
				end
			end
		end

feature -- Type context

	is_valid_context: BOOLEAN = True
			-- A context is valid if the base class of its `root_context'
			-- is preparsed and if its `root_context' is only made up
			-- of class names and formal generic parameter names, and if
			-- the actual parameters of these formal parameters are
			-- themselves

feature -- Output

	append_to_string (a_string: STRING)
			-- Append textual representation of
			-- current type to `a_string'.
		local
			a_parameters: like formal_parameters
		do
			a_string.append_string (upper_name)
			a_parameters := formal_parameters
			if a_parameters /= Void and then not a_parameters.is_empty then
				a_string.append_character (' ')
				a_parameters.append_to_string (a_string)
			end
		end

	append_unaliased_to_string (a_string: STRING)
			-- Append textual representation of unaliased
			-- version of current type to `a_string'.
			-- An unaliased version if when aliased types such as INTEGER
			-- are replaced by the associated types such as INTEGER_32.
		local
			a_parameters: like formal_parameters
		do
			a_string.append_string (upper_name)
			a_parameters := formal_parameters
			if a_parameters /= Void and then not a_parameters.is_empty then
				a_string.append_character (' ')
				a_parameters.append_unaliased_to_string (a_string)
			end
		end

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'
		do
			Result := upper_name
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current master class.
		do
			a_processor.process_master_class (Current)
		end

invariant

	other_local_override_classes_not_void: other_local_override_classes /= Void
	no_void_other_local_override_classes: not other_local_override_classes.has_void
	no_other_local_override_classes: first_local_override_class = Void implies other_local_override_classes.is_empty
	other_local_non_override_classes_not_void: other_local_non_override_classes /= Void
	no_void_other_local_non_override_classes: not other_local_non_override_classes.has_void
	no_other_local_non_override_classes: first_local_non_override_class = Void implies other_local_non_override_classes.is_empty
	other_local_ignored_classes_not_void: other_local_ignored_classes /= Void
	no_void_other_local_ignored_classes: not other_local_ignored_classes.has_void
	no_other_local_ignored_classes: first_local_ignored_class = Void implies other_local_ignored_classes.is_empty
	other_imported_classes_not_void: other_imported_classes /= Void
	no_void_other_imported_classes: not other_imported_classes.has_void
	no_other_imported_classes: first_imported_class = Void implies other_imported_classes.is_empty
	other_overriding_classes_not_void: other_overriding_classes /= Void
	no_void_other_overriding_classes: not other_overriding_classes.has_void
	no_other_overriding_classes: first_overriding_class = Void implies other_overriding_classes.is_empty
	no_local_override_class_if_unknown: intrinsic_class = tokens.unknown_class implies first_local_override_class = Void
	no_local_non_override_class_if_unknown: intrinsic_class = tokens.unknown_class implies first_local_non_override_class = Void
	no_imported_class_if_unknown: intrinsic_class = tokens.unknown_class implies first_imported_class = Void
	no_overriding_class_if_unknown: intrinsic_class = tokens.unknown_class implies first_overriding_class = Void

end
