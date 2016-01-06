
# Criteria library

This library provides an implementation for the Filter|Criteria pattern.

(note: it is using the term "criteria" instead of more correct term "criterion", mainly to match existing known criteria pattern interfaces.)

Useful to filter a list.
Via a Criteria factory, it provides expression evaluation based on
binary operators and labels, such as "name:foo or tag:test" which
keeps items satisfying criteria "name=foo" and has tag "test".
But it is also possible to use directly the CRITERIA [G] objects, and combines them with operators like "and, or, not".

For advanced usage, see examples folder.
